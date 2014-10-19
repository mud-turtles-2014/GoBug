$(document).ready(function(){
  $('#expense_form').hide();

  $('#trip_form').on('click', 'input[type=submit]', function(event){
    $('#trip_form').hide();
    $('#expense_form').show();
  });
  $('input#expense_location_id').geocomplete();

  $('form').on('click','.add_fields', function(event){
    event.preventDefault();
    time = new Date().getTime();
    regexp = new RegExp($(this).data('id'), 'g');
    $(this).before($(this).data('fields').replace(regexp, time));
  });
  // $('#add-location').click(function(e){
  //   e.preventDefault();
  //   addLegForm();
  // })

$('body').on('click','.location',function(e){
  $(this).geocomplete();
});

$('#expenses_grid').on('click','#add-expense',function(e){
  console.log("clicked");
  $('#new_expense').show();
  $('#add-expense').hide();
});

$('#expenses_grid').on('submit','#new_expense',function(e){

  e.preventDefault();
  $.ajax ({
    url: $(e.target).attr('action'),
    type: 'POST',
    data: $(e.target).serialize()
  }).done(function(data){
    $('#expenses_grid').append(data);
    clearInputs();
  });

});
});

clearInputs = function(){
  $("input[name='expense[usd_cost]'").val("");
  $("input[name='expense[location_id]'").val("");
  $("input[name='expense[cost]'").val("");
  $("input[name='expense[category_id]'").val("");

};

