class ShiftsController < ApplicationController
  before_action :set_shift, only: %i[ show edit update destroy ]

  def index
    @shifts = Shift.all
  end

  def show
  end

  def new
    @shift = Shift.new
  end

  def edit
  end

  def create
    @user = User.find_by(id: params[:shift][:user_id])
    @schedule = Schedule.find_by(id: params[:shift][:schedule_id])
    start_at = assemble_datetime_from_params(params["shift"], "start")
    end_at = assemble_datetime_from_params(params["shift"], "end")
    @shift = Shift.new(
      user: @user,
      schedule: @schedule,
      shift_start: start_at,
      shift_end: end_at,
    )

    respond_to do |format|
      if @shift.save
        format.html { redirect_to @shift, notice: "Shift was successfully created." }
        format.json { render :show, status: :created, location: @shift }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @shift.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @shift.update(shift_params)
        format.html { redirect_to @shift, notice: "Shift was successfully updated." }
        format.json { render :show, status: :ok, location: @shift }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @shift.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @shift.destroy
    respond_to do |format|
      format.html { redirect_to shifts_url, notice: "Shift was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def assemble_datetime_from_params(hash, key)
    DateTime.new(*((1..5).map { |e| hash["#{key}(#{e}i)"].to_i }))
  end

  private
    def set_shift
      @shift = Shift.find(params[:id])
    end

    def shift_params
      params.require(:shift).permit(:user_id, :schedule_id, :start, :end)
    end
end
