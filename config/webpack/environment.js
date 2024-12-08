const { environment } = require('@rails/webpacker')

module.exports = environment

const webpack = require('webpack')
environment.plugins.prepend(
  'Provide',
  new webpack.ProvidePlugin({
    $: 'jquery/src/jquery',
    jQuery: 'jquery/src/jquery',
    Popper: 'popper.js'
  })
)
// webpackを使用して、javascriptライブ拉致や依存関係を設定する
// Webpack.ProvidePluginは指定されたモジュールjqueryとpopper.jsをインポートし、全体で利用できるようにする
// ファイル一つ一つにモジュールを指定しなくても済むようになる
// "$"と"jquery"は、jqueryライブラリのグローバル変数
// Popperはpopper.jsのインポートを自動的にインポートする設定で、Bootstrapに必要なjavascriptファイルっぽい
// 要はbootstrapはjqueryとpopperが必要で、それを全体に適用するための設定