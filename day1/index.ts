function modulo(n: number, m: number) {
	return n < 0 ? n + m : n % 100;
}

async function part1() {
	// const smallInput = "L68\nL30\nR48\nL5\nR60\nL55\nL1\nL99\nR14\nL82\n"
	const bigInput = await Bun.file("input.txt").text();
	let sequence = bigInput.split("\n");
	sequence.pop()

	let zeroCount = 0;
	let dial = 50;
	for (const item of sequence) {
		const sign = item[0] == "R" ? 1 : -1;
		const value = Number(item.slice(1)) % 100
		dial += sign * value;
		dial = modulo(dial, 100);
		if (dial == 0) zeroCount += 1;
	}
	console.log(zeroCount);
}

await part1();

async function part2() {
	// const inp = "L68\nL30\nR48\nL5\nR60\nL55\nL1\nL99\nR14\nL82\n"
	const inp = await Bun.file("input2.txt").text()
	let sequence = inp.split("\n");
	sequence.pop()
	let zeroCount = 0;
	let dial = 50;
	for (const item of sequence) {
		const wasOnZero = dial == 0;
		const sign = item[0] == "R" ? 1 : -1;
		let value = Number(item.slice(1));
		const roundaboutClicks = Math.floor(value / 100);
		value = value % 100;
		zeroCount += roundaboutClicks;
		dial += sign * value;
		if ((dial > 100 || dial < 0) && !wasOnZero) zeroCount += 1;
		dial = modulo(dial, 100);
		if (dial == 0) zeroCount += 1;
	}
	console.log(zeroCount);
}

await part2();
