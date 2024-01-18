const {calc} = require("./modules");
const os = require('os');
const fs = require('fs');
const path = require("path");
const util = require('util');
const { error } = require("console");


// console.log("os.version", os.version());

// const res = calculator(5, 6);

// console.log("greeting2", res);

// let res = calc.add(2, 5);
// console.log("res", typeof calc);


// const read = fs.readFileSync('./src/read.txt', { 'encoding': 'utf-8' });
// const read1 = fs.readFile("./src/modules.js", { encoding: "utf-8" },
//     (error, data) => {
//         if (error) {
//             console.log("error", error);
//         }
//         else console.log('data', data);
//     }
// );
// console.log('read', read);
// console.log("read1", read1);

const content = fs.readdirSync('.');
// console.log('content', content);

// console.log('process.env', process.env);
// console.log('__dirname', __dirname);

const dir = __dirname;
// console.log("dir", dir);

const toRead = fs.readdirSync(dir);
// console.log('toRead', toRead);

const files = toRead.filter(file => file.endsWith('.txt'));
// console.log('files', files);
const paths = files.map(file => path.resolve('./src/', file));
console.log('paths', paths);
const readAsync = util.promisify(fs.readFileSync);
let res;
// paths.forEach((path) =>{
//     res = fs.readFileSync(path, {encoding: "utf-8"})}
// );

// console.log('res', res);

paths.forEach((path) => fs.readFile(path, { encoding: "utf-8" }, (err, data) => {
    if (err) {
        console.log('err', err);
    } else {console.log('data', data)}
}));
