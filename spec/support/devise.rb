module DeviseMacros
  #include Devise::TestHelpers

  # gives us the login_as(@user) method when request object is not present
  include Warden::Test::Helpers
  Warden.test_mode!

  # Will run the given code as the user passed in
  def as_user(user=nil, &block)
    current_user = user || create(:user)
    if request.present?
      request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in(current_user)
    else
      login_as(current_user, :scope => :user)
    end
    block.call if block.present?
    return self
  end


  def as_visitor(user=nil, &block)
    current_user = user || build_stubbed(:user)
    if request.present?
      request.env["devise.mapping"] = Devise.mappings[:user]
      sign_out(current_user)
    else
      logout(:user)
    end
    block.call if block.present?
    return self
  end
end

RSpec.configure do |config|
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include Devise::Test::ControllerHelpers, type: :view
  config.include Devise::Test::IntegrationHelpers, type: :feature

  config.after(:each) { Warden.test_reset! }
end

