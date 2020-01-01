import React from "react";
import ReactDOM from "react-dom";
import {TOParagraph, TOFont} from "../font/TOFont"

class TOTextBlock extends React.Component {
    constructor(props){
        super(props);
        const { id,x,y,width,height,scale, fontFamily, fontSize,text} = this.props;
        
        
        new TOFont(fontFamily,(error,font)=>{
            if (!error){
                if (this.state){
                    this.setState({
                        font
                    });
                }else{
                    this.state = {
                        id,x,y,width,height,scale,fontSize,text,font
                    };
                }
            }
        });

        if(!this.state){
            this.state = {
                id,x,y,width,height,scale,fontSize,text
            };
        }

    };
    render() {
        let {id,x = 0,y = 0,width = 100,height = 0,scale = 2,font,fontSize = 14,text = ""} = this.state;
        if (font){
            let paragraph = new TOParagraph(text,font,width,fontSize);
            height = paragraph.getSize().height;
            return <canvas
            id={id}
            width={width * scale}
            height={height * scale}
            style={
                {
                    backgroundColor:"#0000",
                    position:"absolute",
                    top:y,
                    left:x,
                    width,
                    height,
                }
            }/>;

        }else{
            return <div
            id={id}
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

export default TOTextBlock;