//
//  RunLogVC.swift
//  RunTracker
//
//  Created by Miguel Santos on 12/10/2017.
//  Copyright © 2017 Miguel Santos. All rights reserved.
//

import UIKit

class RunLogVC: UIViewController{

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

    }

}

extension RunLogVC: UITableViewDelegate, UITableViewDataSource {

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Run.getAllRuns()?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "RunLogCell") as? RunLogCell {
            guard let run = Run.getAllRuns()?[indexPath.row] else {
                return RunLogCell()
            }
            cell.configure(run: run)
            return cell
            
        } else {
            return RunLogCell()
        }
        
    }
    
}

