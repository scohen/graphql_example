import ApolloClient from 'apollo-boost'
import gql from 'graphql-tag'

const TOKEN_NAME = 'token'

let apollo = null
let performSignInCheck = true
let activeViewer = null

const GET_VIEWER = gql`
query GetViewer {
  viewer {
    id
    name
  }
}
`

/**
 * Get the active viewer. Issues graphql CHECK_TOKEN request on first attempt.
 * returns {Promise<Object>} active viewer map.
 */
async function getActiveViewer () {
  if (performSignInCheck) {
    performSignInCheck = false
    activeViewer = null
    const token = localStorage.getItem(TOKEN_NAME)
    if (token) {
      try {
        apollo = new ApolloClient({
          credentials: 'omit',
          headers: {
            authorization: `Bearer ${token}`
          }
        })
        const response = await apollo.query({ query: GET_VIEWER })
        if (response.data) {
          activeViewer = response.data.viewer
        }
      } catch (e) {
        console.error(e)
      }
    }
  }
  return activeViewer
}

/**
 * Attempt to sign in with email and password.
 * @param {string} email User's email address.
 * @param {string} password User's password.
 * @returns {Promise<Object>} sign in payload.
 */
async function signIn (email, password) {
  let response
  try {
    response = await fetch('/api/v1/sign_in', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        email,
        password
      })
    })
    const httpStatus = response.status
    if ((httpStatus >= 520) || ((httpStatus >= 502) && (httpStatus <= 504))) {
      throw Error(response.statusText)
    }
  } catch (err) {
    throw err // TODO: retryable error
  }

  let json = { message: `Invalid JSON response.` }
  try {
    json = await response.json()
  } catch (err) {
    // JSON parse error
  }
  if (json.token) {
    localStorage.setItem(TOKEN_NAME, json.token)
    performSignInCheck = true
    await getActiveViewer()
  }
  return json
}

/**
 * Drops token from local storage then forces a reload of /. Never returns.
 */
function signOut () {
  localStorage.removeItem(TOKEN_NAME)
  location.replace('/') // never returns
}

function getApollo () {
  return apollo
}

export { getApollo, getActiveViewer, signIn, signOut }
