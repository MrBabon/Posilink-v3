class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :user, only: [:show, :edit, :update, :update_avatar, :my_events]

  def show
    authorize @user
    @participations = Participation.where(user_id: @user.id).includes(:event)
    @participations_by_date = @participations.group_by { |p| p.event.start_time.to_date }
    # @followed_organizations = @user.following
  end

  def edit
    authorize @user
  end

  def update
      if @user.update(user_params)
      redirect_to user_path, notice: 'Profil mis à jour avec succès.'
      else
      render :edit
      end
      authorize @user
  end

  def update_avatar
      if @user.update(user_avatar_params)
      redirect_to user_path, notice: 'Photo de profil mise à jour avec succès.'
      else
      render :show
      end
  end

  def my_events
    authorize @user
    @participating_events = @user.events
  end

  private

  def user
    @user = current_user
  end

  def user_avatar_params
    params.require(:user).permit(:avatar)
  end
  
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :current_password, :avatar, :nickname)
  end
end
