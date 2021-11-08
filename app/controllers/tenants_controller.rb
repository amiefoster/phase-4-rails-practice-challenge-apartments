class TenantsController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :tenant_invalid
    rescue_from ActiveRecord::RecordNotFound, with: :tenant_not_found

    def index
        tenants = Tenant.all
        render json: tenants
    end

    def show
        tenant = Tenant.find(params[:id])
        render json: tenant, status: :ok
    end

    def create
        tenant = Tenant.create!(tenant_params)
        render json: tenant, status: :created
    end

    def update
        tenant = Tenant.find(params[:id]).update!(tenant_params)
        render json: tenant, status: :ok
    end

    def destroy
        tenant = Tenant.find(params[:id])
        tenant.destroy
        head :no_content
    end

    private

    def tenant_params
        params.permit(:name, :age)
    end

    def tenant_invalid(e)
        render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
    end

    def tenant_not_found
        render json: { error: "Tenant not found" }, status: :not_found
    end

end
