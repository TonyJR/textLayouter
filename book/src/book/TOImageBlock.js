import React from "react";

class TOImageBlock extends React.Component {
    constructor(props){
        super(props);
        const { id,x,y,width,height,url} = this.props;
        this.state = {
            id,x,y,width,height,url
        };
    };
    render() {
        const {id,x = 0,y = 0,width = 100,height = 0,url} = this.state;
        return <img 
            id={id} 
            src={url} 
            style={
            {
                position:"absolute",
                top:y,
                left:x,
                width,
                height,
            }
        }></img>
    }
}

export {TOImageBlock}