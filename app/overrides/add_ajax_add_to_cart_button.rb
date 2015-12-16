Deface::Override.new(virtual_path: 'spree/shared/_products',
  name: 'add_add_to_cart_button_to_products_page',
  insert_after: '.panel-footer',
  text: <<-eos
    <div class="add_to_cart_products__panel">
      <%= form_for :order, :url => populate_orders_path, html: { class: 'add_to_cart_products__form' } do |f| %>
        <%= hidden_field_tag "variant_id", product.master.id %>
        <%= hidden_field_tag :back, true %>
        <% if product.price_in(current_currency) and !product.price.nil? %>
          <% if product.variants.size > 1 || product.master.can_supply? %>
            <div class="add-to-cart">
              <div class="input-group">
                <%= number_field_tag :quantity, 1, class: 'title form-control', min: 1, step: 1 %>
                <span class="input-group-btn">
                  <%= button_tag :class => 'btn btn-success add_to_cart_products__button', :type => :submit do %>
                    + <span class="glyphicon glyphicon-shopping-cart"></span>
                  <% end %>
                </span>
              </div>
            </div>
          <% else %>
            <div class="out-of-stock"><%= Spree.t(:out_of_stock) %></div>
          <% end %>
        <% else %>
          <div id="product-price">
            <div><span class="price selling" itemprop="price"><%= Spree.t('product_not_available_in_this_currency') %></span></div>
          </div>
        <% end %>
      <% end %>
      <script>
        $(function() {
          $('.add_to_cart_products__form').addToCartAjaxForm();
        });
      </script>
    </div>
  eos
)

Deface::Override.new(virtual_path: 'spree/products/show',
  name: 'add_ajax_form_to_product_page',
  insert_after: '#cart-form',
  text: <<-eos
    <script>
      $(function() {
        $('#cart-form form').addToCartAjaxForm();
      });
    </script>
  eos
)
