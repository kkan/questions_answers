class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  rescue_from ActiveRecord::RecordNotFound do
    redirect_to root_url, flash: { error: "Record not found." }
  end
end
