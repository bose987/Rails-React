var React =  require('react'),
auth = require('./auth');
	
var Dashboard = React.createClass({
	 getInitialState() {
	    return {
	      isEngg : auth.isEngg(),
	      isAdmin : auth.isAdmin()	      
	    }
	  },
	render: function() {
		return (
			<div className="dashboard">
				<h1 className="page-header">Dashboard</h1>
				<div className="row txtCenter">
				{this.state.isEngg ? 
					<div  className="col-md-4">
						<a href="#/view-expense">
							<i className="fa fa-eye fa-5x"></i>
							<p>View your expense</p>
						</a>
					</div>
				: null}
				{this.state.isEngg ? 
					<div  className="col-md-4">
						<a href="#/new-expense">
							<i className="fa fa-plus-circle fa-5x"></i>
							<p>New expense</p>
						</a>
					</div>
				:null}
				{this.state.isEngg ? null: 
					<div  className="col-md-4">
						<a href="#/pending-list">
							<i className="fa fa-retweet fa-5x"></i>
							<p>Pending List</p>
						</a>
					</div>
				}
				{this.state.isEngg ? null: 
					<div  className="col-md-4">
						<a href="#/all-expenses">
							<i className="fa fa-retweet fa-5x"></i>
							<p>Report</p>
						</a>
					</div>
				}
				{this.state.isAdmin ?					
					<div  className="col-md-4">
						<a href="#/rules">
							<i className="fa fa-retweet fa-5x"></i>
							<p>Rules</p>
						</a>
					</div>
				:null}
				</div>
			</div>
		);
	}
});
module.exports = Dashboard;

