lapis = require "lapis"
models = require "models"
console = require "lapis.console"


class extends lapis.Application
  @include "applications.user"

  "/console": console.make!
  "/": =>
    "Welcome to Lapis #{require "lapis.version"}!"
  "/user": =>
    cate = models.Categorys\find 1
    subjects = cate\get_flowers!
    {
      json: subjects
    }