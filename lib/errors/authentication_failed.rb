class AuthenticationFailed < StandardError

    def http_status
        :unauthorized
    end

    def code
        'not_authenticated'
    end

    def message
        "Not Authenticated"
    end

    def to_hash
        {
            code: code,
            message: message

        }
    end

end