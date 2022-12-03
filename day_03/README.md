# Day 03

Today's solution is in [LDPL](https://www.ldpl-lang.org/), a COBOL-inspired language. This was, honestly, a bit painful,
but also interesting. The language itself has pretty good documentation, and I actually kinda liked how the COBOL-like
syntax looked and all. But it's really verbose, and there are probably a lot of features that are either missing or I
totally overlooked that would have made this cleaner. That said, a large part of the jank is definitely on me.

## Usage

Download LDPL (I used 4.4) [here](https://github.com/Lartu/ldpl/releases/tag/4.4). Extract to this directory, and then run:

```bash
./build.sh
```

to get a binary, `day_03`, which you can then run:

```bash
./day_03
```

Alternatively, build and run in one step with:

```bash
./run.sh
```

You can pass in an argument to either the binary or the script to load specific file:

```bash
./day_03 example.txt

# Or
./run.sh example.txt
```

If you don't pass one in, it assumes that you are looking at a file in the same directory called `input.txt`.
