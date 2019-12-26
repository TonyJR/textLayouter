import React from "react";
import ReactDOM from "react-dom";
import {TOParagraph, TOFont} from "../font/TOFont"

class TOBlock extends React.Component {
    constructor(props){
        super(props);
        const { x,y,width,height,scale, fontFamily, fontSize,text} = this.props;
        this.state = {
            x,y,width,height,scale,fontSize,text
        };
        
        let font = new TOFont(fontFamily,(error)=>{
                
            if (!error){
                this.setState({
                    font
                });
            }
        });
    };
    render() {
        let {x = 0,y = 0,width = 100,height = 0,scale = 2,font,fontSize = 14,text = ""} = this.state;
        if (font){
            let paragraph = new TOParagraph(text,font,width,fontSize);
            height = paragraph.getSize().height;
            return <canvas
            width={width * scale}
            height={height * scale}
            style={
                {
                    backgroundColor:"#0000",
                    position:"absolute",
                    top:y + "px",
                    left:x + "px",
                    width:width+"px",
                    height:height+"px",
                }
            }/>;

        }else{
            return <div
            style={
                {
                    backgroundColor:"#000",
                    position:"absolute",
                    top:y + "px",
                    left:x + "px",
                    width:width+"px",
                    height:height+"px",
                }
            }>loading...</div>;
        }
        

    };
    componentDidUpdate() {
        const { scale,text,font,width, fontSize} = this.state;
        let canvas = ReactDOM.findDOMNode(this);
        if (canvas && font){
            let paragraph = new TOParagraph(text,font,width,fontSize);
            paragraph.draw(canvas.getContext('2d'),0,0,scale);
        }
    }
};

export default TOBlock;