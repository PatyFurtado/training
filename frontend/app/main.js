import React from 'react'
import { render } from 'react-dom'
import { Provider } from 'react-redux'
import { createStore, compose, applyMiddleware } from 'redux'
import thunk from 'redux-thunk'
import reducers from './reducers/index'
import AppPage from './containers/AppPage'
import LoginIndex from './containers/authentication/Index'

import CoursesIndex from './containers/courses/Index'
import CoursesEdit from './containers/courses/Edit'
import CoursesView from './containers/courses/View'
import ModulesEdit from './containers/modules/Edit'
import VideosEdit from './containers/videos/Edit'
import StudentsIndex from './containers/students/Index'
import StudentsEdit from './containers/students/Edit'
import InstructorsIndex from './containers/instructors/Index'
import InstructorsEdit from './containers/instructors/Edit'

import { Router, Route, browserHistory, IndexRoute } from 'react-router'

require('./assets/styles/main.scss')

let store = createStore(reducers,
                        compose(applyMiddleware(thunk),
                        window.devToolsExtension ? window.devToolsExtension() : f => f))

render(
  <Provider store={store}>
    <Router history={browserHistory}>
      <Route path="/">
        <Route path="login" component={LoginIndex} />
        <Route component={AppPage}>
          <IndexRoute component={CoursesIndex}/>
          <Route path="courses">
            <IndexRoute component={CoursesIndex} />
            <Route path="register(/:courseId)" component={CoursesEdit} />
            <Route path="view/:courseId" component={CoursesView} />
            <Route path=":courseId/modules/register(/:moduleId)" component={ModulesEdit} />
            <Route path=":courseId/modules/:moduleId/videos/register(/:videoId)" component={VideosEdit} />
          </Route>
          <Route path="students">
            <IndexRoute component={StudentsIndex} />
            <Route path="register(/:studentId)" component={StudentsEdit} />
          </Route>
          <Route path="instructors">
            <IndexRoute component={InstructorsIndex} />
            <Route path="register(/:instructorId)" component={InstructorsEdit} />
          </Route>
        </Route>
      </Route>
    </Router>
  </Provider>,
  document.getElementById('app')
)
