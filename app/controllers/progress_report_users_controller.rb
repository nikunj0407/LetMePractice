class ProgressReportUsersController < ApplicationController
  # GET /progress_report_users
  # GET /progress_report_users.json
  def index
    @progress_report_users = ProgressReportUser.where(user_id: current_user.id).order('test_result_id desc limit 3')
    @test_count = TestResult.find_all_by_user_id(current_user.id).size
    #@test_time = []
    #@progress_report_users.each do |rep|
    #  @test_time.push(TestResult.find(rep.test_result_id).test_time)
    #end

    #render json: @test_time
    #return
    key_array = ['fill_score', 'tf_score', 'mcq1_score', 'mcq2_score', 'mcq3_score', 'rearrange_score']
    @final_hash = []
    @progress_report_users.each do |report|
      key_array.each do |key|
        score = (report[key].nil?)? 0 : report[key]
        @final_hash.push(score)
      end
    end
  end

  # GET /progress_report_users/1
  # GET /progress_report_users/1.json
  def show
    @progress_report_user = ProgressReportUser.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @progress_report_user }
    end
  end

  # GET /progress_report_users/new
  # GET /progress_report_users/new.json
  def new
    @progress_report_user = ProgressReportUser.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @progress_report_user }
    end
  end

  # GET /progress_report_users/1/edit
  def edit
    @progress_report_user = ProgressReportUser.find(params[:id])
  end

  # POST /progress_report_users
  # POST /progress_report_users.json
  def create
    @progress_report_user = ProgressReportUser.new(params[:progress_report_user])

    respond_to do |format|
      if @progress_report_user.save
        format.html { redirect_to @progress_report_user, notice: 'Progress report user was successfully created.' }
        format.json { render json: @progress_report_user, status: :created, location: @progress_report_user }
      else
        format.html { render action: "new" }
        format.json { render json: @progress_report_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /progress_report_users/1
  # PUT /progress_report_users/1.json
  def update
    @progress_report_user = ProgressReportUser.find(params[:id])

    respond_to do |format|
      if @progress_report_user.update_attributes(params[:progress_report_user])
        format.html { redirect_to @progress_report_user, notice: 'Progress report user was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @progress_report_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /progress_report_users/1
  # DELETE /progress_report_users/1.json
  def destroy
    @progress_report_user = ProgressReportUser.find(params[:id])
    @progress_report_user.destroy

    respond_to do |format|
      format.html { redirect_to progress_report_users_url }
      format.json { head :no_content }
    end
  end
end
