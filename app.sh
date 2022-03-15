#!/bin/bash

repl(){
  clj \
    -J-Dclojure.core.async.pool-size=1 \
    -X:repl Ripley.core/process \
    :main-ns The-Client.main
}


main(){
  clojure \
    -J-Dclojure.core.async.pool-size=1 \
    -M -m The-Client.main
}

jar(){

  rm -rf out/*.jar
  clojure \
    -X:uberjar Genie.core/process \
    :main-ns The-Client.main \
    :filename "\"out/The-Client-$(git rev-parse --short HEAD).jar\"" \
    :paths '["src"]'
}

release(){
  docker build -t theclientapp/the-client:$(git rev-parse --short HEAD) .
  docker build -t theclientapp/the-client:latest .
}

push(){
  release
  docker push theclientapp/the-client:$(git rev-parse --short HEAD)
  docker push theclientapp/the-client:latest
}

deploy(){
  heroku container:login
  heroku container:push -a the-client web
  heroku container:release -a the-client web
}

ui(){
  # watch release
  npm i --no-package-lock
  mkdir -p out/ui/
  cp src/The_Client/index.html out/ui/index.html
  clj -A:ui -M -m shadow.cljs.devtools.cli $1 ui
}

"$@"