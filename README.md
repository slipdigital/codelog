# FloowClientApi

This gem is responsible for communicating with the API via Thrift definitions.

## Installation

Add this line to your application's Gemfile:

    gem 'floow_client_api'

If you are working locally you can do the following

    gem 'floow_client_api', :path => '../path_to_gem_locally'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install floow_client_api

## Tagging versions

Use the tag to dictate the version of the gem.

Tag format for production versions :

: v([0-9].).([0-9].).([0-9].)

To add a tag for a new version do the following :

    git tag -a v1.0.0 -m 'first version'
    git push origin v1.0.0

In order to update a tag version do the following

    git tag -d v1.0.0
    git push origin :refs/tags/v1.0.0
    git tag -a v1.0.0 -m 'first version'
    git push origin v1.0.0

List Existing Tags

    git tag

To view details of an existing tag run

    git show {tag name}
