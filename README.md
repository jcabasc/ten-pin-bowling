ten-pin-bowling
===================
A command-line application to score a game of  ten-pin bowling

Developed by: `Jonathan Cabas Candama`

# Requirements

* Ruby 2.6.0
* RVM

# Installation

Some of the following steps are not strictly required. i.e: you can use a different ruby version manager.

* [Install RVM](https://rvm.io/rvm/install)
* rvm install ruby-2.6.0 (if needed)
* cd ten-pin-bowling
* gem install bundler (if needed)
* bundle install

# Getting Started

``
  $ rake ten_pin_bowling:start "spec/fixtures/perfect_score.txt"
``

More fixtures are included in "spec/fixtures" folder.

# Testing

The testing framework that was used is `RSpec`

In order to run the test suite, just run the following command:

```sh

  $ rspec spec

  .....
  Finished in 0.01094 seconds (files took 0.425 seconds to load)
  7 examples, 0 failures
```
