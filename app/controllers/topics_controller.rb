class TopicsController < ApplicationController
  # Cancan authorization
  authorize_resource

  # GET /topics
  # GET /topics.json
  def index
    @topics = Topic.order('num_votes desc, created_at desc').all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @topics }
    end
  end

  # GET /topics/1
  # GET /topics/1.json
  def show
    @topic = Topic.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @topic }
    end
  end

  # GET /topics/new
  # GET /topics/new.json
  def new
    @topic = Topic.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @topic }
    end
  end

  # GET /topics/1/edit
  def edit
    @topic = Topic.find(params[:id])
  end

  # POST /topics
  # POST /topics.json
  def create
    @topic = Topic.new(permitted_params.topic)
    @topic.user = current_user

    respond_to do |format|
      if @topic.save
        format.html { redirect_to @topic, notice: 'Topic was successfully created.' }
        format.json { render json: @topic, status: :created, location: @topic }
      else
        format.html { render action: "new" }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /topics/1
  # PUT /topics/1.json
  def update
    @topic = Topic.find(params[:id])

    respond_to do |format|
      if @topic.update_attributes(permitted_params.topic)
        format.html { redirect_to @topic, notice: 'Topic was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /topics/1
  # DELETE /topics/1.json
  def destroy
    @topic = Topic.find(params[:id])
    @topic.destroy

    respond_to do |format|
      format.html { redirect_to topics_url }
      format.json { head :no_content }
    end
  end

  # POST /topics/1/vote
  def vote
    # Lookup topic (and vote, if it exists)
    @topic = Topic.find(params[:id])
    @vote = Vote.find_by_topic_id_and_user_id(@topic.id, current_user.id)
    value = params[:direction] == 'up' ? 1 : -1

    # Create/update vote
    if @vote
      @vote.value = value
      @vote.save!
    else
      @vote = Vote.new
      @vote.user = current_user
      @vote.topic = @topic
      @vote.value = value
      @vote.save!
    end

    # Refresh vote count
    @topic.reload

    # Respond with some js to update page
    respond_to do |format|
      format.js
    end
  end
end
