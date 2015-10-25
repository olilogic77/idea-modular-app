require 'sinatra/base'

class MyApp < Sinatra::Base
  set :views, Proc.new { File.join(root, "../views") }

  get '/ideas' do
    @ideas = Idea.all
    erb :'ideas/index', {:layout => :'layouts/application'}

  end

end


