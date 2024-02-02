class ApplicationController < ActionController::API
  include ActionController::MimeResponds
  include RackSessionsFix
  respond_to :json

  before_action :authenticate_user!
end
