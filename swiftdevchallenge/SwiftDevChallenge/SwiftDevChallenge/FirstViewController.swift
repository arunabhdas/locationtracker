//
//  FirstViewController.swift
//  SwiftDevChallenge
//
//  Created by Das on 11/22/19.
//  Copyright © 2019 Arunabh Das. All rights reserved.
//

import UIKit
import RxSwift

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let selectedCharacterVariable = Variable("User")
    
    
    var selectedCharacter: Observable<String> {
        return selectedCharacterVariable.asObservable()
    }
    
    var tableView: UITableView!
    private let headerId = "headerId"
    private let footerId = "footerId"
    private let cellIdentifier = "CupcakeItemCell"
    
    
    var placesList: [Place] = [Place]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                // self.view.hideToastActivity()
            }
            
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("selectedCharacterVariable : \(selectedCharacterVariable)")

        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.isTranslucent = false
        // view.backgroundColor = Constants.Colors.colorPrintexZero
        
        title = "Portfolio"
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        
        //Text Label
        let textLabel = UITextField()
        textLabel.backgroundColor = UIColor.lightGray
        textLabel.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
        textLabel.heightAnchor.constraint(equalToConstant: 100.0).isActive = true
        textLabel.hint("Search")
        textLabel.textAlignment = .center
        
        //Stack View
        let stackView   = UIStackView(frame: CGRect(x: 0, y: -100, width: displayWidth, height: 100 + barHeight))
        stackView.axis  = NSLayoutConstraint.Axis.vertical
        stackView.distribution  = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing   = 16.0
        

        stackView.addArrangedSubview(textLabel)
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
        
    
        self.navigationItem.title = "Cover iOS Dev Challenge"
        
        // self.navigationController?.navigationBar.topItem?.title = "Your Transactions"
        // self.navigationItem.title = "Your Transactions";
        
        /*
        let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 100.0))
        self.view.addSubview(navBar);address
        let navItem = UINavigationItem(title: "Your Transactions");
    
        navBar.setItems([navItem], animated: true);
        */

        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
        setupData()

    }
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    
    func setupData() {
        let transactionOne: Place = Place(title: "Title of Place1", description: "Description of Place1", address: "10/20/2019")
        let transactionTwo: Place = Place(title: "Title of Place2", description: "Description of Place2", address: "10/20/2019")
        let transactionThree: Place = Place(title: "Title of Place3", description: "Description of Place3", address: "10/20/2019")
        let transactionFour: Place = Place(title: "Title of Place4", description: "Description of Place4", address: "10/20/2019")
        
        placesList.append(transactionOne)
        placesList.append(transactionTwo)
        placesList.append(transactionThree)
        placesList.append(transactionFour)
    }
    
    @IBAction func characterSelected(_ sender: UIButton) {
        guard let characterName = sender.titleLabel?.text else {
            return
        }
        selectedCharacterVariable.value = characterName
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return placesList.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CupcakeItemCell
        
        let transaction = self.placesList[indexPath.row]
        
        // create the attributed colour
        let attributedStringColor = [NSAttributedString.Key.foregroundColor : UIColor.white];
        // create the attributed string
        let attributedString = NSAttributedString(string:  transaction.title, attributes: attributedStringColor)
        // Set the label
        
        // cell?.iconView.sd_setImage(with: URL(string: squash.title), placeholderImage: UIImage(named: Constants.AssetNames.kAssetIcon))
        
        // cell?.indexLabel.textColor = UIColor.gray
        // cell?.indexLabel.text = transaction.title
        
        cell?.titleLabel.textColor = UIColor.black
        cell?.titleLabel?.text = String()
        
        cell?.title2Label.textColor = UIColor.black
        cell?.title2Label.text = String(transaction.title)
        
        cell?.subtitleLabel.textColor = UIColor.gray
        cell?.subtitleLabel?.text = String(transaction.description)
        
        cell?.subtitle2Label.textColor = UIColor.gray
        // cell?.subtitle2Label.text = String(squash.squashMatchTime)
        
        // var gameDateTime = "\(squash.squashMatchDate) \(squash.squashMatchTime)"
        // cell?.actionButton.setTitle(gameDateTime, for: UIControl.State.normal)
        
        cell?.subtitle3Label.textColor = UIColor.gray
        cell?.subtitle3Label?.text = String(transaction.address)
        
        cell?.backgroundColor = UIColor.clear
        cell?.layoutSubviews()
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // super.tableView(tableView, willDisplay: cell, forRowAt: indexPath)
        guard let cell = cell as? CupcakeItemCell else { return }
    }
    

    
    // Override to support conditional editing of the table view.
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
