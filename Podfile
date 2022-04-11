# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'MySpotify' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  pod 'RxSwift'
  pod 'RxCocoa'
  # Use to handle navigation link
  pod 'URLNavigator'
  # Use for load photos
  pod 'Kingfisher'
  # Use for networking layer
  pod 'Moya'

  # Pods for MySpotify

  target 'MySpotifyTests' do
    inherit! :search_paths
    pod 'Quick'
    pod 'Nimble'
    pod 'RxNimble', subspecs: ['RxBlocking', 'RxTest']
    # Pods for testing
  end

  target 'MySpotifyUITests' do
    # Pods for testing
  end

end
