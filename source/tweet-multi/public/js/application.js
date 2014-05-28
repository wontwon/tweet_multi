$(document).ready(function(){
  $('#wrapper').tubular({videoId: 'N3JkCCQ2EFY'});

// Buttons-------------------------------------

  $('button#sign-out').click(function(){
        window.location.href='/sign_out';
    });

    $('button#sign-in').click(function(){
        window.location.href='/sign_in';
    });




  var Tweet = {
    postTweet: function(text){
      $.ajax({
        type: 'POST',
        url: '/tweet/create',
        data: {text: text}
      }).done(function(){
        $('#tweeting h1').html('All done');
        $('#tweeting').click(function(){
        $(this).fadeOut();
          })
        $('form input').attr('disabled', false);
        $('input[name=tweet]').val("");
        })
        .fail(function(){
          $('#tweeting h1').html('No bueno, bro');
          $('#tweeting').click(function(){
            $(this).fadeOut();
          $('form input').attr('disabled', false);
          });
        });
    }
  }

  $('#tweet-submit').click(function(e){
    var loading = '<div id="tweeting"><h1>Uploading Tweet</h1></div>'
    e.preventDefault();
    $('form input').attr('disabled', true);
    $('.container').append(loading);
    $('#tweeting').hide();
    $('#tweeting').fadeIn();
      var text = $('input[name=tweet]').val();
      Tweet.postTweet(text);
      });
});

