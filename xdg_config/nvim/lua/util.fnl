(local core (require :nfnl.core))

(fn dep-spec [name maybe-opts]
  (let [opts (if (not= nil maybe-opts) maybe-opts {})]
    (core.assoc opts 1 name)))

{: dep-spec}
