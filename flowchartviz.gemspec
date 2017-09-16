Gem::Specification.new do |s|
  s.name = 'flowchartviz'
  s.version = '0.1.4'
  s.summary = 'Creates a Polyrex Graphviz XML file from pseudocode of ' +
               '1 or more nested if statements'
  s.authors = ['James Robertson']
  s.files = Dir['lib/flowchartviz.rb']
  s.add_runtime_dependency('line-tree', '~> 0.5', '>=0.5.8')
  s.add_runtime_dependency('pxgraphviz', '~> 0.3', '>=0.3.6')
  s.signing_key = '../privatekeys/flowchartviz.pem'
  s.cert_chain  = ['gem-public_cert.pem']
  s.license = 'MIT'
  s.email = 'james@jamesrobertson.eu'
  s.homepage = 'https://github.com/jrobertson/flowchartviz'
end
