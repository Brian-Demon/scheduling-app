import React from 'react'
import { Routes, Route } from 'react-router-dom'
import Landing from './pages/Landing'
import Login from './pages/Login'

const App = () => {
  return(
    <Routes>
      <Route exact path="/" element={ <Landing/> } />
      <Route exact path="/login" element={ <Login/> } />
    </Routes>
  )
}

export default App