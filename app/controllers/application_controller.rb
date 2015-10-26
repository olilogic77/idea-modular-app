require 'sinatra/base'

class ApplicationController < Sinatra::Base
  # enable :sessions

  set :root, Dir['./app']
  set :public_folder, Proc.new { File.join(root, 'assets') }
  set :erb, :layout => :'layouts/application'

  # don't enable logging when running tests
  configure :production, :development do
    enable :logging
  end

end
