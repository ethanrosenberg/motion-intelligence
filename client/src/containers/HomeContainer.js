
import React from 'react';

import Container from 'react-bootstrap/Container';
import { Form, Button, FormControl, InputGroup } from 'react-bootstrap'


class HomeContainer extends React.Component {
  constructor() {
    super()
    this.state = {
      frames: '',
      url: ''
    }

  }

  handleSearchChange = event => {
     this.setState({
       url: event.target.value
     });
   }

   render() {

  const formInputStyle = {
    backgroundColor: this.state.recursive ? '#c6e2ff' : '#FFFFFF',
    height: '50px',
    fontSize: '20px'

  };

  const submitStyle = {
    backgroundColor: '#000000'
  };

  const search = () => {


  const headers = {
    method: "POST",
    headers: {
      "Content-Type": "application/json"
    },
    body: JSON.stringify({  url: this.state.url })
  }

  console.log("Starting new process request... ")
  console.log(this.state.url)

  fetch('http://localhost:3000/api/v1/new_search', headers)
    .then(r => r.json())
    .then(response => {
      console.log("Results...")

      this.setState({
          frames: [...response]
        })



    })

}

const handleSearchSubmit = event => {

  event.preventDefault()

  search()

}



     return (

        <Container>
        <br></br>
        <center><h1>Welcome to Motion Intelligence.</h1></center>
        <br></br>

        <Form onSubmit={handleSearchSubmit} >
              <FormControl
              style={formInputStyle}
               ref={this.inputRef}
                placeholder="enter a video url..."
                aria-label="comment..."
                aria-describedby="basic-addon2"
                onChange={this.handleSearchChange}
              />

              <br></br>
                <Button style={submitStyle} variant="primary" type="submit" size="lg">
                  Search
               </Button>
            </Form>
            <br></br>
            <br></br>


            { this.state.frames.length > 0
              ?
              this.state.frames.map((item, key) =>
                <img key={key} height='200px' align="center" src={item} />
              )
              :
              null

            }



        </Container>


     )

   }

 }

 export default HomeContainer;
