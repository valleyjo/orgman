class Attendance::FinesController < ApplicationController
  before_action :authenticate_user!, except: [:update_fines]
  before_action -> { user_has_position(User::SECRETARY) },
                only: [:outstanding_fines, :update]

  def index
    @fines = current_user.fines.decorate
  end

  def outstanding_fines
    @fines = Fine.unpaid.decorate
  end

  def update
    fine = Fine.find(params[:id])
    paid = params[:paid] == 'true' ? true : false
    fine.update(paid: paid)
    redirect_to outstanding_fines_path
  end

  def update_fines
    created = false
    unfined = Attendance.find_unfined
    unfined.each { |a| created = Fine.create(attendance: a) }
    if created
      head :created
    else
      head :ok
    end
  end

  private

  def fine_params
    params.require(:excuse).permit(:fine_id, :user_id, :paid, :reason)
  end
end
