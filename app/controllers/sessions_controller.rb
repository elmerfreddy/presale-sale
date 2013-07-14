class SessionsController < Devise::SessionsController
  respond_to :json, :html

  def destroy
    current_user.authentication_token = nil
    super
  end

  protected

  def verified_request?
    request.content_type == "application/json" || super
  end
end
