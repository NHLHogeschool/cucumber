$(function(){

  // College 1

  window.Product = Backbone.Model.extend({});

  window.Products = Backbone.Collection.extend({
    model: Product,
    url: '/products'
  })

  window.products = new Products();

  window.ProductView = Backbone.View.extend({

    initialize: function() {
      _.bindAll(this, 'render');
      this.template = _.template('<strong><%= title %></strong><br /><%= details %>');
      this.model.on('change', this.render);
    },

    render: function() {
      $(this.el).html(this.template(this.model.toJSON()));
      return this;
    }

  })

  window.ProductsView = Backbone.View.extend({

    initialize: function() {
      _.bindAll(this, 'render');
      this.collection.on('reset', this.render);
    },

    render: function() {
      var that = this;

      this.collection.each(function(product){
        productView = new ProductView({model: product});
        that.$el.append(productView.render().el);
      })

      return this;
    }

  })

  window.ProductsRouter = Backbone.Router.extend({
    routes: {
      '': 'products'
    },

    products: function() {
      var productsView = new ProductsView({collection: products});
      $('#app').html(productsView.render().el);
    }
  })

  window.app = new ProductsRouter();
  products.fetch({reset: true});
  Backbone.history.start({pushState: false});
})