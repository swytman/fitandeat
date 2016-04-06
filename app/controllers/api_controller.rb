class ApiController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  def update_order
    return(head :bad_request) unless params[:items]  || params[:class]
    respond_to do |format|
      format.json do
        params[:items].each_with_index do |id, index|
          params[:class].constantize.find(id.to_i).update(order: index+1)
        end
        render json: params[:items]
      end
    end
  end
end
