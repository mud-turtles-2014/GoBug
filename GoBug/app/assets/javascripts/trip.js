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
})
