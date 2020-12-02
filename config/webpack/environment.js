const { environment } = require('@rails/webpacker')
const { VueLoaderPlugin } = require('vue-loader')
const  vue = require('./loader/vue')

environment.plugins.prepend('VueLoaderPlugin',new VueLoaderPlugin())
environment.loader.prepend('vue',vue)

//　Vue.js フル版(Compiler入り)
environment.config.resolve.alias = { 'vue$': 'vue/dist/vue.esm.js' }

// jqueryとBootstrapのJSを使えるように
const webpack = require('webpeck')
environment.plugins.prepend(
  'Provide',
  new webpack.ProvidePlugin({
    $: 'jquery',
    jQuery: 'jquery',
    Popper: 'popper.js'
  })
)

module.exports = environment
