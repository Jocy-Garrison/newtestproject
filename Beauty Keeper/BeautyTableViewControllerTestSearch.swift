//
//  BeautyTableViewControllerTestSearch.swift
//  Beauty Keeper
//
//  Created by stephaniesheng on 15/8/12.
//  Copyright (c) 2015年 stephaniesheng. All rights reserved.
//

import UIKit

class BeautyTableViewControllerTestSearch: UITableViewController, UITableViewDataSource ,UISearchBarDelegate, UISearchDisplayDelegate  {
    var beauties = [Beauty]()
    var filteredBeauties = [Beauty]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //向BeautyArray中添加简单的数据
        self.beauties = [Beauty(category: "MAKEUP & FRAGRANCE", name:"BB Cream"),
            Beauty(category:"MOTHER & BABY", name:"Pregnancy Skin Care")
        ]
        
        // 不显示Search Bar边框
        self.searchDisplayController?.searchBar.searchBarStyle = UISearchBarStyle.Minimal

        // 显示分段条
        self.searchDisplayController?.searchBar.showsScopeBar = true
        self.searchDisplayController?.searchBar.scopeButtonTitles = ["All","Junior","Senior"]
        // refresh table
        self.tableView.reloadData()
        
    }
    

    //返回表格行数（也就是返回控件数）
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //让 tableView 知道什么时候使用过滤过的数据
        if tableView == self.searchDisplayController!.searchResultsTableView {
            return self.filteredBeauties.count
            
        } else {
            // 简单的告诉 tableView ，应该包含许多行
            return self.beauties.count
        }
    }

    //创建各单元显示内容(创建参数indexPath指定的单元）
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var beauty : Beauty
        //在tableview中查询一个元素／条目，如果没有创建一个。
        let cell = self.tableView.dequeueReusableCellWithIdentifier("Cell") as! UITableViewCell
        println("test1")
        // 检查标准table和搜索结果table是否正常显示，然后从beauty数据集查找需要的对象.如果确实是搜索table，则数据从 filteredBeauties 数组中获取。否则，数据从全部的项目中获取。
        if tableView == self.searchDisplayController!.searchResultsTableView {
            println("test2")
            beauty = filteredBeauties[indexPath.row]
            
        } else {
            println("test3")
            beauty = beauties[indexPath.row]
            
        }
        
        // 设置元素／条目
        cell.textLabel!.text = beauty.name
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        return cell

    }
    
    // mark: searchBar
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        // 使用 searchText （也就是你的搜索字符串） 过滤 beauties ，然后将结果放入filteredBeauties
        self.filteredBeauties = self.beauties.filter({( beauty: Beauty) -> Bool in
            
            let categoryMatch = (scope == "All") || (beauty.category == scope)
            //rangeOfString() 用于检查是否字符串包含要查找的字符串。如果是，则返回true，表明当前的化妆品包含在过滤的数组中；如果返回false则不包含
            let stringMatch = beauty.name.rangeOfString(searchText)
            return categoryMatch && (stringMatch != nil)
           
            
        })
    }
    
    // 当用户更改搜索的字符串时，方法被调用。
    func searchDisplayController(controller: UISearchDisplayController!, shouldReloadTableForSearchString searchString: String!) -> Bool {
        
        self.filterContentForSearchText(searchString)
        
        return true
        
    }
    
    //用于操作分类条的输入
    func searchDisplayController(controller: UISearchDisplayController!, shouldReloadTableForSearchScope searchOption: Int) -> Bool {
        
        self.filterContentForSearchText(self.searchDisplayController!.searchBar.text)
        
        return true
        
    }
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */


}