(defn get-banner
  []
  (try
    (str
      (slurp "resources/text/banner.txt")
      ;(slurp "resources/text/loading.txt")
      )
    ;; If another project can't find the banner, just skip it;
    ;; this function is really only meant to be used by Dragon itself.
    (catch Exception _ "")))

(defn get-prompt
  [ns]
  (str "\u001B[35m[\u001B[34m"
       ns
       "\u001B[35m]\u001B[33m λ\u001B[m=> "))

(defproject hexagram30/story "0.1.0-SNAPSHOT"
  :description "TBD"
  :url "https://github.com/hexagram30/story"
  :license {
    :name "Apache License, Version 2.0"
    :url "http://www.apache.org/licenses/LICENSE-2.0"}
  :dependencies [
    [clojusc/system-manager "0.3.0-SNAPSHOT"]
    [clojusc/twig "0.3.3"]
    [hexagram30/common "0.1.0-SNAPSHOT"]
    [hexagram30/dice "0.1.0-SNAPSHOT"]
    [org.clojure/clojure "1.9.0"]]
  :source-paths [
    "src/clj"
    "src/cljc"]
  :profiles {
    :ubercompile {
      :aot :all}
    :dev {
      :dependencies [
        [clojusc/trifl "0.3.0"]
        [org.clojure/tools.namespace "0.2.11"]]
      :plugins [
        [lein-shell "0.5.0"]
        [venantius/ultra "0.5.2"]]
      :source-paths ["dev-resources/src"]
      :main hxgm30.story.core
      :repl-options {
        :init-ns hxgm30.story.repl
        :prompt ~get-prompt
        :init ~(println (get-banner))}}
    :lint {
      :source-paths ^:replace ["src"]
      :test-paths ^:replace []
      :plugins [
        [jonase/eastwood "0.2.9"]
        [lein-ancient "0.6.15"]
        [lein-bikeshed "0.5.1"]
        [lein-kibit "0.1.6"]
        [venantius/yagni "0.1.6"]]}
    :test {
      :plugins [
        [lein-ltest "0.3.0"]]}
    :server {
      :jvm-opts ["-XX:MaxDirectMemorySize=512g"]
      :main hxgm30.story.server}
    :cljs {
      :source-paths ["src/cljs"]
      :dependencies [
        [org.clojure/clojurescript "1.10.339"]]
      :plugins [
        [lein-cljsbuild "1.1.7"]
        [lein-shell "0.5.0"]]
      :cljsbuild {
        :builds
          [{:id "cli"
            :source-paths ["src/cljs"]
            :compiler {
              :output-to "bin/story"
              :output-dir "target/cljs/hxgm30"
              :optimizations :simple
              :pretty-print true
              :main hxgm30.story.cli
              :target :nodejs
              :verbose true}}]}}}
  :aliases {
    ;; Dev Aliases
    "repl" ["do"
      ["clean"]
      ["repl"]]
    "ubercompile" ["do"
      ["clean"]
      ["with-profile" "+ubercompile" "compile"]]
    "check-vers" ["with-profile" "+lint" "ancient" "check" ":all"]
    "check-jars" ["with-profile" "+lint" "do"
      ["deps" ":tree"]
      ["deps" ":plugin-tree"]]
    "check-deps" ["do"
      ["check-jars"]
      ["check-vers"]]
    "kibit" ["with-profile" "+lint" "kibit"]
    "eastwood" ["with-profile" "+lint" "eastwood" "{:namespaces [:source-paths]}"]
    "lint" ["do"
      ["kibit"]
      ; ["eastwood"]
      ]
    "ltest" ["with-profile" "+test" "ltest"]
    "ltest-clean" ["do"
      ["clean"]
      ["ltest"]]
    "build" ["do"
      ["clean"]
      ["check-vers"]
      ["lint"]
      ["ltest" ":all"]
      ["uberjar"]
      ["build-cli"]]
    "clean-cljs" ["with-profile" "+cljs" "do"
      ["clean"]
      ["shell" "rm" "-f" "bin/roll"]]
    "build-cli" ["with-profile" "+cljs" "do"
      ["cljsbuild" "once" "cli"]
      ["shell" "chmod" "755" "bin/roll"]]
    "clean-build-cli" ["with-profile" "+cljs" "do"
      ["clean-cljs"]
      ["build-cli"]]
    ;; Script Aliases
    "roll" ["run"]})

