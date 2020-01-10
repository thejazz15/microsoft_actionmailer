require "microsoft_actionmailer/version"
require 'microsoft_actionmailer/railtie' if defined?(Rails)
require 'microsoft_actionmailer/api'

require 'httparty'
require 'net/http'
require 'uri'

module MicrosoftActionmailer

  GRAPH_HOST = 'https://graph.microsoft.com'.freeze

  class DeliveryMethod
    include MicrosoftActionmailer::Api

    attr_reader :access_token
    attr_reader :delivery_options

    def initialize params
      @access_token = params[:authorization]
      @delivery_options = params[:delivery_options] || {}
    end

    def deliver! mail
      message = ms_create_message(
        access_token,
        mail.subject,
        mail.body.encoded,
        mail.to.first
      )

      before_send = delivery_options[:before_send]
      if before_send && before_send.respond_to?(:call)
        before_send.call(mail, message)
      end

      ms_send_message(access_token, message['id'])

      after_send = delivery_options[:after_send]
      if after_send && after_send.respond_to?(:call)
        after_send.call(mail, message)
      end
    end
  end
end
