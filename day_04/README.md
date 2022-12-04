# Day 4

For the fourth day of Advent of Code, so how could I not use... Forth!

...but it if wasn't for the joke, honestly, I wouldn't have picked this. As always,
I'm sure it's my fault because I'm basically speedrunning learning new languages,
but this was... kinda painful.

Part of it is just that it's a very different language style from what I'm used to,
which is both a good and a bad. It did make something that should be trivial - just
checking ranges, for example - slightly trickier at first. In particular, it wasn't
until I realized that I could just use `roll` to easily manipulate values further
down the stack by bringing them up the stack where most commands worked.

The other is that... well, part of it is because I'm trying to work quickly and read
fast, but I didn't have a fun time with the Forth documentation or figuring out what
some things did. For example, I had to check Advent of Code solutions from a few years
ago to figure out how the heck you read from a file, because googling it or looking
at documentation just left me more confused. The poor IDE/editor experience also left
much to be desired.

On the good side, the stack-based logic was actually pretty fun once things started
working, and working at this sort of "low level" where you're manually managing
the stack is pretty satisfying.

All in all I still had fun with Forth and today's Advent of Code, but... yeah.

## Usage

Install the gforth compiler, then run:

```bash
./run.sh
```
