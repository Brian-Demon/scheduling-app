import React, { useState } from 'react';
import axios from 'axios';
import { Button, Form } from 'react-bootstrap';

const LogoutButton = (props) => {

  function handleLogout() {
    axios.delete('http://localhost:3000/logout')
      .then(response => {
        if (!response.data.logged_in) {
          props.setIsLoggedIn(false);
          props.setToken(response.data.csrf)
        }
      })
      .catch(error => console.log('api errors:', error))
  }
  
  return (
    <div id="logout-button">
      <Button variant="danger" onClick={handleLogout}>Logout</Button>
    </div>
  )
}

export default LogoutButton