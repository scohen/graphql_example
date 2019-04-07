import Vue from 'vue'

// https://webpack.js.org/guides/dependency-management/#require-context
const requireComponent = require.context('@/components', true, /[a-z0-9-]+\.vue$/i)

// For each matching file name...
requireComponent.keys().forEach(fileName => {
  const componentConfig = requireComponent(fileName)
  const componentName = fileName
    .substr(fileName.lastIndexOf('/') + 1)
    .replace(/\.\w+$/, '')
  Vue.component(componentName, componentConfig.default || componentConfig)
})
