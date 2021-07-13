//
//  ViewController.swift
//  DownloadTaskExample
//
//  Created by Ralf Ebert on 13/02/2017.
//  Copyright © 2017 Example. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var progressView: UIProgressView!
    
    override func viewDidLoad() {
        let _ = DownloadManager.shared.activate()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DownloadManager.shared.onProgress = { (progress) in
            OperationQueue.main.addOperation {
                self.progressView.progress = progress
            }
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        DownloadManager.shared.onProgress = nil
    }

    @IBAction func startDownload(_ sender: Any) {
        let url = URL(string: "https://scholar.princeton.edu/sites/default/files/oversize_pdf_test_0.pdf")!
        let task = DownloadManager.shared.activate().downloadTask(with: url)
        task.resume()
    }

}
