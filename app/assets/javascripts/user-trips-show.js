$(document).ready(function(){
	$('.trip').hover(function(){
		$(this).css('background-color','red')
	},function(){
		$(this).css('background','none')
	});

	$('.best_in_place').best_in_place()

	$('body').on('click','.delete',function(e){
		var usd = $(e.target).closest('li').children('time').children('#usd-cost-field').text();
		usd = parseFloat(usd.replace(/[A-Za-z$-,]/g, ""));
		$(e.target).closest('li').hide();
		var old_balance = parseFloat($('#balance-field').text().replace(/[A-Za-z$-,]/g, ""));
		var new_balance = (old_balance + usd).toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$&,');
		$('#balance-field').text('$' + new_balance)
	})

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