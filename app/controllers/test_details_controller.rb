class TestDetailsController < ApplicationController
  # GET /test_details
  # GET /test_details.json
  def index
    @test_details = TestDetail.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @test_details }
    end
  end

  # GET /test_details/1
  # GET /test_details/1.json
  def show
    @test_detail = TestDetail.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @test_detail }
    end
  end

  # GET /test_details/new
  # GET /test_details/new.json
  def new
    @test_detail = TestDetail.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @test_detail }
    end
  end

  # GET /test_details/1/edit
  def edit
    @test_detail = TestDetail.find(params[:id])
  end

  # POST /test_details
  # POST /test_details.json
  def create
    render json: params
    return

    @test_detail = TestDetail.new(params[:test_detail])

    respond_to do |format|
      if @test_detail.save
        format.html { redirect_to @test_detail, notice: 'Test detail was successfully created.' }
        format.json { render json: @test_detail, status: :created, location: @test_detail }
      else
        format.html { render action: "new" }
        format.json { render json: @test_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /test_details/1
  # PUT /test_details/1.json
  def update
    @test_detail = TestDetail.find(params[:id])

    respond_to do |format|
      if @test_detail.update_attributes(params[:test_detail])
        format.html { redirect_to @test_detail, notice: 'Test detail was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @test_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /test_details/1
  # DELETE /test_details/1.json
  def destroy
    @test_detail = TestDetail.find(params[:id])
    @test_detail.destroy

    respond_to do |format|
      format.html { redirect_to test_details_url }
      format.json { head :no_content }
    end
  end

  # Used for checking the test being submitted by user.
  def test_submit
    received_params = params
    received_params.delete(:authenticity_token)
    received_params.delete(:controller)
    received_params.delete(:action)

    time = received_params['time_taken'].split(':')
    time_taken = '' + (2 - time[0].to_i).to_s + ':' + (30 - time[1].to_i).to_s + ':' + (60 - time[2].to_i).to_s

    received_params.delete(:time_taken)

    final_score = 0

    @test = TestResult.create(user_id: current_user.id, test_time: time_taken)

    received_params.each do |param|
      @question = Question.find (param[0])
      #puts '====>> ' + (param[1].nil? || param[1] === '').to_s
      if (param[1].nil? || param[1] === '' || param[1] === 'None')
        ans='Not Attempted'
        @test.test_details.create(question_id: @question.id, answer: ans, user_id: current_user.id, question_type: @question.type, score: 0)
      else
        ans = param[1]
        final_ans = ''
        score = 0
        if (@question.type === 'FillInTheBlank' || @question.type === 'Rearrange')
          ans = ans.strip
          @option = Option.where(question_id: param[0])
          @option.each do |option|
            (option.key.casecmp(ans) == 0) ? score = @question.options.first.val : score = 0
          end
          final_score += score
          @test.test_details.create(question_id: @question.id, answer: ans, user_id: current_user.id, question_type: @question.type, score: score)
        elsif (@question.type === 'TrueFalse' || @question.type === 'Mcq1')
          score = ans.split('_')[1].to_i
          final_score += score
          puts '======>>' + @question.type
          @test.test_details.create(question_id: @question.id, answer: ans.split('_')[0], user_id: current_user.id, question_type: @question.type, score: score)
        elsif (@question.type === 'Mcq2' || @question.type === 'Mcq3')
          if param[1].size < 2
            final_ans = 'Not Attempted'
            score = 0
          else
            ans.each do |answer|
              if (answer != 'None')
                @option = Option.find(answer.to_i)
                final_ans += @option.key + '||'
                score += @option.val
              end
            end
          end
          final_score += score
          @test.test_details.create(question_id: @question.id, answer: final_ans, user_id: current_user.id, question_type: @question.type, score: score)
        else
          @test.test_details.create(question_id: @question.id, answer: ans, user_id: current_user.id, question_type: @question.type)
        end
      end
    end

    @test.update_attribute(:obj_score, final_score)

    @questionwise_score = TestDetail.group(:question_type, :test_result_id).having(test_result_id: @test.id).sum(:score)

    @questionwise_score.each do |qscore|
      case qscore[0][0]
        when 'FillInTheBlank'
          @fill_score = qscore[1].to_i
        when 'TrueFalse'
          @tf_score = qscore[1].to_i
        when 'Mcq1'
          @mcq1_score = qscore[1].to_i
        when 'Mcq2'
          @mcq2_score = qscore[1].to_i
        when 'Mcq3'
          @mcq3_score = qscore[1].to_i
        when 'Rearrange'
          @rearrange_score = qscore[1].to_i
      end
    end
    ProgressReportUser.create(user_id: current_user.id, test_result_id: @test.id, fill: 'FillInTheBlank', fill_score: @fill_score, tf: 'TrueFalse', tf_score: @tf_score, mcq1: 'Mcq1', mcq1_score: @mcq1_score, mcq2: 'Mcq2', mcq2_score: @mcq2_score, mcq3: 'Mcq3', mcq3_score: @mcq3_score, rearrange: 'Rearrange', rearrange_score: @rearrange_score)
    render action: "submit"
  end

  def submit
  end

  def show_details
    test_id = params[:test_id]
    @test_details = TestDetail.find_all_by_test_result_id(test_id)
    @question_ids = @test_details.map { |td| td.question_id }
    @fill_in_the_blank = Question.where(['id IN (?) AND type = (?)', @question_ids, 'FillInTheBlank'])
    @true_false = Question.where(['id IN (?) AND type = (?)', @question_ids, 'TrueFalse'])
    @mcq1 = Question.where(['id IN (?) AND type = (?)', @question_ids, 'Mcq1'])
    @mcq2 = Question.where(['id IN (?) AND type = (?)', @question_ids, 'Mcq2'])
    @mcq3 = Question.where(['id IN (?) AND type = (?)', @question_ids, 'Mcq3'])
    @rearrange = Question.where(['id IN (?) AND type = (?)', @question_ids, 'Rearrange'])
    @short_note_1 = Question.where(['id IN (?) AND type = (?) AND weightage = (?)', @question_ids, 'ShortNote', 4])
    @short_note_2 = Question.where(['id IN (?) AND type = (?) AND weightage = (?)', @question_ids, 'ShortNote', 2])
    @html_code = Question.where(['id IN (?) AND type = (?)', @question_ids, 'CodingOutput'])

    @questionwise_score = TestDetail.group(:question_type, :test_result_id).having(test_result_id: test_id).sum(:score)

    @questionwise_score.each do |qscore|
      case qscore[0][0]
        when 'FillInTheBlank'
          @fill_score = qscore[1].to_i
        when 'TrueFalse'
          @tf_score = qscore[1].to_i
        when 'Mcq1'
          @mcq1_score = qscore[1].to_i
        when 'Mcq2'
          @mcq2_score = qscore[1].to_i
        when 'Mcq3'
          @mcq3_score = qscore[1].to_i
        when 'Rearrange'
          @rearrange_score = qscore[1].to_i
      end
    end

  end

end
