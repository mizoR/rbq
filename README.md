# rbq
[![Gem Version](https://badge.fury.io/rb/rbq.svg)](http://badge.fury.io/rb/rbq)
[![Build Status](https://travis-ci.org/mizoR/rbq.svg)](https://travis-ci.org/mizoR/rbq)
[![Code Climate](https://codeclimate.com/github/mizoR/rbq/badges/gpa.svg)](https://codeclimate.com/github/mizoR/rbq)
[![Test Coverage](https://codeclimate.com/github/mizoR/rbq/badges/coverage.svg)](https://codeclimate.com/github/mizoR/rbq/coverage)
[![Dependency Status](https://gemnasium.com/mizoR/rbq.svg)](https://gemnasium.com/mizoR/rbq)

rbq is a command-line processor like [jq](http://stedolan.github.io/jq/). It is equipped with ruby-syntax.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rbq'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rbq

## Usage

### Pre-conditions

If you have the following json file:

```sh
$ cat source.json
```

```json
[
  {
    "id": "55c6fcfa15fd385ac4d70b10",
    "picture": "http://placehold.it/32x32",
    "age": 35,
    "name": "Faye Hood",
    "gender": "female",
    "tags": [ "in", "elit", "laborum" ],
    "friends": [
      { "id": 0, "name": "Chaney Lopez" },
      { "id": 1, "name": "Trina Gaines" }
    ],
    "greeting": "Hello, Faye Hood! You have 2 unread messages."
  },
  {
    "id": "55c6fcfaafd6a08789100755",
    "picture": "http://placehold.it/32x32",
    "age": 38,
    "name": "Herrera Henderson",
    "gender": "male",
    "tags": [ "veniam", "deserunt", "cillum" ],
    "friends": [
      { "id": 0, "name": "Ramirez Guerrero" },
      { "id": 1, "name": "Chen Mullen" }
    ],
    "greeting": "Hello, Herrera Henderson! You have 4 unread messages."
  },
  {
    "id": "55c6fcfa8a4d8f16cddae1c4",
    "picture": "http://placehold.it/32x32",
    "age": 21,
    "name": "Lowery Strong",
    "gender": "male",
    "tags": [ "ad", "voluptate", "exercitation" ],
    "friends": [
      { "id": 0, "name": "Holland White" },
      { "id": 1, "name": "Isabelle Hudson" }
    ],
    "greeting": "Hello, Lowery Strong! You have 4 unread messages."
  }
]
```

### Fetch first user

```
$ cat source.json | rbq 'first'
```

```json
{
  "id": "55c6fcfa15fd385ac4d70b10",
  "picture": "http://placehold.it/32x32",
  "age": 35,
  "name": "Faye Hood",
  "gender": "female",
  "tags": [
    "in",
    "elit",
    "laborum"
  ],
  "friends": [
    {
      "id": 0,
      "name": "Chaney Lopez"
    },
    {
      "id": 1,
      "name": "Trina Gaines"
    }
  ],
  "greeting": "Hello, Faye Hood! You have 2 unread messages."
}
```

### Extract user's "id" and "name"

```
$ cat source.json | rbq 'map {|user| user.slice("id", "name")}'
```

```json
[
  {
    "id": "55c6fcfa15fd385ac4d70b10",
    "name": "Faye Hood"
  },
  {
    "id": "55c6fcfaafd6a08789100755",
    "name": "Herrera Henderson"
  },
  {
    "id": "55c6fcfa8a4d8f16cddae1c4",
    "name": "Lowery Strong"
  }
]
```

### Extract only user's "name" and "tags", and convert to YAML.

```
$ cat source.json | rbq --dst-format yaml 'map {|user| user.slice("name", "tags")}'
```

```yaml
---
- name: Faye Hood
  tags:
  - in
  - elit
  - laborum
- name: Herrera Henderson
  tags:
  - veniam
  - deserunt
  - cillum
- name: Lowery Strong
  tags:
  - ad
  - voluptate
  - exercitation

```

### Render male's names in text.

```
$ cat source.json | rbq --dst-format text 'select {|user| user["gender"] == "male"}.map {|user| user["name"]}.join("\n")'
```

```
Herrera Henderson
Lowery Strong
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mizoR/rbq.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

