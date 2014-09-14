-module(msys_host).

-init([start_link/1, init/1]).

-record(host, {
  id,
  node,
  name,
  status,
  status_start
}).
