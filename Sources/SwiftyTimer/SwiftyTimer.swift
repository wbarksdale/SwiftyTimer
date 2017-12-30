
#if os(Linux)
    import Glibc
#else
    import Darwin
#endif

public struct SwiftyTimer {
    var startTime: UInt64 = 0
    var stopTime: UInt64 = 0
    let numer: UInt64
    let denom: UInt64
    
    init() {
        #if os(Linux)
            numer = 1
            denom = 1
        #else
            var info = mach_timebase_info(numer: 0, denom: 0)
            mach_timebase_info(&info)
            numer = UInt64(info.numer)
            denom = UInt64(info.denom)
        #endif
    }
    
    public mutating func start() {
        #if os(Linux)
            var ts: timespec = timespec()
            clock_gettime(CLOCK_MONOTONIC, &ts)
            startTime = UInt64(ts.tv_sec)
        #else
           startTime = mach_absolute_time()
        #endif
    }
    
    public mutating func stop() {
        #if os(Linux)
            var ts: timespec = timespec()
            clock_gettime(CLOCK_MONOTONIC, &ts)
            stopTime = UInt64(ts.tv_sec)
        #else
            stopTime = mach_absolute_time()
        #endif
    }
    
    public var nanoseconds: UInt64 {
        return ((stopTime - startTime) * numer) / denom
    }
    
    public var microseconds: Double {
        return Double(nanoseconds) / 1_000
    }
    
    public var milliseconds: Double {
        return Double(nanoseconds) / 1_000_000
    }
    
    public var seconds: Double {
        return Double(nanoseconds) / 1_000_000_000
    }
    
    public var minutes: Double {
        return seconds / 60
    }
    
    public var hours: Double {
        return seconds / (60 * 60)
    }
}
