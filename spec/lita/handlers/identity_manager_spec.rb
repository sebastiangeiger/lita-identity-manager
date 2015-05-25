require "spec_helper"

describe Lita::Handlers::IdentityManager, lita_handler: true do

  describe '#new_github_identity' do
    it { is_expected.to route_command("@sebastian is @sebastiangeiger on github").to(:new_github_identity) }
  end
end
