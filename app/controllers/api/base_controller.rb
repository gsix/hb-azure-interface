class Api::BaseController < ActionController::API
  def home
    render json: {
      app_name: 'hb_azure_interface'
    }
  end
end
