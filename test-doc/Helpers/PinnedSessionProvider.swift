//
//  PinnedSessionProvider.swift
//  test-doc
//
//  Created by Artem Golovanev on 17.07.2025.
//

import Foundation

private typealias CallbackResult = (URLSession.AuthChallengeDisposition, URLCredential?)

final class PinnedSessionProvider: NSObject {
    static let shared = PinnedSessionProvider()
    
    private override init() {}
    
    lazy var session: URLSession = {
        URLSession(configuration: .default, delegate: self, delegateQueue: nil)
    }()
}

extension PinnedSessionProvider: URLSessionDelegate {
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        
        if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust {
            
            guard let serverTrust = challenge.protectionSpace.serverTrust,
                  let serverCert = (SecTrustCopyCertificateChain(serverTrust) as? [SecCertificate])?.first
            else { return completionHandler(.cancelAuthenticationChallenge, nil) }
            
            let serverCertData = SecCertificateCopyData(serverCert) as Data
            
            guard let localCertPath = Bundle.main.path(forResource: "autodoc", ofType: "cer"),
                  let localCertData = try? Data(contentsOf: URL(fileURLWithPath: localCertPath))
            else { return completionHandler(.cancelAuthenticationChallenge, nil) }
            
            let result: CallbackResult = serverCertData == localCertData ?
            (.useCredential, URLCredential(trust: serverTrust)) :
            (.cancelAuthenticationChallenge, nil)
            
            completionHandler(result.0, result.1)
        } else {
            completionHandler(.cancelAuthenticationChallenge, nil)
        }
    }
}
