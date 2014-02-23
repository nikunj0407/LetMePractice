class WelcomeController < ApplicationController
  before_filter :authenticate_user!, except: [:contact_us, :pricing]

  def index
    @user = current_user
    @test_count = @user.max_tests.to_i - TestResult.find_all_by_user_id(@user.id).size
  end

  def test
    @test_count = current_user.max_tests.to_i - TestResult.find_all_by_user_id(current_user.id).size

    if @test_count < 0
      redirect_to index
    elsif current_user.has_paid
      @test_given = TestResult.find_all_by_user_id(current_user.id).size

      @previous_question_set = TestDetail.where(user_id: current_user.id).select(:question_id)

      previous_question_set = @previous_question_set.map { |i| i.question_id }.to_s.gsub('[', '').gsub(']', '').gsub('\'', '').split(',')

      #render text: previous_question_set
      #return

      if !@previous_question_set.blank?
        #@fill_in_the_blank_chapter = Question.find_by_sql("select * from (SELECT *, row_number() over (partition by chapter_id order by random()) FROM questions LEFT OUTER JOIN test_details on test_details.question_id != questions.id where questions.type = 'FillInTheBlank') a where row_number=1;")
        @fill_in_the_blank = Question.find_by_sql("select * from (SELECT *, row_number() over (partition by chapter_id order by random()) FROM questions where questions.type = 'FillInTheBlank' AND questions.id NOT IN (" + @previous_question_set.map { |i| i.question_id }.to_s.gsub('[', '').gsub(']', '') + ")) a where row_number=1;").sample(6)
        @fill_in_the_blank_next = Question.where(type: 'FillInTheBlank').where(['id NOT IN (?)', @fill_in_the_blank.map { |q| q.id }]).where(['id NOT IN (?)', previous_question_set.map{|i| i.to_i}]).order('RANDOM()').limit(4).sample(4)

        @true_false = Question.find_by_sql("select * from (SELECT *, row_number() over (partition by chapter_id order by random()) FROM questions where questions.type = 'TrueFalse' AND questions.id NOT IN (" + @previous_question_set.map { |i| i.question_id }.to_s.gsub('[', '').gsub(']', '') + ")) a where row_number=1;").sample(6)
        @true_false_next = Question.where(type: 'TrueFalse').where(['id NOT IN (?)', @true_false.map { |q| q.id }]).where(['id NOT IN (?)', previous_question_set.map{|i| i.to_i}]).order('RANDOM()').limit(4).sample(4)

        @mcq1 = Question.find_by_sql("select * from (SELECT *, row_number() over (partition by chapter_id order by random()) FROM questions where questions.type = 'Mcq1' AND questions.id NOT IN (" + @previous_question_set.map { |i| i.question_id }.to_s.gsub('[', '').gsub(']', '') + ")) a where row_number between 1 AND 2;").sample(12)
        @mcq1_next = Question.where(type: 'Mcq1').where(['id NOT IN (?)', @mcq1.map { |q| q.id }]).where(['id NOT IN (?)', previous_question_set.map{|i| i.to_i}]).order('RANDOM()').limit(8).sample(8)

        @mcq2 = Question.where(type: 'Mcq2').where(['id NOT IN (?)', @previous_question_set.map { |i| i.question_id }]).order('RANDOM()').limit(5)

        @mcq3 = Question.where(type: 'Mcq3').where(['id NOT IN (?)', @previous_question_set.map { |i| i.question_id }]).order('RANDOM()').limit(2)

        @rearrange = Question.where(type: 'Rearrange').where(['id NOT IN (?)', @previous_question_set.map { |i| i.question_id }]).order('RANDOM()').limit(2)

        @short_note_1 = Question.where(type: 'ShortNote', weightage: 4).where(['id NOT IN (?)', @previous_question_set.map { |i| i.question_id }]).order('RANDOM()').limit(2)

        @short_note_2 = Question.where(type: 'ShortNote', weightage: 2).where(['id NOT IN (?)', @previous_question_set.map { |i| i.question_id }]).order('RANDOM()').limit(1)

        @html_code = Question.where(type: 'CodingOutput').where(['id NOT IN (?)', @previous_question_set.map { |i| i.question_id }]).order('RANDOM()').limit(2)
      else
        @fill_in_the_blank = Question.find_by_sql("select * from (SELECT *, row_number() over (partition by chapter_id order by random()) FROM questions where questions.type = 'FillInTheBlank') a where row_number=1;").sample(6)
        @fill_in_the_blank_next = Question.where(type: 'FillInTheBlank').where(['id NOT IN (?)', @fill_in_the_blank.map { |q| q.id }]).order('RANDOM()').limit(4).sample(4)

        @true_false = Question.find_by_sql("select * from (SELECT *, row_number() over (partition by chapter_id order by random()) FROM questions where questions.type = 'TrueFalse') a where row_number=1;").sample(6)
        @true_false_next = Question.where(type: 'TrueFalse').where(['id NOT IN (?)', @true_false.map { |q| q.id }]).order('RANDOM()').limit(4).sample(4)

        @mcq1 = Question.find_by_sql("select * from (SELECT *, row_number() over (partition by chapter_id order by random()) FROM questions where questions.type = 'Mcq1') a where row_number between 1 AND 2;").sample(12)
        @mcq1_next = Question.where(type: 'Mcq1').where(['id NOT IN (?)', @mcq1.map { |q| q.id }]).order('RANDOM()').limit(8).sample(8)

        @mcq2 = Question.where(type: 'Mcq2').order('RANDOM()').limit(5)

        @mcq3 = Question.where(type: 'Mcq3').order('RANDOM()').limit(2)

        @rearrange = Question.where(type: 'Rearrange').order('RANDOM()').limit(2)

        @short_note_1 = Question.where(type: 'ShortNote', weightage: 4).order('RANDOM()').limit(2)

        @short_note_2 = Question.where(type: 'ShortNote', weightage: 2).order('RANDOM()').limit(1)

        @html_code = Question.where(type: 'CodingOutput').order('RANDOM()').limit(2)
      end
    else
      @fill_in_the_blank = Question.find_by_sql("select * from (SELECT *, row_number() over (partition by chapter_id) FROM questions where questions.type = 'FillInTheBlank') a where row_number=1;").sample(6)
      @fill_in_the_blank_next = Question.where(type: 'FillInTheBlank').where(['id NOT IN (?)', @fill_in_the_blank.map { |q| q.id }]).limit(4).sample(4)

      @true_false = Question.find_by_sql("select * from (SELECT *, row_number() over (partition by chapter_id) FROM questions where questions.type = 'TrueFalse') a where row_number=1;").sample(6)
      @true_false_next = Question.where(type: 'TrueFalse').where(['id NOT IN (?)', @true_false.map { |q| q.id }]).limit(4).sample(4)

      @mcq1 = Question.find_by_sql("select * from (SELECT *, row_number() over (partition by chapter_id) FROM questions where questions.type = 'Mcq1') a where row_number between 1 AND 2;").sample(12)
      @mcq1_next = Question.where(type: 'Mcq1').where(['id NOT IN (?)', @mcq1.map { |q| q.id }]).limit(8).sample(8)

      @mcq2 = Question.where(type: 'Mcq2').limit(5)

      @mcq3 = Question.where(type: 'Mcq3').limit(2)

      @rearrange = Question.where(type: 'Rearrange').limit(2)

      @short_note_1 = Question.where(type: 'ShortNote', weightage: 4).limit(2)

      @short_note_2 = Question.where(type: 'ShortNote', weightage: 2).limit(1)

      @html_code = Question.where(type: 'CodingOutput').limit(2)
    end

  end

  def import_questions
    render layout: false
  end

  def import_chapters
    render layout: false
  end

  def import_users
    render layout: false
  end

  def importing_users
    if request.post? && params[:file].present?
      User.import(params[:file])
      redirect_to '/admin/user', notice: "Users imported."
    else
      redirect_to '/admin/user', notice: "Users couldn't be imported."
    end
  end

  def create_guest
    email = "#{Time.now.to_i}#{rand(99)}@guestuser.com"
    password = 'ittest_password'
    @user = User.create(email: email, password: password, password_confirmation: password, name: 'Guest', is_guest: true)
    @user.save
    sign_in(:user, @user)
    redirect_to '/admin'
  end

  def contact_us
  end

  def pricing
  end

end
