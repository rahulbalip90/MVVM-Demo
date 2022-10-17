//
//  VideoListingVC.swift
//  TouTubeList
//
//  Created by JustMac on 27/03/22.
//

import UIKit

class VideoListingVC: UIViewController {
    
    @IBOutlet weak var searhBarView: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel = VideoListingViewModel()
    
    
    static func loadFromNib() -> VideoListingVC {
        let listingVC = VideoListingVC(nibName: "VideoListingVC", bundle: nil)
        return listingVC
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindTableView()
        searhBarView.delegate  = self
        viewModel.videoListModelShouldReload.bindAndFire { value in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.callYouTubrListingAPI()
    }
    
    func bindTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: videoTableViewCell.cellId(), bundle: nil), forCellReuseIdentifier: videoTableViewCell.cellId())
    }
    

}

extension VideoListingVC : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: videoTableViewCell.cellId(), for: indexPath) as! videoTableViewCell
        cell.bindData(data: viewModel.recordOnIndex(currentIndex: indexPath.row))
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = VideoDetailVC.loadFromNib()
        detailVC.passedURL = viewModel.recordOnIndex(currentIndex: indexPath.row).url ?? ""
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension VideoListingVC : UISearchBarDelegate{
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.callSearchVideoAPI(searchText: searchBar.text!)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.callSearchVideoAPI(searchText: searchBar.text!)
    }
}
