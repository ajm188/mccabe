# McCabe

Measure the McCabe or [cyclomatic](http://en.wikipedia.org/wiki/Cyclomatic_complexity)
complexity of Ruby code.

## Installation

This is currently not a gem, though I will probably turn it in to one soon.
For now, the following will suffice:

```
git clone git@github.com:ajm188/mccabe.git
cd mccabe
# Execute the mccabe.rb file (see usage instructions below)
```

## Usage

From the command line, pass the list of files you want to analyze. You can
optionally specify your own threshold as the first argument. The default
threshold is 4. You will get error messages for any methods which have
complexity greater than the threshold.

If the first argument is not an integer, it will be interpreted as a file
pattern (any other arguments are also file patterns).

Note that the script only considers files with .rb extensions, so that it
doesn't attempt to parse other languages as Ruby. So, if you have
extensionless Ruby scripts, you won't be able to use this on them.

Examples:
```
ruby mccabe.rb file1 ../file2
ruby mccabe.rb 3 file1 # using a different threshold
ruby mccabe.rb *.rb # wildcards work, too
ruby mccabe.rb . # can also look through entire directories
```

## Contributing

Fork and pull.
