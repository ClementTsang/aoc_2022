#!/bin/bash

purty --write src/Main.purs && spago run -b "asdf $1"