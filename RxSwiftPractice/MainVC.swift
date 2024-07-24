//
//  ViewController.swift
//  RxSwiftPractice
//
//  Created by Shivakumar Harijan on 16/07/24.
//

import UIKit
import RxSwift
import RxCocoa

class MainVC: UIViewController {
    let disposeBag = DisposeBag()
    @IBOutlet weak var userInputTextField: UITextField!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var countDownLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        printTimeInLabel()
        updateState()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tapGesture)
    }
    @objc func dismissKeyboard() {
      self.view.endEditing(true)
    }
    
    @IBAction func nectViewButtonTapped(_ sender: Any) {
        let tabelVC = TabelScreenVC()
        navigationController?.pushViewController(tabelVC, animated: true)
//        if let tableVC = storyboard?.instantiateViewController(withIdentifier: "TabelScreenVC") as? TabelScreenVC {
//            self.navigationController?.pushViewController(tableVC, animated: true)
//            print("Going to next screen")
//        }
    }
    
    
    func updateState(){
        let inputObservable = userInputTextField.rx.text.orEmpty.asObservable()
        
        inputObservable.map{ $0.count >= 3}
            .bind(to: submitButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        inputObservable.map { $0.count >= 3 ? self.userInputTextField.text : "Input Must be at least 3 characterLong"}
            .bind(to: timeLabel.rx.text)
            .disposed(by: disposeBag)
        
        submitButton.rx.tap
            .withLatestFrom(inputObservable)
            .subscribe(onNext: { text in
                print("Submitted text : \(text)")
            }).disposed(by: disposeBag)
    }
    
    
    func printTimeInLabel() {
        let observableVar = Observable<Int>
            .interval(.seconds(1), scheduler: MainScheduler.instance)

        observableVar.subscribe(onNext: { element in
            self.countDownLabel.text = String(element)

        }).disposed(by: disposeBag)
    }
}

