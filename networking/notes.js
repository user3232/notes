let p = 13n;
console.log(`> Modulus is prime = ${p}`);
let g = 17n;
console.log(`> Exponent base is = ${g}`);
let s_1 = 11n; 
console.log(`> First secret is  = ${s_1}`);
let s_2 = 15n;
console.log(`> Second secret is = ${s_2}`);

let fgp = (g, p, s) => g**s % p;

let S_12 = fgp(g, p, s_1*s_2);
console.log(`
> Common mapped secret knowing 
  both secrets is = ${S_12}`);


let S_1 = fgp(g, p, s_1);
let S_2 = fgp(g, p, s_2);
let S_12_1 = fgp(S_2, p, s_1);
console.log(`
> Common mapped secret knowing first secret 
  and mapping of second secret is = ${S_12_1}`);
let S_12_2 = fgp(S_1, p, s_2);
console.log(`
> Common mapped secret knowing second secret 
  and mapping of first secret is  = ${S_12_2}`);

console.assert(S_12 === S_12_1);
console.assert(S_12 === S_12_2);