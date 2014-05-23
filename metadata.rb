name             'sch-elasticsearch'
maintainer       'David F. Severski'
maintainer_email 'davidski@deadheaven.com'
license          'MIT'
description      'Installs and configures Elasticsearch'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends 'elasticsearch', '>= 0.3.9'