class ContactFormsController < ApplicationController
  def new
    @contact_form = ContactForm.new
    authorize @contact_form
  end

  def create
    @contact_form = ContactForm.new(contact_form_params)
    if @contact_form.valid?
      ActiveStorage::Current.url_options = Rails.application.config.active_storage.service
      ContactFormMailer.contact_email(@contact_form).deliver_now
      @contact_form.recto_id.attach(params[:contact_form][:recto_id])
      @contact_form.verso_id.attach(params[:contact_form][:verso_id])
      @contact_form.receipt.attach(params[:contact_form][:receipt])
      flash[:success] = "Votre message a été envoyé avec succès."
      redirect_to root_path
    else
      render :new
    end
    authorize @contact_form
  end

  private

  def contact_form_params
    params.require(:contact_form).permit(:first_name, :last_name, :email, :message, :recto_id, :verso_id, :receipt, :rna_number)
  end
end
