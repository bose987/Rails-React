var React =  require('react');
	
var Roles = React.createClass({
	render: function() {
		return (
			<div className="expense">
				<h1 className="page-header">Add new rule</h1>
				<form>
					<div className="row">
						<div className="col-md-6 form-group">
							<label>Expense type *</label>
							<select className="form-control"/>
						</div>
						<div className="col-md-6 form-group">
							<label>Expense sub type *</label>
							<select className="form-control"/>
						</div>
						<div className="col-md-6 form-group">
							<label>Amount *</label>
							<input className="form-control"/>
						</div>
						<div className="col-md-6 form-group">
							<label>Condition *</label>
							<select className="form-control"/>
						</div>
						<div className="col-md-6 form-group">
							<label>Assign to *</label>
							<select className="form-control"/>
						</div>
					</div>
				</form>
			</div>
		);
	}
});
module.exports = Roles;
