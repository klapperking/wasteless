class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  be
  include Pundit::Authorization

  # pundit whitelisting - TODO: Update on the go
  after_action :verify_authorized, except: :index, unless: :skip_pundit?
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

  # Rescue a non-authorized
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized if Rails.env.production?

  def user_not_authorized
    # when action not authorized: Display flash
    flash[:alert] = "You are not authorized to perform this action."
  end

  private

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end
end
