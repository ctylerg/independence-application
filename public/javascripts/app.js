var app = app || {};

/**
 * This function is designed to take a bracket number + team and
 * append it to the appropriate ID on the page.
 * @bracketNumber: ID associated with bracket
 * @teamName: string that is name of Team
 */
app.placeTeamInBracket = function(bracketNumber, teamName) {

  // ### refcator:
  // var game = round[n];               //get game matchups
  // var html = $('<div><p>' + game.team_a + '</p><p>' + game.team_b + '</p></div>');
  // html.addClass('game'); //add Class to games to refernce in styling
  //   html.hide(); //makes games not shift as other games come in
  //
  // (function (){      //bring in round by round but delayed
  //   var locali = i+1;  //i+1 keeps the "#round1" as round1 and not round2
  //   console.log("local i:"+locali)
  //   var localhtml = html;
  //   setTimeout(function(){
  //     $('#round'+locali).append(localhtml);
  //     localhtml.fadeIn(2000);
  //   }, (i*6600));
  // })();

  $('#round-' + bracketNumber).append("<br>" + teamName);
  return true;

};

app.splitBracketInTwo = function(bracketArray) {

}
