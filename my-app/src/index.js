import React from 'react';
import ReactDOM from 'react-dom';

import './index.css';
import 'bootstrap/dist/css/bootstrap.css';

const API_KEY = process.env.REACT_APP_API_KEY;

class Adsense extends React.Component {
	componentDidMount () {
    	(window.adsbygoogle = window.adsbygoogle || []).push({});
  	}

	render () {
		return (
			<div className='ad card'>
				<ins className="adsbygoogle"
					style={{ display: 'block' }}
					data-ad-format="fluid"
					data-ad-layout-key="-fb+5w+4e-db+86"
					data-ad-client="ca-pub-5998387216955315"
					data-ad-slot="3318781376">
				</ins>
			</div>
		);
	}
};

class Article extends React.Component {
	render () {
		return (
			<div className="src card" onClick={this.props.onClick}>
				<div className="row">
					<div className="align col-sm-5">
						<div className="size card-img" style={{backgroundImage: `url(${this.props.img})`}}>
						</div>
					</div>
					<div className="col-sm-7">
						<div className="card-body">
							<h5 className="card-title">{this.props.title}</h5>
					    	<p className="card-text">{this.props.content}</p>
					    	<div className="card-footer text-muted">Källa: {this.props.source} - {this.props.time}</div>
						</div>
					</div>
					
				</div>
			</div>
		);
	}
};

class Articles extends React.Component {
	constructor(props) {
		super(props);
		this.state = {
			articles: [{ 
				"img": "https://via.placeholder.com/200", 
				"title": "Opss! här var det tomt", 
				"content": "inga nyheter ännu",
				"publisher": "Admin",
	  			"publish_date": "2012-12-12 13:37",
	  			"src": "https://www.w3schools.com/"}],
			loc: "",
			amount: 6
		};
	}

	componentDidMount() {
		window.addEventListener('scroll', this.handleScroll);
		let loc = "";
		fetch('https://ipapi.co/region/')
			.then(res => res.text())
			.then((result) => {
				loc = result.replace(" County", "");
				this.setState({
				    loc: loc
				});
				loc = encodeURI(loc);
				const requestOptions = {
				method: 'POST',
				headers: { 'Content-Type': 'application/json'
					},
				body: JSON.stringify({ 
					loc: loc,
					api_key: API_KEY 
				 })
				};
				fetch("https://dagsnyheter.nu/api/get_news/", requestOptions)
				.then(res => res.json())
				.then(
					(result) => {
						if (result.message === "success"){

							this.setState({
								articles: result.data
							});
						}
					},
					(error) => {
					  console.log(error);
					}
				);

				},
				(error) => {
				  console.log(error);
				}
			);		
	}

	handleScroll = e => {
	    let element = document.documentElement;
	    if ((element.scrollHeight - element.clientHeight) - window.pageYOffset < 200) {
	    	document.removeEventListener('scroll', this.handleScroll);
	    	let left = this.state.articles.length - this.state.amount;
	    	let add = left >= 6 ? 6 : left;
	    	if (add !== 0) {
		      	this.setState({
					amount: this.state.amount + add
				});
				window.addEventListener('scroll', this.handleScroll);
	      	}
			
	    }
 	}

	onclickArticle(src) {
		/*Add counter to article, api call to database*/

		const requestOptions = {
        method: 'POST',
        headers: { 'Content-Type': 'application/json'},
        body: JSON.stringify({ 
        	loc: this.state.loc,
        	src: src,
        	api_key: API_KEY 
         })
	    };
	    fetch('https://dagsnyheter.nu/api/add_counter/', requestOptions)
	        .then(response => response.json())
	        .then((result) => {
				window.location.href = src
			});
	}

	renderArticle(article, i) {
		let ad = null;
		if ( i !== 0 && (i+1) % 5 === 0)  {
			ad = <Adsense/>;
		} 
		return (
			<div>
				<Article 
					img = {article.img}
					title = {article.title}
					content = {article.content}
					src = {article.src}
					source = {article.publisher}
					time = {article.publish_date.substr(11, 5)}
					onClick={() => this.onclickArticle(article.src)}
				/>
				{ad}
			</div>
		);
	}

	render() {
		return (
			<div className="Articles card-columns" id="columns">
				{this.state.articles.slice(0, this.state.amount).map((article, index) => this.renderArticle(article, index))}
			</div>
		);
	}
};

ReactDOM.render(
	<Articles />,
	document.getElementById('root')
);

