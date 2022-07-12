import React from 'react'
import "bootstrap/dist/css/bootstrap.min.css"
import { Routes, Route } from 'react-router-dom'

import Landing from './pages/Landing'
import NavBar from './Navbar'

const App = () => {
  return (
    <>
      <NavBar />
      <Routes>
        <Route exact path="/" element={<Landing />} />
      </Routes>
    </>
  )
}

export default App