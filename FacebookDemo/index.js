$(function(){
    var app_id = '2945680822359869';
    var scopes = 'email, user_friends, user_online_presence';

    var btn_login = ' <a href="#" id="login" class="btn btn-primary">Login</a>';

    var div_session = "<div id='facebook-session'>"+
                      "<strong></strong>"+
                      "<img>"+
                      "<a href='#' id='logout' class='btn btn-danger'>Cerrar Sesion</a>"+
                      "</div>";

    window.fbAsyncInit = function(){
        FB.init({
            appId : 'app_id',
            status : true,
            cookie : true,
            xfbml : true,
            version : 'v2.1'
        });
        FB.getLoginStatus(function(response){
            statusChangeCallback(response, function(){

            });
        });
    };

    var statusChangeCallback = function(response, callback){
       // console.log('statusChangeCallback');
        console.log(response);

        if(response.status === 'connected'){
            getFacebookData();
        } else {
            callback(false);
            //document.getElementById('status').innerHTML = 'Please log' + 'into this app.';
        } //else {
          //  document.getElementById('status').innerHTML = 'Please log' + 'into Facebook';
        //}
    }

    var checkLoginState = function(){
        FB.getLoginStatus(function(response){
            statusChangeCallback(response);
        });
    }


})