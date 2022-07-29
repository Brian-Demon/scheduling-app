import React, { useEffect, useState } from 'react';
import axios from 'axios';
import { Link } from 'react-router-dom';
import { Navbar, Nav, Container, Button } from 'react-bootstrap';

import LoginButton from './LoginButton';
import LogoutButton from './LogoutButton';

const NavBar = () => {
  const [token, setToken] = useState(document.querySelector('[name=csrf-token]').content);
  const [isLoggedIn, setIsLoggedIn] = useState(false);
  const logo = require("../../assets/images/logo.png")

  useEffect(() => {
    axios.get('http://localhost:3000/logged_in',
      {withCredentials: true})
      .then(response => {
        if (response.data.logged_in) {
          setIsLoggedIn(true);
        } else {
          setIsLoggedIn(false);
        }
      })
      .catch(error => console.log('api errors:', error))
  }), []

  return (
    <div id="navbar">
      <Navbar collapseOnSelect expand="lg" bg="dark" variant="dark">
        <Container>
          <Navbar.Brand as={Link} to="/">
              <img
                alt="lgo"
                src={logo}
                width="60"
                height="33"
                className="d-inline-block align-top"
              />
            </Navbar.Brand>
          <Navbar.Toggle aria-controls="responsive-navbar-nav" />
          <Navbar.Collapse id="responsive-navbar-nav">
            <Nav className="me-auto">
              <Nav.Link as={Link} to="/test">
                Test
              </Nav.Link>
            </Nav>
            <Nav>
              {isLoggedIn ? <LogoutButton setToken={setToken} setIsLoggedIn={setIsLoggedIn} /> : <LoginButton token={token} setIsLoggedIn={setIsLoggedIn} />}
            </Nav>
          </Navbar.Collapse>
        </Container>
      </Navbar>
    </div>
  )
}

export default NavBar