# SwiftyNet

SwiftyNet is a lightweight, protocol-oriented networking framework for Swift applications that follows SOLID principles and modern best practices.

## Features

- Protocol-oriented design
- Async/await support
- Built-in caching mechanism
- Network reachability monitoring
- Type-safe request/response handling
- Comprehensive error handling
- Pagination support
- SOLID principles compliance
- Testable architecture

## Installation

### Swift Package Manager

Add the following to your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/username/SwiftyNet.git", from: "1.0.0")
]

## Basic Usage
### Making a Simple Request

```swift 
// Setup
let networkMonitor = NetworkMonitor()
let cacheManager = CacheManager()
let client = HTTPClient(
    cacheManager: cacheManager,
    networkMonitor: networkMonitor
)

// Create endpoint
let endpoint = Endpoint(
    baseURL: URL(string: "https://api.example.com")!,
    path: "/users",
    method: .get
)

// Make request
do {
    let users: [User] = try await client.sendRequest(endpoint, responseType: [User].self)
    print("Retrieved users: \(users)")
} catch {
    print("Error: \(error.localizedDescription)")
}
```

### Handling Paginated Responses
```swift 
let response: PaginatedResponse<User> = try await client.sendRequest(
    endpoint,
    responseType: PaginatedResponse<User>.self
)

print("Users: \(response.data)")
print("Next page: \(response.nextPage ?? "none")")
```

## Architecture
### Core Components
1. **HTTPClient**
   * Main class for making network requests
   * Supports async/await
   * Handles response parsing and error mapping
2. **Endpoint**
   * Defines API endpoints
   * Configurable base URL, path, method, headers, and query parameters
3. **CacheManager**
   * Handles response caching
   * Configurable expiration time
   * Memory-efficient implementation
4. **NetworkMonitor**
   * Monitors network reachability
   * Prevents requests when offline
   * Real-time connectivity updates
Response Types
1. **APIResponse**
   * Generic wrapper for API responses
   * Includes status, data, and error information
2. **PaginatedResponse**
   * Handles paginated data
   * Includes next page information and total counts
3. **ParentKeyWrapper**
   * Helps decode nested JSON responses
   * Extracts data from specific keys
   
## Error Handling
SwiftyNet provides comprehensive error handling through `APIError`:
```swift 
public enum APIError: Error {
    case invalidURL
    case requestFailed(statusCode: Int, data: Data?)
    case decodingError(Error)
    case networkUnavailable
    case invalidResponse
    case timeout
    case unauthorized
    case unknown(Error)
}
```

## Advanced Features
### Custom Headers
```swift 
let endpoint = Endpoint(
    baseURL: URL(string: "https://api.example.com")!,
    path: "/protected/resource",
    method: .get,
    headers: ["Authorization": "Bearer your-token"]
)
```

### Request Caching
```swift
// Cache is automatically handled for GET requests
let cacheManager = CacheManager(expirationInterval: 3600) // 1 hour
let client = HTTPClient(cacheManager: cacheManager)
```

### Network Monitoring
```swift
let networkMonitor = NetworkMonitor()
networkMonitor.startMonitoring()

// Check connection status
if networkMonitor.isConnected {
    // Make request
}
```

## Testing
### The protocol-oriented design makes testing straightforward:
```swift 
class MockCacheManager: CacheManaging {
    // Test implementation
}

class MockNetworkMonitor: NetworkMonitoring {
    // Test implementation
}

// Use in tests
let mockCache = MockCacheManager()
let mockMonitor = MockNetworkMonitor()
let client = HTTPClient(
    cacheManager: mockCache,
    networkMonitor: mockMonitor
)
```

## Requirements

* iOS 13.0+ / macOS 10.15+
* Swift 5.5+
* Xcode 13.0+

## Contributing

1. Fork the repository.  
2. Create your feature branch:  
   ```bash
   git checkout -b feature/amazing-feature
   ```
3. Commit your changes 
```bash
git commit -m 'Add amazing feature'
```
4. Push to the branch (
```bash
git push origin feature/amazing-feature
```
5. Open a Pull Request

## License
see the LICENSE file for details
