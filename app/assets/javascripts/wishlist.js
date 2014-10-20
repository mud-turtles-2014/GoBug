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

});
