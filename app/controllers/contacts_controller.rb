class ContactsController < ApplicationController
  def new
    @contact = Contact.new
    unless current_user.nil?
      @contact.name = current_user.name
      @contact.email = current_user.email
    end
  end

  def create
    @contact = Contact.new(params[:contact])
    @contact.request = request
    if @contact.deliver
      flash.now[:success] = 'Správa úspešne odoslaná!'
    else
      flash.now[:error] = 'Správu sa nepodarilo odoslať'
    end
    render :new
  end
end