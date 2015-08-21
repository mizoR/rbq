# rbq(1)
[![Gem Version](https://badge.fury.io/rb/rbq.svg)](http://badge.fury.io/rb/rbq)
[![Build Status](https://travis-ci.org/mizoR/rbq.svg)](https://travis-ci.org/mizoR/rbq)
[![Code Climate](https://codeclimate.com/github/mizoR/rbq/badges/gpa.svg)](https://codeclimate.com/github/mizoR/rbq)
[![Test Coverage](https://codeclimate.com/github/mizoR/rbq/badges/coverage.svg)](https://codeclimate.com/github/mizoR/rbq/coverage)
[![Dependency Status](https://gemnasium.com/mizoR/rbq.svg)](https://gemnasium.com/mizoR/rbq)

## NAME

rbq - Command-line processor like jq.

## DESCRIPTION

rbq is a command-line processor like [jq](http://stedolan.github.io/jq/). But it allows you to use the Ruby-syntax.

## SYNOPSIS

    $ rbq [--to format] [--to-options optKey:optValue] [-r library] <script> [file ...]

## EXAMPLES

### If you have the following JSON file:

```sh
$ cat <<JSON > languages.json
    [
        { "lang": "C",          "born_in": 1973, "inspired_by": ["Algol", "B"]                       },
        { "lang": "C++",        "born_in": 1980, "inspired_by": ["C", "Simula", "Algol"]             },
        { "lang": "C#",         "born_in": 2000, "inspired_by": ["Delphi", "Java", "C++", "Ruby"]    },
        { "lang": "Java",       "born_in": 1994, "inspired_by": ["C++", "Objective-C", "C#"]         },
        { "lang": "JavaScript", "born_in": 1995, "inspired_by": ["C", "Self", "awk", "Perl"]         },
        { "lang": "Perl",       "born_in": 1987, "inspired_by": ["C", "shell", "AWK", "sed", "LISP"] },
        { "lang": "PHP",        "born_in": 1995, "inspired_by": ["Perl", "C"]                        },
        { "lang": "Python",     "born_in": 1991, "inspired_by": ["ABC", "Perl", "Modula-3" ]         },
        { "lang": "Ruby",       "born_in": 1995, "inspired_by": ["Perl", "Smalltalk", "LISP", "CLU"] }
    ]
JSON
```

### Extract name and born_in of languages the first letter is "P", and dump as JSON

```sh
$ cat languages.json | rbq 'map {|l| l.slice(:lang, :born_in)}.select {|l| l[:lang].start_with?("P")}'
[
  {
    "lang": "Perl",
    "born_in": 1987
  },
  {
    "lang": "PHP",
    "born_in": 1995
  },
  {
    "lang": "Python",
    "born_in": 1991
  }
]
```

### Extract name and born_in of all languages, dump as TSV

```sh
$ cat languages.json | rbq 'map {|l| l.slice(:born_in, :lang).values}' --to tsv
1973    C
1980    C++
2000    C#
1994    Java
1995    JavaScript
1987    Perl
1995    PHP
1991    Python
1995    Ruby
```

## INSTALLATION

Add this line to your application's Gemfile:

```ruby
gem 'rbq'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rbq

## CONTRIBUTING

Bug reports and pull requests are welcome on GitHub at https://github.com/mizoR/rbq.

## LICENSE

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

