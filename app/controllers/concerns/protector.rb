module Protector
  # For protected pages
  extend ActiveSupport::Concern
  included do
    before_filter :authenticate_user!
    authorize_resource :class => false
    check_authorization
  end
end
