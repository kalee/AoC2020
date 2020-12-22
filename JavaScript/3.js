// AdventOfCode2020
// --- Day 2: Password Philosophy ---
// part1: 600
// part1: 6.45ms
// part2: 456
// part2: 1.811ms

let fs = require("fs");

function part1() {
    let data = new Array();
    fs.readFileSync("../data/google-3.txt", "utf-8")
    //fs.readFileSync("./data.txt", "utf-8")
        .split("\n")
        .forEach((line,index,arr) => {
            if (index === arr.length - 1 && line === "") { return; }
            data.push(line)
        });

    // Solve the problem here
    let ans = 1;
    let r   = 0;
    let c   = 0;
    while (r+1 < data.length) {
        c += 3
        r += 1
        if (data[r][c%data[r].length]
    }
}


import fileinput

slopes = [(1,1),(3,1),(5,1),(7,1),(1,2)]

G=[]
for line in fileinput.input():
    G.append(list(line.strip()))

ans = 1
for (dc,dr) in slopes:
    r = 0
    c = 0
    score = 0
    while r+1 < len(G):
        c+= dc
        r+= dr
        if G[r][c%len(G[r])]=="#":
            score += 1
    ans *= score
    if dc==3 and dr==1:
        print(score)
print(ans)





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
