class ApplicationController < ActionController::API
  include ActionController::MimeResponds
  include RackSessionsFix

  rescue_from CanCan::AccessDenied do |exception|
    if request.xhr?
      if signed_in?
        render json: {:status => :error, :message => "You don't have permission to #{exception.action} #{exception.subject.class.to_s.pluralize}"}, :status => 403
      else
        render json: {:status => :error, :message => "You must be logged in to do that!"}, :status => 401
      end
    else
      render :file => "public/401.html", :status => :unauthorized
    end
  end

  respond_to :json

  before_action :authenticate_user!
end
