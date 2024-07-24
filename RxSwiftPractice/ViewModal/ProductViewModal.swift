//
//  ProductViewModal.swift
//  RxSwiftPractice
//
//  Created by Shivakumar Harijan on 24/07/24.
//

import Foundation
import RxSwift

struct ProductViewModel {
    var items = PublishSubject<[ProductList]>()
    
    func fetchItems() {
        let product = [
            ProductList(title: "Home", imagePic: "house"),
            ProductList(title: "Settings", imagePic: "gear"),
        ProductList(title: "Person", imagePic: "person"),
        ProductList(title: "Fly", imagePic: "airplane"),
        ProductList(title: "Notification", imagePic: "bell"),
        ProductList(title: "Favorite", imagePic: "star")
        ]
        
        items.onNext(product)
        items.onCompleted()
    }
}
