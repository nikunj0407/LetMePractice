class QuestionwiseMarksDistributionsController < ApplicationController
  # GET /questionwise_marks_distributions
  # GET /questionwise_marks_distributions.json
  def index
    @questionwise_marks_distributions = QuestionwiseMarksDistribution.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @questionwise_marks_distributions }
    end
  end

  # GET /questionwise_marks_distributions/1
  # GET /questionwise_marks_distributions/1.json
  def show
    @questionwise_marks_distribution = QuestionwiseMarksDistribution.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @questionwise_marks_distribution }
    end
  end

  # GET /questionwise_marks_distributions/new
  # GET /questionwise_marks_distributions/new.json
  def new
    @questionwise_marks_distribution = QuestionwiseMarksDistribution.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @questionwise_marks_distribution }
    end
  end

  # GET /questionwise_marks_distributions/1/edit
  def edit
    @questionwise_marks_distribution = QuestionwiseMarksDistribution.find(params[:id])
  end

  # POST /questionwise_marks_distributions
  # POST /questionwise_marks_distributions.json
  def create
    @questionwise_marks_distribution = QuestionwiseMarksDistribution.new(params[:questionwise_marks_distribution])

    respond_to do |format|
      if @questionwise_marks_distribution.save
        format.html { redirect_to @questionwise_marks_distribution, notice: 'Questionwise marks distribution was successfully created.' }
        format.json { render json: @questionwise_marks_distribution, status: :created, location: @questionwise_marks_distribution }
      else
        format.html { render action: "new" }
        format.json { render json: @questionwise_marks_distribution.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /questionwise_marks_distributions/1
  # PUT /questionwise_marks_distributions/1.json
  def update
    @questionwise_marks_distribution = QuestionwiseMarksDistribution.find(params[:id])

    respond_to do |format|
      if @questionwise_marks_distribution.update_attributes(params[:questionwise_marks_distribution])
        format.html { redirect_to @questionwise_marks_distribution, notice: 'Questionwise marks distribution was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @questionwise_marks_distribution.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questionwise_marks_distributions/1
  # DELETE /questionwise_marks_distributions/1.json
  def destroy
    @questionwise_marks_distribution = QuestionwiseMarksDistribution.find(params[:id])
    @questionwise_marks_distribution.destroy

    respond_to do |format|
      format.html { redirect_to questionwise_marks_distributions_url }
      format.json { head :no_content }
    end
  end
end
