import React from 'react';
import { TOPage } from './book/TOPage';

function App() {
  let blockList = [{id:1,text:"😄😄123456789012345678901234567890123456789012345678901234567890",type:1,x:100,y:100,width:100}
  ];
  return (
    <TOPage blockList={blockList}></TOPage>
  );
}

export default App;
