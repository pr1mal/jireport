class ReportEntriesController < ApplicationController
  before_action :set_report_entry, only: [:show, :edit, :update, :destroy]

  # GET /report_entries
  # GET /report_entries.json
  def index
    @report_entries = ReportEntry.all
  end

  # GET /report_entries/1
  # GET /report_entries/1.json
  def show
  end

  # GET /report_entries/new
  def new
    @report_entry = ReportEntry.new
  end

  # GET /report_entries/1/edit
  def edit
  end

  # POST /report_entries
  # POST /report_entries.json
  def create
    @report_entry = ReportEntry.new(report_entry_params)

    respond_to do |format|
      if @report_entry.save
        format.html { redirect_to @report_entry, notice: 'Report entry was successfully created.' }
        format.json { render :show, status: :created, location: @report_entry }
      else
        format.html { render :new }
        format.json { render json: @report_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /report_entries/1
  # PATCH/PUT /report_entries/1.json
  def update
    respond_to do |format|
      if @report_entry.update(report_entry_params)
        format.html { redirect_to @report_entry, notice: 'Report entry was successfully updated.' }
        format.json { render :show, status: :ok, location: @report_entry }
      else
        format.html { render :edit }
        format.json { render json: @report_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /report_entries/1
  # DELETE /report_entries/1.json
  def destroy
    @report_entry.destroy
    respond_to do |format|
      format.html { redirect_to report_entries_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_report_entry
      @report_entry = ReportEntry.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def report_entry_params
      params.require(:report_entry).permit(:user_id, :report_id, :project, :task_id, :task_desc, :msproject_task_completion_date, :started_at, :ended_at, :percentage, :eta, :status, :issues, :risk_mitigation_plans)
    end
end
