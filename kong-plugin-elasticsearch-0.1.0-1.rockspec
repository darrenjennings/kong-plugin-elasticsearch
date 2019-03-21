package = "kong-plugin-elasticsearch"

version = "0.1.0-1"

supported_platforms = {"linux", "macosx"}

source = {
  url = "",
  tag = "0.1.0",
}

description = {
  summary = "A Kong plugin to turn index Kong entities using elasticsearch.",
  homepage = "http://getkong.org",
  license = "MIT",
}

build = {
  type = "builtin",
  modules = {
    ["kong.plugins.elasticsearch.handler"] = "kong/plugins/elasticsearch/handler.lua",
    ["kong.plugins.elasticsearch.schema"] = "kong/plugins/elasticsearch/schema.lua",
    ["kong.plugins.elasticsearch.indexer"] = "kong/plugins/elasticsearch/indexer.lua",
  }
}
