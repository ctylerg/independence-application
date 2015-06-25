require 'bundler'
Bundler.require()


###################
# connection for heroku
db = URI.parse(ENV['DATABASE_URL'] || 'postgres://localhost/march_madness')
ActiveRecord::Base.establish_connection(
 :adapter => 'postgresql',
 :host     => db.host,
 :username => db.user,
 :password => db.password,
 :database => db.path[1..-1],
 :encoding => 'utf8'
)
###################
# sessions
enable(:sessions)


###################
#models
require './models/team'
require './models/game'
require './models/season'
require './models/user'

######################
# helpers
def current_user
  if session[:current_user]
    User.find(session[:current_user])
  else
    nil
  end
end

def authenticate!
  redirect '/' unless current_user
end
#####################
#routes

get '/' do
  # if current_user
  #   "You are now logged in"
  # else
  #   "Please sign in"
  # end
  erb :index
end

post '/users' do
  user = User.new(params[:user])
  user.password = params[:password]  # Setting: Doing the hashing
  user.save!  # save in place
  redirect '/'
end

# Sign-In
post '/sessions' do
  user = User.find_by(username: params[:username])
  if (user.password == params[:password])  # Does the password match?
    session[:current_user] = user.id
    redirect '/' # Authenticated
  else
    redirect '/' # Not Authenticated
  end
end

# Log-out
delete '/sessions' do
  session[:current_user] = nil
  redirect '/'
end

#########
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
