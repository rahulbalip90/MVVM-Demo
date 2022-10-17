//
//  VideoDetailViewModel.swift
//  TouTubeList
//
//  Created by JustMac on 27/03/22.
//

import Foundation

class VideoDetailViewModel{
    
    var youTubeVideoDetail : VideoDetail = VideoDetail()
    var videoDetailResponce : ReactiveListener<Bool> = ReactiveListener(false)
    var videouUrl = ""
    
    init(url : String){
        videouUrl = url
    }
    
    func callDetailAPI(){
        NetworkManager().callDetailAPI(url: videouUrl) { result in
            do{
                let data = try JSONDecoder().decode(VideoDetail.self, from: result)
                self.youTubeVideoDetail = data
                self.videoDetailResponce.value = true
            }catch{
                
            }
            
        }
    }
    
    
    func getVideoLikeCount()-> String{
        let likeCount : Int = youTubeVideoDetail.result?.ratings.likes ?? 0
        let count = self.calculate(views: likeCount)
        let likeCountString : String = String(count)
        return likeCountString
    }
    
    func getVideoDisLikeCount()-> String{
        let disLikeCount : Int = youTubeVideoDetail.result?.ratings.dislikes ?? 0
        let count2 = self.calculate(views: disLikeCount)
        let disLikeCountString : String = String(count2)
        return disLikeCountString
    }
    
    func getViewCount() -> String{
        let viewCount : Int = youTubeVideoDetail.result?.views ?? 0
        let count = self.calculate(views: viewCount)
        let viewCountString : String = String(count)
        return viewCountString
    }
    
    
    func getVideoUpdatedOn()-> String{
        let updatedOn = youTubeVideoDetail.result?.uploadedAt ?? ""
        return updatedOn
    }
    
    func getChannelIcon() -> URL? {
        let url = (URL(string:youTubeVideoDetail.result?.channel.icon ?? ""))
        return url
    }
    
    func getChannelIcon() -> String {
        let channelName = youTubeVideoDetail.result?.channel.name
        return channelName ?? ""
    }
    
    func getNavBartitle()-> String{
        let title = youTubeVideoDetail.result?.url.components(separatedBy: "=").last ?? ""
        return title
    }
    
    func calculate(views : Int) -> Int{
        return views / 1000;
    }
    
}
