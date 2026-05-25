//
// Team Members: Aden Yu (adenyu@iu.edu)
// App Name: HikeTracker
//

import UIKit

class HikeListViewController: UITableViewController {

    var appDelegate: AppDelegate?
    var myDataManager: DataManager?

    func connectModel() {
        self.appDelegate = UIApplication.shared.delegate as? AppDelegate
        self.myDataManager = self.appDelegate?.myDataManager
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        connectModel()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        connectModel()
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myDataManager?.numberOfHikes() ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        var cell = tableView.dequeueReusableCell(withIdentifier: "HikeCell")

        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "HikeCell")
        }

        if let hike = myDataManager?.hike(at: indexPath.row) {
            cell?.textLabel?.text = hike.title
            cell?.detailTextLabel?.text = "\(hike.dateText) | \(hike.distanceText)"
        }

        return cell!
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        connectModel()

        myDataManager?.setCurrentIndex(indexPath.row)

        if let tabs = self.tabBarController?.viewControllers {
            for index in 0..<tabs.count {
                let vc = tabs[index]
                let screen = (vc as? UINavigationController)?.viewControllers.first ?? vc

                if let detailVC = screen as? HikeDetailViewController {
                    detailVC.loadViewIfNeeded()
                    detailVC.loadHikeDetails()
                    self.tabBarController?.selectedIndex = index
                }
            }
        }

        tableView.deselectRow(at: indexPath, animated: true)
    }
}
