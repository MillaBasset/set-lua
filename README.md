# set-lua
Implementation of sets in Lua. A set can only contain unique elements.

## Features
- Set creation from a list of elements or a table
- Conversion of a set to a table / list or a string representation
- Set cloning
- Set union, intersection, and difference
- Set equality and (proper) subset checking
- Checking if a set contains an element
- Checking if a set is empty
- Checking a set's size / cardinality
- Insertion and removal of elements in a set
- Iterate through all elements in a set
- Small (< 200 sloc)
- Portable (works in Lua 5.1+)

## How to use

First, `require` the library to load it, preferably into a local variable named `set`.

    local set = require "set"
    
To create a `set`, supply zero or more elements to `set.new`.

    local x = set.new(3, 2, 6, 9)
    
It is also possible to create a set from a table:

    local y = set.fromList({4, 3, 5})
    
For operations on `set`s, there are a few choices of syntax:

    local z = set.union(x, y) --> {3, 2, 6, 9, 4, 5}
    local z = x:union(y)

Some operations are attached to metamethods:

    local z = x + y -- equivalent to above two statements
    
Remember that sets are unordered, so the elements' placement in a set need not be consistent.

Please see the source code for other method names.

## Warnings

The following will result in the library having undefined behavior:

- Modifying elements of a set manually (`set.insert` and `set.remove` are OK)
- Inserting a string that happens to be a method name into a set (TODO: fix)

It is up to you to make sure that your code avoids these things.
