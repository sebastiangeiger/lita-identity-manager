require "spec_helper"

describe Lita::Handlers::IdentityManager, lita_handler: true do

  describe '#new_github_identity' do
    it { is_expected.to route_command("Lita: @sebastian is @sebastiangeiger on github").to(:new_github_identity) }

    it "replies with a confirmation message" do
      send_message("Lita: @sebastian is @sebastiangeiger on github")
      expect(replies.last).to eql "Linked @sebastian to @sebastiangeiger on github"
    end
  end
end
