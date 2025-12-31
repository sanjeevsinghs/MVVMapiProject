//
//  ProductListViewController.swift
//  MVVMapiProject
//
//  Created by bd01 on 30/12/25.
//

import UIKit
import Kingfisher

class ProductListViewController: UIViewController {

    @IBOutlet weak var proTblViewO: UITableView!
    private var viewModel = ProductViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configuration()
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension ProductListViewController{
    
    func configuration(){
        proTblViewO.register(UINib(nibName: "ProductCell", bundle: nil), forCellReuseIdentifier: "ProductCell")
        initViewModel()
        observeEvent()
    }
    
    func initViewModel(){
        viewModel.fetchProducts()
    }
    
    // data binding -- communication
    func observeEvent(){
        viewModel.eventHandler = { [weak self] event in
            guard let self else { return }
            
            
            switch event {
            case .loading:
                //indicater show
                print ("Product loading....")
            case .stopLoading:
                //indicater hide
                print("Stop loading...")
            case .dataLoaded:
                print ("Data loaded...")
                print(self.viewModel.products)
                DispatchQueue.main.async {
                    self.proTblViewO.reloadData()
                }
            case .error(let error):
                print(error as Any)
            }
        }
    }
    
}

extension ProductListViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell") as? ProductCell else {
            return UITableViewCell()
        }
        let product = viewModel.products[indexPath.row]
        cell.product = product
//        cell.imgViewO.kf.setImage(with: URL(string: product.image))
        return cell
    }
    
    
}
