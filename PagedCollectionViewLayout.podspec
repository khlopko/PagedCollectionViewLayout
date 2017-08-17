Pod::Spec.new do |s|
    s.name = 'PagedCollectionViewLayout'
    s.version = '1.0.0'
    s.homepage = 'https://github.com/khlopko/PagedCollectionViewLayout'
    s.license = { :type => 'MIT' }
    s.authors = 'Kirill Khlopko'
    s.summary = 'Custom UICollectionViewLayout that handles paginated scroll.'
    s.source = {
        :git => 'https://github.com/khlopko/PagedCollectionViewLayout.git',
        :tag => s.version
    }
    s.source_files = 'Sources/*.swift'
    s.ios.deployment_target = '10.0'
end
