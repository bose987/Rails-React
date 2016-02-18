var React =  require('react'),
	auth = require('./auth'),
	History = require('react-router').History;

	
var NewExpense = React.createClass({
	mixins: [ History ],
	handleChange: function(event) {
		var patten = /^[0-9]+$/ ;
		var str = event.target.value;		
		if(!patten.test(str)){
			event.target.value = str.substring(0, str.length - 1);	
		}
	},
	handleSubmit: function(event) {
	    event.preventDefault()
	    var expense = {
    	    	name : event.target[0].value,
    	    	expense_type_id : event.target[1].value,
    	    	amount : event.target[2].value,
    	    	description : event.target[3].value
    	    }
	    var url = auth.getApiUrl() + "expense";
	    var header = auth.getHeaders();
	     $.ajax({
            url: url,
            type: "POST",
            data: expense,
            headers:header, 
            crossDomain: true,
	        xhrFields: {
			    withCredentials: true
			},
            success: function (data) {
            	if(data){
            		if(data.notification != null){
            			alert(data.notification.description);
            		}
					var r = confirm("Do you like to add more expenses");
					if (r == true) {
						$("input[type=text], textarea").val("");
					} else {
	        			window.location.replace("#/dashboard")						
					}
            	}
            },
            error: function (jqXHR, textStatus, errorThrown) {
            	alert(textStatus);
            }
         });
	},
	render: function() {
		return (
			<div className="expense">
				<h1 className="page-header">New expense</h1>

				<form onSubmit={this.handleSubmit}>
					<div className="row">
						<div className="form-group col-md-6 col-lg-6 col-sm-12 col-xs-12">
							<label>Expense Name *</label>
							<input type="text" required className="form-control" />
						</div>	
					</div>
					<div className="row">
						<div className="form-group col-md-6 col-lg-6 col-sm-12 col-xs-12">
							<label>Expense type *</label>
							<select required className="form-control">
								<option value="1">Traveling</option>
								<option value="1">Technical</option>
							</select>
						</div>	
					</div>
					<div className="row">
						<div className=" form-group col-md-6 col-lg-6 col-sm-12 col-xs-12">
							<label>Expense Amount *</label>
							<input type="text" pattern="[0-9]*" onChange={this.handleChange} required className="form-control" />
						</div>	
					</div>
					<div className="row">
						<div className="form-group col-md-6 col-lg-6 col-sm-12 col-xs-12">
							<label>Expense Description *</label>
							<textarea className="form-control" required rows="5"></textarea>
						</div>
					</div>
					<div className="row">
						<div className="form-group col-md-6 col-lg-6 col-sm-12 col-xs-12">
							<a className="btn btn-warning cancel-btn" href="#/dashboard">Cancel</a>   <input type="submit" className="btn btn-primary" value="Submit"/>
						</div>
					</div>
				</form>
			</div>


		);
	}
});
module.exports = NewExpense;

