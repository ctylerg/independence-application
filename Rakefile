# ***** GEMS *****
require 'bundler/setup'
Bundler.require

# ***** CONNECTION *****
ActiveRecord::Base.establish_connection(
  :adapter => 'postgresql',
  :database => 'march_madness'
)

# ***** MODELS *****
require './models/team'
require './models/season'
require './models/game'


namespace :db do


  desc "Fill Database some Junk Data"
  task :junk_data do

    #Generate random Team
     teams_starting = ['CLE', 'CHI', 'NY', 'LA']
     teams_ending = ['town', 'land', 'city', 'attle', 'boro']
     teams_post =['college', 'university', 'tech']
    (16).times do
      Team.create({
          name: ( teams_starting.sample + ' ' + teams_ending.sample + ' ' + teams_post.sample),
      })
    end

  end # task :junk_data



  desc "Fill Database game data"
  task :seed do

    require 'json'

    year_data = {}
    data = JSON(File.read('./data.json'))
    names = ['East', 'West', 'Midwest', 'South', 'National']

    data.each do |year, year_data|
      names.each do |name|
        year_data[name].each_with_index do |team, idx|
          score = team.scan(/(\d+)/).flatten.first

          team_name = team.chars
          team_name.pop(score.length) if score
          team_name = team_name.join('').strip

          data[year][name][idx] = {name: team_name, score: score}
        end
      end
    end

    ####################
    first_round = [
      [0, 5],
      [6, 8],
      [9, 12],
      [13, 15],
      [16, 20],
      [21, 23],
      [24, 27],
      [28, 30],
    ]

    names = ['East', 'West', 'Midwest', 'South']
    data.each do |year, year_data|
      names.each do |name|
        first_round.each do |game_idx|
          year_data[name][game_idx[0]][:game] = 1 if year_data[name][game_idx[0]]
          year_data[name][game_idx[1]][:game] = 1 if year_data[name][game_idx[1]]
        end
      end
    end
    # #########################
    second_round = [
      [1,7],
      [10,14],
      [17, 22],
      [25, 29],
    ]

    names = ['East', 'West', 'Midwest', 'South']
    data.each do |year, year_data|
      names.each do |name|
        second_round.each do |game_idx|
          year_data[name][game_idx[0]][:game] = 2 if year_data[name][game_idx[0]]
          year_data[name][game_idx[1]][:game] = 2 if year_data[name][game_idx[1]]
        end
      end
    end
    ##############################
    sweet_sixteen = [
      [2,11],
      [18,26],
    ]

    names = ['East', 'West', 'Midwest', 'South']
    data.each do |year, year_data|
      names.each do |name|
        sweet_sixteen.each do |game_idx|
          year_data[name][game_idx[0]][:game] = 3 if year_data[name][game_idx[0]]
          year_data[name][game_idx[1]][:game] = 3 if year_data[name][game_idx[1]]
        end
      end
    end
    ##############################
    elite_eight = [
      [3,19],
    ]

    names = ['East', 'West', 'Midwest', 'South']
    data.each do |year, year_data|
      names.each do |name|
        elite_eight.each do |game_idx|
          year_data[name][game_idx[0]][:game] = 4 if year_data[name][game_idx[0]]
          year_data[name][game_idx[1]][:game] = 4 if year_data[name][game_idx[1]]
        end
      end
    end

    ##############################
    final_four = [
      [0,3],
      [4,5]
    ]

    names = ['National']
    data.each do |year, year_data|
      names.each do |name|
        final_four.each do |game_idx|
          year_data[name][game_idx[0]][:game] = 5 if year_data[name][game_idx[0]]
          year_data[name][game_idx[1]][:game] = 5 if year_data[name][game_idx[1]]
        end
      end
    end
    ##############################
    championship = [
      [1,6],
    ]

    names = ['National']
    data.each do |year, year_data|
      names.each do |name|
        championship.each do |game_idx|
          year_data[name][game_idx[0]][:game] = 6 if year_data[name][game_idx[0]]
          year_data[name][game_idx[1]][:game] = 6 if year_data[name][game_idx[1]]
        end
      end
    end




    #Collect Teams
    names = ['East', 'West', 'Midwest', 'South']
    data.each do |year, year_data|
      names.each do |name|
        year_data[name].each do |record|
          unless team = Team.find_by(name: record[:name])
            team = Team.create({name: record[:name]})
          end
        end
      end
    end


    #Collect Games
    game_idx = ['1', '2', '3', '4']
    data.each do |year, year_data|
      game_idx.each do |name|
        year_data[game_idx].each do |record|
          unless game = Game.find_by(game_idx: record[:game_idx])
            game = Game.create({game_idx: record[:game_idx]})
          end
        end
      end
    end

  end



  desc "Empty Database"
  task :empty do
    Team.destroy_all
    Group.destroy_all
    Season.destroy_all
  end # task :empty

end # namespace :db
