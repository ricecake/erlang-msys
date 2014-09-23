-module(msys_service_check).

-init([start_link/1, init/1]).

-record(srvck, {
  id,
  host_id,
  service_id,
  status={undefined, []},
  status_start=undefined,
  options={[], []}
}).

-join([
  {belongs_to, msys_host, host_id},
  {belongs_to, msys_service, service_id}
]).
