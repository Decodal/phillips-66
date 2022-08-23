var webpack = require("webpack"),
  path = require("path"),
  glob = require("glob"),
  MiniCssExtractPlugin = require('mini-css-extract-plugin');
  PurifyCSSPlugin = require("purifycss-webpack"),
  CleanWebpackPlugin = require("clean-webpack-plugin"),
  BuildManifestPlugin = require("./build/plugins/BuildManifestPlugin"),
  CopyWebpackPlugin = require("copy-webpack-plugin"),
  BrowserSyncPlugin = require("browser-sync-webpack-plugin"),
  WebpackNotifierPlugin = require("webpack-notifier"),
  inProduction = process.env.NODE_ENV === "production";

module.exports = {
  mode: inProduction ? 'production' : 'development',
  entry: {
    app: "./01_src/js/app.js"
  },
  output: {
    path: path.resolve(__dirname, "./public/assets"),
    filename: "./js/[name].js"
  },
  module: {
    rules: [
      {
        test: /\.(woff|woff2|eot|ttf|svg)$/,
        use: {
          loader: "url-loader",
          options: {
            limit: 8192,
            name: "./fonts/[name].[ext]"
          }
        }
      },
      {
        test: /\.(sa|sc|c)ss$/,
        use: [
          MiniCssExtractPlugin.loader,
          'css-loader',
          'postcss-loader',
          'sass-loader',
        ],
      },
      {
        test: /\.js$/,
        exclude: /node_modules/,
        loader: "babel-loader",
        query: {
          presets: [
            [
              "@babel/preset-env",
              {
                "useBuiltIns": "entry"
              }
            ]
          ]
        }
      }
    ]
  },
  watchOptions: {
    ignored: /node_modules/
  },
  plugins: [
    new MiniCssExtractPlugin({
      filename: './css/styles.css'
    }),

    new webpack.LoaderOptionsPlugin({
      minimize: inProduction
    }),
    new webpack.ProvidePlugin({
      $: "jquery",
      jQuery: "jquery"
    }),

    // Use this when adding hashes to styles and scripts for caching
    // It will delete and recreate the folders specified though so be careful!
    /*new CleanWebpackPlugin(['dist'], {
            root:__dirname,
            verbose:true,
            dry:false
        }),*/

    new CopyWebpackPlugin({
      
        // Add any libraries here that might be page specific and loaded using head.load
        patterns: [
          {
            from: "node_modules/jquery-validation/dist/jquery.validate.min.js",
            to: "js/lib/"
          }
        ]
        // {
        //   from: "node_modules/slick-carousel/slick/",
        //   to: "js/lib/slick/"
        // }
   
    }),

    new BrowserSyncPlugin({
      host: "localhost",
      port: 3000,
      proxy: "http://local.communisis/", //this needs to be the local url for the website as defined by you
      files: [
        "craft/templates/**/*.twig",
        "01_src/scss/*.scss",
        "01_src/js/*.js"
      ]
    }),

    new WebpackNotifierPlugin()

    // This outputs the name of the files into a manifest.json file
    // Need to figure out the best way of re-writing header / footer files with these values.
    // See build/plugins for code.
    // new BuildManifestPlugin()
  ]
};

if (inProduction) {
  // module.exports.plugins.push(new webpack.optimize.UglifyJsPlugin());

  // this doesnt work with browsersync so will only run during production webpack call
  // module.exports.plugins.push(
  //   new PurifyCSSPlugin({
  //     paths: glob.sync(path.join(__dirname, "craft/templates/**/*.twig")),
  //     minimize: inProduction
  //   })
  // );
}
