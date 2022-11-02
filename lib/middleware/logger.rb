
require 'logger'

  class SimplerLogger

    def initialize(app)
    @app = app
    @log = Logger.new('log/app.log')
    end

    def call(env)
      status, headers, response = @app.call(env)
      @log.info(log(status, headers, env))

      [status, headers, response]
    end

    def log(status, headers, env)
      {
        Request: "#{env['REQUEST_METHOD']} #{env['REQUEST_PATH']}",
        Handler: "#{env['simpler.controller'].class}##{env['simpler.action']}",
        Parameters: env['simpler.params'],
        Response: "#{status} [#{headers['Content-Type']}] #{env['simpler.template_path']}"
      }

    end

  end