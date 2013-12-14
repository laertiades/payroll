class ChecksController < ApplicationController
  def show
    @check = Check.find(params[:id])
    @worker = @check.worker
  end
end
