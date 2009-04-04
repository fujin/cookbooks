rsyslog = Mash.new
rsyslog[:server] = [ "" ] unless rsyslog.has_key?(:server)
