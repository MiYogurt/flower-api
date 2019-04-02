lapis = require "lapis"
models = require "models"

class extends lapis.Application
  "/": =>
    "Welcome to Lapis #{require "lapis.version"}!"
  "/user": =>
    user = models.User\find 1
    {
      json: user
    }