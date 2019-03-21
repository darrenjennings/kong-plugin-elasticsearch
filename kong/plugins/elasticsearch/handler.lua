local BasePlugin = require "kong.plugins.base_plugin"

-- Grab pluginname from module name
local plugin_name = ({...})[1]:match("^kong%.plugins%.([^%.]+)")

local ElasticsearchHandler = BasePlugin:extend()
local Indexer = require "kong.plugins.elasticsearch.indexer"

ElasticsearchHandler.PRIORITY = 1000

-- constructor
function ElasticsearchHandler:new()
  ElasticsearchHandler.super.new(self, plugin_name)
end


function ElasticsearchHandler:init_worker()
  ElasticsearchHandler.super.access(self)
end

function ElasticsearchHandler:access()
  ElasticsearchHandler.super.access(self)

  ngx.req.set_header("Hello-World", "this is wassup ")
end


function ElasticsearchHandler:header_filter()
  ElasticsearchHandler.super.access(self)
end


function ElasticsearchHandler:init_worker()
  ElasticsearchHandler.super.init_worker(self)
  Indexer.init_worker()
end

return ElasticsearchHandler
