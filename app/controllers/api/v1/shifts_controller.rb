module Api
  module V1
    class ShiftsController < ApplicationController
      before_action :set_shift, only: %i[ show update destroy ]

      def index
        shifts = Shift.all
        render json: ShiftSerializer.new(shifts).serialized_json, status: :ok
      end

      def show
        if @shift
          render json: ShiftSerializer.new(@shift).serialized_json, status: :ok
        else
          render json: { error: @shift.errors }, status: :unprocessable_entity
        end
      end

      def create
        user = User.find_by(id: shift_params[:user_id])
        schedule = Schedule.find_by(id: shift_params[:schedule_id])
        shift = Shift.new(
          user: user,
          schedule: schedule,
          shift_start: shift_params[:shift_start],
          shift_end: shift_params[:shift_end],
        )

        if shift.save
          render json: { message: formatted_shift_block(shift) }, status: :created
        else
          render json: { error: shift.errors }, status: :unprocessable_entity
        end
      end

      def update
        if @shift.update(shift_params)
          render json: { message: formatted_shift_block(@shift, "updated") }, status: :ok
        else
          render json: { error: @shift.errors }, status: :unprocessable_entity
        end
      end

      def destroy
        shift_user_name = @shift.user.employee_name
        shift_schedule_name = @shift.schedule.schedule_name
        if @shift.destroy
          render json: { message: "Shift owned by #{shift_user_name} for schedule #{shift_schedule_name} successfully deleted" }, status: :ok
        else
          render json: { error: @shift.errors }, status: :unprocessable_entity
        end
      end

      private

      def set_shift
        @shift = Shift.find(params[:id])
      end

      def formatted_shift_block(shift, type = "created")
        "Shift for #{shift.user.employee_name} #{type}: #{shift.format_shift(shift.shift_start)} - #{shift.format_shift(shift.shift_end)}"
      end

      def shift_params
        params.require(:shift).permit(:user_id, :schedule_id, :shift_start, :shift_end)
      end
    end
  end
end
