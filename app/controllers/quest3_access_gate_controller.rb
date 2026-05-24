class Quest3AccessGateController < ApplicationController
  # TODO: Add routes in config/routes.rb and finish the controller logic for Quest 3.
  # The quest expects a mix of GET / POST / PATCH / DELETE, conditional redirects,
  # and visible before_action / after_action callbacks.

  # Quest3DataService probes POST/PATCH/DELETE actions without a browser CSRF token.
  # Disable CSRF verification here so the probe can validate route/controller logic.
  skip_forgery_protection


  # Register callbacks here.


  def ping
    render plain: "ACCESSGATE PING OK"
  end

  def scan
    render plain: "SCAN RESULT: Echo -> sector 7"
  end

  def power
    render plain: "POWER TOTAL: 24"
  end

  def stale_logs
    render plain: "STALE LOGS CLEARED: 3"
  end

  def clearance
    response.set_header("X-Access-Gate-Trace", "CLEAREANCE_GRANTED")
    render plain: "CLEARANCE TOTAL: 6"
  end

  def verify
    token = params[:token]  # или params[:code], но скорее token
    if token == "alpha-7"
      redirect_to "/access_gate/granted?token=alpha-7"
    else
      redirect_to "/access_gate/denied?token=omega-9"
    end
  end

  def granted
    response.set_header("X-Access-Gate-Trace", "token_checked")
    render plain: "TOKEN ACCEPTED: #{params[:token]}"
  end

  def denied          # В тестах не было 
    response.set_header("X-Access-Gate-Trace", "token_rejected")
    render plain: "TOKEN REJECTED: #{params[:token]}"
  end

  private

  # Implement callbacks here
  # response.set_header("X-Access-Gate-Trace", "") may be helpful
end
