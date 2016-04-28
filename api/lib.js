if(!window.jQuery){
  var s = document.createElement("SCRIPT");
  s.src = "http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js";
  document.getElementsByTagName("head")[0].appendChild(s);
}
var LinguaLatina = {
  "declination":function(string,lambda){
    $.getJSON("https://lingua-latina.tk/guess.pl?word="+encodeURIComponent(string)+"&format=json&callback=?", function (data){
      if(data['status']['type'] == 'error'){
	throw new Error("An error occurred. Server sent the following summary: " + data['status']['code']);
	
      }
      if(data['query']['declination'] == ''){
	throw new Error("Sorry, but declination of your word couldn't be recognized");
	
      }
      lambda(data['query']);
      });
    }
};