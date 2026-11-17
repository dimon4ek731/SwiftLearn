import SwiftUI
import WebKit

public struct OfficialDocsWebView: View {
    let url: URL
    @ObservedObject var lang = LanguageManager.shared
    
    @State private var canGoBack: Bool = false
    @State private var canGoForward: Bool = false
    @State private var estimatedProgress: Double = 0.0
    @State private var isLoading: Bool = false
    @State private var webView = WKWebView()
    
    public init(url: URL = URL(string: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/")!) {
        self.url = url
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            // Live Web Navigation Bar
            HStack(spacing: 12) {
                Button(action: { webView.goBack() }) {
                    Image(systemName: "chevron.backward")
                        .font(.system(size: 14, weight: .semibold))
                }
                .disabled(!canGoBack)
                
                Button(action: { webView.goForward() }) {
                    Image(systemName: "chevron.forward")
                        .font(.system(size: 14, weight: .semibold))
                }
                .disabled(!canGoForward)
                
                // URL Pill
                HStack(spacing: 6) {
                    Image(systemName: "lock.fill")
                        .font(.system(size: 10))
                        .foregroundColor(Color(red: 0.16, green: 0.58, blue: 0.40))
                    
                    Text("docs.swift.org")
                        .font(.caption.bold())
                        .foregroundColor(.primary)
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .background(Color(UIColor.secondarySystemBackground))
                .clipShape(Capsule())
                
                Spacer()
                
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .scaleEffect(0.8)
                } else {
                    Button(action: { webView.reload() }) {
                        Image(systemName: "arrow.clockwise")
                            .font(.system(size: 14, weight: .semibold))
                    }
                }
                
                Button(action: {
                    if let currentURL = webView.url {
                        UIApplication.shared.open(currentURL)
                    } else {
                        UIApplication.shared.open(url)
                    }
                }) {
                    Image(systemName: "safari")
                        .font(.system(size: 15, weight: .semibold))
                }
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 8)
            .background(Color(UIColor.systemBackground))
            
            // Progress Bar
            if isLoading && estimatedProgress < 1.0 {
                ProgressView(value: estimatedProgress, total: 1.0)
                    .progressViewStyle(LinearProgressViewStyle(tint: Color(red: 0.14, green: 0.38, blue: 0.88)))
                    .frame(height: 2)
            } else {
                Divider()
            }
            
            // Native WKWebView
            WKWebViewRepresentable(
                webView: webView,
                initialURL: url,
                canGoBack: $canGoBack,
                canGoForward: $canGoForward,
                isLoading: $isLoading,
                estimatedProgress: $estimatedProgress
            )
        }
    }
}

private struct WKWebViewRepresentable: UIViewRepresentable {
    let webView: WKWebView
    let initialURL: URL
    @Binding var canGoBack: Bool
    @Binding var canGoForward: Bool
    @Binding var isLoading: Bool
    @Binding var estimatedProgress: Double
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> WKWebView {
        webView.navigationDelegate = context.coordinator
        webView.allowsBackForwardNavigationGestures = true
        
        context.coordinator.setupObservation(for: webView)
        
        let request = URLRequest(url: initialURL)
        webView.load(request)
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {}
    
    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WKWebViewRepresentable
        private var progressObservation: NSKeyValueObservation?
        
        init(_ parent: WKWebViewRepresentable) {
            self.parent = parent
        }
        
        func setupObservation(for webView: WKWebView) {
            progressObservation = webView.observe(\.estimatedProgress, options: [.new]) { [weak self] webView, _ in
                DispatchQueue.main.async {
                    self?.parent.estimatedProgress = webView.estimatedProgress
                    self?.parent.canGoBack = webView.canGoBack
                    self?.parent.canGoForward = webView.canGoForward
                }
            }
        }
        
        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            DispatchQueue.main.async {
                self.parent.isLoading = true
                self.parent.canGoBack = webView.canGoBack
                self.parent.canGoForward = webView.canGoForward
            }
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            DispatchQueue.main.async {
                self.parent.isLoading = false
                self.parent.canGoBack = webView.canGoBack
                self.parent.canGoForward = webView.canGoForward
            }
        }
        
        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            DispatchQueue.main.async {
                self.parent.isLoading = false
            }
        }
        
        deinit {
            progressObservation?.invalidate()
        }
    }
}
