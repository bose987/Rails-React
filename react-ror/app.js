var React =  require('react'),
	ReactDOM = require('react-dom'),
	Login = require('./js/component/login'),
	Expense = require('./js/component/expense'),
	NewExpense = require('./js/component/newExpense'),
	Dashboard = require('./js/component/dashboard'),
	Rout = require('react-router'),
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
	      isAdmin : auth.isAdmin()	      
	    }
	  },
	  componentWillMount() {
	    auth.onChange = this.updateAuth
	  },
	  updateAuth(loggedIn) {
	    this.setState({
	      loggedIn: loggedIn
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
		                <li>
		                    <Link to="/dashboard">Dashboard</Link>
		                </li>
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
			                    <Link to="/pending-list">Pending list</Link>
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
		          		this.props.children ? this.props.children : <p>home page</p>
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
		this.history.replace('/login')
	},
	render() {
		return <p>You are now logged out</p>
	}
})

var rautes = ReactDOM.render((
  <Router>
    <Route path="/" component={App}>
      <Route path="/login" component={Login} onEnter={LoggedIn}/>
      <Route path="/logout" component={Logout} />
      <Route path="/view-expense" component={Expense} />
      <Route path="/new-expense" component={NewExpense} />
      <Route path="/dashboard" component={Dashboard} onEnter={requireAuth}/>
    </Route>
  </Router>
), document.getElementById('app'))
