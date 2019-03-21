local singletons = require "kong.singletons"
local cjson = require "cjson.safe"
local http = require "resty.http"

local json_encode = cjson.encode

local _M = {
  client = nil -- resty.http client
}

function _M.init_worker()
  if not singletons.worker_events or not singletons.worker_events.register then
    return
  end

  singletons.worker_events.register(_M.crudHandler, "crud", "consumers")
  singletons.worker_events.register(_M.crudHandler, "crud", "services")
  singletons.worker_events.register(_M.crudHandler, "crud", "routes")
  singletons.worker_events.register(_M.crudHandler, "crud", "ssl_certificates")
  singletons.worker_events.register(_M.crudHandler, "crud", "ssl_servers_names")
  singletons.worker_events.register(_M.crudHandler, "crud", "workspace_entities")
  singletons.worker_events.register(_M.crudHandler, "crud", "targets")
  singletons.worker_events.register(_M.crudHandler, "crud", "upstreams")
  singletons.worker_events.register(_M.crudHandler, "crud", "basicauth_credentials")
  singletons.worker_events.register(_M.crudHandler, "crud", "plugins")
end

function _M.crudHandler(data)
  if data.operation == "create" or data.operation == "update" then
    _M.client = http.new()
    local _, err = _M.client:connect("localhost", 9200)

    if err then
      ngx.log(ngx.ERR, err)

      return
    end

    _M.client:set_timeout(600000)

    local index_name = data.schema.table or data.schema.name
    local request_body = json_encode(data.entity)

    local res
    res, err =
      _M.client:request {
      method = "PUT",
      path = index_name .. "/_doc/" .. tostring(data.entity.id),
      body = request_body,
      headers = {
        ["Content-Length"] = #(request_body or ""),
        ["Content-Type"] = "application/json; charset=UTF-8"
      }
    }

    if err then
      ngx.log(ngx.ERR, err)

      return
    end
  end
end

return _M
