class ReportsController < ApplicationController
  before_action :set_report, only: [:show, :edit, :update, :destroy]

  # GET /reports
  # GET /reports.json
  def index
    @reports = Report.all
  end

  # GET /reports/1
  # GET /reports/1.json
  def show
  end

  # GET /reports/new
  def new
    @report = Report.new
    @report.users = User.all
  end

  # GET /reports/1/edit
  def edit
  end

  # POST /reports
  # POST /reports.json
  def create
    @report = Report.new(report_params)

    respond_to do |format|
      if @report.save
        format.html { redirect_to @report, notice: 'Report was successfully created.' }
        format.json { render :show, status: :created, location: @report }
      else
        format.html { render :new }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reports/1
  # PATCH/PUT /reports/1.json
  def update
    respond_to do |format|
      if @report.update(report_params)
        format.html { redirect_to @report, notice: 'Report was successfully updated.' }
        format.json { render :show, status: :ok, location: @report }
      else
        format.html { render :edit }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reports/1
  # DELETE /reports/1.json
  def destroy
    @report.destroy
    respond_to do |format|
      format.html { redirect_to reports_url }
      format.json { head :no_content }
    end
  end
  
  def self.fetch_all_issues
    logger.info "reading config/fetch.yml"
    conf = YAML::load File.open("#{ROOT}/config/fetch.yml")

    new_last_fetch = Time.now

    fetcher = JiReport::JiraRSSFetch.new(:login => conf['login'],
                               :password => conf['password'],
                               :url => conf['url'],
                               :proxy => conf['proxy'])
    fetch_limit = conf[:fetch_limit] || DEFAULT_FETCH_LIMIT
    
    User.all.each do |user|
      logger.info "fetching issues for #{user.full_name}"
      issues = fetcher.fetch_changed_issues(user.jira_user, fetch_limit)
      if issues.size == 0
        logger.info "No issues fetched for #{user}, probably there is an auth problem"
        next
      end
      logger.info "tracking issues for #{user}"
      issues.each do |issue|
        issue[:user_id] = user.id
        ReportEntry.track(issue)
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_report
      @report = Report.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def report_params
      params.require(:report).permit(:generated_at)
    end
end
