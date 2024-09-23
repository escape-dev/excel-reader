class ReaderController < ApplicationController

  def index 
    @reader = Reader.new(params[:file])

    if @reader.valid? 
      render json: { message: "OK", data: @reader.read }, status: :ok
    else
      render json: { message: "ERROR", data: @reader.errors.full_messages}
    end
  end

end
