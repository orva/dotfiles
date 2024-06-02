(local core (require :nfnl.core))

(fn dep-spec [name opts?]
  (let [opts (or opts? {})]
    (core.assoc opts 1 name)))

{: dep-spec}
