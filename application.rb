require_relative 'time_handler'

class Application
  def call(env)
    @request = Rack::Request.new(env)
    if @request.path_info == '/time/'
      time = TimeHandler.new(@request.params)
      response(time.status, time.response)
    else
      response(404, 'Not Found')
    end
  end

  private

  def response(code, text)
    [
      code,
      { 'Content-Type' => 'text/plain' },
      [text]
    ]
  end
end
