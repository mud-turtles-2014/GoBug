$(document).ready(function(){

  $('select[name="wishlist_id"').change(function(e){
    e.preventDefault();
    var wishlist_id = $(this).val()
    var expense_id = $(this).parent().children('.expense_id').val()
    var wishlist_button = $(this).closest('.wishlist-button')
    wishlist_button.html('<i>Adding to wishlist...  </i>')
    
    $.ajax ({
      url: '/add_to_wishlist?expense_id=' + expense_id + '&' + 'wishlist_id=' + wishlist_id,
      type: 'POST'
    }).done(function(response){
      wishlist_button.html('<i>In your Wishlist</i>')
    });
  });


  $('.add-to-wishlist').click(function(e){
    e.preventDefault();
    var wishlist_button = $(this).closest('.wishlist-button')
    wishlist_button.html('<i>Adding to wishlist...  </i>')
    
    $.ajax ({
      url:$(e.target).parent().parent().attr('action'),
      type: 'POST'
    }).done(function(response){
      wishlist_button.html('<i>In your Wishlist</i>')
    });

  });


}); 


