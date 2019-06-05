module JsonRender extend ActiveSupport::Concern
  def render_ok(data={})
    if data.is_a?(Hash)&&data[:data].present?
      data[:status]=200
    else
      data={ status: 200,data: data }
    end
    render json: data
  end

  def render_err(error,params={})
    render json: { status: :error,code: error }
  end
end