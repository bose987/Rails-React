var React =  require('react');
	
var Count = React.createClass({
	render: function() {
		return (
			<span className="couner">{this.props.count}</span>
		);
	}
});
module.exports = Count;
