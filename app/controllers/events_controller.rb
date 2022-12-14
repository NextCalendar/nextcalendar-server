class EventsController < ApplicationController
  before_action :set_event, only: %i[ show edit update destroy ]
  before_action :set_groups, only: %i[ new create edit update ]

  # GET /events or /events.json
  def index
    @events = Event.all
  end

  # GET /events/1 or /events/1.json
  def show
  end

  # GET /events/new
  def new
    current_time = Time.new
    @prefilled_start_time = Time.new(year = current_time.year, mon = current_time.mon, mday = current_time.mday, hour = current_time.hour + 1, min = 0).strftime("%Y-%m-%dT%k:%M")
    @prefilled_end_time = Time.new(year = current_time.year, mon = current_time.mon, mday = current_time.mday, hour = current_time.hour + 2, min = 0).strftime("%Y-%m-%dT%k:%M")
    @group = Group.find_by_id(params[:group_id])
    @event = Event.new(:group_id => params[:group_id])
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events or /events.json
  def create
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to event_url(@event), notice: "Event was successfully created." }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1 or /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to event_url(@event), notice: "Event was successfully updated." }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1 or /events/1.json
  def destroy
    @event.destroy

    respond_to do |format|
      format.html { redirect_to events_url, notice: "Event was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_event
    @event = Event.find(params[:id])
  end

  def set_groups
    @groups = current_user.groups
  end

  # Only allow a list of trusted parameters through.
  def event_params
    params.require(:event).permit(:name, :group_id, :start_time, :end_time)
  end
end
