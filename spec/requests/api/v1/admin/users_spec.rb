require 'rails_helper'

RSpec.describe "Api::V1::Admin::Users", type: :request do
  let(:admin) { create(:user, :admin, :with_book) }
  let(:user) { create(:user, :consumer, :with_book) }

  path '/api/v1/admin/users/{user_id}' do
    get 'get consumer info' do
      tags 'Consumer'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :user_id, :in => :path, :type => :integer
      parameter name: 'Authorization', :in => :header, :type => :string

      response '200', 'success' do
        let('Authorization') { Devise::JWT::TestHelpers.auth_headers({}, admin)['Authorization'] }
        let(:user_id) { user.id }

        run_test! do
          expect(JSON.parse(response.body)['email']).to eq(user.email)
        end
      end

      response '401', 'not allowed' do
        let('Authorization') { Devise::JWT::TestHelpers.auth_headers({}, user)['Authorization'] }
        let(:user_id) { user.id }
        let(:id) { user1.books.first.id }


        run_test!
      end
    end
  end
end
