//
//  ProductViewModal.swift
//  RxSwiftPractice
//
//  Created by Shivakumar Harijan on 24/07/24.
//

import Foundation
import RxSwift
import Alamofire

struct ProductViewModel {
//    var items = PublishSubject<[ProductList]>()
    var results = PublishSubject<[Result]>()
    
    func fetchMovieResult() {
        AF.request(apiURL)
            .responseDecodable(of: MovieData.self){ response in
                switch response.result {
                case .success(let data):
                    self.results.onNext(data.results ?? [])
                    print(data)
                case .failure(let error):
                    print("Error in retriving \(error)")
                }
            }
    }
    
//    func fetchItems() {
//        let product = [
//            ProductList(title: "Home", imagePic: "house"),
//            ProductList(title: "Settings", imagePic: "gear"),
//            ProductList(title: "Person", imagePic: "person"),
//            ProductList(title: "Fly", imagePic: "airplane"),
//            ProductList(title: "Notification", imagePic: "bell"),
//            ProductList(title: "Favorite", imagePic: "star")
//        ]
//        items.onNext(product)
//        items.onCompleted()
//    }
}
