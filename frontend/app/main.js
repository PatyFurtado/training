import React from 'react'
import { render } from 'react-dom'
import { Provider } from 'react-redux'
import { createStore, compose, applyMiddleware } from 'redux'
import thunk from 'redux-thunk'
import reducers from './reducers/index'
import AppPage from './containers/AppPage'

import { Router, Route, hashHistory } from 'react-router'

require('./assets/stylesheets/style.scss')
require('./assets/stylesheets/_bootstrap.scss')

let store = createStore(reducers, compose(applyMiddleware(thunk), window.devToolsExtension ? window.devToolsExtension() : f => f))

render(
  <Provider store={store}>
    <Router history={hashHistory}>
      <Route path="/" component={AppPage} />
    </Router>
  </Provider>,
  document.getElementById('app')
)
