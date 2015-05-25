module Lita
  module Handlers
    class IdentityManager < Handler
      NEW_GITHUB_IDENTITY_REGEX = /(.+) is (.+) on github$/i

      route NEW_GITHUB_IDENTITY_REGEX, :new_github_identity,
        command: true,
        help: { "CHAT_USER is GITHUB_USER on github" => "Will link the chat user to the specified github username" }

      def new_github_identity(response)
        match_data = response.message.body.match(NEW_GITHUB_IDENTITY_REGEX)
        chat_name = match_data[1]
        github_name = match_data[2]
        response.reply("Linked #{chat_name} to #{github_name} on github")
      end
    end

    Lita.register_handler(IdentityManager)
  end
end
