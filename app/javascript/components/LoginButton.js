import React from 'react';
import axios from 'axios';
import { Button, Form } from 'react-bootstrap';

const LoginButton = (props) => {
  
  return (
    <div id="login-button">
      <Form method="post" action="/auth/intuit">
        <input type="hidden" name="authenticity_token" value={props.token}/>
        <Button type="submit" value="Login with Intuit" variant="success">Login with Intuit</Button>
      </Form>
    </div>
  )
}

export default LoginButton