class TOPage extends React.Component {
    
    constructor(props){
        super(props);
        this.state = {
            blockList:[]
        }
    };
    
    render(props) {
        if (this.state.blockList){
            var children = this.state.blockList.map((item) =>
                                                    <TOBlock
                                                    key={item.id}
                                                    type={item.type}
                                                    scale={this.props.scale}
                                                    x={item.x}
                                                    y={item.y}
                                                    width={item.width}
                                                    height={item.height}
                                                    text={item.text}
                                                    >
                                                    </TOBlock>
                                                    );
        }
        
        if(!children){
            children = [];
        }
        return <div>{children}</div>;
    }
};
