require 'bundler'
Bundler.require()

###################
ActiveRecord::Base.establish_connection(
  :adapter => 'postgresql',
  :database => 'march_madness'
)
###################
require './models/team'
require './models/game'
require './models/season'

######################

get '/' do
  erb :index
end

get '/api/teams' do
  content_type :json
  teams = Team.all
  teams.to_json
end

get '/api/teams/:id' do
  content_type :json
  id = params[:id].to_i
  team = team.find(id)
  team.to_json
end


post '/api/teams' do
  content_type :json
  team = team.create(params[:team])
  team.to_json
end


patch '/api/teams/:id' do
  content_type :json
  id = params[:id].to_i
  team = team.find(id)
  team.update(params[:team])
  team.to_json
end
put '/api/teams/:id' do
  content_type :json
  id = params[:id].to_i
  team = team.find(id)
  team.update(params[:team])
  team.to_json
end


delete '/api/teams/:id' do
  content_type :json
  id = params[:id].to_i
  team.delete(id)
  {message: 'Success'}.to_json
end

#################

get '/api/seasons/random' do
  content_type :json
  season = Game.season(rand(1985..1997)).order(:round)
  season.to_json
end



##################################
get '/api/games' do
  content_type :json
  games = Game.all
  games.to_json
end

get '/api/games/:id' do
  content_type :json
  id = params[:id].to_i
  game = game.find(id)
  game.to_json
end


post '/api/games' do
  content_type :json
  game = team.create(params[:game])
  game.to_json
end


patch '/api/games/:id' do
  content_type :json
  id = params[:id].to_i
  game = game.find(id)
  game.update(params[:game])
  game.to_json
end
put '/api/games/:id' do
  content_type :json
  id = params[:id].to_i
  game = game.find(id)
  game.update(params[:game])
  game.to_json
end


delete '/api/games/:id' do
  content_type :json
  id = params[:id].to_i
  game.delete(id)
  {message: 'Success'}.to_json
end
