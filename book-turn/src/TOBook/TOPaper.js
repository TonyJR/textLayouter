import React from "react";
import {vec2,mat2d} from "gl-matrix"

class TOPaper extends React.Component {
    constructor(props){
        super(props);
        const {width,height,progress,enabled} = props;

        this.state = {
            width,height,progress,enabled
        }
    };

 

    rotate(matrix,cx,cy,r){
        var offset = vec2.fromValues(cx,cy);
        var unoffset = vec2.fromValues(-cx,-cy);
        mat2d.translate(matrix,matrix,offset);
        mat2d.rotate(matrix,matrix,r);
        mat2d.translate(matrix,matrix,unoffset);
        return matrix;
    }

    render(){
        let {progress} = this.props;
        let {width = 400,height = 500} = this.state;
        let frontPage = this.props.children[0];
        let backPage = this.props.children[1];

        let z = 100;
        if(progress < 0){
            z = Math.floor(z + progress);
            progress = 0;
        }
        if(progress > 1){
            z = Math.floor(z - progress);
            progress = 1;
        }
        
        let paperMatrix,frontMatrix,backMatrix;
        {
            var move = vec2.fromValues(-width *(1-progress),0);
            var r = 3.14/180*15 *  (1 - Math.pow((1 - progress),2));
            var offset = vec2.fromValues(width,height/2);
            var unoffset = vec2.fromValues(-width,-height/2);

            var containerMatrix = mat2d.create();
            mat2d.translate(containerMatrix,containerMatrix,move);
            containerMatrix = this.rotate(containerMatrix,width,height/2,r);
    
            
            var invertContainerMatrix = mat2d.create();
            var image1Matrix = mat2d.fromValues(1,0,0,1,0,0);
            mat2d.invert(invertContainerMatrix,containerMatrix);
    
            offset = vec2.fromValues(-width/2,0);
            unoffset = vec2.fromValues(width/2,0);
            mat2d.translate(image1Matrix,image1Matrix,offset);
            mat2d.multiply(image1Matrix,image1Matrix,invertContainerMatrix);
            mat2d.translate(image1Matrix,image1Matrix,unoffset);
    
            var image2Matrix = mat2d.fromValues(1,0,0,1,width,0);
            image2Matrix = this.rotate(image2Matrix,-width/2,height/2,r);
            mat2d.translate(image2Matrix,image2Matrix,move);
            
            paperMatrix = mat2d.str(containerMatrix).replace("mat2d","matrix");
            frontMatrix = mat2d.str(image1Matrix).replace("mat2d","matrix");
            backMatrix = mat2d.str(image2Matrix).replace("mat2d","matrix");
        }
        

        return <div className="TOPaper" style={{
            zIndex : z,
            position:"absolute",
            top: -height/2,
            left:0,
            width:width * 2,
            height:height * 2,
            clip: "rect(0px "+width * 2+"px "+height * 2+"px 0px)",
            transform: paperMatrix,
            pointerEvents: "none",
        }}>
            <div className="TOFrontPage" style={{
             //"position: absolute;top: 120px;left: 100px; width: 100px; height: 120px;"
                position:"absolute",
                top: height/2,
                left: width,
                width: width,
                height: height,
                transform: frontMatrix,
                pointerEvents: "auto",
            }}>
                {frontPage}
            </div>
            <div className="TOBackPage" style={{
                // position: absolute;top: 120px;left: 100px; width: 100px; height: 120px;
                position:"absolute",
                top: height/2,
                left: width,
                width: width,
                height: height,
                transform: backMatrix,
                pointerEvents: "auto",
            }}>
                {backPage}
            </div>
        </div>
    }
}

export {TOPaper}