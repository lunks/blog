function twitterReactions (json) {
  // Checking the JSON response
  var results = json.response.list;

  twitterReactionsPresenter = document.getElementById("twitter-reactions");;
  twitterReactionsHeader = document.createElement("h5");
  // Creating header before tweets container
  twitterReactionsHeader.id = "twitter-reactions-header";
  twitterReactionsHeader.innerHTML = "Comments";
  twitterReactionsPresenter.parentNode.insertBefore(twitterReactionsHeader, twitterReactionsPresenter);
  tweets = '';
  // If there are any results, iterate over them			
  if ((typeof results !== "undefined") && (results.length > 1)) {
    var resultsLength = results.length,
    current,
    currentAuthor,
    tweet;


    // Iterating over all tweets
    for (var i=resultsLength-1; i>=0; i--) {
      current = results[i];
      currentAuthor = current.author;
      if (typeof current.date_alpha == "undefined") {
        current.date_alpha = "a distant past";
      }
      tweet = '<div class="comment">';
      tweet += '<a href="' + currentAuthor.url + '">' + "@" + currentAuthor.nick  + "</a> said on "+ current.date_alpha + ":";
      tweet += '<div class="comment-text">' + current.content.replace(/(http:\/\/[\w\.\d%\/\-\_]+)/gi, '<a href="$1" class="twitter-link">$1</a>') + '</div>';
      tweet += '</div>';
      tweet += '<hr>';
      tweets += tweet;
    }
  } else {
    tweets = 'No tweets about this post yet. <hr>';
  }
  twitterReactionsPresenter.innerHTML = tweets;
}
