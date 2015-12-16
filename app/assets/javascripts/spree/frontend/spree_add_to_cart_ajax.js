// Placeholder manifest file.
// the installer will append this file to the app vendored assets here: vendor/assets/javascripts/spree/frontend/all.js'

(function($) {

  $.fn.addToCartAjaxForm = function() {
    var options = {
      dataType: 'json',
      success: function(e) {
        addAlert('success', e.message);
        $.ajax({ url: Spree.pathFor("cart_link"), success: function(data) {
          $('#link-to-cart').html(data);
        }});
      },
      error: function(e) {
        addAlert('error', JSON.parse(e.responseText).message);
      }
    };
    return this.ajaxForm(options);
  }

  function animate($elem, action, speed, callback) {
    $elem.animate({
      height: action,
      marginBottom: action,
      marginLeft: action,
      marginRight: action,
      marginTop: action,
      opacity: action,
      paddingBottom: action,
      paddingLeft: action,
      paddingRight: action,
      paddingTop: action}, speed, callback);
  }

  function animateAlerts($alerts) {
    if ($alerts.length > 2) {
      animate($alerts.last(), 'hide', 200, function() { $(this).remove(); });
    }
    animate($alerts.first(), 'show', 240);
  }

  function addAlert(type, message) {
    var $content = $('#content');
    $content.prepend('<div style="display: none" class="alert alert-' + type + '">' + message + '</div>');
    animateAlerts($content.find('.alert'));
  }

}(jQuery));
