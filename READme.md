#Old Skool Pool

An entertaining app, where users guess the year of the NCAA men's basketball tournament.  Just like college the shot clock is only 35 seconds.


#About
This Sinatra app incorporated a lot of Javascript and jQuery to get the data to render in a usable fashion.  To get the data for this app, it had to be scraped using the 'nokogiri' gem.  Unfortunately the data was not easily parsed and it took many attempts to get the json meta-data into usable data by testing some Ruby code with Pry.  Once the data was digestible and entered into the database, the app building process started.  Sinatra was used as the base and then Backbone.js views were added.  API calls were made to the database to retrieve the necessary data.


#Technology
- Sinatra
- Javascript
- jQuery
- Ruby
- postgresql
- nokogiri
- bootstrap
- Ajax
- CRUD


#Version 2.0
- Better rendering of teams in bracket format
- Include missing years where data sourced changed the name of the regions
- Log-in
- Authentication
- Top-scores (quickest time) for each year
- different levels of difficulty



##Screenshots
![Wrong](/public/images/wrongans.png)


![Right](/public/images/rightans.png)



#Code  
why else are you scrolling this far down?


Example of how to clean and sort the json data.
```ruby
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
      team_a_data = year_data[name][game_idx[0]]
      team_b_data = year_data[name][game_idx[1]]
      if team_a_data && team_b_data
        team_a = Team.find_by({name: team_a_data[:name]})
        team_b = Team.find_by({name: team_b_data[:name]})
        Game.create({  
          team_a_id: team_a.id,
          team_b_id: team_b.id,
          score_a: team_a_data[:score],
          score_b: team_b_data[:score],
          round: 1,
          year: year
        })
      end
    end
  end
end
```


Getting the json data into a usable form into to the PSQL was a major complication that took some time.  In the Quality Control stage I realized that some of the data didn't pull in since the name of the region changed.  I then had to go and modify the scraper, in order to pull the full data.

Once the data was there getting each game to render correctly was tricky...Some javascript was used to loop through each round and get the teams to match up.  The rounds then had to render in slowly to give the user a chance to guess the year.  

```javascript
for (var i = 0; i < rounds.length; i++) {
  var round = rounds[i];
  for (var n = 0; n < round.length; n++) {
    var game = round[n];               //get game matchups
    var html = $('<div><p>' + game.team_a + '</p><p>' + game.team_b + '</p></div>');
    html.addClass('game'); //add Class to games
    html.hide(); //makes games not shift as other games come in

    (function (){      //bring in round by round but delayed
      var locali = i;
      var localhtml = html;
      setTimeout(function(){
        $('#round'+locali).append(localhtml);
        localhtml.fadeIn(2000);
      }, (i*3000));
    })();

  }
}
```

#Author
[Tyler Geneva](https://github.com/ctylerg)
