$(document).ready(function(){

  $('body').on('change','.currency select',function(e){
    $('#usd input').val("")
    var cost = $('.currency input').val();
    var currency = $('.currency select').val();
    var converted = fx.convert(cost, {from: currency, to: "USD"}).toFixed(2)
    $('#usd input').val(converted + " USD")
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

  // $('.currency').focusout(function(){
  //   var cost = $('.currency input').val();
  //   var currency = $('.currency input select').val();
  //   var converted = fx.convert(cost, {from: currency, to: "USD"});
  //   $('#usd').prepend(converted + "USD")
  // })

  // $('.new_expense').on('ajax:success', function(event, data){
  //       console.log("hi")
  //       console.log(data)
  //     })
  //   })