Pod::Spec.new do |s|
  s.name = "TableRow"
  s.version = "0.1.0"
  s.summary = "A tableView row (including inline variant) for use with Eureka library"
  s.homepage = 'https://github.com/EurekaCommunity/TableRow'
  s.license = { :type => 'MIT', :file => 'LICENSE' }
  s.author = 'Anton Kovtun'
  s.ios.deployment_target = '8.0'
  s.ios.frameworks = 'UIKit', 'Foundation'
  s.source = { :git => 'https://github.com/EurekaCommunity/TableRow.git' }
  s.source_files  = 'Sources/**/*.{swift}'
  s.requires_arc = true
  s.dependency 'Eureka', '~> 4.1'
end
