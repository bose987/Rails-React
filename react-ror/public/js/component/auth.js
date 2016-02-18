module.exports = {
  login(email, pass, cb) {
    cb = arguments[arguments.length - 1]
    if (localStorage.token) {
      if (cb) cb(true)
      this.onChange(true)
      return
    }
    pretendRequest(email, pass, (res) => {
      if (res.authenticated) {
        localStorage.token = res.token
        localStorage.client = res.client
        localStorage.uid = res.uid
        localStorage.role = res.role
        if (cb) cb(true)
        this.onChange(true)
      } else {
        if (cb) cb(false)
        this.onChange(false)
      }
    })
  },
  getHeaders(){
    return {
            "access-token" : localStorage.token,
            "client" : localStorage.client,
            "uid" : localStorage.uid
          }
  },
  getApiUrl(){
    return "http://www.rails.lcl/"
  },
  getToken() {
    return localStorage.token
  },
  getClient() {
    return localStorage.client
  },
  getUid() {
    return localStorage.uid
  },
  isEngg() {
    if(localStorage.role == undefined) {
      return true;
    }
    return localStorage.role == 'engineer' ? true :false;
  },
  isAdmin() {
    return localStorage.role == 'admin' ? true :false;
  },
  logout(cb) {    
    var header = this.getHeaders();
    var url = this.getApiUrl() + "auth/sign_out";
     $.ajax({
            url: url,
            type: "DELETE",
            headers:header, 
            crossDomain: true,
            xhrFields: {
              withCredentials: true
            },
            success: function (data) {
              if(data.success = true){
                delete localStorage.token
                delete localStorage.client
                delete localStorage.uid
                delete localStorage.role
                alert("Logout successfully")
                window.location.replace("#/login")
              }
            }.bind(this),
              error: function (jqXHR, textStatus, errorThrown) {
              alert(textStatus);
            }
     });
    if (cb) cb()
      this.onChange(false)
  },
  loggedIn() {
    return !!localStorage.token
  },
  onChange() {}
}
var auth = require('./auth');
function pretendRequest(email, pass, cb) {
    var postData = { 'email' : email  ,'password' : pass };
    var url = auth.getApiUrl() + "auth/sign_in"
    try{
      $.post(url, postData,
        function(data){
          cb({
            authenticated: true,
            token: data.access_token['access-token'],
            client: data.access_token['client'],
            uid: data.access_token['uid'],
            role: data.data.role
          })
      }).fail(function(err) {
        alert( err.responseJSON.errors );
      });
    }
    catch(err) {
      console.log(err);
    }
}
