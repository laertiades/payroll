class WorkersController < ApplicationController
  http_basic_authenticate_with name: ENV['USERNAME'], password: ENV['PASSWORD']
  
  def update
    @worker = Worker.find(params[:id])
      if @worker.update_attributes(params[:modus] => params[:value])
          render 'show', layout: false
      else
        render json: "Holder", status: 400
      end
  end

  def show
    @worker = Worker.find(params[:id])
  end
  
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

  def createCheck
    puts params[:worker_id]
    @worker = Worker.find(params[:worker_id])
    @check = @worker.checks.build(check_params)
    @check.hours = params[:hours]
    @check.rate = @worker.hourrate
    if @check.save
      render 'show', layout: false
    else
      render json: "Holder", status: 400
    end
  end

  private

    def check_params
      params.fetch(:check, {}).permit(:hours)
    end

    def worker_params
      params.require(:worker).permit(:fname, :mname, :lname, :address, :city,
                                     :state, :zipcode, :withhold, :married, :hourrate)
    end


end
