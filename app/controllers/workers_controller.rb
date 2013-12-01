class WorkersController < ApplicationController
  http_basic_authenticate_with name: ENV['USERNAME'], password: ENV['PASSWORD']
  def new
    @worker = Worker.new
  end
  def create
    @worker = Worker.new(worker_params)
    if @worker.save
      flash[:success] = @worker.fname + " " + @worker.lname + " has been added to roster"
      redirect_to root_path
    else
      render 'new'
    end
  end

  private

    def worker_params
      params.require(:worker).permit(:fname, :mname, :lname, :address, :city,
                                     :state, :zipcode, :withhold, :married, :hourrate)
    end


end
