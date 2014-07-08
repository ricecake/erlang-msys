-module(msys_service_check).

-fields([
  id,
  host_id,
  service_id,
  status,
  status_start,
  options
]).

-join([
  {belongs_to, msys_host, host_id},
  {belongs_to, msys_service, service_id}
]).
