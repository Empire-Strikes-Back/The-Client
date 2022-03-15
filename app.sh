#!/bin/bash

repl(){
  clj \
    -J-Dclojure.core.async.pool-size=1 \
    -X:repl Ripley.core/process \
    :main-ns lingonberry-app.main
}


main(){
  clojure \
    -J-Dclojure.core.async.pool-size=1 \
    -M -m lingonberry-app.main
}

jar(){

  rm -rf out/*.jar
  clojure \
    -X:uberjar Genie.core/process \
    :main-ns lingonberry-app.main \
    :filename "\"out/lingonberry-app-$(git rev-parse --short HEAD).jar\"" \
    :paths '["src"]'
}

release(){
  docker build -t lingonberryapp/lingonberry-app:$(git rev-parse --short HEAD) .
  docker build -t lingonberryapp/lingonberry-app:latest .
}

push(){
  release
  docker push lingonberryapp/lingonberry-app:$(git rev-parse --short HEAD)
  docker push lingonberryapp/lingonberry-app:latest
}

deploy(){
  heroku container:login
  heroku container:push -a lingonberry-app web
  heroku container:release -a lingonberry-app web
}

ui(){
  # watch release
  npm i --no-package-lock
  mkdir -p out/ui/
  cp src/lingonberry_app/index.html out/ui/index.html
  clj -A:ui -M -m shadow.cljs.devtools.cli $1 ui
}

"$@"