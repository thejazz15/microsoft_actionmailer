module MicrosoftActionmailer
  module Api
    # Creates a message and saves in 'Draft' mailFolder
    def ms_create_message(token, subject, content, addresses)
      recipients = []
      addresses.each do |address|
        data = { "emailAddress": { "address": address } }
        recipients << data
      end

      query = {
        "subject": subject,
        "importance": "Normal",
        "body":{
          "contentType": "HTML",
          "content": content
        },
        "toRecipients": recipients,
      }
      create_message_url = '/v1.0/me/messages'
      req_method = 'post'
      response = make_api_call create_message_url, token, query,req_method
      raise response.parsed_response.to_s || "Request returned #{response.code}" unless response.code == 201
      response
    end

    # Sends the message created using message id
    def ms_send_message(token, message_id)
      send_message_url = "/v1.0/me/messages/#{message_id}/send"
      req_method = 'post'
      query = {}
      response = make_api_call send_message_url, token, query,req_method
      raise response.parsed_response.to_s || "Request returned #{response.code}" unless response.code == 202
      response
    end

    def make_api_call(endpoint, token, params = nil, req_method)
      headers = {
        'Authorization'=> "Bearer #{token}",
        'Content-Type' => 'application/json'
      }

      query = params || {}
      if req_method == 'get'
        HTTParty.get "#{GRAPH_HOST}#{endpoint}",
                   headers: headers,
                   query: query
      elsif req_method == 'post'
        HTTParty.post "#{GRAPH_HOST}#{endpoint}",
                   headers: headers,
                   body: query.to_json
      end
    end
  end
end
