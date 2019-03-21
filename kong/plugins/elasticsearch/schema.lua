return {
  no_consumer = true,
  fields = {
    hosts = {
      type = "table",
      schema = {
        fields = {
          protocol = {type = "string", default = "http"},
          host = {type = "string", default = "localhost"},
          port = {type = "string", default = ""}
        }
      }
    },
    params = {
      type = "table",
      schema = {
        fields = {
          pingTimeout = {type = "number", default = "2"}
        }
      }
    }
  }
}
