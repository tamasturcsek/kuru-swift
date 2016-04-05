//
//  RestApiManager.swift
//  kuru-swift
//
//  Created by Tamas Turcsek on 26/03/16.
//  Copyright © 2016 Meruem Software. All rights reserved.
//

// MARK: Using NSURLSession
using UIKit

// Get first post
let postEndpoint: String = "http://jsonplaceholder.typicode.com/posts/1"
guard let url = NSURL(string: postEndpoint) else {
    print("Error: cannot create URL")
    return
}
let urlRequest = NSURLRequest(URL: url)

let config = NSURLSessionConfiguration.defaultSessionConfiguration()
let session = NSURLSession(configuration: config)

let task = session.dataTaskWithRequest(urlRequest, completionHandler: { (data, response, error) in
    guard let responseData = data else {
        print("Error: did not receive data")
        return
    }
    guard error == nil else {
        print("error calling GET on /posts/1")
        print(error)
        return
    }
    // parse the result as JSON, since that's what the API provides
    let post: NSDictionary
    do {
        post = try NSJSONSerialization.JSONObjectWithData(responseData,
            options: []) as! NSDictionary
    } catch  {
        print("error trying to convert data to JSON")
        return
    }
    // now we have the post, let's just print it to prove we can access it
    print("The post is: " + post.description)
    
    // the post object is a dictionary
    // so we just access the title using the "title" key
    // so check for a title and print it if we have one
    if let postTitle = post["title"] as? String {
        print("The title is: " + postTitle)
    }
})
task.resume()

// Create new post
let postsEndpoint: String = "http://jsonplaceholder.typicode.com/posts"
guard let postsURL = NSURL(string: postsEndpoint) else {
    print("Error: cannot create URL")
    return
}
postsUrlRequest.HTTPMethod = "POST"

let newPost: NSDictionary = ["title": "Frist Psot", "body": "I iz fisrt", "userId": 1]
do {
    let jsonPost = try NSJSONSerialization.dataWithJSONObject(newPost, options: [])
    postsUrlRequest.HTTPBody = jsonPost
    
    let config = NSURLSessionConfiguration.defaultSessionConfiguration()
    let session = NSURLSession(configuration: config)
    
    let createTask = session.dataTaskWithRequest(postsUrlRequest, completionHandler: {
        (data, response, error) in
        guard let responseData = data else {
            print("Error: did not receive data")
            return
        }
        guard error == nil else {
            print("error calling GET on /posts/1")
            print(error)
            return
        }
        
        // parse the result as json, since that's what the API provides
        let post = JSON(data: responseData)
        if let postID = post["id"].int {
            print("The post ID is \(postID)")
        }
    })
    createTask.resume()
} catch {
    print("Error: cannot create JSON from post")
}

// Delete first post
let firstPostEndpoint: String = "http://jsonplaceholder.typicode.com/posts/1"
let firstPostUrlRequest = NSMutableURLRequest(URL: NSURL(string: firstPostEndpoint)!)
firstPostUrlRequest.HTTPMethod = "DELETE"

let deleteTask = session.dataTaskWithRequest(firstPostUrlRequest, completionHandler: {
    (data, response, error) in
    guard let _ = data else {
        print("error calling DELETE on /posts/1")
        return
    }
})
deleteTask.resume()

// MARK: Using Alamofire

// Get first post
let postEndpoint: String = "http://jsonplaceholder.typicode.com/posts/1"
Alamofire.request(.GET, postEndpoint)
    .responseJSON { response in
        guard response.result.error == nil else {
            // got an error in getting the data, need to handle it
            print("error calling GET on /posts/1")
            print(response.result.error!)
            return
        }
        
        if let value: AnyObject = response.result.value {
            // handle the results as JSON, without a bunch of nested if loops
            let post = JSON(value)
            // now we have the results, let's just print them though a tableview would definitely be better UI:
            print("The post is: " + post.description)
            if let title = post["title"].string {
                // to access a field:
                print("The title is: " + title)
            } else {
                print("error parsing /posts/1")
            }
        }
}

// Create new post
let postsEndpoint: String = "http://jsonplaceholder.typicode.com/posts"
let newPost = ["title": "Frist Psot", "body": "I iz fisrt", "userId": 1]
Alamofire.request(.POST, postsEndpoint, parameters: newPost, encoding: .JSON)
    .responseJSON { response in
        guard response.result.error == nil else {
            // got an error in getting the data, need to handle it
            print("error calling GET on /posts/1")
            print(response.result.error!)
            return
        }
        
        if let value: AnyObject = response.result.value {
            // handle the results as JSON, without a bunch of nested if loops
            let post = JSON(value)
            print("The post is: " + post.description)
        }
}

// Delete first post
let firstPostEndpoint: String = "http://jsonplaceholder.typicode.com/posts/1"
Alamofire.request(.DELETE, firstPostEndpoint)
    .responseJSON { response in
        if let error = response.result.error {
            // got an error while deleting, need to handle it
            print("error calling DELETE on /posts/1")
            print(error)
        }
}