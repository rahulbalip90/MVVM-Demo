//
//  VideoDetailVC.swift
//  TouTubeList
//
//  Created by JustMac on 27/03/22.
//

import UIKit
import YouTubePlayer
import Kingfisher

class VideoDetailVC: UIViewController {

    @IBOutlet weak var playerView : YouTubePlayerView!
    @IBOutlet weak var labelNavBarTitle: UILabel!
    @IBOutlet weak var labelViewCountUpdatedOn: UILabel!
    @IBOutlet weak var labelLike: UILabel!
    @IBOutlet weak var labelDislike: UILabel!
    @IBOutlet weak var textViewDescription: UITextView!
    @IBOutlet weak var youtuberImgView: UIImageView!
    @IBOutlet weak var youTuberName: UILabel!
    
    var passedURL:String?
    var viewModel : VideoDetailViewModel?
    
    static func loadFromNib() -> VideoDetailVC {
        let detailVC = VideoDetailVC(nibName: "VideoDetailVC", bundle: nil)
        return detailVC
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = VideoDetailViewModel.init(url: passedURL!)
        relaodData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.callDetailAPI()
    }
    
    func relaodData(){
        viewModel?.videoDetailResponce.bindAndFire { value in
            let video : String = self.viewModel!.getNavBartitle()
            self.playerView.loadVideoID(video)
            DispatchQueue.main.async {
                self.labelNavBarTitle.text = self.viewModel?.youTubeVideoDetail.result?.title
                
                self.labelLike.text = self.viewModel!.getVideoLikeCount() + " K"
                self.labelDislike.text = self.viewModel!.getVideoDisLikeCount() + " K"
                self.labelViewCountUpdatedOn.text = self.viewModel!.getViewCount() + " K Views" + "  .  " + self.viewModel!.getVideoUpdatedOn()
                self.textViewDescription.text =  self.viewModel?.youTubeVideoDetail.result?.resultDescription
                self.youtuberImgView.kf.indicatorType = .activity
                self.youtuberImgView.kf.setImage(with: self.viewModel!.getChannelIcon())
                self.youTuberName.text = self.viewModel!.getChannelIcon()
                self.youtuberImgView.layer.cornerRadius = 25
            }
        }
    }
    

    
    @IBAction func onClickBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
