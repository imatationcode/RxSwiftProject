//
//  TabelScreenVC.swift
//  RxSwiftPractice
//
//  Created by Shivakumar Harijan on 24/07/24.
//

import UIKit
import RxSwift
import RxCocoa

class TabelScreenVC: UIViewController {
    let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    private var viewModel = ProductViewModel()
    private var bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        view.addSubview(tableView)
        tableView.frame = view.bounds
        bindTableData()
    }
    
    func bindTableData(){
        viewModel.items.bind(
            to: tableView.rx.items(
                cellIdentifier: "cell",
                cellType: UITableViewCell.self)
        ){ row, model, cell in
            cell.textLabel?.text = model.title
            cell.imageView?.image = UIImage(systemName: model.imagePic ?? "")
        }.disposed(by: bag)
        
        tableView.rx.modelSelected(ProductList.self)
            .bind { product in
                print(product.title!)
            }.disposed(by: bag)
        
        viewModel.fetchItems()
    }
}
