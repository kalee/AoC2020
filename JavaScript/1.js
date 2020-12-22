// AdventOfCode2020
// --- Day 1: Report Repair ---
// part1:  63616
// part1: 11.303ms
// part2:  67877784
// part2: 96.447ms
//
let fs = require("fs");

function part1() {
    let a = new Array();
    let data = new Set();
    fs.readFileSync("../data/google-1.txt", "utf-8")
        .split("\n")
        .forEach((line,index,arr) => {
            if (index === arr.length - 1 && line === "") { return; }
            data.add(line);
        });
    for (let i of data.values()) {
        for (let j of data.values()) {
            if (Number(i)+Number(j)===2020) {
                console.log("part1: ",Number(i)*Number(j));
            }
        }
    }    
}

function part2() {
    let a = new Array();
    let data = new Set();
    fs.readFileSync("../data/google-1.txt", "utf-8")
        .split("\n")
        .forEach((line,index,arr) => {
            if (index === arr.length - 1 && line === "") { return; }
            data.add(line);
        });
    for (let i of data.values()) {
        for (let j of data.values()) {
            for (let k of data.values()) {
                if (Number(i)+Number(j)+Number(k)===2020) {
                    console.log("part2: ",Number(i)*Number(j)*Number(k));
                }
            }
        }
    }    
}

console.time('part1');
part1();
console.timeEnd('part1');

console.time('part2');
part2();
console.timeEnd('part2');
