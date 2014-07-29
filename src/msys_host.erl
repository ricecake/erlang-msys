-module(msys_host).

-init([start_link/1, init/1]).

-fields([
  id,
  name,
  status,
  status_start
]).
