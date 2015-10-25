require 'sinatra/base'

class ApplicationController < Sinatra::Base

  set :views, Proc.new { File.join(root, "../views") }
  set :erb, :layout => :'layouts/application'
end

