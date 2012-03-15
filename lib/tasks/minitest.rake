require "rake/testtask"

Rake::TestTask.new :test do |t|
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
end

task default: :test

namespace :test do
  Rake::Task.new :models do |t|
    t.libs << 'test'
    t.pattern = 'test/models/*_test.rb'
  end

  Rake::Task.new :integration do |t|
    t.libs << 'test'
    t.pattern = 'test/integration/*_test.rb'
  end
end
