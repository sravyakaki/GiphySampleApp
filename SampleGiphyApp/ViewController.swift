//
//  ViewController.swift
//  SampleGiphyApp
//
//  Created by Sravya Kaki on 11/27/20.
//  Copyright © 2020 Sravya Kaki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var network = GifHTTPCalls()
    var gifs = [Gif]()
    let child = SpinnerViewController()
    var gifDataPresent = false
    var spinner = UIActivityIndicatorView(style: .large)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setTableViewDelegates()
        createSpinnerView()
        trendingGifs()
    }
    
    
    
    func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.searchTextField.delegate = self
        searchBar.searchTextField.placeholder = "Whats your favorite gif?"
        searchBar.returnKeyType = .search
    }
    
   func searchGifs(for searchText: String) {
   // createSpinnerView()
        network.fetchGifs(searchTerm: searchText) { gifArray in
            if gifArray != nil {
                //self.gifDataPresent = true
                //removeSpinnerView()
                self.gifs = gifArray!.gifs
                self.tableView.reloadData()
                self.removeSpinnerView()
            }
        }
    }
    
    func trendingGifs() {
        network.displayTrendingGifs() { gifArray in
            if gifArray != nil {
                self.gifs = gifArray!.gifs
                self.tableView.reloadData()
                self.removeSpinnerView()
            }
            
        }
    }
    
    func createSpinnerView() {
//        let child = SpinnerViewController()
//
        
//        // add the spinner view controller
//       // child.displayActivityIndicator(shouldDisplay: true)
//        addChild(child)
//        child.view.frame = view.frame
//        view.addSubview(child.view)
//        child.didMove(toParent: self)
//
//        if gifDataPresent == true {
//            child.willMove(toParent: nil)
//            child.view.removeFromSuperview()
//            child.removeFromParent()        }


        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        view.addSubview(spinner)

        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

      
    }
    
    func removeSpinnerView() {
//        let child = SpinnerViewController()
//
//        // wait two seconds to simulate some work happening
//        //child.displayActivityIndicator(shouldDisplay: false)
//
////              DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                  // then remove the spinner view controller
//                  child.willMove(toParent: nil)
//                  child.view.removeFromSuperview()
//                  child.removeFromParent()
////              }
//    }
        UIView.animate(withDuration: 0.2, animations: {
                       self.spinner.stopAnimating()
                   }) { (finished) in
                       self.spinner.removeFromSuperview()
                   }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return gifs.count
       }
       func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 200
       }
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "gifTableViewCell") as! GifTableViewCell
        cell.gif = gifs[indexPath.row]
           return cell
       }
   }

extension ViewController: UISearchTextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField.text != nil {
createSpinnerView()
            searchGifs(for: textField.text!)
        }
        return true
    }
}

