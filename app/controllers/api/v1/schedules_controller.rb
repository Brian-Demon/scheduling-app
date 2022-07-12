module Api
  module V1
    class SchedulesController < ApplicationController
      before_action :set_schedule, only: %i[ show update destroy ]

      def index
        schedules = Schedule.all
        render json: ScheduleSerializer.new(schedules).serialized_json, status: :ok
      end

      def show
        if @schedule
          render json: ScheduleSerializer.new(@schedule).serialized_json, status: :ok
        else
          render json: { error: @schedule.errors }, status: :unprocessable_entity
        end
      end

      def create
        schedule = Schedule.new(schedule_params)

        if schedule.save
          render json: { message: "#{schedule.schedule_name} successfully created" }, status: :created
        else
          render json: { error: schedule.errors }, status: :unprocessable_entity
        end
      end

      def update
        if @schedule.update(schedule_params)
          render json: { message: "#{@schedule.schedule_name} successfully updated" }, status: :ok
        else
          render json: { error: @schedule.errors }, status: :unprocessable_entity
        end
      end

      def destroy
        schedule_name = @schedule.schedule_name if @schedule
        if @schedule.destroy
          render json: { message: "#{schedule_name} successfully deleted" }, status: :ok
        else
          render json: { error: @schedule.errors }, status: :unprocessable_entity
        end
      end

      private

        def set_schedule
          @schedule = Schedule.find(params[:id])
        end

        def schedule_params
          params.require(:schedule).permit(:first_day, :last_day)
        end
    end
  end
end
