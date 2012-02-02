# Purpose

This extends [Jasmine](http://pivotal.github.com/jasmine/) so that the code under test can be compiled using [Sprockets](https://github.com/sstephenson/sprockets). This allows for declarative dependency management and preprocessing. 

# Installation with [Bundler](http://gembundler.com/)

In the `Gemfile` add:

    ...
    gem 'jasmine-sprockets'
    ...

# Configuration

By default jasmine-sprockets will add the directory `vendor` to the load path for resolving dependencies. This is useful if the code under test requires external dependencies that are not part of the library. To change this behaviour edit `jasmine.yml` and add:

    # sprocket_dirs
    #
    # Return an array of directories used by sprockets to resolve dependencies
    sprocket_dirs:
        - vendor

# Adding preprocessing (coffee script)

In the `Gemfile` add:

    ...
    gem 'coffee-script'
    gem 'tilt'
    ...
    
And in `jasmine_runner.rb` add:

    ...
    ::Tilt::CoffeeScriptTemplate.default_bare = true
    ...