$(document).ready(function(){
  $('td#add').hide();
  $('tr').hover(
    function(){
      $(this).children('td#add').show();
    },
    function(){
      $(this).children('td#add').hide();
    }
  );
  $('select[name="wishlist_id"').change(function(e){
    e.preventDefault();
    var wishlist_id = $(this).val()
    var expense_id = $(this).parent().children('.expense_id').val()
    $.ajax ({
      url: '/add_to_wishlist?expense_id=' + expense_id + '&' + 'wishlist_id=' + wishlist_id,
      type: 'POST'
    });
  });
  $(document).on('click', 'a.converter', function(event) {
    console.log('click');
    expenses = [];
    $('.event-list li').each(function() {
      console.log(this);
       expense = {};
       expense.title = $(this).find('.title').html();
       expense.location = $(this).find('.loc').html();
       expense.category_id = $(this).attr('data-category');
       expenses.push(expense);
     });
    console.log(expenses);
    var div = document.createElement('div');
    div.setAttribute('id', 'form_container');

    var form = document.createElement('form');
    form.setAttribute('action', '/trips/from_expenses');
    form.setAttribute('method', 'POST');
    form.setAttribute('id', 'exp_form')
    div.appendChild(form);
    document.body.appendChild(div);

    for (i=0; i< expenses.length; i++) {
      var exp = expenses[i];
      $('<input>').attr('name', 'title_' + i).attr('value', exp.title ).appendTo('#exp_form');
      $('<input>').attr('name', 'cat_' + i).attr('value', exp.category_id ).appendTo('#exp_form');
      $('<input>').attr('name', 'loc_' + i).attr('value', exp.location ).appendTo('#exp_form');
    }
    $('<input>').attr('type', 'hidden').attr('name', 'number_of_items').attr('value', expenses.length).appendTo('#exp_form');
    $('<input>').attr('type', 'submit').attr('value', 'Create trip').appendTo('#exp_form');

    console.log($('#form_container'));

  });

});

