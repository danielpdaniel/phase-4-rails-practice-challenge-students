class InstructorsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_response_not_found 
    rescue_from ActiveRecord::RecordInvalid, with: :render_invalid_response


    def index
    instructors = Instructor.all
    render json: instructors, status: :ok
    end

    def show
    instructor = Instructor.find(params[:id])
    render json: instructor, status: :ok
    end

    def create
    instructor = Instructor.create!(permitted_params)
    render json: instructor, status: :created
    end

    def update
    instructor = Instructor.find(params[:id])
    instructor.update!(permitted_params)

    render json: instructor, status: :accepted
    end

    def destroy
    instructor = Instructor.find(params[:id])
    instructor.destroy
    render json: [], status: :no_content
    end

    private

    def render_response_not_found
        render json: { error: "Instructor not found" }, status: :not_found
    end

    def render_invalid_response(invalid)
        render json: { errors: [invalid.record.errors] }, status: :unprocessable_entity
    end

    def permitted_params
        params.permit(:name)
    end
end
