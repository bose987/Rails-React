var React =  require('react'),
	ReactDOM = require('react-dom'),
	Login = require('./js/component/login'),
	Expense = require('./js/component/expense'),
	NewExpense = require('./js/component/newExpense'),
	Dashboard = require('./js/component/dashboard'),
	PendingList = require('./js/component/pendingList'),
	AllExpenses = require('./js/component/allExpenses'),
	Rules = require('./js/component/Roles'),
	Rout = require('react-router'),
	Count = require('./js/component/counter'),
	Router = Rout.Router, 
	Route = Rout.Route, 
	Link = Rout.Link, 
	History = Rout.History,
	auth = require('./js/component/auth'),
	createHistory = require('history').createHistory,
	useBasename = require('history').useBasename;
const history = useBasename(createHistory)({
  basename: '/ROR'
})

const App = React.createClass({
	  getInitialState() {
	    return {
	      loggedIn: auth.loggedIn(),
	      isEngg : auth.isEngg(),
	      isAdmin : auth.isAdmin(),
	      count : 0	      
	    }
	  },
	  componentWillMount() {
	    if(!auth.isEngg() ){
			var url = auth.getApiUrl() +  "notifications";
			var header = auth.getHeaders();
	    	$.ajax({
	            url: url,
	            type: "GET",
	            headers:header, 
	            crossDomain: true,
	            xhrFields: {
				    withCredentials: true
				},
	            success: function (data) {
	            	var countP = 0;
	            	for(var i = 0; i < data.length; i++){
	            		if(data[i].approval_status_type_id == 0){
	            			countP++;
	            		}
	            	}
	            	this.setState({
	            		count : countP
	            	})
	            }.bind(this)
	 		});
	    }
	    auth.onChange = this.updateAuth
	  },
	  updateAuth(loggedIn) {
	    this.setState({
	      loggedIn: loggedIn,
	      isEngg : auth.isEngg(),
	      isAdmin : auth.isAdmin()
	    })	    
	  },

	  render() {
	    return (
		       <div className="container">
		        <nav className="navbar navbar-default">
		          <div className="container-fluid">
		            <div className="navbar-header">
		              <button type="button" className="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
		                <span className="icon-bar"></span>
		                <span className="icon-bar"></span>
		                <span className="icon-bar"></span>                        
		              </button>
		              <Link className="navbar-brand" to="/">Expense approval</Link>
		            </div>
		            <div className="collapse navbar-collapse" id="myNavbar">
		              {this.state.loggedIn ? (
		              <ul className="nav navbar-nav">
		                
		                {this.state.isEngg ? 
			                <li>
			                    <Link to="/new-expense">New expense</Link>
			                </li>
		                : null}
		                {this.state.isEngg ? 
			                <li>
			                    <Link to="/view-expense">View Expense</Link>
			                </li>
		                : null}
		                {this.state.isEngg ? null :
			                <li>
			                    <Link to="/pending-list">Task list
			                    	{this.state.count != 0 ? <Count count={this.state.count}/> : null}</Link>			                    	
			                </li> 
		            	}
		            	{this.state.isEngg ? null :
			                <li>
			                    <Link to="/all-expenses">Report</Link>
			                </li> 
		            	}
		            	{this.state.isAdmin ? 
	                		<li>
			                    <Link to="/rules">Rules</Link>
			                </li> 
		                :null}
		              </ul>
		              ): null}
		              <ul className="nav navbar-nav navbar-right">
		              	{this.state.loggedIn ? (
	              			<li>
			                	<Link to="/logout"><span className="glyphicon glyphicon-log-in"></span> Logout</Link>
			                </li>):(
			                <li>
			                	<Link to="/login"><span className="glyphicon glyphicon-log-in"></span> Login</Link>
			                </li>
		                )}
		              </ul>
		            </div>
		          </div>
		        </nav>
		       <div>		        
		          {
		          		this.props.children ? this.props.children : (this.state.loggedIn ? <Dashboard /> : <Login />)
		          }
		        </div>
		      </div>
	    )
	  }
})

function requireAuth(nextState, replaceState) {
  if (!auth.loggedIn())
    replaceState({ nextPathname: nextState.location.pathname }, '/login')
}
function LoggedIn(nextState, replaceState) {
  if (auth.loggedIn())
    replaceState(null, '/dashboard')
}

const Logout = React.createClass({
	mixins: [ History ],
	componentDidMount() {
		auth.logout();		
	},
	render() {
		return <p>You are now logged out</p>
	}
})

var rautes = ReactDOM.render((
  <Router>
    <Route path="/" component={App}>
      <Route path="/login" component={Login} onEnter={LoggedIn}/>
      <Route path="/logout" component={Logout} onEnter={requireAuth}/>
      <Route path="/view-expense" component={Expense} onEnter={requireAuth}/>
      <Route path="/pending-list" component={PendingList}  onEnter={requireAuth}/>
      <Route path="/all-expenses" component={AllExpenses}  onEnter={requireAuth}/>      
      <Route path="/rules" component={Rules}  onEnter={requireAuth}/>
      <Route path="/new-expense" component={NewExpense}  onEnter={requireAuth}/>
      <Route path="/dashboard" component={Dashboard} onEnter={requireAuth}/>
    </Route>
  </Router>
), document.getElementById('app'))
