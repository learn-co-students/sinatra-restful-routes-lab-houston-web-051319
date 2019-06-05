class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/recipes' do
    @recipes = Recipe.all
    erb :index
  end

  get '/recipes/new' do
    erb :new
  end

  post '/recipes' do
    recipe = Recipe.create(params)
    redirect "/recipes/#{recipe.id}"
  end

  get '/recipes/:id' do
    @recipe = recipe_finder(params)
    erb :show
  end
##
  get '/recipes/:id/edit' do
    @recipe = recipe_finder(params)
    erb :edit
  end

  patch '/recipes/:id' do
    recipe = recipe_finder(params)
    recipe.update(title: params[:title],content: params[:content])
    redirect "/recipes/#{recipe.id}"
  end

  delete '/recipes/:id' do
    recipe = recipe_finder(params)
    recipe.delete
    redirect "/recipes"
  end

  def recipe_finder(params)
    Recipe.find(params[:id])
  end

end
