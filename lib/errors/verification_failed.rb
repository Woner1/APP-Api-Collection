class VerificationFailed < StandardError
    def http_status
        :forbidden
    end

    def code
        "verification_failed"
    end

    def message
        "Incorrect verification code"
    end

    def to_hash
        {
            code: code,
            message: message
        }
    end

end