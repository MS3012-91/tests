const fs = require("fs");
const path = require("path");

let k = 0;
module.exports = function foo(req, res) {
  const p = path.resolve("pages/");
  console.log("p", p);
  const pages = fs.readdirSync(p, { encoding: "utf8" });
  console.log("pages", pages);
  // const paths = path.join(p, 'home.html');
  const { url, method } = req;
  console.log(url);
    if (method == "GET") {
        let resPage;
        if (
            resPage = pages.find(page => page.includes(url.slice(1)))
        )
        { 
            res.statusCode = 200;
            res.setHeader('Content-Type', 'text/html');
            const results = fs.readFileSync(`./pages/${resPage}`, {
              encoding: "utf-8",
            });
            
            res.end(results);
        }
        else {
            res.statusCode = 404;
            res.setHeader("Content-Type", "text/html");
            res.end('Page not found');
        }
  } else {
    res.statusCode = 400;
    res.setHeader("Content-Type", "text/html");
    res.end("Bad Request");
  }
};
