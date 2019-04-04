module MicrosoftActionmailer
  class Railtie < Rails::Railtie
    initializer 'microsoft_actionmailer.add_delivery_method', before: 'action_mailer.set_configs' do
      ActionMailer::Base.add_delivery_method(:microsoft_actionmailer, MicrosoftActionmailer::DeliveryMethod)
    end
  end
end
