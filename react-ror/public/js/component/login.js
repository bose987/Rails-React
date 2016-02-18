var React =  require('react'),
	auth = require('./auth'),
	History = require('react-router').History;
	
const Login = React.createClass({
	mixins: [ History ],
	
	getInitialState() {
	    return {
	      email: null
	    }
	},	
	handleSubmit: function(event) {
	    event.preventDefault()
	    const email = event.target[0].value;
	    const pass = event.target[1].value;
	    auth.login(email, pass, (loggedIn) => {
	      if (!loggedIn)
	        return this.setState({ error: true })
	      	var location = this.props
	      if (location.state && location.state.nextPathname) {
	        this.history.replace(location.state.nextPathname)
	      } else {
	        this.history.replace('/dashboard')
	      }
	      window.location.reload();
	    })
	},
	render: function() {
		return (
			<div id="login-form">
			<section className="login-section">
				 <div className="login">
					<form onSubmit={this.handleSubmit}>
					   <ul className="ul-list">
						  <li>
						  	<input type="email" required className="input" placeholder="Your Email"/>
						  	<span className="icon">
						  		<i className="fa fa-user"></i>
						  	</span>
						  </li>
						  <li>
						  	<input type="password" required className="input" placeholder="Password"/>
						  	<span className="icon">
						  		<i className="fa fa-lock"></i>
						  	</span>
						  </li>
						  <li>
						  	<input type="submit" value="SIGN IN" className="btn btn-login" />
						  </li>
					   </ul>
					</form>
				 </div>
			</section>
			</div>
		);
	}
});
module.exports = Login;