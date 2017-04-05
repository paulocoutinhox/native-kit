# Native Kit

This is a framework that use the same codebase for all native platforms (Android, iOS, MacOS, Linux and Windows).  

# Some projects can be compiled using Docker

To build the docker container:

```
make docker-build
```

To run tasks, you can use:

```
make docker-run task=[make task name]
```

Example:

```
make docker-run task=build-native-kit-android-sdk
```

# Android

```
make build-native-kit-android-sdk
```

# MacOS

```
make build-native-kit-macos-sdk
```