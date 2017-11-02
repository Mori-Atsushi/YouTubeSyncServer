class Api::V1::RoomsController < ApplicationController
  include ApiCommon

  def create
    @room = Room.new room_params

    unless @room.save!
      # TODO: localeファイルに書いておくやつな気がする
      render json: { error: t("room_create_error") }, status: :unprocessable_entity
    end
  end

  def show
    @room = Room.find(params[:id])
  end

  private

    def room_params
      params.require(:room).permit(:name, :description)
    end
end
