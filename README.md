## rspec-context-doubles

Temporarily configure `RSpec` to use a different type of doubles.

### Why would you want to do that?

Here is the one that resulted in this library:

If you use `Rails` and add a helper method from a controller (or use a gem like `canable` that does), `RSpec` will raise an error when one of those helper methods is stubbed in a view spec if it is configured to use verifying doubles.

### How do you use it?

Just pass `:normal_doubles` or `:verifying_doubles` as metadata to a `describe` block and you'll temporarily set the behavior for the examples in that block.

```ruby
# spec_helper.rb
# ...
config.mock_with :rspec do |mocks|
  mocks.verify_partial_doubles = true
end
# ...
```

```ruby
# Gemfile
group :test do
  gem "rspec-context-doubles"
end
```

```ruby
# example.rb
class Example
  def foo; end
end
```

```ruby
# example_spec.rb
describe Example do
  context "configured to use verifying doubles" do
    before(:all) { RSpec::Mocks.configuration.verify_partial_doubles = true }

    describe "temporarily using normal doubles", :normal_doubles do
      it "does not raise an error when a non-existent method is stubbed" do
        expect{allow(subject).to receive(:fo)}.to_not raise_error
      end
    end
    it "raises an error when a non-existent method is stubbed" do
      expect{allow(subject).to receive(:fo)}.to raise_error(RSpec::Mocks::MockExpectationError)
    end
  end

  context "configured to use normal doubles" do
    before(:all) { RSpec::Mocks.configuration.verify_partial_doubles = false }

    describe "temporarily using verifying doubles", :verifying_doubles do
      it "raises an error if a non-existent method is stubbed" do
        expect{allow(subject).to receive(:fo)}.to raise_error(RSpec::Mocks::MockExpectationError)
      end
    end
    it "does not raise an error when a non-existent method is stubbed" do
      expect{allow(subject).to receive(:fo)}.to_not raise_error
    end
  end
end
```

### Credits

Written by [@barelyknown](http://twitter.com/barelyknown).

This gem uses [RSpec's shared context feature](https://www.relishapp.com/rspec/rspec-core/docs/example-groups/shared-context).

The idea for the gem came from [this rspec-mocks issue](https://github.com/rspec/rspec-mocks/issues/633).
