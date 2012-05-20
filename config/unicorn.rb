def workers
  @workers ||= if ENV['WORKERS']
    ENV['WORKERS'].to_i
  else
    1
  end
end

puts "Workers: #{workers}"
worker_processes workers
timeout 30
