require "spec_helper"

class Example
  def foo; end
end

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
