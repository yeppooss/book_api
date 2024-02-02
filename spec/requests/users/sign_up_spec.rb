require 'swagger_helper'
require 'devise/jwt/test_helpers'

RSpec.describe Devise::RegistrationsController, type: :request do
  path '/users' do
    post 'register' do
      tags 'Register'
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
            expect(User.find_by(email: "test@example.com")).not_to be_nil
          end
        end
      end

      response '422', 'success' do
        context "success login" do
          let(:request_body) do
            {
              user:{
                email: "test@example.com",
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
