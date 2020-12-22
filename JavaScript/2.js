// AdventOfCode2020
// --- Day 2: Password Philosophy ---
// part1: 600
// part1: 6.45ms
// part2: 456
// part2: 1.811ms

let fs = require("fs");

function part1() {
    let data = new Array();
    fs.readFileSync("../data/google-2.txt", "utf-8")
    //fs.readFileSync("./data.txt", "utf-8")
        .split("\n")
        .forEach((line,index,arr) => {
            if (index === arr.length - 1 && line === "") { return; }
            //console.log("line="+line);
            let rx_extract = /(\d{1,2})-(\d{1,2}) (\w): (\w+)/;
            m=rx_extract.exec(line)
            //console.log(m[1],m[2],m[3],m[4]);
            let row = new Array(m[1],m[2],m[3],m[4])
            data.push(row);
        });

    // Solve the problem here
    let valid = 0;
    for (i = 0; i < data.length; i++) {
        let array = data[i];
        let cnt = array[3].split( new RegExp(array[2], "i" )).length-1
        //console.log("cnt= "+cnt,"array[1]= "+Number(array[0]),"array[2]= "+Number(array[1]));
        if (cnt >= Number(array[0]) && cnt <= Number(array[1]) )
            valid++;
    }
    console.log("part1: " + valid);
}

function part2() {
    let data = new Array();
    fs.readFileSync("../data/google-2.txt", "utf-8")
    //fs.readFileSync("./data.txt", "utf-8")
        .split("\n")
        .forEach((line,index,arr) => {
            if (index === arr.length - 1 && line === "") { return; }
            //console.log("line="+line);
            let rx_extract = /(\d{1,2})-(\d{1,2}) (\w): (\w+)/;
            m=rx_extract.exec(line)
            //console.log(m[1],m[2],m[3],m[4]);
            let row = new Array(m[1],m[2],m[3],m[4])
            data.push(row);
        });

    // Solve the problem here
    let valid = 0;
    for (i = 0; i < data.length; i++) {
        let array = data[i];
        //console.log("cnt= "+cnt,"array[1]= "+Number(array[0]),"array[2]= "+Number(array[1]));
        if (array[3].charAt(Number(array[0]))===array[2] ^ array[3].charAt(Number(array[1]))===array[2])
            valid++;
    }
    console.log("part2: " + valid);
}

console.time('part1');
part1();
console.timeEnd('part1');

console.time('part2');
part2();
console.timeEnd('part2');
