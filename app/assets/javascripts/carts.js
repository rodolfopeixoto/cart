// AddCart

$(window).load(function(){
  return $('a[data-target]').click(function(event){
    var $this, input;
    event.preventDefault();
    $this = $(this);
    input = $('input#product_quantity').val();
    console.log(input);
  });
});

$(window).load(function() {
  return $('a[data-target]').click(function(e) {
    var $this, new_target, url;
    e.preventDefault();
    $this = $(this);
    if ($this.data('target') === 'Add to') {
      url = $this.data('addurl');
      new_target = "Remove from";
    } else {
      url = $this.data('removeurl');
      new_target = "Add to";
    }
    return $.ajax({
      url: url,
      type: 'put',
      success: function(data) {
        $('.cart-count').html(data);
        $this.find('span').html(new_target);
        return $this.data('target', new_target);
      }
    });
  });
  
});


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