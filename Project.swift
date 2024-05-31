import ProjectDescription

private let appName: String = "TuistTest"
private let bundleID: String = "com.dongho.TuistTest"
private let version: String = "0.0.1"
private let bundleVersion: String = "1"
private let iOSTargetVersion: String = "15.0"

let project = Project(
    name: appName,
    packages: [],
    settings: Settings.settings(configurations: makeConfigurations()),
    targets: [
        .target(
            name: appName,
            destinations: .iOS,
            product: .app,
            bundleId: bundleID,
            deploymentTargets: .iOS(iOSTargetVersion),
            infoPlist: makeInfoPlist(),
            sources: ["TuistTest/Sources/**"],
            resources: ["TuistTest/Resources/**"],
            dependencies: [],
            settings: baseSettings()
        ),
        .target(
            name: "TuistTestTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "com.dongho.TuistTestTests",
            infoPlist: .default,
            sources: ["TuistTest/Tests/**"],
            resources: [],
            dependencies: [.target(name: "TuistTest")]
        ),
    ],
    additionalFiles: [
        "README.md"
    ]
)

private func makeInfoPlist(merging other: [String: Plist.Value] = [:]) -> InfoPlist {
    var extendedPlist: [String: Plist.Value] = [
        "UIApplicationSceneManifest": ["UIApplicationSupportsMultipleScenes": true],
        "UILauncScreen": [],
        "UISupportedInterfaceOrientations":
            [
                "UIInterfaceOrientationPortrait",
            ],
        "CFBundleShortVersionString": "\(version)",
        "CFBundleVersion": "\(bundleVersion)",
        "CFBundleDisplayName": "$(APP_DISPLAY_NAME)"
    ]
    other.forEach { (key: String, value: Plist.Value) in
        extendedPlist[key] = value
    }
    
    return InfoPlist.extendingDefault(with: extendedPlist)
}


private func makeConfigurations() -> [Configuration] {
    let debug: Configuration = Configuration.debug(name: "Debug", xcconfig: "Configs/Debug.xcconfig")
    let release: Configuration = Configuration.release(name: "Release", xcconfig: "Configs/Release.xcconfig")
    
    return [debug, release]
}

private func baseSettings() -> Settings {
    var settings = SettingsDictionary()
    
    return Settings.settings(base: settings,
                             configurations: [],
                             defaultSettings: .recommended)
}
