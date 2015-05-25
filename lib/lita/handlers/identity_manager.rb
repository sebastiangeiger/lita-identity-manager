module Lita
  module Handlers
    class IdentityManager < Handler
      route /.+ is .+ on github$/, :new_github_identity,
        command: true,
        help: { "CHAT_USER is GITHUB_USER on github" => "Will link the chat user to the specified github username" }
    end

    Lita.register_handler(IdentityManager)
  end
end
