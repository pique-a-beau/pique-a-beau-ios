import ProjectDescription

let tuist = Tuist(
    fullHandle: "mudrhs1997/PiqueABeau",
    project: .tuist(plugins: [
        .local(path: .relativeToRoot("Plugin/DependencyPlugin")),
        .local(path: .relativeToRoot("Plugin/EnvironmentPlugin")),
    ])
)
