//
//  ViewController.swift
//  Parsing-Json-Using-Bundle
//
//  Created by Tsering Lama on 11/5/20.
//

import UIKit

class ViewController: UIViewController {
    
    enum Section {
        case main
    }

    @IBOutlet weak var tableView: UITableView!
    
    typealias DataSource = UITableViewDiffableDataSource<Section, President>
    
    private var dataSource: DataSource!  // section and presidents needs to be hashable
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        configureDataSource()
        fetchPresident()
    }
    
    private func configureDataSource() {
        dataSource = DataSource(tableView: tableView, cellProvider: { (tableView, indexPath, president) -> UITableViewCell? in
            // configure cell
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = president.name
            cell.detailTextLabel?.text = "\(president.number)"
            return cell
        })
        
        // setup intial snapshot
        var snapshot = NSDiffableDataSourceSnapshot<Section, President>()
        snapshot.appendSections([.main])
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    private func fetchPresident() {
        var president: [President] = []
        do {
            president = try Bundle.main.parseJSON(name: "presidents")
        } catch {
            print("error: \(error)")
        }
        
        // update the snapshot
        var snapshot = dataSource.snapshot()
        snapshot.appendItems(president, toSection: .main)
        dataSource.apply(snapshot, animatingDifferences: true)
    }


}

