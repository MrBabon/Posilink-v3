class OrganizationsController < ApplicationController
  
  def index
    if params[:query].present?
        @organizations = Organization.search_by_organization(params[:query])
    else
        @organizations = Organization.all
    end
    params[:query] = ""
    if user_signed_in? && current_user.director?
      @organization = current_user.organizations.first
    end
    @filtered_organizations = policy_scope(Organization)
end

def show
    @organization = Organization.find(params[:id])
    @events = @organization.events
    @markers = @events.geocoded.map do |event|
      {
        lat: event.latitude,
        lng: event.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: {event: event})
      }
    end
    authorize @organization
end

def edit
  @organization = Organization.find(params[:id])
  @events = @organization.events

  @new_event = @organization.events.build
  authorize @organization
end

def update
  @organization = Organization.find(params[:id])
  authorize @organization, :update?

  if @organization.update(organization_params)
    redirect_to @organization, notice: "L'association a été mise à jour avec succès."
  else
    render :edit
  end
end

######### POUR GESTION DES EVENTS ##########

def create_event
  @organization = Organization.find(params[:id])
  @event = @organization.events.build(event_params)
  authorize @event, :create?
  if @event.save
    redirect_to @organization, notice: "Événement créé avec succès."
  else
    render :edit
  end
end

def update_event
  @organization = Organization.find(params[:id])
  @event = Event.find(params[:event_id])

  authorize @event, :update?

  if @event.update(event_params)
    redirect_to @organization, notice: "Événement mis à jour avec succès."
  else
    render :edit
  end
end

####################################################

private

def event_params
  params.require(:event).permit(:title, :description, :address, :start_time, :end_time, :picture)
end

def organization_params
  params.require(:organization).permit(:name, :address, :phone, :description, :avatar)
end
end
