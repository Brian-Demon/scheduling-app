import React, { useState, useEffect } from 'react'
import axios from 'axios';

const Login = () => {
  const handleLoginSubmit = () => {
    let email = document.getElementById("loginEmail").value;
    let password = document.getElementById("loginPassword").value;
    if (!email || !password) return;

    let login_data = {
      email: email,
      password: password,
      password_confirmation: password,
    }

    axios.post("/api/v1/login", login_data)
      .then( response => console.log(JSON.stringify(response.data)) )
      .catch( error => console.log(JSON.stringify(error)) )
  }

  return(
    <div id='login-page-container' className='container-fluid bg-secondary bg-gradient p-2 text-dark bg-opacity-10'>
      <form className='m-5'>
        <div className="mb-3">
          <label className="label-login-form-email">Email address</label>
          <input type="email" className="form-control" id="loginEmail" placeholder="name@example.com" required/>
        </div>
        <div className="mb-3">
          <label className="label-login-form-password">Password</label>
          <input type="password" className="form-control" id="loginPassword" required />
        </div>
        <div className="pt-1">
          <button type="submit" className="btn btn-primary" onClick={() => {handleLoginSubmit()}}>Login</button>
        </div>
      </form>
    </div>
  )
}

export default Login