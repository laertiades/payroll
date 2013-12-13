function editWorker(){
  $.ajax({
    url: location.href,
    type: "POST",
    data: { _method:'PATCH', modus:$('#field').val(), value:$('#value').val() },
    success: function(msg) {
      $('body div.container').html(msg);
      $('body div.container').prepend('<div class="alert alert-success">change was successful</div>');
    },
    error: function(msg, msg2, msg3) {
      $('.alert').remove();
      $('body div.container').prepend('<div class="alert alert-error">' + msg3 + '</div>');
    }
  });
}
function createCheck(id){
  var re = /^[1-9]\d*(\.\d+)?$/;
  if (re.test($('#hours').val())) {
  $.ajax({
    url: '/createcheck',
    type: "POST",
    data: { hours:$('#hours').val(), worker_id:id },
    success: function(msg) {
      $('body div.container').html(msg);
      $('body div.container').prepend('<div class="alert alert-success">Check Created</div>');
    },
    error: function(msg, msg2, msg3) {
      $('.alert').remove();
      $('body div.container').prepend('<div class="alert alert-error">' + msg3 + '</div>');
    }
  });
  }
  else { alert("bad hours value"); }
}
