(ns tw.weekly.c84.core
  (:require [tw.weekly.c84.t1 :as t1])
  (:gen-class))

(defn -main
  "Run all tasks"
  [& _]
  (println "Task #1")
  (t1/-main))
