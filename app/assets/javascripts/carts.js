
//getUser

  function getUser(url){
    return url.match(/\d/)
  }


// AddCart
$(window).load(function() {
  return $('a[data-target]').click(function(e) {
    var $this, new_target, url, id_user, quantity;
    quantity = $('input#product_quantity').val();
    e.preventDefault();
    $this = $(this);
 
     url = $this.data('addurl');
     var price = document.querySelector("#product_price").textContent;

    id_user = getUser(url);
    return $.ajax({
      url: '/cart/add/'+id_user+'/'+quantity + '/' + price,
      type: 'put',
      success: function(data) {
        $('.cart-count').html(data);
      }
    });
  });
  
});

$(window).load(function(){
  subtotals = document.querySelectorAll("#subtotal")
  var total = 0

  for(var i = 0; i < subtotals.length; i++){
    total = total + parseFloat(subtotals[i].textContent);
  }
  var total_html = document.querySelector("span#total");
  
   if (total_html){
    total_html.textContent = total;
   }

})


// Remove Cart

$(window).load(function() {
  return $('#mycart .fi-x').click(function(e) {
    var $this, url;
    e.preventDefault();
    $this = $(this).closest('a');
    url = $this.data('targeturl');
    return $.ajax({
      url: url,
      type: 'put',
      success: function(data) {
        $('.cart-count').html(data);
        return $this.closest('.cart-movie').slideUp();
      }
    });
  });
});


$(window).load(function(){
  return $("#checkout").click(function(event){
    var $this
    event.preventDefault();
    alert('Thanks!!');
  })
})