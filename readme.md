# swift-macro-compile-safe-init

Various macros for making compile-time checked types out of otherwise runtime checked calls like `URL(string:)`.

## Examples

Instead of

```swift
let url = URL("http://example.com")!
let date = try! Date("2017-01-03T12:34:56Z", strategy: .iso8601)
```

you can use these macros and the compiler will tell you if you mistyped the format:

```swift
let url = #URL("http://example.com")
let date = #Date("2017-01-03T12:34:56Z", strategy: .iso8601)
```

## How to use

1. Add the package to the list of dependencies in your Package.swift file.
    ```swift
    .package(url: "https://github.com/fizker/swift-macro-compile-safe-init.git", from: "1.0.0")
    ```
2. Add the product to the dependencies of the targets:
    ```swift
    .product(name: "CompileSafeInitMacro", package: "swift-macro-compile-safe-init")
    ```
3. Add `import CompileSafeInitMacro` in the file.
