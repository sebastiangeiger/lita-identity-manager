module Lita
  module Handlers
    class IdentityManager < Handler
      NEW_GITHUB_IDENTITY_REGEX = /I am (.+) on github$/i
      GET_GITHUB_IDENTITY_REGEX = /Who is (.+) on github\??$/i

      route NEW_GITHUB_IDENTITY_REGEX, :new_github_identity,
        command: true,
        help: { "I am GITHUB_USER on github" => "Will link your chat identity to the specified github username" }

      def new_github_identity(incoming_message)
        chat_name = incoming_message.user.id
        match_data = incoming_message.message.body.match(NEW_GITHUB_IDENTITY_REGEX)
        github_name = match_data[1]
        redis.set("github:#{chat_name}", github_name)
        reply = "Linked #{chat_name} to #{github_name} on github"
        log.debug(%Q{"#{incoming_message.message.body}" by "#{incoming_message.user}" -> "#{reply}"})
        incoming_message.reply(reply)
      end

      route GET_GITHUB_IDENTITY_REGEX, :get_github_identity,
        command: true,
        help: { "Who is CHAT_USER on github?" => "Returns the github username for CHAT_USER" }

      def get_github_identity(incoming_message)
        match_data = incoming_message.message.body.match(GET_GITHUB_IDENTITY_REGEX)
        chat_name = match_data[1]
        github_name = redis.get("github:#{chat_name}")
        reply = if github_name
                  "#{chat_name} is known as #{github_name} on github"
                else
                  "I don't know about #{chat_name} on github"
                end
        log.debug(%Q{"#{incoming_message.message.body}" by "#{incoming_message.user}" -> "#{reply}"})
        incoming_message.reply(reply)
      end
    end

    Lita.register_handler(IdentityManager)
  end
end
