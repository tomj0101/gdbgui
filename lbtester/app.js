const os = require('os');
console.log( os.hostname() );

const express = require('express')
const bodyParser = require('body-parser');
const cors = require('cors');

const app = express();
const port = 8888;

const sys_info = {"hostname": os.hostname()};

app.use(cors());

// Configuring body parser middleware
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

app.get('/v3/app', (req, res) => {
  console.log("hostname", os.hostname(), " time: ",new Date().toLocaleString("en-US", {timeZone: "America/New_York"}));
  res.json(sys_info);
});

app.set("view engine", "ejs");

app.get('/v3/ui', (req, res) => {
  res.render("index",sys_info);
});

app.listen(port, () => console.log(`Welcome, app listening on port ${port}!`));