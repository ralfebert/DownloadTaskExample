import SwiftUI

struct DownloadQueueView: View {
    @ObservedObject var downloadManager = DownloadManager.shared
    @ObservedObject var backgroundMessages = DownloadBackgroundMessages.shared

    var body: some View {
        List {
            if let messages = backgroundMessages.messages {
                Button(messages) { backgroundMessages.messages = nil }
            }
            ForEach(downloadManager.tasks, id: \.taskIdentifier) { task in
                VStack(alignment: .leading, spacing: 8) {
                    Text(task.currentRequest?.url?.absoluteString ?? "-")
                    ProgressView(task.progress)
                }
            }
        }
        .navigationBarTitle("Downloads")
        .navigationBarItems(trailing: self.startDownloadButton)
    }

    @ViewBuilder var startDownloadButton: some View {
        Button(
            action: startDownload,
            label: {
                Image(systemName: "square.and.arrow.down")
            }
        )
    }

    func startDownload() {
        let url = URL(string: "https://scholar.princeton.edu/sites/default/files/oversize_pdf_test_0.pdf")!
        downloadManager.startDownload(url: url)
    }
}
