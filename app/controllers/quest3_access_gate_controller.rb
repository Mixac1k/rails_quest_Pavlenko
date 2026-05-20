class Quest3AccessGateController < ApplicationController
  # TODO: Add routes in config/routes.rb and finish the controller logic for Quest 3.
  # The quest expects a mix of GET / POST / PATCH / DELETE, conditional redirects,
  # and visible before_action / after_action callbacks.

  before_action :prepare_clearance, only: :clearance
  before_action :capture_token, only: :granted
  after_action :append_clearance_trace, only: :clearance
  after_action :append_token_trace, only: :granted

  def ping
    render plain: ""
  end

  def scan
    render plain: ""
  end

  def power
    render plain: ""
  end

  def stale_logs
    render plain: ""
  end

  def clearance
    render plain: ""
  end

  def verify
    head :not_found
  end

  def granted
    render plain: ""
  end

  def denied
    render plain: ""
  end

  private

  def prepare_clearance
    @clearance_total = 0
  end

  def capture_token
    @token = params[:token].to_s
  end

  def append_clearance_trace
    response.set_header("X-Access-Gate-Trace", "")
  end

  def append_token_trace
    response.set_header("X-Access-Gate-Trace", "")
  end
end
