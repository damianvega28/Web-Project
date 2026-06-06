class PagesController < ApplicationController
  skip_after_action :verify_pundit_authorization, only: [:home]

  def home
  end
end