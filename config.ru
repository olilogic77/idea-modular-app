require './config/application'

# map the controllers to routes
map('/about') { run AboutController }
map('/') { run IdeasController }
