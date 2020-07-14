class NoticesController < ApplicationController
  before_action :set_notice, only: :show

  def index
    @notices = if params[:category]
                 Notice.all.with_attached_image.where(category_id: params[:category])
               else
                 Notice.all.with_attached_image
               end
  end

  def show; end

  def create
    @notice = Notice.new(notice_params)

    if @notice.save
      render json: @notice, status: :created, location: @notice
    else
      render json: @notice.errors, status: :unprocessable_entity
    end
  end

  private

  def set_notice
    @notice = Notice.find(params[:id])
  end

  def notice_params
    params.require(:notice).permit(:title, :text, :category_id, :user_id, :image)
  end
end
