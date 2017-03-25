const path = require('path');
module.exports = {
  entry: {
    app: path.resolve(__dirname, 'src', 'index.ts')
  },
  output: {
    filename: '[name].bundle.js',
    publicPath: '/build/',
    path: path.resolve(__dirname, 'build')
  },
  devtool: 'source-map',
  module: {
    rules: [
           {
        test: /\.elm$/,
        exclude: [/elm-stuff/, /node_modules/],
        use: [
          { loader: 'elm-hot-loader' }
          ]
      },
      {
        test: /\.elm$/,
        exclude: [/elm-stuff/, /node_modules/],
        use: [
          { loader: 'elm-webpack-loader' }
          ]
      },
      {
        test: /\.ts|\.tsx/,
        use: [
          { loader: 'ts-loader'}
        ],
        exclude: /node_modules/
      },
      {
        enforce: "pre",
        test: /\.ts|\.tsx/,
        use: [
          { loader: 'tslint-loader'}
        ],
        exclude: /node_modules/
      }
    ]
  },
  plugins: [],
  resolve: {
    extensions: [
      ".js", ".ts", ".tsx", ".elm"
    ]
  },
  devServer: {
    contentBase: [path.join(__dirname)],
    watchContentBase: true,
    publicPath: '/build/',
    compress: true,
    port: 9000,
    proxy: {
       "/schedule": {
    target: "http://localhost:8080/schedule",
    pathRewrite: {"^/schedule" : ""}
      }
    }
  }
}