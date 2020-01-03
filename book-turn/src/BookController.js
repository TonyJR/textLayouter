import React from "react";
import { TOBook } from "./TOBook/TOBook";

class BookController extends React.Component {

    constructor(props){
        super(props);
        const {paperIndex = 0} = props;
        this.state = {
            paperIndex
        }
    };

    handeChange(item,event){
        for(let StateItem in this.state){
            if(item===StateItem){
                this.state[item]=event.target.value;
                this.setState(this.state)
            }
        }
       this.setState({
        paperNum: this.refs.book.paperNum
       });
       this.refs.book.paperIndex = event.target.value;
    }

    render(){
        const {paperIndex = 0,paperNum} = this.state;
        return <div><TOBook ref="book" width={400} height={500} paperIndex={paperIndex}>{this.props.children}</TOBook><button>上一页</button><button>下一页</button><input ref="slider" type="range" step="1" min="0" max={paperNum} onChange={this.handeChange.bind(this,"paperIndex")} value={paperIndex}/></div>
    }

}

export {BookController}