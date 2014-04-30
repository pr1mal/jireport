module JiReport

  class JiraRSSFetch

    # params [Hash] -
    #   :url => [String]      - Jira server url
    #   :login => [String]    - Jira login
    #   :password => [String] - Jira password
    #   :proxy => [String]    - optional
    def initialize params
      login = CGI.escape(params[:login])
      pswd = CGI.escape(params[:password])
      @uri_name = "#{params[:url].chomp '/'}/activity?os_password=#{pswd}&" \
                  "os_username=#{login}"

      @uri_params = { :ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE, :read_timeout => 3600 }
      @uri_params[:proxy] = params[:proxy] if params[:proxy]
    end

    DEFAULT_LIMIT = 30

    # user [String] - login of user, whose activity entries will be fetched
    # limit [String] - max number of rss entries
    def fetch user, limit=DEFAULT_LIMIT
      full_uri_name = "#{@uri_name}&streams=user+IS+#{user}&maxResults=#{limit}"

      io = open(full_uri_name, @uri_params)

      begin
        block_given? ? yield(io) : io.read
      ensure
        io.close
      end
    end

    def fetch_changed_issues user, limit=DEFAULT_LIMIT
      puts "Fetching #{user}..."
      fetch(user, limit){ |io| SimpleRSS.parse io }.entries.map{ |e|
        # activity:
        #   changed the status to Assigned on
        #   started progress on
        #   resolved
        #puts '-' * 80
        #puts e.title

        %r(/a>([^<]+)) =~ e.title
        activity = ($1 || '').strip
        #puts "  activity: #{activity}"

        %r(browse/(\w+-\d+)) =~ e.title
        bug_id = ($1 || '').strip
        #puts "  bug id: #{bug_id}"

        %r( - (.*?)&lt;/a>) =~ e.title
        summary = ($1 || '').strip
        #puts "  summary: #{summary}"

        feed = {
          :key => bug_id,
          :assignee => user
        }

        if activity.start_with? 'changed the status'
          /to (.*?) on\s/ =~ activity
          feed[:status] = $1
        elsif activity.start_with? 'started progress'
          feed[:status] = 'Working on it'
        elsif activity.start_with? 'resolved'
          feed[:status] = 'Resolved'
        else
          next
        end

        feed[:summary] = CGI.unescape_html CGI.unescape_html summary
        feed[:updated_at] = e.updated

        puts "  #{feed[:updated_at]} #{feed[:key]} => #{feed[:status]}"

        feed
      }.compact
    end

  end

end
