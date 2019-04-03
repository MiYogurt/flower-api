lapis = require "lapis"
models = require "models"

class extends lapis.Application
  "/": =>
    "Welcome to Lapis #{require "lapis.version"}!"
  "/user": =>
    cate = models.Categorys\find 1
    subjects = cate\get_flowers!
    {
      json: subjects
    }