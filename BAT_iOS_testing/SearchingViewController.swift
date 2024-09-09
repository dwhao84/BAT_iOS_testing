//
//  SearchingViewController.swift
//  BAT_iOS_testing
//
//  Created by Dawei Hao on 2024/9/9.
//

import UIKit

class SearchingViewController: UIViewController {
    
    let ubikeBtn: UIBarButtonItem = {
        let btn: UIBarButtonItem = UIBarButtonItem()
        btn.image = Images.youbike
        return btn
    } ()
    
    let grayLine: UIView = {
        let view: UIView = UIView()
        view.backgroundColor = Colors.hexStringToUIColor(hex: "#EBEBEB")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    } ()
    
    let tableView: UITableView = {
        let tableView: UITableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.rowHeight = 66
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    } ()
    
    var youbikeData: [Youbike] = []
    
    private let apiUrl: String = "https://tcgbusfs.blob.core.windows.net/dotapp/youbike/v2/youbike_immediate.json"
        
    enum NetworkError: Error {
        case wrongURL
        case requestFailed
        case decodeError
        case unexpectedStatusCode
        case noDataReceived
    }
        
    let menuView: MenuView = MenuView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchYoubikeData()
        print("Log into the SearchVC")
    }
    
    func fetchYoubikeData() {
        getYoubikeData(url: apiUrl) { result in
            switch result {
            case .success(let youbikeData):
                self.youbikeData = youbikeData.filter { $0.sna.contains("YouBike2.0_") }
                // If you have a UITableView, reload it here
                DispatchQueue.main.async {
                    self.tableView.reloadData() // Reload the table view
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getYoubikeData(url: String, completion: @escaping (Result<[Youbike], NetworkError>) -> Void) {
        // Use the URL passed to the function
        guard let url = URL(string: url) else {
            completion(.failure(.wrongURL))
            return
        }
        
        // Create the data task
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Network error: \(error.localizedDescription)")
                completion(.failure(.requestFailed))
                return
            }
            
            // Check if data is received
            guard let data = data else {
                print("No data received")
                completion(.failure(.noDataReceived))
                return
            }
            
            // Decode the data
            do {
                let decoder = JSONDecoder()
                let youbike = try decoder.decode([Youbike].self, from: data)
                self.youbikeData = youbike // Store decoded data
                print("Decoded data: \(youbike)")
                completion(.success(youbike)) // Return the decoded data through the completion handler
            } catch {
                print("Decoding error: \(error)")
                completion(.failure(.decodeError))
            }
        }.resume() // Don't forget to start the task!
    }
    
    func setupUI () {
        self.view.backgroundColor = Colors.white
        configNavigationView()
        addConstraints()
        configTableView()
    }
    
    func configNavigationView() {
        // Resize the image to make it smaller
        let resizedImage = resizeImage(image: Images.list, targetSize: CGSize(width: 30, height: 30))
        // Create a UIBarButtonItem using the resized image
        let listBarButton = UIBarButtonItem(image: resizedImage, style: .plain, target: self, action: #selector(listBtnTapped))
        listBarButton.tintColor = Colors.hexStringToUIColor(hex: "#B5CC22")

        // Assign the UIBarButtonItem to the navigation item's rightBarButtonItem
        self.navigationItem.rightBarButtonItem = listBarButton
    }

    // Helper function to resize the image
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size

        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height

        // Determine the scale factor to maintain the aspect ratio
        let scaleFactor = min(widthRatio, heightRatio)
        
        let newSize = CGSize(width: size.width * scaleFactor, height: size.height * scaleFactor)
        let renderer = UIGraphicsImageRenderer(size: newSize)
        
        // Resize the image using the renderer
        let resizedImage = renderer.image { _ in
            image.draw(in: CGRect(origin: .zero, size: newSize))
        }
        return resizedImage
    }

    
    func addConstraints () {
        self.view.addSubview(tableView)
        self.view.addSubview(grayLine)
        NSLayoutConstraint.activate([
            grayLine.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            grayLine.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            grayLine.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            grayLine.heightAnchor.constraint(equalToConstant: 1),
            
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20)
        ])
    }
    
    func configTableView () {
        tableView.register(BikeInfoTableViewCell.self, forCellReuseIdentifier: BikeInfoTableViewCell.identifier)
        tableView.register(BikeTopInfoTableViewCell.self, forCellReuseIdentifier: BikeTopInfoTableViewCell.identifier)
        tableView.rowHeight = 66
        tableView.delegate   = self
        tableView.dataSource = self
        tableView.separatorColor = .clear
        tableView.backgroundColor = Colors.white
    }
    
    
    // MARK: - Actions
    @objc func listBtnTapped () {
        print("listBtnTapped")
        let menuView: MenuView = MenuView()
        self.view.addSubview(menuView)
        menuView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            menuView.topAnchor.constraint(equalTo: self.view.topAnchor),
            menuView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            menuView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            menuView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
}

extension SearchingViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: numberOfSections
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2  // Showing one line.
    }
    
    // MARK: numberOfRowsInSection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            print("youbikeData: \(youbikeData.count)")
            return youbikeData.count
        }
    }
    
    // MARK: cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            // 配置第一行使用 BikeTopInfoTableViewCell
            let cell = tableView.dequeueReusableCell(withIdentifier: BikeTopInfoTableViewCell.identifier, for: indexPath) as! BikeTopInfoTableViewCell
            cell.contentView.backgroundColor = Colors.hexStringToUIColor(hex: "#B5CC22")
            cell.cityLabel.text        = "縣市"
            cell.districtLabel.text    = "區域"
            cell.stationNameLabel.text = "站點名稱"
            cell.cityLabel.font = UIFont.boldSystemFont(ofSize: 16)
            cell.districtLabel.font = UIFont.boldSystemFont(ofSize: 16)
            cell.stationNameLabel.font = UIFont.boldSystemFont(ofSize: 16)
            cell.cityLabel.textColor = Colors.white
            cell.districtLabel.textColor = Colors.white
            cell.stationNameLabel.textColor = Colors.white
            return cell
        }
        
        // 配置其他行使用 BikeInfoTableViewCell
        let cell = tableView.dequeueReusableCell(withIdentifier: BikeInfoTableViewCell.identifier, for: indexPath) as! BikeInfoTableViewCell
        let data = youbikeData[indexPath.row]
        let modifiedSna = data.sna.replacingOccurrences(of: "YouBike2.0_", with: "")
        // 配置每個行的內容
        cell.cityLabel.text        = "台北市"
        cell.districtLabel.text    = data.sarea
        cell.stationNameLabel.text = modifiedSna
        
        // 偶數行與奇數行的背景顏色設置
        if indexPath.row % 2 != 0 {
            cell.contentView.backgroundColor = Colors.hexStringToUIColor(hex: "#F6F6F6")
            print("indexPath.row \(indexPath.row)")
        } else {
            cell.contentView.backgroundColor = Colors.white
            print("indexPath.row \(indexPath.row)")
        }
        
        // 設置字體顏色
        cell.cityLabel.textColor        = Colors.darkGray
        cell.districtLabel.textColor    = Colors.darkGray
        cell.stationNameLabel.textColor = Colors.darkGray
        
        cell.isSelected = false
        return cell
    }

    // MARK: didSelectRowAt
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("indexPath.row: \(indexPath.row)")
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let headerView = UIView()
            headerView.backgroundColor = Colors.white
            // 創建一個UILabel作為header的標題
            let headerLabel = UILabel()
            headerLabel.textColor = Colors.hexStringToUIColor(hex: "#B5CC22")
            headerLabel.font = UIFont.boldSystemFont(ofSize: 18)
            headerLabel.text = "站點資訊"
            headerLabel.frame = CGRect(x: 0, y: 15, width: tableView.frame.width - 32, height: 24)

            // 將標題label添加到header view
            headerView.addSubview(headerLabel)
            return headerView
        }
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return 0.0
        } else {
            return 50.0 // 設定區段標題的高度
        }
    }
}

#Preview {
    UINavigationController(rootViewController: SearchingViewController())
}
