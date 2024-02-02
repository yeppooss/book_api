require 'swagger_helper'
require 'devise/jwt/test_helpers'

RSpec.describe Devise::SessionsController, type: :request do
  let!(:user) { create(:user, email: "test@example.com", password: "password") }

  path '/users/sign_in' do
    post 'login' do
      tags 'Login'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :request_body, in: :body, schema: { type: :object, properties:
          {
            user:{ type: :object, properties: {
              email: {type: :string},
              password: {type: :string}
            }
          }
        }
      }

      response '201', 'success' do
        context "success login" do
          let(:request_body) do
            {
              user:{
                email: "test@example.com",
                password: "password"
              }
            }
          end

          run_test! do
          end
        end
      end

      response '401', 'success' do
        context "success login" do
          let(:request_body) do
            {
              user:{
                email: "test@example.com",
                password: "password123"
              }
            }
          end

          run_test! do
          end
        end
      end
    end
  end
end
