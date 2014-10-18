$(document).ready(function(){
  console.log("ready")

  $('form').on('click','.remove_fields', function(event){
    event.preventDefault();
    $(this).prev('input[type=hidden]').val('1');
    $(this).closest('fieldset').hide();
  });

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
  console.log("clicked")
  $('#new-expense').show();
  $('#add-expense').hide();
});

$('#expenses_grid').on('submit','#new-expense',function(e){
  
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
})

clearInputs = function(){
  $(':input').val("");
}
