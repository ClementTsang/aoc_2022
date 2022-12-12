# Day 12

Today's language of choice is [Neko](https://nekovm.org/).

This was an interesting one - I learned about this language as it's a Haxe build target.

This was tricky as well since there... just isn't much Neko code out there. When looking on GitHub, I only found 180
files matching the file format. Documentation was also quite lacking, though thankfully with GitHub Code Search, I
could easily go through the backing C code to find the functions I needed. There also wasn't any real IDE/editor support
except a single syntax highlighter, which is always a great way to make things harder.

Despite this all though, honestly, using Neko was fine. I think this language is pretty cool as a simple language,
it feels like this weird blend of C and JS.

## Usage

Install [Neko](https://nekovm.org/). Run:

```bash
./run.sh example.txt
```

Omitting the file path will just assume that you meant to run it with `input.txt`:

```bash
./run.sh
```
