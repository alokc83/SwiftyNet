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

# Roadmap for SwiftyNet Framework

## Current Functionality

### Protocols
1. **HTTPClientProtocol**  
   - Implements `sendRequest` method for executing network requests.
   - Ensures Single Responsibility and Interface Segregation.

2. **EndpointProtocol**  
   - Defines `baseURL`, `path`, `method`, `queryItems`, and `headers`.
   - Promotes Open/Closed principle for extending endpoints.

3. **RequestBuildable**  
   - Handles the construction of `URLRequest` objects from `EndpointProtocol`.

4. **CacheManaging**  
   - Manages caching of network responses.
   - Includes methods to save, retrieve, and clear cached data.

5. **NetworkMonitoring**  
   - Tracks network connectivity status (`isConnected`).
   - Supports starting and stopping network monitoring.

6. **ErrorHandling**  
   - Converts errors into user-friendly messages.
   - Simplifies error management in the library.

---

### Enums
- **HTTPMethod**  
  - Supports standard HTTP methods like GET, POST, PUT, DELETE, and PATCH.

---

### Implementations
1. **Endpoint**  
   - Implements `EndpointProtocol` to define endpoints with configurable paths, query items, and headers.

2. **RequestBuilder**  
   - Implements `RequestBuildable` to build `URLRequest` objects with query items and headers.

3. **HTTPClient**  
   - Implements `HTTPClientProtocol` to execute network requests.
   - Integrates caching with `CacheManaging`.
   - Validates responses and decodes data using `DecodingHelper`.
   - Handles network unavailability with `NetworkMonitoring`.

4. **NetworkMonitor**  
   - Implements `NetworkMonitoring` using `NWPathMonitor` to track connectivity changes.

---

## Potential Enhancements

### 1. Retry Mechanism
- Implement a retry logic to handle transient network failures.
- Allow configurable retry counts and backoff strategies.

### 2. Authentication Support
- Add token-based authentication (e.g., OAuth, JWT).
- Automatically attach tokens to request headers.
- Refresh tokens when they expire.

### 3. Advanced Caching
- Add disk-based caching for large responses.
- Implement cache expiry and invalidation policies.

### 4. Middleware/Interceptors
- Add support for request/response middleware to preprocess or log requests and responses.

### 5. Custom Error Mapping
- Extend `ErrorHandling` to support app-specific error codes and messages.
- Add localization support for error messages.

### 6. Logging and Debugging
- Add a logging utility to track network calls and responses.
- Include optional verbose logging for debugging purposes.

### 7. Multi-Part Requests
- Support for multi-part form data for file uploads.

### 8. Performance Monitoring
- Track network performance (e.g., latency, response times).
- Provide metrics for optimizing API usage.

### 9. Tests and Mocks
- Add unit tests for all protocols and implementations.
- Provide mock implementations for `HTTPClientProtocol` and `NetworkMonitoring` for testing.

---

## Summary

### Features Implemented
- Protocol-based design for flexibility and modularity.
- Core functionalities: HTTP requests, caching, network monitoring, error handling.
- Updated implementations for `HTTPClient`, `Endpoint`, `RequestBuilder`, and `NetworkMonitor`.

### Features to Add
- Retry mechanism, advanced caching, and authentication support.
- Middleware, multi-part request handling, and performance monitoring.
- Comprehensive tests and logging utilities.

This roadmap ensures SwiftyNet evolves into a robust, universal networking library for multiple platforms.

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
