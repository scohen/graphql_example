module.exports = {
  assetsDir: 's',
  chainWebpack (config) {
    config.module
      .rule('gql')
      .test(/\.gql$/)
      .use('graphql-tag/loader')
      .loader('graphql-tag/loader')
      .end()
  },
  devServer: {
    disableHostCheck: true,
    proxy: {
      '/graphql': {
        target: 'http://localhost:4000'
      },
      '/api': {
        target: 'http://localhost:4000'
      }
    }
  },
  lintOnSave: false
}
