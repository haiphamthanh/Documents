const path = require('path')
const webpackNodeExternals = require("webpack-node-externals");

module.exports = {
    entry: {
        server: "./app.js"
    },
    output: {
        path: path.join(__dirname, 'dist'),
        filename: "bundle.js"
    },
    target: 'node',
    node: {
        __dirname: false,
        __filename: false
    },
    externals: [webpackNodeExternals()],
    module: {
        rules: [
            {
                // Dịch từ ES6 sang ES5
                test: /\.js$/,
                exclude: /node_modules/,
                use: {
                    loader: "babel-loader"
                }
            }
        ]
    }
}