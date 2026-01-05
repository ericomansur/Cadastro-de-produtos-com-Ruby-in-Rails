module ApiErrorHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound do
      render json: { error: "Registro não encontrado" }, status: :not_found
    end
  end
end