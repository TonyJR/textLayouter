import React from "react";
import TOBlock from "./TOBlock";
import { TOFont } from "../font/TOFont";


class TOPage extends React.Component {

    constructor(props) {
        super(props);
        const {fontFamily,blockList,scale} = props;
        this.state = {
            fontFamily,blockList,scale
        }

    };

    render() {
        const { blockList = [], fontFamily} = this.state;
        return <div>
            {
                blockList && blockList.map((item) =>
                    <TOBlock
                        key={item.id}
                        type={item.type}
                        scale={this.state.scale}
                        x={item.x}
                        y={item.y}
                        width={item.width}
                        height={item.height}
                        text={item.text}
                        fontFamily={item.fontFamily?item.fontFamily:fontFamily}
                    >
                    </TOBlock>
                )
            }
        </div>;
    }
};

export { TOPage };
