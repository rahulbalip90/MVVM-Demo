//
//  NetworkManager.swift
//  TouTubeList
//
//  Created by JustMac on 27/03/22.
//

import Foundation
import ProgressHUD

class NetworkManager {
    
    func callLitingAPI(completionHandler:@escaping(Data) -> Void){
     
        ProgressHUD.show()
        let headers = [
            "X-RapidAPI-Host": "simple-youtube-search.p.rapidapi.com",
            "X-RapidAPI-Key": "8e0b2b4559msh7a3c0bda2e74ceap187208jsn6bff6adca544"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://simple-youtube-search.p.rapidapi.com/playlist?list=PLillGF-RfqbZ2ybcoD2OaabW2P7Ws8CWu")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            ProgressHUD.dismiss()
            if (error != nil) {
                print("error")
            } else {
                completionHandler(data!)
            }
        })
        dataTask.resume()
    }
    
    func callSearchAPI(searchText : String,completionHandler:@escaping(Data) -> Void){
        ProgressHUD.show()
        let headers = [
            "X-RapidAPI-Host": "simple-youtube-search.p.rapidapi.com",
            "X-RapidAPI-Key": "8e0b2b4559msh7a3c0bda2e74ceap187208jsn6bff6adca544"
        ]
        

        let request = NSMutableURLRequest(url: NSURL(string: "https://simple-youtube-search.p.rapidapi.com/search?query='\(searchText)'&type=video&safesearch=false")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            ProgressHUD.dismiss()
            if (error != nil) {
                print("error")
            } else {
                completionHandler(data!)
            }
        })

        dataTask.resume()
    }
    
    
    func callDetailAPI(url : String,completionHandler:@escaping(Data) -> Void){
        ProgressHUD.show()
        let headers = [
            "X-RapidAPI-Host": "simple-youtube-search.p.rapidapi.com",
            "X-RapidAPI-Key": "8e0b2b4559msh7a3c0bda2e74ceap187208jsn6bff6adca544"
        ]

        
        let tempUrl = "https://simple-youtube-search.p.rapidapi.com/video?search=" + url
        let request = NSMutableURLRequest(url: NSURL(string: tempUrl)! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            ProgressHUD.dismiss()
            if (error != nil) {
                print("error")
            } else {
                completionHandler(data!)
            }
        })

        dataTask.resume()
    }
}


