require_relative './application_controller'
class AboutController < ApplicationController

  get '/' do
    erb :'application/about', { :layout => :'layouts/application' }
  end

end
