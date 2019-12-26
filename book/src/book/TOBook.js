import React from "react";
import { TOPage } from "./TOPage";

class TOBook extends React.Component {

    constructor(props) {
        super(props);
        const {fontFamily,blockList,scale} = props;
        this.state = {
            fontFamily,blockList,scale
        }

    };

    render (){
        return <TOPage></TOPage>
    }
}