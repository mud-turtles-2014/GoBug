$(document).ready(function(){
  $('#expense_form').hide();

  $('#trip_form').on('click', 'input[type=submit]', function(event){
    $('#trip_form').hide();
    $('#expense_form').show();
  });
  // $('body').on('click','.location',function(e){
  //   $(this).geocomplete();
  // });

});
