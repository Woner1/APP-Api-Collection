module ExceptionHandler
    extend ActiveSupport::Concern
  
    included do
      rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
      rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
      rescue_from AuthenticationFailed,
                  Unauthorized,
                  TokenExpired,
                  VerificationFailed,
                  with: :render_error_response
    end
  
    private
  
    def render_unprocessable_entity_response(exception)
      render json: {
          message: "Validation failed",
          errors: ValidationErrorsSerializer.new(exception.record).serialize
      }, status: :unprocessable_entity
    end
  
    def render_not_found_response
      render json: { message: "Not found", code: "not_found" }, status: :not_found
    end
  
    def render_error_response(exception)
      render json: { message: exception.message, code: exception.code }, status: exception.http_status
    end
  
  end
  