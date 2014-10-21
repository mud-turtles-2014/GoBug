$(document).ready(function(){

  $('#expense_description').keyup(function () {
    var max = 300;
    var len = $(this).val().length;
    var char = max - len;
    if (len >= max) {
      $('#charNum').text(char + ' chars left');
      $('#charNum').css('color', 'red');
    } else {
      $('#charNum').text(char + ' chars left');
      $('#charNum').css('color', 'grey');
    }
  });


  $("#menu-toggle").click(function(e) {
      e.preventDefault();
      console.log("hello")
      $("#wrapper").toggleClass("active");
  });

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

$('#expenses_grid').on('click','#add-expense', function(e){
  e.preventDefault();
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
    $('.event-list').append(data);
    clearInputs();
  });
});

clearInputs = function(){
  $("input[name='expense[usd_cost]'").val("");
  $("input[name='expense[location_id]'").val("");
  $("input[name='expense[cost]'").val("");
  $("input[name='expense[category_id]'").val("");
  };
});





