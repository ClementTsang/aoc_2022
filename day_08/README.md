# Day 8

Today's main solution is in PureScript. I was going to do this yesterday but it wasn't really a great fit for that problem, so today's the day I finally write something in it after having first looked into this language for almost 2 or 3 years.

As for working the language itself... it's alright, I guess. I've used Haskell before for school and the previous Advent of Code, as well as functional languages in general, so it wasn't too much of a jump, and I enjoy working in Haskell and similar languages. It's really satisfying to get something working, and the resulting code has an overall style that I really like ~~even if my code itself is pretty horrible~~.

That said, it was a bit tricky figuring out the ecosystem and some of the syntax/docs. Examples seem very sparse as well, which isn't great when you're learning a new language and want to see how the heck they apply some function or concept in actual code - something the documentation _sorely_ lacks for the most part from my experience. The tooling in VS Code was a also kinda spotty and kept crashing, which is a bit problematic for me since I often lean a bit on some compiler/editor hints when new. At least it would usually work again if I reloaded, but that's... not a good solution.

Some minor gripes as well - the extension also didn't auto-format for some reason despite having options for it (I had to manually do that in the `run.sh` script each time), and adding a new dependency (which was very common at the start) required a full reload. On that note, it was... kinda weird how sometimes, the extension would have no issues with me adding a dependency, but then Spago would complain about how I never added it. It's again easy to fix, but it confused me the few times it happened.

Despite me complaining though, these are pretty small things, and overall I enjoyed working with PureScript. It's definitely an interesting functional option when in the JS ecosystem.

On a side note, cheated a bit today as well and did my initial solution in Python. I'll probably be doing this for a while as it's a much faster way for me to first figure out something that works (and is usually very ugly), and wrap my head around the problem, without me fighting learning a new language at the exact same time.

## Usage

To run, install [PureScript](https://www.purescript.org/), then run the `./run.sh` script with the path to your input:

```bash
./run.sh example.txt
```

As usual, omitting the file path will just assume you mean to run it with `input.txt`:

```bash
./run.sh
```
