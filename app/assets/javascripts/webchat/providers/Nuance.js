function  Nuance(options) {
  this.openUrl = options.openUrl
  this.API_STATES = [
    "BUSY",
    "UNAVAILABLE",
    "AVAILABLE",
    "ERROR",
    "ONLINE",
    "OFFLINE"
  ]
}

 Nuance.prototype.apiResponseSuccess = function(result) {
  var validState  = this.API_STATES.indexOf(result.status.toUpperCase()) != -1
  var state       = ""

  state = validState ? result.status : "ERROR"

  if (result.inHOP){

    if(result.availability == "true"){
            if(result.status == "online"){
              state="AVAILABLE"
            }
            if (result.status == "busy"){
                state="BUSY"
            }
            if (result.status == "offline"){
                state="UNAVAILABLE"
            }
      }else{
        state="UNAVAILABLE"
      }
  }else{
    state = "UNAVAILABLE"
  }

  return { status: state };
}

 Nuance.prototype.apiResponseError = function(result) {
  return { status: "ERROR" };
}

 Nuance.prototype.handleOpenChat = function(global) {
  //global.open(this.openUrl, 'newwin', 'width=200,height=100')
  window.location.href = ('https://www.tax.service.gov.uk/check-income-tax/webchat-poc?url=' + this.openUrl)
}
