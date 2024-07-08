import { useQuery } from '@apollo/client'

import { addApolloState, initializeApollo } from '@/lib/apolloClient'

import { GET_ME } from '.'

export default function About() {
  const { loading, error, data } = useQuery(GET_ME)

  if (loading) return <p>Loading...</p>
  return (
    <>
      <h1>About Page</h1>
      <p>This page using Server Side Rendering to fetch User Info</p>
      {error ? <p>Error: {error.message}</p> : <p>{data?.me.name}</p>}{' '}
    </>
  )
}
export async function getServerSideProps() {
  const apolloClient = initializeApollo()
  try {
    await apolloClient.query({
      query: GET_ME
    })
  } catch (error) {
    console.log('error', error)
  }
  return addApolloState(apolloClient, {
    props: {}
  })
}
