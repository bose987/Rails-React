var React =  require('react'),
	auth = require('./auth');
	
var PendingList = React.createClass({
	
	getInitialState() {
	    return {
			expenseList :  null           
	    }
  	},
  	handleClick: function(IsAorR, id) {
	    var url = auth.getApiUrl();
	    var msg = "Do you like to "
	    if(IsAorR == 0){
			msg += "Reject";
	    	url += "notification/reject/" + id
	    }
	    if(IsAorR == 1){
			msg += "Approve";
	    	url += "notification/approve/" + id
	    }
	    var dataPost = {
	    	reason : $("#comment_" + id).val()
	    }
	    var r = confirm(msg);
		if (r == true) {
		    var header = auth.getHeaders();
		    $.ajax({
	            url: url,
	            type: "POST",
	            headers: header, 
	            data : dataPost,
	            crossDomain: true,
	            xhrFields: {
				    withCredentials: true
				},
	            success: function (data) {
	            	window.location.reload();
	            }.bind(this),
	            error: function (jqXHR, textStatus, errorThrown) {
	            	alert(textStatus);
	            }
		   });
	   }
  	},
	componentWillMount() {
	   var url = auth.getApiUrl() + "notifications";
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
			var row =[];
			var k = 1;
			function sortStatus(a,b){  
			     if (a.approval_status_type_id == b.approval_status_type_id){
			       return 0;
			     }
			     return a.approval_status_type_id> b.approval_status_type_id ? 1 : -1;  
			};
			arr = $(arr).sort(sortStatus);
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

							{(arr[i].approval_status_type_id == 1 || arr[i].approval_status_type_id == 2) ? 
								<div className="table-cell" style={center}>	
									<button className="disabled btn btn-primary" style={margin}>
										<i className="fa fa-thumbs-up"></i>
									</button>
									<button className="disabled btn btn-danger">
										<i className="fa fa-thumbs-down"></i>
									</button>
								</div>
									: 
								<div className="table-cell" style={center}>	
									<button className="btn btn-primary" style={margin} onClick={this.handleClick.bind(this, 1, arr[i].id)}>
										<i className="fa fa-thumbs-up"></i>
									</button>
									<button className="btn btn-danger" onClick={this.handleClick.bind(this, 0, arr[i].id)}>
										<i className="fa fa-thumbs-down"></i>
									</button>
								</div>
							}								
							<div className="table-cell" style={center}>	
								<textarea id={id} className="form-control"  defaultValue={arr[i].reason}   disabled={(arr[i].approval_status_type_id == 1 || arr[i].approval_status_type_id == 2)} >
									
								</textarea>
							</div>
						</div>
					);
			}
			return (
				<div className="expense">						 	
					<h1 className="page-header">Notifications</h1>
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
								Approve/Reject
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

