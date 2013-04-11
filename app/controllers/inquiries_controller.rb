class InquiriesController < ApplicationController
  skip_before_filter :authenticate_user!

  def new
    @inquiry = Inquiry.new
  end
  
  def create
    @inquiry = Inquiry.new(params[:inquiry])
    @inquiry.request = request
  
    if @inquiry.valid?
      @inquiry.deliver
      redirect_to(new_inquiry_path, :notice => "Thanks for reaching out. We'll get back to you shortly.")
    else
      flash.now.alert = "There was a problem with the information you submitted."
      render :new
    end
  end
  
end
