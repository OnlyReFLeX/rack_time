class TimeHandler
  attr_reader :status, :response
  FORMATS = {
    'year' => '%Y-', 'month' => '%m-', 'day' => '%d',
    'hour' => '%H:', 'minute' => '%M:', 'second' => '%S'
  }.freeze

  def initialize(params)
    @valid_formats = ''
    @unknown = []
    @response = time_format(params)
  end

  private

  def time_format(params)
    parser_parameters(params['format'].split(','))

    return unknown_format unless @unknown.empty?
    time_output
  end

  def unknown_format
    @status = 400
    "Unknown time format #{@unknown}"
  end

  def time_output
    @status = 200
    Time.now.strftime(@valid_formats)
  end

  def parser_parameters(parameters)
    parameters.each do |formats|
      if FORMATS[formats]
        @valid_formats += FORMATS[formats]
      else
        @unknown << f
      end
    end
  end
end
