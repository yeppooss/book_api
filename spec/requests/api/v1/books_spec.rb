require 'swagger_helper'
require 'devise/jwt/test_helpers'

RSpec.describe "Api::V1::Books", type: :request do
  let!(:user) { create(:user, :admin, :with_book) }
  let!(:user1) { create(:user, :consumer, :with_book) }

  path '/api/v1/books' do
    get 'books' do
      tags 'Books'
      produces 'application/json'

      parameter name: 'Authorization', :in => :header, :type => :string

      response '200', 'success' do
        let('Authorization') { Devise::JWT::TestHelpers.auth_headers({}, user1)['Authorization'] }

        run_test! do
          p JSON.parse(response.body).size
        end
      end
    end
  end
end
