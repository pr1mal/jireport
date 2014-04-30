class ReportsUsersController < ApplicationController
  before_action :set_reports_user, only: [:show, :edit, :update, :destroy]

  # GET /reports_users
  # GET /reports_users.json
  def index
    @reports_users = ReportsUser.all
  end

  # GET /reports_users/1
  # GET /reports_users/1.json
  def show
  end

  # GET /reports_users/new
  def new
    @reports_user = ReportsUser.new
  end

  # GET /reports_users/1/edit
  def edit
  end

  # POST /reports_users
  # POST /reports_users.json
  def create
    @reports_user = ReportsUser.new(reports_user_params)

    respond_to do |format|
      if @reports_user.save
        format.html { redirect_to @reports_user, notice: 'Reports user was successfully created.' }
        format.json { render :show, status: :created, location: @reports_user }
      else
        format.html { render :new }
        format.json { render json: @reports_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reports_users/1
  # PATCH/PUT /reports_users/1.json
  def update
    respond_to do |format|
      if @reports_user.update(reports_user_params)
        format.html { redirect_to @reports_user, notice: 'Reports user was successfully updated.' }
        format.json { render :show, status: :ok, location: @reports_user }
      else
        format.html { render :edit }
        format.json { render json: @reports_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reports_users/1
  # DELETE /reports_users/1.json
  def destroy
    @reports_user.destroy
    respond_to do |format|
      format.html { redirect_to reports_users_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reports_user
      @reports_user = ReportsUser.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reports_user_params
      params.require(:reports_user).permit(:report_id, :user_id, :vac, :on_track, :delay_details, :recovery_plan, :comments, :user_report_ready)
    end
end
