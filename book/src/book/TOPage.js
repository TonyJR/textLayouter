import React from "react";
import TOTextBlock from "./TOTextBlock";
import { TOBlockType } from "./TOBlock";
import { TOImageBlock } from "./TOImageBlock";


class TOPage extends React.Component {

    constructor(props) {
        super(props);
        const {fontFamily,blockList,scale,width,height} = props;
        this.state = {
            fontFamily,blockList,scale,width,height
        }

    };

    render() {
        const { blockList = [], fontFamily, width = 600, height = 800} = this.state;
        return <div style={
            {
                position:"relative",
                width:width,
                height:height,
                border:"1px solid #999",
                backgroundColor:"#eee",
            }
            }>
            {
                blockList.map((item) =>
                {
                    switch(item.type){
                        case TOBlockType.text:
                            return <TOTextBlock
                                key={item.id}
                                id={item.id}
                                type={item.type}
                                scale={this.state.scale}
                                x={item.x}
                                y={item.y}
                                width={item.width}
                                height={item.height}
                                text={item.text}
                                fontFamily={item.fontFamily?item.fontFamily:fontFamily}
                            />

                        case TOBlockType.image:
                            return <TOImageBlock
                                key={item.id}
                                id={item.id}
                                type={item.type}
                                x={item.x}
                                y={item.y}
                                width={item.width}
                                height={item.height}
                                url={item.url}
                            />
                        default:
                            return null;
                    }
                })
            }
        </div>;
    }
};

export { TOPage };
