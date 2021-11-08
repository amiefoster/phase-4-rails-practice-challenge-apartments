class ApartmentsController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :apartment_invalid
    rescue_from ActiveRecord::RecordNotFound, with: :apartment_not_found

    def index
        apartments = Apartment.all
        render json: apartments
    end

    def show
        apartment = Apartment.find(params[:id])
        render json: apartment, status: :ok
    end

    def create
        apartment = Apartment.create!(apartment_params)
        render json: apartment, status: :created
    end

    def update
        apartment = Apartment.find(params[:id]).update!(apartment_params)
        render json: apartment, status: :ok
    end

    def destroy
        apartment = Apartment.find(params[:id])
        apartment.destroy
        head :no_content
    end

    private 

    def apartment_params
        params.permit(:number)
    end

    def apartment_invalid(e)
        render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
    end

    def apartment_not_found
        render json: { error: "Apartment not found" }, status: :not_found
    end
end
