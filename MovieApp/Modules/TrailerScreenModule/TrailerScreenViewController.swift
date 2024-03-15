//
//  PlayerScreenViewController.swift
//  MovieApp
//
//  Created by Winter on 3/15/24.
//

import UIKit
import YouTubeiOSPlayerHelper

class TrailerScreenViewController: UIViewController {
    
    var presenter: TrailerScreenViewToPresenterProtocol?
    
    //Initialized Outlet
    @IBOutlet weak var trailerTableView: UITableView!
    @IBOutlet weak var playerView: YTPlayerView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    //Initialized Property
    var videoInfos: [VideoInfo] = [] {
        didSet {
            trailerTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        configureTableView()
        playerView.delegate = self
        
        if ConnectionService.isConnectedToNetwork() {
            if !videoInfos.isEmpty {
                activityIndicatorView.startAnimating()
                playerView.load(withVideoId: videoInfos.first?.key ?? "")
                trailerTableView.selectRow(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .top)
            } else {
                showToatMessage(Message.COULD_NOT_LOAD)
            }
        } else {
            showToatMessage(Message.NO_CONNECTION_MESSAGE)
        }
    }
    
    //Initialized Action
    @IBAction func onActionButtonClicked(_ sender: UIButton) {
        presenter?.onBackButtonClicked()
    }
    
    //Initialized Method
    private func configureTableView() {
        trailerTableView.delegate = self
        trailerTableView.dataSource = self
        trailerTableView.registerCell(TrailerTableViewCell.self)
    }
    
    private func showToatMessage(_ message: String) {
        self.view.makeToast(message, duration: 3.0, position: .bottom)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        playerView.stopVideo()
        super.viewDidDisappear(animated)
    }
}

// MARK: - Presenter -> View
extension TrailerScreenViewController: TrailerScreenPresenterToViewProtocol, YTPlayerViewDelegate {
    
    func showLoading(_ isLoading: Bool) {
        self.displayLoading(isLoading)
    }
    
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        self.activityIndicatorView.stopAnimating()
        self.playerView.isHidden = false
        playerView.playVideo()
    }
}

// MARK: - Tableview Delegate
extension TrailerScreenViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if ConnectionService.isConnectedToNetwork() {
            playerView.stopVideo()
            activityIndicatorView.startAnimating()
            activityIndicatorView.isHidden = false
            playerView.isHidden = true
            playerView.load(withVideoId: videoInfos[indexPath.row].key)
        } else {
            showToatMessage(Message.NO_CONNECTION_MESSAGE)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videoInfos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(TrailerTableViewCell.self, for: indexPath)
        cell.setData(videoInfos[indexPath.row], posterPath: presenter?.getPosterPath() ?? "")
        return cell
    }
    
}
