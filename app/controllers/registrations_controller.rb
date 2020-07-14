class RegistrationsController < Devise::RegistrationsController

  respond_to :json

  def create
    build_resource(registration_params)
    resource.save
    if resource.errors.empty?
      render json: resource
    else
      render json: resource.errors
    end
  end

  private

  def registration_params
    params.require(:user).permit(:name, :email, :password)
  end
end