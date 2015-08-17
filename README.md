# McCabe

Measure the McCabe or [cyclomatic](http://en.wikipedia.org/wiki/Cyclomatic_complexity)
complexity of Ruby code.

## Installation

```
$ gem install mccabe
```

## Usage

From the command line, pass the list of files you want to analyze. You can
optionally specify your own threshold as the first argument. The default
threshold is 4. You will get error messages for any methods which have
complexity greater than the threshold.

Note that the script only considers files with .rb extensions, so that it
doesn't attempt to parse other languages as Ruby. So, if you have
extensionless Ruby scripts, you won't be able to use this on them.

Examples:
```
mccabe file1 ../file2
mccabe file1 --threshold 3 # using a different threshold
mccabe *.rb # wildcards work, too
mccabe . # can also look through entire directories
mccabe . --quiet # will not print to stdout, only return success/failure status code
```

## Contributing

Fork and pull.
