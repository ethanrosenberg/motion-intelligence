
import React from 'react';

import PulseLoader from "react-spinners/PulseLoader";

class Loader extends React.Component {



render()



return (

  <PulseLoader
    size={75}
    //size={"150px"} this also works
    color={"#c2b5ff"}
    loading={this.state.loading}
  />

)

}
export default Loader;
