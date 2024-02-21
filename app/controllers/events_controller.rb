class EventsController < ApplicationController
    before_action :set_event, only: [:show, :update, :destroy]
    before_action :authenticate_request, except: [:index]

    def index
        events = Event.order(created_at: :desc).page(params[:page]).per(12)

        render json: {
            events: EventBlueprint.render_as_hash(events, view: :short),
            total_pages: events.total_pages,
            current_page: events.current_page
        }
    end

    def show
        render json: @event, status: :ok
    end

    def create
        event = @current_user.created_events.new(event_params)

        if event.save
            render json: event, status: :created
        else
            render json: event.errors, status: :unprocessable_entity
        end
    end

    def update
        if @event.update(event_params)
            render json: @event, status: :ok
        else
            render json: @event.errors, status: :unprocessable_entity
        end
    end

    def destroy
        if @event.destroy
            render json: nil, status: :ok
        else
            render json: @event.errors, status: :unprocessable_entity
        end
    end

    private

    def set_event
        @event = Event.find(params[:id])
    end

    def event_params
        params.permit(:title, :content, :start_date_time, :end_date_time, :guests, :sport_ids => [])
    end
end
