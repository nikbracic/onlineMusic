class ProfileController < ApplicationController
  def index
    if user_signed_in?
      @assets = current_user.assets.order("uploaded_file_file_name desc")
    end
  end
end