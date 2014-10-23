$(document).on('click', '.converter', function(event){
    expenses = [];
    $('.event-list li').each(function() {
      if ($(this).find("input[name='did_it']").prop('checked')) {
       expense = {};
       expense.title = $(this).find('.title').html();
       expense.location = $(this).find('.loc').html();
       expense.category_id = $(this).attr('data-category');
       expense.currency_id = $(document.body).find('.currency-code').html();
       expenses.push(expense);
       console.log(expense);
     }
    var div = document.createElement('div');
    div.setAttribute('id', 'form_container');

    var form = document.createElement('form');
    form.setAttribute('action', '/trips/from_expenses');
    form.setAttribute('method', 'POST');
    form.setAttribute('id', 'exp_form');
    div.appendChild(form);
    $(document.body).find("#expenses_grid").append(div).hide();

    for (i=0; i< expenses.length; i++) {
      var exp = expenses[i];
      $('<input>').attr('name', 'title_' + i).attr('value', exp.title ).appendTo('#exp_form');
      $('<input>').attr('name', 'cat_' + i).attr('value', exp.category_id ).appendTo('#exp_form');
      $('<input>').attr('name', 'loc_' + i).attr('value', exp.location ).appendTo('#exp_form');
      $('<input>').attr('name', 'cur_' + i).attr('value', exp.currency_id ).appendTo('#exp_form');
    }
    $('<input>').attr('type', 'hidden').attr('name', 'number_of_items').attr('value', expenses.length).appendTo('#exp_form');
    $('<input>').attr('type', 'submit').attr('value', 'Create trip').appendTo('#exp_form');
  });
    $("#exp_form").submit();
  });