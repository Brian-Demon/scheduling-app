import React from 'react'
import "bootstrap/dist/css/bootstrap.min.css"
import { Routes, Route } from 'react-router-dom'

import Landing from './pages/Landing'
import NavBar from './Navbar'
import Test from './pages/Test'

const App = () => {
  return (
    <div id="schedule">
      <NavBar />
      <Routes>
        <Route exact path="/" element={<Landing />} />
        <Route exact path="/test" element={<Test />} />
      </Routes>
    </div>
  )
}

export default App