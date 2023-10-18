class ArticlesController < ApplicationController
  def new
    @organization = Organization.find(params[:organization_id])
    @event = @organization.events.find(params[:event_id])
    @article = @event.articles.build
    authorize @article, :new?
end

def create
    @organization = Organization.find(params[:organization_id])
    @event = @organization.events.find(params[:event_id])
    @article = @event.articles.build(article_params)

    if @article.save
      flash[:notice] = "Article créé avec succès."
      redirect_to organization_event_path(@organization, @event)
    else
      flash[:alert] = "Erreur lors de la création de l'article."
      render 'new'
    end
    authorize @article, :create?
end

private

def article_params
params.require(:article).permit(:title, :content)
end
end
