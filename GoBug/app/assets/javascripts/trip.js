$(document).ready(function(){

  $('body').on('click','.location',function(e){
    $(this).geocomplete();
  });

})
