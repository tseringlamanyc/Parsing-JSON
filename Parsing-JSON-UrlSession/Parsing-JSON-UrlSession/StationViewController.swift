//
//  ViewController.swift
//  Parsing-JSON-UrlSession
//
//  Created by Tsering Lama on 11/5/20.
//

import UIKit
import Combine

class StationViewController: UIViewController {
    
    enum Sections {
        case primary
    }
    
    let apiClient = APIClient()
    
    @IBOutlet weak var tableView: UITableView!
    
    typealias DataSource = UITableViewDiffableDataSource<Sections, Station>
    
    private var dataSource: DataSource!
    
    private var subscriptions: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Citi Bike Stations"
       // fetchData()
        fetchDataCombine()
        configureDataSource()
    }
    
    private func fetchData() {
        // Result type has 2 values (failure and success)
        apiClient.fetchData { [weak self] (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let stations):
                DispatchQueue.main.async {
                    self?.updateSnapshot(stations: stations)
                }
            }
        }
    }
    
    private func fetchDataCombine() {
        /*
         sink - receives values
         assign - binds a value to a property ot UI element
         */
        do {
            let _ = try apiClient.fetchData()
                .sink(receiveCompletion: { (completion) in
                    print(completion)
                }, receiveValue: { [weak self] (stations) in
                    self?.updateSnapshot(stations: stations)
                })
            // store subscription
                .store(in: &subscriptions)
        } catch {
            print(error)
        }
    }
    
    private func updateSnapshot(stations: [Station]) {
        var snapshot = dataSource.snapshot()
        snapshot.appendItems(stations, toSection: .primary)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    private func configureDataSource() {
        dataSource = DataSource(tableView: tableView, cellProvider: { (tableView, indexPath, station) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = "\(station.name)"
            cell.detailTextLabel?.text = "Capacity: \(station.capacity)"
            return cell
        })
        
        var snapshot = NSDiffableDataSourceSnapshot<Sections, Station>()
        snapshot.appendSections([.primary])
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

