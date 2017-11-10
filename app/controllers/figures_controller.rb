class FiguresController < ApplicationController

  get '/figures' do
    @figures = Figure.all
    erb :'figures/index'
  end

  get '/figures/new' do
    @titles = Title.all
    @landmarks = Landmark.all

    erb :'figures/new'
  end

  post '/figures' do
    @figure = Figure.create(params[:figure])

    if !params[:title].empty?
      @figure.titles << Title.create(params[:title])
    end
    if !params[:landmark].empty?
      @figure.landmarks << Landmark.create(params[:landmark])
    end

    redirect "/figures/#{@figure.id}"
  end

  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])

    erb :'figures/edit'
  end

  patch '/figures/:id' do
    @figure = Figure.find(params[:id])
    binding.pry
    @figure.name = params[:figure][:name]
    @figure.title_ids << params[:figure][:title_ids]
    @figure.landmark_ids << params[:figure][:landmark_ids]

    if !params[:landmark].empty?
      @figure.landmarks << Landmark.create(params[:landmark])
    end
    if !params[:title].empty?
      @figure.titles << Title.create(params[:title])
    end
    @figure.save

    redirect "/figures/#{@figure.id}"
  end

  get '/figures/:id' do
    @figure = Figure.find(params[:id])
    erb :'figures/show'
  end
end
