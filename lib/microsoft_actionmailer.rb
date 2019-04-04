require "microsoft_actionmailer/version"
require 'microsoft_actionmailer/railtie' if defined?(Rails)

module MicrosoftActionmailer
	class DeliveryMethod
		def initialize mail

		end

		def deliver! mail

		end
	end
end
