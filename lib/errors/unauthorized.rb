class Unauthorized < StandardError
    def http_status
        :forbidden
      end
    
      def code
        'not_authorized'
      end
    
      def message
        'Not authorized'
      end
    
      def to_hash
        {
            message: message,
            code: code
        }
      end
end