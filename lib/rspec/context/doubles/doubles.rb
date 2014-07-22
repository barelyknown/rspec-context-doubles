RSpec.shared_context 'normal doubles', normal_doubles: true do

  before :all do
    @partial_doubles_configuration = RSpec::Mocks.configuration.verify_partial_doubles?
    RSpec::Mocks.configuration.verify_partial_doubles = false
  end

  after :all do
    RSpec::Mocks.configuration.verify_partial_doubles = @partial_doubles_configuration
  end

end

RSpec.shared_context "verifying doubles", verifying_doubles: true do

  before :all do
    @partial_doubles_configuration = RSpec::Mocks.configuration.verify_partial_doubles?
    RSpec::Mocks.configuration.verify_partial_doubles = true
  end

  after :all do
    RSpec::Mocks.configuration.verify_partial_doubles = @partial_doubles_configuration
  end

end
