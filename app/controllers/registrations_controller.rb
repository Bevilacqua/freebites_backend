class RegistrationsController < Devise::RegistrationsController
  respond_to :json

  def create
    build_resource(params.permit(:email, :password, :name, :account_type))

    if(resource.save)
      sign_up(:user, resource)
      render json: { status: 201, user: resource }, status: :created
    else
      render json: { status: 400, errors: validation_error(resource)}, status: :bad_request
    end
  end
end
