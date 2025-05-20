//
//  NetworkMonitorVM.swift
//  TestTask
//
//  Created by Vadym Vasylaki on 19.05.2025.
//

import Foundation
import Network

final class NetworkMonitorVM: ObservableObject {
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitor")
    //The status changes automatically when the internet disappears or reappears.
    @Published var isConnected: Bool = true
    
    init() {
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.isConnected = path.status == .satisfied
            }
        }
        monitor.start(queue: queue)
    }
    
    func checkConnectionWithPing() {
        //"Manually force a request to the URL to check for feedback
        guard let url = URL(string: "https://www.google.com") else {
            isConnected = false
            return
        }
        
        var request = URLRequest(url: url)
        request.timeoutInterval = 5.0
        
        URLSession.shared.dataTask(with: request) { _, response, error in
            DispatchQueue.main.async {
                if let error = error {
#if DEBUG
                    print("Ping failed with error: \(error.localizedDescription)")
#endif
                    self.isConnected = false
                } else if let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) {
                    self.isConnected = true
                } else {
                    self.isConnected = false
                }
            }
        }.resume()
    }
    
    deinit {
        monitor.cancel()
    }
}
