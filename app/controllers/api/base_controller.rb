class Api::BaseController < ActionController::API
  before_action :check_access_token

  def home
    render json: { app: 'hb-azure interface' }
  end

  private

  def check_access_token
    render json: { error: 'token is invalid or not present' }, status: :unauthorized and return if User.where(access_token: params[:token]).none?
  end
end
