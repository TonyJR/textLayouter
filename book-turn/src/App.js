import React from 'react';
import './App.css';
import { TOPaper } from './TOBook/TOPaper';
import { TOBook } from './TOBook/TOBook';
import { BookController } from './BookController';

function App() {


  return (
   <div style={{
     position:"absolute",
     top:200,
     left:200,
   }}>
    <BookController>
      <div style={{width:"100%",height:"100%",backgroundColor:"#0f0"}}>
        <input></input>
        <button>1</button>
      </div>
      <div style={{width:"100%",height:"100%",backgroundColor:"#10f"}}>
        <button>2</button>
      </div>
      <div style={{width:"100%",height:"100%",backgroundColor:"#200"}}>
        <button>3</button>
      </div>
      <div style={{width:"100%",height:"100%",backgroundColor:"#300"}}>
        <button>4</button>
      </div>
      <div style={{width:"100%",height:"100%",backgroundColor:"#400"}}></div>
      <div style={{width:"100%",height:"100%",backgroundColor:"#500"}}></div>
      <div style={{width:"100%",height:"100%",backgroundColor:"#600"}}></div>
      <div style={{width:"100%",height:"100%",backgroundColor:"#700"}}></div>
      <div style={{width:"100%",height:"100%",backgroundColor:"#800"}}></div>
      <div style={{width:"100%",height:"100%",backgroundColor:"#900"}}></div>
      <div style={{width:"100%",height:"100%",backgroundColor:"#a00"}}></div>
      <div style={{width:"100%",height:"100%",backgroundColor:"#b00"}}></div>
    </BookController>
    
   </div>
    
  );
}

export default App;
