module Bullet
  module Presenter
    class BulletLogger < Base
      @logger_file = nil
      @logger = nil

      def self.active? 
        @logger
      end

      def self.out_of_channel_notify( notice )
        return unless active?
        @logger.info notice.full_notice
        @logger_file.flush
      end

      def self.setup
        @logger_file = File.open( Rails.root.join('log/bullet.log'), 'a+' )
        @logger = Logger.new( @logger_file )

        def @logger.format_message( severity, timestamp, progname, msg )
          "#{timestamp.to_formatted_s(:db)}[#{severity}] #{msg}\n"
        end
      end

    end
  end
end
