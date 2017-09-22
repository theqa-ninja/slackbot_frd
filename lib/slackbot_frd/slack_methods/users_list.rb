require 'httparty'
require 'json'

module SlackbotFrd
  module SlackMethods
    class UsersList
      include HTTParty
      base_uri 'https://slack.com/api/users.list'

      attr_reader :response

      def initialize(token)
        @token = token
      end

      def connect
        @response = JSON.parse(self.class.post('', :body => { token: @token } ).body)
        ValidateSlack.response(@response)
        self
      end

      def ids_to_names
        retval = {}
        @response['members'].each do |user|
          retval[user['id']] = user['name']
        end
        retval
      end

      def names_to_ids
        retval = {}
        @response['members'].each do |user|
          retval[user['name']] = user['id']
        end
        retval
      end

      def ids_to_displaynames
        retval = {}
        @response['members'].each do |user|
          retval[user['id']] = user['profile']['display_name_normalized']
        end
        retval
      end

      def ids_to_realnames
        retval = {}
        @response['members'].each do |user|
          retval[user['id']] = user['profile']['real_name_normalized']
        end
        retval
      end

      def ids_to_email
        retval = {}
        @response['members'].each do |user|
          retval[user['id']] = user['profile']['email']
        end
        retval
      end
    end
  end
end
