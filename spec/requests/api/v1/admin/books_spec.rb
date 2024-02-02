require 'rails_helper'

RSpec.describe "Api::V1::Admin::Books", type: :request do
  let(:admin) { create(:user, :admin, :with_book) }
  let(:user) { create(:user, :consumer, :with_book) }
  let(:user1) { create(:user, :consumer, :with_book) }

  path '/api/v1/admin/users/{user_id}/books' do
    get 'get consumer`s book`' do
      tags 'Admin'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :user_id, :in => :path, :type => :integer
      parameter name: 'Authorization', :in => :header, :type => :string

      response '200', 'success' do
        let('Authorization') { Devise::JWT::TestHelpers.auth_headers({}, admin)['Authorization'] }
        let(:user_id) { user.id }

        run_test! do
          expect(JSON.parse(response.body)).not_to match_array([])
        end
      end

      response '401', 'not allowed' do
        let('Authorization') { Devise::JWT::TestHelpers.auth_headers({}, user)['Authorization'] }
        let(:user_id) { user.id }

        run_test!
      end
    end

    post 'add book to consumer' do
      tags 'Admin'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :user_id, :in => :path, :type => :integer
      parameter name: 'Authorization', :in => :header, :type => :string

      parameter name: :request_body, in: :body, schema: { type: :object, properties:
        {
          title: {type: :string},
          description: {type: :string}
        }
      }

      response '201', 'success' do
        let('Authorization') { Devise::JWT::TestHelpers.auth_headers({}, admin)['Authorization'] }
        let(:user_id) { user.id }
        let(:request_body) do
          {
            title: "test123",
            description: "desc"
          }
        end


        run_test! do
          expect(JSON.parse(response.body)['title']).to eq('test123')
        end
      end

      response '401', 'not allowed' do
        let('Authorization') { Devise::JWT::TestHelpers.auth_headers({}, user)['Authorization'] }
        let(:user_id) { user.id }
        let(:request_body) do
          {
            title: "test123",
            description: "desc"
          }
        end

        run_test!
      end
    end
  end

  path '/api/v1/admin/users/{user_id}/books/{id}' do
    delete 'destroy consumer`s book`' do
      tags 'Admin'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :user_id, :in => :path, :type => :integer
      parameter name: :id, :in => :path, :type => :integer
      parameter name: 'Authorization', :in => :header, :type => :string

      response '204', 'success' do
        let('Authorization') { Devise::JWT::TestHelpers.auth_headers({}, admin)['Authorization'] }
        let(:user_id) { user1.id }
        let(:id) { user1.books.first.id }

        run_test! do
          expect(user1.books.size).to eq(0)
        end
      end

      response '401', 'not allowed' do
        let('Authorization') { Devise::JWT::TestHelpers.auth_headers({}, user)['Authorization'] }
        let(:user_id) { user1.id }
        let(:id) { user1.books.first.id }


        run_test!
      end
    end
  end
end
