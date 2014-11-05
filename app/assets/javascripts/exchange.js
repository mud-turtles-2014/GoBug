$(document).ready(function(){

  $('body').on('change','#expense_currency_id',function(e){
    currency_exchange();
    });

   $('body').on('focusout','#expense_cost',function(e){
   currency_exchange();
    });

  var original_value = ""
  $('.best_in_place[data-bip-attribute="cost"]').on('click',function(){
    original_value = parseFloat($(this).text().replace(/[A-Za-z$-,]/g, ""));
  });

  var converted = ""
  $('time').change(function(e){
    var foreign_cost = e.target.value
    var code = e.delegateTarget.dataset.currencyCode
    var difference = parseFloat(original_value - foreign_cost)
    var diff_converted = fx.convert(difference, {from: code, to :"USD"}).toFixed(2)
    var new_balance = parseFloat($('#balance-field').text().replace(/[A-Za-z$-,]/g, "")) + parseFloat(diff_converted)
    converted = fx.convert(foreign_cost, {from: code, to: "USD"}).toFixed(2)
    $('.usd-cost-field', e.delegateTarget).text('$'+converted)
    $('#balance-field').text('$'+new_balance)
  });



  $.getJSON(
        'http://openexchangerates.org/api/latest.json?app_id=10eff371738744b3b3f187281d3f9a06',
        function(data) {
            // Check money.js has finished loading:
            var currency_data = data
            if ( typeof fx !== "undefined" && fx.rates ) {
                fx.rates = data.rates;
                fx.base = data.base;
            } else {
                // If not, apply to fxSetup global:
                var fxSetup = {
                    rates : data.rates,
                    base : data.base
                }
            }
        });
});

function currency_exchange() {
   $('#expense_usd_cost').val("")
    var cost = $('#expense_cost').val();
    var currency = $('#expense_currency_id option:selected').text()
    var converted = fx.convert(cost, {from: currency, to: "USD"}).toFixed(2)
    $('#expense_usd_cost').val(converted + " USD")
}
