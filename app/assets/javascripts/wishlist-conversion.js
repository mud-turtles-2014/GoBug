$(document).ready(function(){

  $('#expenses_grid').on('click', '#show-done-checkboxes', function(e){
    e.preventDefault();
    $('.conversion-checkboxes').show();
    $('.delete').hide();
    $('#show-done-checkboxes').hide();
    $('.converter').show();
  });

});
