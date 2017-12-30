# SwiftyTimer

Do you need to time something in swift? Do you want it to run on Linux and on macOS. Thats what I needed, and thats why I made `SwiftyTimer`.


## Usage

```swift
var myTimer: SwiftyTimer = SwiftyTimer()

myTimer.start()

// do some stuff

myTimer.stop()

print("stuff took \(myTimer.nanoseconds) nanoseconds to complete")
print("or if you prefer a more manageable unit, stuff took \(myTimer.milliseconds) milliseconds to complete")
```

## Swift Package Manger

Add `SwiftyTimer` to your project by simply adding the following to your Package dependencies.

```swift
.package(url: "https://github.com/wbarksdale/SwiftyTimer.git", from: "0.1.0")
``` 
