class LeasesController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :lease_invalid

    def create
        lease = Lease.create!(lease_params)
        render json: lease, status: :ok
    end

    def destroy
        lease = Lease.find(params[:id])
        lease.destroy
        head :no_content
    end

    private

    def lease_params
        params.permit(:rent, :apartment_id, :tenant_id)
    end

    def lease_invalid(e)
        render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
    end
end
