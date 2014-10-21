$(document).ready(function(){
    var max = 300;

  $('#expense_description').keyup(function () {
    var len = $(this).val().length;
    var char = max - len;
    if (len >= max) {
      $('#charNum').text(char + ' chars left');
      $('#charNum').css('color', 'red');
      $('.new_expense input[type=submit]').attr('disabled','disabled');
    } else {
      $('#charNum').text(char + ' chars left');
      $('#charNum').css('color', 'grey');
      $('.new_expense input[type=submit]').removeAttr('disabled');
    }
  });

   $('#expense_currency_id').select2();


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
  var old_balance = parseFloat($('#balance-field').text().replace(/[A-Za-z$-,]/g, ""));
  $.ajax ({
    url: $(e.target).attr('action'),
    type: 'POST',
    data: $(e.target).serialize()
  }).done(function(data){
    $('.event-list').append(data);
    var usd = parseFloat($('.event-list li:last-child #usd-cost-field').text().replace(/[A-Za-z$-,]/g, ""));
    var new_balance = (old_balance - usd).toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$&,');
    $('#balance-field').text('$' + new_balance)
    clearInputs();
  });
});

clearInputs = function(){
  $("input[name='expense[usd_cost]'").val("");
  $("input[name='expense[location_id]'").val("");
  $("input[name='expense[cost]'").val("");
  $("input[name='expense[category_id]'").val("");
  $("textarea[name='expense[description]'").val("");
  $("input[name='expense[title]'").val("");
  $('select option:contains("Category")').prop('selected',true);
  $('#charNum').text(max + ' chars left');
  };
});





