
class TOBlock extends React.Component {
    constructor(props){
        super(props);
        /*
         this.state = {
         scale:this.props.scale,
         text:this.props.data.text,
         };*/
    };
    render(props) {
        
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
    }
};


export default TOBlock
