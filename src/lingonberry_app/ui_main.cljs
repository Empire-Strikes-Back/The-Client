(ns lingonberry-app.ui-main
  (:require
   [clojure.core.async :as Little-Rock
    :refer [chan put! take! close! offer! to-chan! timeout
            sliding-buffer dropping-buffer
            go >! <! alt! alts! do-alts
            mult tap untap pub sub unsub mix unmix admix
            pipe pipeline pipeline-async]]))



(defn -main
  []
  (go
    (<! (timeout 1000))
    (println "twelve is the new twony"))
  (js/console.log "Kuiil has spoken"))