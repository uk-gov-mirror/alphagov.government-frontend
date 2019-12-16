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
  var validState  = this.API_STATES.indexOf(result.response) != -1
  return validState ? { status: result.response } : { status: "ERROR" }
}

 Nuance.prototype.apiResponseError = function(result) {
  return { status: "ERROR" };
}

 Nuance.prototype.handleOpenChat = function(global) {
  global.open(this.openUrl, 'newwin', 'width=200,height=100')
}
