import React from "react";
import { TOPaper } from "./TOPaper";

class TOBook extends React.Component {
    constructor(props){
        super(props);
        const {buffer,width,height,progress,paperIndex = 0} = props;
        this.state = {
            buffer,width,height,progress,paperIndex
        }
    };

    get paperNum(){
        return Math.ceil(this.props.children.length / 2);
    }

    

    get paperIndex(){
        const {paperIndex = 0} = this.state;
        return paperIndex;
    }

    set paperIndex(paperIndex){
        this.setState({
            paperIndex
        });
        this.beginAnimation(paperIndex);
    }


    get animationPaperIndex(){
        const {animationPaperIndex = this.paperIndex} = this.state;
        return animationPaperIndex;
    }

    set animationPaperIndex(animationPaperIndex){
        this.setState({
            animationPaperIndex
        });
    }

    animation = {};
    beginAnimation(paperIndex){
        this.stopAnimation();
        let key = window.requestAnimationFrame(this.animationStep);
        let begin = this.animationPaperIndex;
        let end = paperIndex;
        let date = window.performance.now();
        this.animation = {key,begin,end,date};
    }

    stopAnimation(){
        if(this.animation){
            let {key} = this.animation;
            window.cancelAnimationFrame(key);
        }
    }

    animationStep = (timestamp)=>{
        let {begin,end,date} = this.animation;

        timestamp = timestamp - date;

        const durning = 300;
        let progress = timestamp / durning;
        progress = Math.max(Math.min(progress,1),0);
        
        this.animationPaperIndex = (end - begin) * progress + begin;
        if (timestamp < durning) {
            this.animation.key = window.requestAnimationFrame(this.animationStep);
        }else{
            window.cancelAnimationFrame(this.animation.key);
        }
    }

    render(){
        let animationPaperIndex = this.animationPaperIndex;
        const {buffer = 1,width = 400,height = 500} = this.state;
        let papers = [];
        let maxPaperCount = this.paperNum;
        
        for (let i = Math.max(0,Math.floor(animationPaperIndex) - buffer); i < Math.min(maxPaperCount,Math.ceil(animationPaperIndex) + buffer + 1) ; i++){
            papers.push(
                <TOPaper key={"paper"+i} width={width} height={height} progress={i-animationPaperIndex + 1}>{[this.props.children[i * 2],this.props.children[i * 2 + 1]]}</TOPaper>
            );
        }
        return <div style={{
            width:width * 2,
            height:height
        }}>{ papers }
        </div>
            
            

    }
}

export {TOBook}