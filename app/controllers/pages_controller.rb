class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    if user_signed_in? && current_user.director?
      @organization = current_user.organizations.first
    end
  end
end
