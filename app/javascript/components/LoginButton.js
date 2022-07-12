import React from 'react'
import { Button } from 'react-bootstrap';

const LoginButton = () => {
  const handleLoginClick = () => {
    console.log("LOGIN");
  }

  return (
    <>
      <div id="login_button">
        <Button variant="dark" onClick={() => handleLoginClick()}>Login</Button>{' '}
      </div>
    </>
  )
}

export default LoginButton