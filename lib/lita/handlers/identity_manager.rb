module Lita
  module Handlers
    class IdentityManager < Handler
      NEW_GITHUB_IDENTITY_REGEX = /(.+) is (.+) on github$/i
      GET_GITHUB_IDENTITY_REGEX = /Who is (.+) on github\??$/i

      route NEW_GITHUB_IDENTITY_REGEX, :new_github_identity,
        command: true,
        help: { "CHAT_USER is GITHUB_USER on github" => "Will link the chat user to the specified github username" }

      def new_github_identity(response)
        match_data = response.message.body.match(NEW_GITHUB_IDENTITY_REGEX)
        chat_name = match_data[1]
        github_name = match_data[2]
        response.reply("Linked #{chat_name} to #{github_name} on github")
        redis.set("github:#{chat_name}", github_name)
      end

      route GET_GITHUB_IDENTITY_REGEX, :get_github_identity,
        command: true,
        help: { "Who is CHAT_USER on github?" => "Returns the github username for CHAT_USER" }

      def get_github_identity(response)
        match_data = response.message.body.match(GET_GITHUB_IDENTITY_REGEX)
        chat_name = match_data[1]
        if github_name = redis.get("github:#{chat_name}")
          response.reply("#{chat_name} is known as #{github_name} on github")
        else
          response.reply("I don't know about #{chat_name} on github")
        end
      end
    end

    Lita.register_handler(IdentityManager)
  end
end
