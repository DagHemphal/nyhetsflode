
const express = require('express')
const bodyParser = require("body-parser");
const schedule = require('node-schedule');
const request = require('request');
const sql = require("./db/db.js");
var cors = require('cors');

const app = express()

const port = 8080

const key = "tZaGfEweghF1dBZzB9gPLnN7YOAnkcIo"

// parse requests of content-type: application/json
app.use(bodyParser.json());

// allow cors
app.use(cors());

//allow only 
/*app.use(cors({
  origin: 'https://dagsnyheter.nu'
}));*/


// parse requests of content-type: application/x-www-form-urlencoded
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.text({defaultCharset: 'utf-8'}));

function insertArticles(articles) {
	if (articles.length && articles !== null) {
			sql.query("INSERT IGNORE INTO articles (title, content, src, img, publish_date, publisher) VALUES ?", [articles], (err, result) => {
			    if (err) {
			    	console.log(err);
			    	console.log({"message": "error with sql"});
			    }else
			    	console.log({ "message": " success, no errors ;)"});
		  	});
		} else
			console.log("vaules null");
}

function apiNews(src) {
	request(src, { json: true }, (err, res, body) => {
		if (err) { return console.log(err); }
		console.log("Fecthing news for ");
		console.log(body);
		var values = [];
		for(let val of body.articles) {
			var publish_date = val.publishedAt;
			publish_date = publish_date.replace("Z", "");
			publish_date = publish_date.replace("T", " ");
			var desc = val.description;
			if (desc.length > 255) 
				desc = desc.substr(0, 255-4) + '...';
			if (val.images !== undefined)
	  			values.push([val.title, desc, val.url, val.image, publish_date, val.source.name]);
	  		else {
	  			let title = val.title;
	  			let source = title.substr(title.lastIndexOf(" - ") + 3);
	  			title = title.substr(0, title.lastIndexOf(" - "));
	  			values.push([title, desc, val.url, val.urlToImage, publish_date, source]);
	  		}
		}
		
		insertArticles(values);
	});
}


app.post('/api/get_news/', (req, res) => {
	var loc = req.body.loc;
	var api_key = req.body.api_key;
	var url = req.get('referer');
	loc = decodeURI(loc);

	var lans = ["Blekinge", "Dalarna", "Gävleborg", "Gotland", "Halland", "Jämtland", "Jönköping", "Kalmar", "Kronoberg", "Norrbotten",
	"Örebro", "Östergötland", "Skåne", "Södermanland", "Stockholm", "Uppsala", "Värmland", "Västerbotten", "Västernorrland",
	"Västmanland", "Västra Götaland"];

	if (!lans.includes(loc))
		loc = "Stockholm";
	console.log(loc);
	if (api_key === key) {
		sql.query("SELECT articles.* FROM articles, views_articles_lan WHERE publish_date >= (now() - interval 12 hour) and article_src = src and lan = ? ORDER BY views DESC;", loc, (err, result) => {
		    if (err) {
		      res.json({"message": "error with sql"});
		    }
		    else
		    	res.json({"message": "success", "data": result});
	  	});
	}
	else {
		res.json({"message": "no access :P"});
	}
})

app.post('/api/add_counter/' , (req, res) => {
	var loc = req.body.loc;
	var src = req.body.src;
	var api_key = req.body.api_key;
	var url = req.get('referer');
	if (api_key === key) {
		sql.query("UPDATE views_articles_lan SET views = views + 1 WHERE article_src = ? AND lan = ?", [src, loc], (err, result) => {
		    if (err) {
		    	console.log(err);
		    	res.json({"message": "error with sql"});
		    }
		    else
		    	res.json({ "message": "success"});
	  	});
	}
	else {
		res.json({"message": "no access :P"});
	}
})


var j = schedule.scheduleJob('09 */1 * * *', function(){
	var time = new Date()
	time.setHours(time.getHours() - 3);
	time = time.toISOString();
	time = time.substr(0,19) + "Z";

	/*topics = ["breaking-news", "world", "nation", "business", "technology", "entertainment", "sports", "science", "health"];
	for (let topic of topics) {
		apiNews('https://gnews.io/api/v4/top-headlines?token=a9f154f7a5c5c9023caf1e393efbcbb9&country=se&topic='+topic+'&from='+time);
	}*/
	apiNews('https://newsapi.org/v2/top-headlines?country=se&apiKey=a8ded2f78f27436191dbb0a65d736356');
});

var a = schedule.scheduleJob('0 0 * * *', function(){
		sql.query("DELETE FROM views_articles_lan WHERE article_src IN (SELECT src FROM Articles WHERE publish_date < (CURRENT_DATE() - interval 1 day))", (err, result) => {
		    if (err) {
		    	console.log(err);
		    	console.log({"message": "error with sql"});
		    }
		    else
		    	console.log({ "message": "success"});
	  	});

	  	sql.query("DELETE FROM Articles WHERE publish_date < (CURRENT_DATE() - interval 1 day)", (err, result) => {
		    if (err) {
		    	console.log(err);
		    	console.log({"message": "error with sql"});
		    }
		    else
		    	console.log({ "message": "success"});
	  	});
});

app.listen(port, () => {
  console.log(`Example app listening at http://localhost:${port}`)
})

