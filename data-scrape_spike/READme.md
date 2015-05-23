

This get the data for this app, the data had to be scraped.  The 'nokogiri' gem was used to accomplish this.  Unfortunately the data was not easily parsed and it took many attempts to get the json meta-data into usable data by checking some Ruby code with Pry.  Once the data was digestible and entered into the database, the app building process started.  Sinatra was used as the base and then Backbone.js views were added.  API calls were made to the database to retrieve the necessary data.

Example of how to clean the json data.
```ruby
require 'json'
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
```
