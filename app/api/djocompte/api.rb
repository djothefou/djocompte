require 'doorkeeper/grape/helpers'

module Djocompte
  class API < Grape::API
    version 'v1', path: "v1"
    format :json
    prefix :api

    helpers Doorkeeper::Grape::Helpers

    helpers do

      def current_user
        @current_user ||= (User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token)
      end

    end

    before do
      doorkeeper_authorize!
    end

    resource :users do
      desc 'Return a public timeline.'
      get :all do
        User.all
      end

      desc 'Return a personal timeline.'
      get :me do
        current_user
      end

    end
  end
end