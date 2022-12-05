import sys.io.File;
import sys.thread.Deque;

class Tower {
	public var stacks:Array<Deque<String>>;

	public function new() {
		stacks = new Array();
	}

	public function addLine(line:String) {
		var lineIndex = 0;
		var stackIndex = 0;

		while (lineIndex < line.length) {
			stackIndex += 1;

			var symbol = line.substr(lineIndex + 1, 1);
			lineIndex += 4;
			if (stacks.length < stackIndex) {
				stacks.push(new Deque());
			}

			if (symbol != " ") {
				stacks[stackIndex - 1].add(symbol);
			}
		}
	}

	public function topLine() {
		for (stack in stacks) {
			Sys.print(stack.pop(false));
		}
		Sys.print("\n");
	}
}

class Instruction {
	public var amount:Int;
	public var from:Int;
	public var to:Int;

	public function new(line:String) {
		var words = line.split(" ");
		this.amount = Std.parseInt(words[1]);
		this.from = Std.parseInt(words[3]);
		this.to = Std.parseInt(words[5]);
	}

	public function toString() {
		return "Instruction: move " + amount + " from " + from + " to " + to;
	}
}

class Data {
	public var tower:Tower;
	public var instructions:Array<Instruction>;

	public function new(tower, instructions) {
		this.tower = tower;
		this.instructions = instructions;
	}
}

class Day05 {
	static public function readToData(lines:Array<String>) {
		var readingInstructions = false;
		var tower = new Tower();
		var instructions:Array<Instruction> = new Array();

		for (line in lines) {
			if (line == "") {
				readingInstructions = true;
				continue;
			} else if (!readingInstructions && line.split("1").length > 1) {
				// Skip the counter row.
				continue;
			}

			if (readingInstructions) {
				instructions.push(new Instruction(line));
			} else {
				tower.addLine(line);
			}
		}

		return new Data(tower, instructions);
	}

	static public function partOne(lines) {
		var data = readToData(lines);

		for (instruction in data.instructions) {
			for (i in 0...(instruction.amount)) {
				var symbol = data.tower.stacks[instruction.from - 1].pop(false);
				data.tower.stacks[instruction.to - 1].push(symbol);
			}
		}

		Sys.print("Part one: ");
		data.tower.topLine();
	}

	static public function partTwo(lines) {
		var data = readToData(lines);

		for (instruction in data.instructions) {
			var queue = new Array();
			for (i in 0...(instruction.amount)) {
				var symbol = data.tower.stacks[instruction.from - 1].pop(false);
				queue.push(symbol);
			}
			for (i in 0...(instruction.amount)) {
				var symbol = queue.pop();
				data.tower.stacks[instruction.to - 1].push(symbol);
			}
		}

		Sys.print("Part two: ");
		data.tower.topLine();
	}

	static public function main() {
		var filePath = Sys.args().length > 0 ? Sys.args()[0] : "input.txt";
		Sys.println("Reading from file `" + filePath + "`\n");
		var lines = File.getContent(filePath).split("\n");

		partOne(lines);
		partTwo(lines);
	}
}
