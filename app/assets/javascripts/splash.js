$(document).ready(function(event){
  $('.splash-search input[type=text]').keypress(function(event){
    if (event.which == 13) {
      evenet.preventDefault();
      $('form').submit();
      console.log("hi");
    }
  })
})