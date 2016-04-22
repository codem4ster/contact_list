require 'pp'

# Load the Rails application.
require File.expand_path('../application', __FILE__)
Bundler.require(:default, Rails.env)

# Initialize the Rails application.
Rails.application.initialize!
