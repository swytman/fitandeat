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

  def clone_program_day
    return(head :bad_request) unless params[:id]
    program_day = ProgramDay.find_by(id: params[:id])
    return (head :not_found) unless program_day

    render json: program_day.clone_day
    
  end


end
