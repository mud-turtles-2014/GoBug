$(document).ready(function(){
  $('#expense_form').hide();

  $('#trip_form').on('click', 'input[type=submit]', function(event){
    $('#trip_form').hide();
    $('#expense_form').show();
  });

  $('input#expense_location_id').geocomplete();

});
