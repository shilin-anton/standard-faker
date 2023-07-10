require "yaml"

module Standard
  module Faker
    class Plugin < LintRoller::Plugin
      def about
        LintRoller::About.new(
          name: "standard-faker",
          version: VERSION,
          homepage: "https://github.com/shilin-anton/standard-faker",
          description: "Configuration for rubocop-faker rules."
        )
      end

      def supported?(context)
        true
      end

      def rules(context)
        trick_rubocop_into_thinking_we_required_rubocop_faker!

        LintRoller::Rules.new(
          type: :object,
          config_format: :rubocop,
          value: YAML.load_file(Pathname.new(__dir__).join("../../../config/base.yml"), aliases: true)
        )
      end

      private

      # This is not fantastic.
      #
      # When you `require "rubocop-faker"`, it will not only load the cops,
      # but it will also monkey-patch RuboCop's default_configuration, which is
      # something that can't be undone for the lifetime of the process.
      #
      # See: https://github.com/koic/rubocop-faker/blob/master/lib/rubocop-faker.rb#L9
      #
      # As an alternative, standard-faker loads the cops directly, and then
      # simply tells the RuboCop config loader that it's been loaded. This is
      # taking advantage of a private API of an `attr_reader` that probably wasn't
      # meant to be mutated externally, but it's better than the `Inject` monkey
      # patching that rubocop-faker does (and many other RuboCop plugins do)
      def trick_rubocop_into_thinking_we_required_rubocop_faker!
        without_warnings do
          require_relative "load_rubocop_faker_without_the_monkey_patch"
        end
        RuboCop::ConfigLoader.default_configuration.loaded_features.add("rubocop-faker")
      end

      # This is also not fantastic, but because loading RuboCop before loading
      # ActiveSupport will result in RuboCop redefining a number of ActiveSupport
      # methods like String#blank?, we need to suppress the warnings that are
      # emitted when we load the cops.
      def without_warnings(&blk)
        original_verbose = $VERBOSE
        $VERBOSE = nil
        yield
      ensure
        $VERBOSE = original_verbose
      end
    end
  end
end
