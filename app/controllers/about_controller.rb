require_relative './application_controller'
class AboutController < ApplicationController

  set :run, true

  get '/' do
    erb :'application/about', { :layout => :'layouts/application' }
  end

end
