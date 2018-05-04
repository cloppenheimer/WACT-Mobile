const express = require('express')
var bodyParser = require('body-parser');
const path = require('path')
const PORT = process.env.PORT || 5000
var app = express()

// See https://stackoverflow.com/questions/5710358/how-to-get-post-query-in-express-node-js
app.use(bodyParser.json());
// See https://stackoverflow.com/questions/25471856/express-throws-error-as-body-parser-deprecated-undefined-extended
app.use(bodyParser.urlencoded({ extended: true }));

var mongoUri =  "mongodb://heroku_tz3vqkvs:otv4ebeo638r16vmqn5im7ak54@ds237979.mlab.com:37979/heroku_tz3vqkvs" || process.env.MONGODB_URI || process.env.MONGOLAB_URI || process.env.MONGOHQ_URL;
/*|| 'mongodb://localhost/travie2017';*/
var MongoClient = require('mongodb').MongoClient, format = require('util').format;
var db = MongoClient.connect(mongoUri, function(error, databaseConnection) {
        console.log(error);
        db = databaseConnection;
});

//app.use(express.static(__dirname + '/public'));

app.use(express.static(path.join(__dirname, 'public')))
app.set('views', path.join(__dirname, 'views'))
app.set('view engine', 'ejs')
//app.get('/', (req, res) => res.render('pages/index'))

app.get('/', function(request, response) {
	//response.set('Content-Type', 'text/html');
	//var indexPage = '';

	// Line 50: equivalent to `db.fooditems` in MongoDB client shell
	db.collection('respiration', function(er, collection) {

		// Line 53: equivalent to `db.fooditems.find()` in MongoDB client shell
		collection.find().toArray(function(err, results) {

			// All results of db.fooditems.find() will go into...
			// ...`results`.  `results` will be an array (or list)
			if (!err) {
				//indexPage += "<!DOCTYPE HTML><html><head><title>What Did You Feed Me?</title></head><body><h1>What Did You Feed Me?</h1>";
				//for (var count = 0; count < results.length; count++) {
				//	indexPage += "<p>You fed me " + results[count].food + "!</p>";
				//}
				//indexPage += "</body></html>"
				response.send(results[0]);
			} else {
				response.send("error");
			}
		});
	});
});

app.post('/submit', function(request, response) {
	console.log(request.body);
	var dataItem = request.body.ecgvalue;
	//foodItem = foodItem.replace(/[^\w\s]/gi, ''); // remove all special characters.  Can you explain why this is important?
	var toInsert = {
		"data": dataItem,
	};
	db.collection('ECG', function(error, coll) {
		coll.insert(toInsert, function(error, saved) {
			if (error) {
				console.log("Error: " + error);
				response.send(500);
			}
			else {
				response.send("Inserted data into mongo");
			}
	    });
	});
	response.send("made it!")
});



app.listen(PORT, () => console.log(`Listening on ${ PORT }`))
