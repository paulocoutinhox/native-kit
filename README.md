# Native Kit

This is a framework that use the same codebase and libraries for all native platforms (Android, iOS, MacOS, Linux and Windows).  

# Help

Type the following command to get all possible execute options:

```
make help
```

# Android

BUILD:

```
make build-native-kit-android-sdk
```

DEPLOY:

```
make android-deploy-local-debug
```

# MacOS

```
make build-native-kit-macos-sdk
```

# Linux 64

```
make build-native-kit-linux-sdk
```

# Unit test

```
make test
```

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
make docker-run task=test
```
