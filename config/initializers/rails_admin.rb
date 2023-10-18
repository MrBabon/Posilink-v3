RailsAdmin.config do |config|
  config.asset_source = :sprockets

  ### Popular gems integration

  ## == Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method(&:current_user)

  config.authorize_with do
    unless current_user.admin?
      flash[:alert] = "Désolé, pas d'accès administrateur pour vous."
      redirect_to main_app.root_path
    end
  end
  ###################################

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == Rails_admin == 
  config.model 'Organization' do
    edit do
      field :name do
        label "Nom de l'association"
      end
      field :category do
        label "Catégorie"
        formatted_value do
          bindings[:object].category_form_value
        end
      end
      field :email
      field :address do
        label "Adresse de l'association"
      end
      field :phone do
        label "Téléphone"
      end
      field :description
      field :avatar, :active_storage
    end
  end

  config.model 'Event' do
    edit do
      field :title do
        label "Titre"
      end
      field :organization do
        label "Association"
      end
      field :address do
        label "Adresse de l'évènement"
      end
      field :description
      field :start_time do
        label "Début de l'évènement"
      end
      field :end_time do
        label "Fin de l'évènement"
      end
      field :picture, :active_storage
    end
  end
  ####################################
  
  ## == CancanCan ==
  # config.authorize_with :cancancan

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/railsadminteam/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar = true

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end
