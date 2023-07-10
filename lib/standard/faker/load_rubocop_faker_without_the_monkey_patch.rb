# GENERATED FILE - DO NOT EDIT
#
# This file should look just like: https://github.com/koic/rubocop-faker/blob/master/lib/rubocop-faker.rb
# Except without the `Inject.defaults!` monkey patching.
#
# Because there are both necessary require statements and additional patching
# of RuboCop built-in cops in this file, we need to monitor it for changes
# in rubocop-faker and keep it up to date.
#
# Last updated from rubocop-faker v1.1.0

# frozen_string_literal: true

require "rubocop"

require_path = Pathname.new(Gem.loaded_specs["rubocop-faker"].full_require_paths.first)
require require_path.join("rubocop/faker")
require require_path.join("rubocop/faker/version")
# require_relative 'rubocop/faker/inject'

# RuboCop::Faker::Inject.defaults!

require require_path.join("rubocop/cop/faker_cops")
