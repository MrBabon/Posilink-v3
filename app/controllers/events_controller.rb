class EventsController < ApplicationController
  before_action :set_event, only: [:destroy, :show]


  def index
      @events = Event.all
      @markers = @events.geocoded.map do |event|
          map_view(event)
      end
  end
  
  def show
      @participation = Participation.participation_for(current_user, @event)
      @marker = map_view(@event)
      authorize @event
  end

  def new
      @event = Event.new
  end

  def edit
      @organization = Organization.find(params[:organization_id])
      @event = @organization.events.find(params[:id])
      authorize @event, :edit?
  end

  def update
      @organization = Organization.find(params[:organization_id])
      @event = @organization.events.find(params[:id])
      if @event.update(event_params)
          redirect_to edit_organization_path(@organization)
          flash[:notice] = "Événement mis à jour avec succès."
      else
          flash[:notice] = "Erreur"
          render :edit
      end
      authorize @event, :update?
  end

  def destroy
      @organization = Organization.find(params[:organization_id])
      @event.destroy
      redirect_to edit_organization_path(@organization)
      flash[:notice] = "Événement supprimé avec succès."
      authorize @event, :destroy?
  end
  
  private

  def set_event
      @event = Event.find(params[:id])
  end

  def event_params
      params.require(:event).permit(:title, :description, :address, :start_time, :end_time, :picture)
    end
  
  def map_view(event)
      {
      lat: event.latitude,
      lng: event.longitude,
      info_window_html: render_to_string(partial: "info_window", locals: {event: event})
      }
  end
end
