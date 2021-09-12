$(document).ready(function(){   
 
    // add event listener on the login button
    
    $("#login").click(function(){
   
       facebookLogin();
   
      
    });

    // add event listener on the logout button
 
  $("#logout").click(function(){
 
    $("#logout").hide();
    $("#login").show();
    $("#status").empty();
    facebookLogout();
 
  });

    function facebookLogin()
    {
      FB.getLoginStatus(function(response) {
          console.log(response);
          statusChangeCallback(response);
      });
    }

    function statusChangeCallback(response)
    {
        console.log(response);
        if(response.status === "connected")
        {
           $("#login").hide();
           $("#logout").show(); 
           fetchUserProfile();
        }
        else{
            // Logging the user to Facebook by a Dialog Window
            facebookLoginByDialog();
        }
    }
    function fetchUserProfile()
    {
      console.log('Welcome!  Fetching your information.... ');
      FB.api('/me?fields=id,name,email,gender,birthday,picture', function(response) {
        console.log(response);
        console.log('Login exitoso: ' + response.name);
        var profile = `<h3 class="alert alert-warning">Bienvenido ${response.name}<h3>
        <h3 class="alert alert-success">Imagen de Usuario:</h3>
        <img class="rounded-circle" width="100" height="100" src="${response.picture.data.url}">
        <h3 class="alert alert-primary">Correo del usuario: ${response.email}</h3>`;
        $("#status").append(profile);
      });
    }

    function facebookLoginByDialog()
  {
    FB.login(function(response) {
       
        statusChangeCallback(response);
       
    }, {scope: 'public_profile,email'});
  }

  function facebookLogout()
  {
    FB.logout(function(response) {
        statusChangeCallback(response);
    });
  }
});