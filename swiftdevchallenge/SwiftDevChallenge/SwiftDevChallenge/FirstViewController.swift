//
//  FirstViewController.swift
//  SwiftDevChallenge
//
//  Created by Das on 11/22/19.
//  Copyright © 2019 Arunabh Das. All rights reserved.
//

import UIKit
import RxSwift

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    private let selectedCharacterVariable = Variable("User")
    
    
    var selectedCharacter: Observable<String> {
        return selectedCharacterVariable.asObservable()
    }
    
    var tableView: UITableView!
    private let headerId = "headerId"
    private let footerId = "footerId"
    private let cellIdentifier = "CupcakeItemCell"
    
    var placesResponse: PlacesResponse!
    
    var predictionsList: [Prediction] = [Prediction]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
    }
    
    var searchTextField: UITextField!
    
    var searchUrlString: String! = Constants.Endpoints.kGetNearbyPlaces
    
    var searchString: String! = "" {
        didSet {
            let escapedString = self.searchString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
            self.searchUrlString = "\(Constants.Endpoints.kGetNearbyPlaces)\(escapedString!)"
            fetchData(self.searchUrlString!)
            
        }
    }
    
    var suggestionSelected: Bool = false
    
    var selectedSuggestionString: String! = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("selectedCharacterVariable : \(selectedCharacterVariable)")

        self.navigationController?.navigationBar.isTranslucent = false
        

        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        
        //Text Label
        searchTextField = UITextField()
        searchTextField.backgroundColor = UIColor.lightGray
        searchTextField.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
        searchTextField.heightAnchor.constraint(equalToConstant: 100.0).isActive = true
        searchTextField.hint("Search")
        searchTextField.textAlignment = .center
        searchTextField.delegate = self
        
        //Stack View
        let stackView   = UIStackView(frame: CGRect(x: 0, y: -100, width: displayWidth, height: 100 + barHeight))
        stackView.axis  = NSLayoutConstraint.Axis.vertical
        stackView.distribution  = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing   = 16.0
        

        stackView.addArrangedSubview(searchTextField)
        stackView.translatesAutoresizingMaskIntoConstraints = false

        self.view.addSubview(stackView)

        //Constraints

        let marginTop = NSLayoutConstraint(item: stackView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 0)
        let marginLeft = NSLayoutConstraint(item: stackView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1.0, constant: 20)
        let marginRight = NSLayoutConstraint(item: stackView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1.0, constant: -20)
        let height = NSLayoutConstraint(item: stackView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100)
        NSLayoutConstraint.activate([marginTop, marginLeft, marginRight, height])
        
        // stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        // stackView.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true

        
        tableView = UITableView(frame: CGRect(x: 0, y: 100, width: displayWidth, height: displayHeight + barHeight))
        self.tableView.backgroundColor = UIColor.clear
        self.tableView.register(CupcakeItemCell.self, forCellReuseIdentifier: cellIdentifier)
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 400
        tableView.dataSource = self
        tableView.delegate = self
        self.view.addSubview(tableView)
        // stackView.addArrangedSubview(self.tableView)
        
    
        self.navigationItem.title = Constants.Titles.kTopNavTitle
        
        
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        keyboardToolbar.isTranslucent = false
        keyboardToolbar.barTintColor = UIColor.white

        let nextButton = UIBarButtonItem(title: Constants.Titles.kNextButtonTitle, style: .plain, target: self, action: #selector(nextButtonTapped))
        
        nextButton.tintColor = UIColor.red
        
        let leftFlexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let rightFlexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        keyboardToolbar.items = [leftFlexibleSpace, nextButton, rightFlexibleSpace]
        searchTextField.inputAccessoryView = keyboardToolbar

    }
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    @objc func nextButtonTapped() {
        
        displayAlertDialog(self.suggestionSelected)
        
    }
    
    
    func fetchData(_ searchFor: String) {

        
        guard let url = URL(string: searchFor) else {
            return
        }
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            
            do {
                self.placesResponse = try JSONDecoder().decode(PlacesResponse.self, from: data)
                self.predictionsList = self.placesResponse.predictions
                
            } catch let jsonErr {
                print("Error serializing json:", jsonErr)
            }
            
            }.resume()
    }
    
    func displayAlertDialog(_ isSuccess: Bool) {
            
        var alert: UIAlertController = UIAlertController()
        
        if (isSuccess) {
            alert = UIAlertController(title: Constants.Titles.kAlertSuccesTitle, message: Constants.Titles.kAlertSuccess, preferredStyle: .alert)
        } else {
            alert = UIAlertController(title: Constants.Titles.kAlertErrorTitle, message: Constants.Titles.kAlertError, preferredStyle: .alert)
        }
        

        alert.addAction(UIAlertAction(title: Constants.Titles.kAlertOkTitle, style: .default, handler: nil))

        self.present(alert, animated: true)
    }
    
    @IBAction func characterSelected(_ sender: UIButton) {
        guard let characterName = sender.titleLabel?.text else {
            return
        }
        selectedCharacterVariable.value = characterName
    }
    
    
    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return predictionsList.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CupcakeItemCell
        
        let prediction = self.predictionsList[indexPath.row]
        
        // create the attributed colour
        let attributedStringColor = [NSAttributedString.Key.foregroundColor : UIColor.white];
        // create the attributed string
        let attributedString = NSAttributedString(string:  prediction.predictionDescription, attributes: attributedStringColor)

        cell?.titleLabel.textColor = UIColor.black
        cell?.titleLabel?.text = String()
        
        cell?.title2Label.textColor = UIColor.black
        cell?.title2Label.text = String(prediction.structuredFormatting.mainText)
        
        cell?.subtitleLabel.textColor = UIColor.gray
        cell?.subtitleLabel?.text = String(prediction.predictionDescription)
        
        cell?.subtitle2Label.textColor = UIColor.gray
        
        cell?.subtitle3Label.textColor = UIColor.gray
        
        cell?.backgroundColor = UIColor.clear
        cell?.layoutSubviews()
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        guard let cell = cell as? CupcakeItemCell else { return }
    }
    

    
    // Override to support conditional editing of the table view.
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.suggestionSelected = true
        let prediction = self.predictionsList[indexPath.row]
        searchTextField.text = String(prediction.predictionDescription)
        
    }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // self.view.endEditing(true)
        
    }
    func textFieldDidEndEditing(_ textField: UITextField) {


    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        // textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
        guard let searchStr = self.searchTextField.text else { return }
        self.searchString = searchStr
        
    }
    
}
