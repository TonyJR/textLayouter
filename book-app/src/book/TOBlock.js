import React from "react";

class TOBlock extends React.Component {
    constructor(props){
        super(props);
        /*
         this.state = {
         scale:this.props.scale,
         text:this.props.data.text,
         };*/
    };
    render() {
        
        return <canvas
        width={this.props.width * this.props.scale}
        height={this.props.height * this.props.scale}
        style={
            {
                position:"absolute",
                top:this.props.y + "px",
                left:this.props.x + "px",
                width:this.props.width+"px",
                height:this.props.height+"px",
            }
        }/>;
    };
    componentDidUpdate() {
        
        var canvas = ReactDOM.findDOMNode(this);
        if (canvas && this.props.font){
            var paragraph = new TOParagraph(this.props.text,this.props.font,this.props.width,14);
            paragraph.draw(canvas.getContext('2d'),0,0,this.props.scale);
        }
        /*
        var canvas = this.findDOMNode();
        canvas.getContext("2d");
         */
    }
};

export default TOBlock;