class HomeController < ApplicationController
  def index; end

  def generate_json
    @json = ReplaceDrawFaceParams.process(upload_params)
    render json: @json, status: :ok
  end

  private

  def upload_params
    params.require(:upload).permit(:new_name, :new_face_index, :replace, :data)
  end
end