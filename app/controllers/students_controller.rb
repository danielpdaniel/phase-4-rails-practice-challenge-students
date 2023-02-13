class StudentsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_record_not_found
rescue_from ActiveRecord::RecordInvalid, with: :render_record_invalid

    def index
        students = Student.all
        render json: students
    end

    def show
        student = Student.find(params[:id])
        render json: student, status: :ok
    end

    def create
        student = Student.create!(permitted_params)
        render json: student, status: :created
    end

    def update
        student = Student.find(params[:id])
        student.update!(permitted_params)
        render json: student, status: :accepted
    end

    def destroy
        student = Student.find(params[:id])
        student.destroy!
        render json: [], status: :no_content
    end

    private

    def render_record_not_found
        render json: {error: "Student not found"}, status: :not_found
    end

    def render_record_invalid(invalid)
        render json: { errors: [invalid.record.errors] }, status: :unprocessable_entity
    end

    def permitted_params
        params.permit(:name, :major, :age, :instructor_id)
    end
end
