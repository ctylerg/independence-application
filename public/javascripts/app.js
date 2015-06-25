var app = app || {};

app.findTeamById = function (id) {
  for (var team in app.teams) {
    if (app.teams[team].id == id) {
      return app.teams[team].name;
    }
  }
}

app.pickTeam = function (){
 $.ajax({
   url: '/api/seasons/random',  //pick a random year
   success: function(data){
     console.log(data)

     var round1 = [];
     var round2 = [];
     var round3 = [];
     var round4 = [];
     var round5 = [];
     var round6 = [];

     app.tourney = [];
     for (var selection in data) {   //loop through all the data
       var game = data[selection];
       game.team_a = app.findTeamById(game['team_a_id']);  //get team name
       game.team_b = app.findTeamById(game['team_b_id']);
       app.tourney.push(game);
       switch(game.round) {
        case 1:                //breaks out games into rounds
          round1.push(game);
        break;
        case 2:
          round2.push(game);
        break;
        case 3:
          round3.push(game);
        break;
        case 4:
          round4.push(game);
        break;
        case 5:
          round5.push(game);
        break;
        case 6:
          round6.push(game);
        break;
       }

       var rounds = [round1, round2, round3, round4, round5, round6];

     }

    console.log(rounds.length)
     for (var i = 0; i < rounds.length; i++) {
       var round = rounds[i];

       var splitRounds = app.splitBracketInTwo(round);
       var bootstrapId = (i + 1);
       var reverseBootstrapId = app.getReverseBootstrapColumnId(bootstrapId);

       (function (){      //bring in round by round but delayed
         for (var inc = 0; inc < splitRounds.firstHalf.length; inc++) {

           app.placeTeamInBracket(bootstrapId, splitRounds.firstHalf.pop());

         }

         for (var inc = 0; inc < splitRounds.secondHalf.length; inc++) {

           app.placeTeamInBracket(reverseBootstrapId, splitRounds.secondHalf.pop());

         }
         }, (6600));
       }

   }  // success
 }); // ajax
}

/**
 * This function is designed to take a bracket number + team and
 * append it to the appropriate ID on the page.
 * @bracketNumber: ID associated with bracket
 * @teamName: string that is name of Team
 */
app.placeTeamInBracket = function(bracketNumber, game) {

  //### refcator:
  var html = $('<div><p>' + game.team_a + '</p><p>' + game.team_b + '</p></div>');
  html.addClass('game'); //add Class to games to refernce in styling
    html.hide(); //makes games not shift as other games come in


    var localhtml = html;
    setTimeout(function(){
      $('#round-' + bracketNumber).append(localhtml);
      localhtml.fadeIn(2000);
    })

  console.log("please fix rendering");
  console.log(game);


  //$('#round-' + bracketNumber).append("<br>" + game);
  return true;

};

app.splitBracketInTwo = function(bracketArray) {

  var bracketObject = {
    firstHalf: [],
    secondHalf: []
  };
  var lengthOfBracket = bracketArray.length
  var halfOfBracket = lengthOfBracket / 2;

  for (var inc = 0; inc < halfOfBracket; inc++) {
    bracketObject.firstHalf.push(bracketArray[inc]);
  }

  for (var inc = 0; inc < halfOfBracket; inc++) {
    bracketObject.secondHalf.push(bracketArray[inc]);
  }

  console.log("splitBracketInTwo result:");
  console.log(bracketObject);

  return bracketObject;

};

app.getReverseBootstrapColumnId = function(firstHalfId) {

  var result;

  // firstHalfId = 1 ... 6
  switch (firstHalfId) {

    case 1:
      result = 12;
      break;
    case 2:
      result = 11;
      break;
    case 3:
      result = 10;
      break;
    case 4:
      result = 9;
      break;
    case 5:
      result = 8;
      break;
    case 6:
      result = 7;
      break;

  }

  console.log("getReverseBootstrapColumnId result:")
  console.log(result);

  return result;

};
