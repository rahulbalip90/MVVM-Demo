//
//  VideoListingViewModel.swift
//  TouTubeList
//
//  Created by JustMac on 27/03/22.
//

import Foundation

class VideoListingViewModel{
    
    var youTubeList : YouTubeListData = YouTubeListData()
    var videoListModelShouldReload : ReactiveListener<Bool> = ReactiveListener(false)
    
    init(){
        
    }
    
    func callYouTubrListingAPI(){
        NetworkManager().callLitingAPI { (result) in
            
            do{
                let data = try JSONDecoder().decode(YouTubeListData.self, from: result)
                self.youTubeList = data
            }catch{
                print("Error")
            }

            self.videoListModelShouldReload.value = true
            
        }
    }
    
    
    func callSearchVideoAPI(searchText : String){
        NetworkManager().callSearchAPI(searchText: searchText) { result in
            do{
                let data = try JSONDecoder().decode(YouTubeSearchData.self, from: result)
                self.youTubeList.result?.videos?.removeAll()
                self.youTubeList.result?.videos = data.results
                self.videoListModelShouldReload.value = true
                print(data)
            }catch{
               print("Error")
            }
        }
    }
}

// UItableView Delegate & Data Source

extension VideoListingViewModel {
    func numberOfRows()-> Int{
        return youTubeList.result?.videos?.count ?? 0
    }
    
    func recordOnIndex(currentIndex : Int) -> Video{
        return (youTubeList.result?.videos?[currentIndex])!
    }
}
