//
//  http.swift
//  shakeYourFood
//
//  Created by Daniel Lee on 2016/11/2.
//  Copyright © 2016年 sohoGroup. All rights reserved.
//

import Foundation

class httpWork: NSObject, URLSessionDelegate {
    
    private let siteString = "https://minithon2-b-team-back-end.herokuapp.com/api";
    private var taskArray : [URLSessionDataTask]? = [];
    
    //MARK: http request with uri parameters
    func httpRequestWithURLParam(withRoute route : String, HTTPMethod method:String, parameters paramDic : [String : String], callback : @escaping (_ data:Data?, _ res:URLResponse?, _ error:Error?)->Void) -> Void {
        
        
        var urlStr : String = siteString + route;
        
        //configure uri parameters
        var paramList : [String] = [];
        
        if paramDic.count>0
        {
            for param in paramDic
            {
                let tempStr = "\(param.key)=\(param.value)";
                paramList.append(tempStr);
            }
            
            let uriStr = paramList.joined(separator: "&");
            
            urlStr = urlStr + "?" + uriStr;
        }
        
        print("url : \(urlStr)");
        
        //configure request
        var request : URLRequest = URLRequest(url: URL(string: urlStr)!);
        request.httpMethod = method;
        
        
        //configure session
        let configuration:URLSessionConfiguration = URLSessionConfiguration.default
        
        let session:URLSession = URLSession(configuration: configuration)
        
        
        
        let newTask:URLSessionDataTask = session.dataTask(with: request) { (data, response, error)->Void in
            
            
            callback(data, response, error);
            
            print("res: \(response)");
            
                        
        }
        
        print("before : \(self.taskArray)");
        //Avoiding multiple tasks pending, cancel old task to release resources.
        if taskArray != nil
        {
            
            for task in taskArray!
            {
                task.cancel();
            }
            taskArray?.removeAll();
        }
        //Add task to pending Queue.
        self.taskArray?.append(newTask);
        
        print("pending task: \(self.taskArray)");
        
        newTask.resume();

        
        
    }
    
    
    //MARK: URL session delegate, not used for now
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        
        
        //ssl tolerant
        if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust
        {
            let credential = URLCredential(trust: challenge.protectionSpace.serverTrust!);
            completionHandler(URLSession.AuthChallengeDisposition.useCredential, credential);
        }
    }
    
}
