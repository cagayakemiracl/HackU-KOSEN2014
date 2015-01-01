//
//  ViewController.swift
//  TestTableTweet
//
//  Created by 中原 啓雅 on 2015/01/01.
//  Copyright (c) 2015年 中原啓雅. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var NameOfMake = ["すっぴんメイク","めがねメイク","ヒゲメイク"]
    var ImageOfMake = ["hige.png","manome.png","nakahara.png"]
    var AuthorOfMake = ["Manome","Nakahara","Reon"]
    var UpdateOfMake = ["2015/01/01","2015/01/02","2015/01/11"]

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        tableView.delegate = self
        tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NameOfMake.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as CustomTableViewCell

        // Configure the cell...
        cell.nameLabel.text = NameOfMake[indexPath.row]
        cell.makeImageView.image = UIImage(named: ImageOfMake[indexPath.row])
        cell.authorLabel.text = AuthorOfMake[indexPath.row]
        cell.updateLabel.text = UpdateOfMake[indexPath.row]

        return cell
    }
}
