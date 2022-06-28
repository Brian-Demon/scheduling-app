import axios from 'axios'
import React, { useState, useEffect } from 'react'

const Landing = () => {
  const url = '/api/v1/users'
  const [users, setUsers] = useState([])
  const [userCount, setUserCount] = useState(0)

  let content = []

  useEffect(() => {
    axios.get(url)
      .then(response => {
        setUsers(configureAndSetUsers(response.data))
        setUserCount(users.length)
      })
  }, [userCount])

  const configureAndSetUsers = (data) => {
    data = data['data'];
    let new_users = [];

    data.map((user) => {
      let new_user = {}
      new_user["id"] = (user["attributes"]["id"])
      new_user["email"] = (user["attributes"]["email"])
      new_user["first_name"] = (user["attributes"]["first_name"])
      new_user["last_name"] = (user["attributes"]["last_name"])
      new_user["title"] = (user["attributes"]["title"])
      new_user["role"] = (user["attributes"]["role"])
      new_user["provider"] = (user["attributes"]["provider"])
      new_user["shifts"] = (user["relationships"]["shifts"]["data"])
      new_user["exclusions"] = (user["relationships"]["exclusions"]["data"])

      new_users.push(new_user);
    })

    return new_users;
  }

  const handleAddUser = () => {
    let userCount = users.length
    let new_user = {
      user: {
        email: `Test_${userCount}@gmail.com`,
        password: `${userCount}`,
        password_confirmation: `${userCount}`,
        first_name: "Test",
        last_name: `${userCount}`,
      }
    }

    console.log(`A DATA: ${JSON.stringify(new_user)}`)
    axios.post("/api/v1/users", new_user)
      .then(response => { setUserCount(users.length) })
      .catch((error) => {
          console.log(error);
      });
  }

  const handleRemoveUser = () => {
    let userCount = users.length
    let user_to_delete = users[users.length - 1]
    let data = {
      user: {
        email: user_to_delete['email'],
        password: user_to_delete['password'],
        password_confirmation: user_to_delete['password_confirmation'],
        first_name: user_to_delete['first_name'],
        last_name: user_to_delete['last_name'],
      }
    }
    console.log(`D DATA: ${JSON.stringify(data)}`)
    axios.delete(`/api/v1/users/${user_to_delete['id']}`, data)
      .then(response => { setUserCount(users.length) })
      .catch((error) => {
          console.log(error);
      });
  }

  if (users) {
    content = 
      <>
        <div className='py-4'>
        <button onClick={() => handleAddUser()}>Add User</button>
        {users.length > 0 ? 
          <button onClick={() => handleRemoveUser(users.length)}>Remove Last User</button>
          :
          <></>
        }
        
        </div>
        <div>
          <ul>
            {users.map(user => {
              return (
                <li>
                  {JSON.stringify(user)}
                </li>
              )
            })}
          </ul>
        </div>
      </>
  }

  return (
    <div>
      {content}
    </div>
  )
}

export default Landing
