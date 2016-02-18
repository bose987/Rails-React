var React =  require('react'),
	auth = require('./auth');
	
var PendingList = React.createClass({
	
	getInitialState() {
	    return {
			expenseList :  null           
	    }
  	},

	componentWillMount() {
	   var url = auth.getApiUrl() +  "expense/all";
	   var header = auth.getHeaders();
	   var flag = false;
	   var dataAjax = null;
	   $.ajax({
            url: url,
            type: "GET",
            headers:header, 
            crossDomain: true,
            xhrFields: {
			    withCredentials: true
			},
            success: function (data) {
            	flag = true;
            	this.setState({
		    		expenseList : data
		    	})
            }.bind(this),
            error: function (jqXHR, textStatus, errorThrown) {
            	alert(textStatus);
            }
	   });
	},

	render: function() {
		var center = {
			textAlign :'center'
		};
		var margin = {
			marginRight : '10px'
		}
		var expense = this.state.expenseList;
		if(this.state.expenseList != null){
			var arr = $.map(expense, function(el) {
				 return el 
				});
		function sortStatus(a,b){  
		     if (a.approval_status_type_id == b.approval_status_type_id){
		       return 0;
		     }
		     return a.approval_status_type_id> b.approval_status_type_id ? 1 : -1;  
		 };
		 arr = $(arr).sort(sortStatus);
			var row =[];
			var k = 1;
			for(var i = 0; i < arr.length; i++){
				var id = "comment_"  + arr[i].id;
					row.push(
						<div className="table-row" key={arr[i].id}>
							<div className="table-cell">	
								{k++}
							</div>
							<div className="table-cell">								
								  {arr[i].name}
							</div>
							<div className="table-cell">	
								{arr[i].description}
							</div>
							<div className="table-cell">	
								{arr[i].amount}
							</div>						
							<div className="table-cell" style={center}>	
								{arr[i].approval_status_type_id == 1 ? "Approved" : (arr[i].approval_status_type_id == 2 ? 'Rejected' : (arr[i].approval_status_type_id == null ? 'Auto Approved' : "Pending"))}															
							</div>
							<div className="table-cell" style={center}>	
								{arr[i].reason}
							</div>
						</div>
					);
			}
			return (
				<div className="expense">						 	
					<h1 className="page-header">Expense</h1>
					<div className="table-class">
						<div className="table-heading">
							<div className="table-cell">	
								Sr.No.
							</div>
							<div className="table-cell">	
								Name
							</div>
							<div className="table-cell">	
								Description
							</div>
							<div className="table-cell">	
								Amount
							</div>							
							<div className="table-cell" style={center}>	
								Status
							</div>
							<div className="table-cell" style={center}>	
								Comment
							</div>
						</div>
						{row}
					</div>					
				</div>
			);
		} else{
			return (<div></div>);
		}
	}
});
module.exports = PendingList;

