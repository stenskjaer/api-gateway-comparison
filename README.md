
# API gateway experiments

The purpose of the repository is to experiment with different ways of setting up
and exposing API endpoints for an application.


# History of this repository: Ruby Getting Started

This repository is based off of Google's [repository for getting started with Ruby
on Rails on GCP App
Engine](https://github.com/GoogleCloudPlatform/ruby-docs-samples). See also [the
guide associated with the original
repository](https://cloud.google.com/endpoints/docs/openapi/get-started-app-engine). 

The readme relevant for the part of the codebase that is preserved here is given
below. It gives some notes for how to setup the Cloud Datastore database
connection.

## Datastore
Checkout branches to view particular steps of this sample application.

 - `1-hello-world`
 - `2-sql-database`
 - `2-datastore`
 - `3-files`
 - `4-auth`
 - `5-logging (?)` *(hello world has logging enabled)*
 - `6-task-queueing`
 - `7-compute-engine`

[Ruby on Rails][ror] web application on [Google App Engine flexible environment][fevm].

### Dependencies

To run the Bookshelf app, first ensure that you have a [stable version][rstable] of Ruby.

For information on installing Ruby, view [Installing Ruby][] on the [Ruby website][].

If you are using a system version of ruby, you will need to use `sudo` to install gems.

To install gems locally for your user, add the following to your `~/.bashrc` or `~/.bash_profile`:

    export GEM_HOME="$HOME/.gems"
    export GEM_PATH="$HOME/.gems"
    export PATH="$GEM_PATH/bin:$PATH"

Or gems can be installed using the [`--user-install` flag][user-install].

### Run

To run the application, first install dependencies:

    $ bundle install

And then run the Rails web server:

    $ rails server

### To run the tests

    $ bundle install
    $ rspec spec/

### To deploy to App Engine Managed VMs

    $ gcloud app deploy

[ror]: http://rubyonrails.org/
[fevm]: https://cloud.google.com/appengine/docs/flexible/
[Installing Ruby]: https://www.ruby-lang.org/en/documentation/installation/
[Ruby website]: https://www.ruby-lang.org
[rstable]: https://www.ruby-lang.org/en/downloads/
[user-install]: http://guides.rubygems.org/faqs/#user-install

## Contributing changes

* See [CONTRIBUTING.md](CONTRIBUTING.md)

## Licensing

* See [LICENSE](LICENSE)
