class IdeasController < ApplicationController

  %w(/ /ideas).each do |path|
    get path do
      @ideas = Idea.all
      erb :'ideas/index'
    end
  end

  %w(/new /ideas/new).each do |path|
    get path do
      @title = 'New Idea'
      @idea  = Idea.new
      erb :'ideas/new'
    end
  end

  post '/ideas/:id' do
    if params[:idea].try(:[], :picture)
      file      = params[:idea][:picture][:tempfile]
      @filename = params[:idea][:picture][:filename]
    end

    @idea = Idea.find(params[:id])

    if @idea.update_attributes(params[:idea])
      if @filename
        @idea.picture = @filename
        @idea.save
        File.open("./files/#{@filename}", 'wb') do |f|
          f.write(file.read)
        end
      end
      @idea.save
      redirect "/ideas/#{@idea.id}"
    else
      erb :'ideas/edit'
    end
  end

  post '/ideas' do
    if params[:idea] && params[:idea][:picture] && params[:idea][:picture][:filename] && params[:idea][:picture][:tempfile]
      @idea         = Idea.new(params[:idea])

      @filename     = params[:idea][:picture][:filename]
      directory     = ('a'..'z').to_a.shuffle[0, 8].join
      @idea.picture = "#{directory}/#{@filename}"
      file          = params[:idea][:picture][:tempfile]
      Dir.mkdir("./files/#{directory}")

      FileUtils.copy_file(file.path,
                          "files/#{@idea.picture}")

      if @idea.save
        redirect '/ideas'
      else
        erb :'ideas/new'
      end
    else
      erb :'ideas/new'
    end
  end

  # Get the individual page of the post with this ID.
  get '/ideas/:id' do
    @idea     = Idea.find(params[:id])
    erb :'ideas/show'
  end

  get '/ideas/:id/edit' do
    @idea = Idea.find(params[:id])
    erb :'ideas/edit'
  end

  put '/ideas/:id' do
    if params[:idea].try(:[], :picture)
      file      = params[:idea][:picture][:tempfile]
      @filename = params[:idea][:picture][:filename]
    end



    @idea = Idea.find(params[:id])

    if @idea.update_attributes(params[:idea])
      if @filename
        @idea.picture = @filename
        @idea.save
        File.open("./files/#{@filename}", 'wb') do |f|
          f.write(file.read)
        end
      end
      @idea.save
      redirect "/ideas/#{@idea.id}"
    else
      erb :'ideas/edit'
    end
  end


end


