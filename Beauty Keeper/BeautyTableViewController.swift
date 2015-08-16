//
//  BeautyTableViewController.swift
//  Beauty Keeper
//
//  Created by stephaniesheng on 15/8/11.
//  Copyright (c) 2015年 stephaniesheng. All rights reserved.
//

import UIKit

class BeautyTableViewController: UITableViewController, UISearchBarDelegate, UISearchDisplayDelegate {
    var beauties = [Beauty]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //向BeautyArray中添加简单的数据
        self.beauties = [Beauty(category: "MAKEUP & FRAGRANCE", name:"BB Cream"),
            Beauty(category: "MAKEUP & FRAGRANCE", name:"Blush & Bronzer"),
            Beauty(category: "MAKEUP & FRAGRANCE", name:"Body Mist"),
            Beauty(category: "SKIN & HAIR CARE", name:"Anti-Aging"),
            Beauty(category:"SKIN & HAIR CARE", name:"Antiperspirant"),
            Beauty(category:"SKIN & HAIR CARE", name:"Bath & Shower"),
            Beauty(category:"SKIN & HAIR CARE", name:"Body & Firming"),
            Beauty(category:"SKIN & HAIR CARE", name:"Body Treatment"),
            Beauty(category:"SKIN & HAIR CARE", name:"Cleanser"),
            Beauty(category:"MEN", name:"Aftershave"),
            Beauty(category:"MEN", name:"Fragrance"),
            Beauty(category:"MEN", name:"Hair Care"),
            Beauty(category:"MOTHER & BABY", name:"Baby Skin Care"),
            Beauty(category:"MOTHER & BABY", name:"Postpartum Skin Care"),
            Beauty(category:"MOTHER & BABY", name:"Pregnancy Skin Care")
        ]
        
        // refresh table
        self.tableView.reloadData()
        // 不显示Search Bar边框
        self.searchDisplayController?.searchBar.searchBarStyle = UISearchBarStyle.Minimal
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 添加控制表视图本身的功能:告诉 tableView ，应该包含许多行，而这个数量是你在 beauties 数组中确定的。
        return self.beauties.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // 在tableview中查询一个条目，如果没有创建一个。
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as!UITableViewCell
        
        // 从我们的糖果数组中获得相应的内容
        let beauty = self.beauties[indexPath.row]
        
        // 设置条目Configure the cell...
        cell.textLabel!.text = beauty.name
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        return cell
        
    } 
    
    
    // Mark: Search Bar
    var filteredBeauties = [Beauty]()
    
    func filterContentForSearchText(searchText: String, scope: String) {
        //使用 searchText （也就是你的搜索字符串） 过滤 beauties ，然后将结果放入 filteredCandies 。
        self.filteredBeauties = beauties.filter({( beauty: Beauty) -> Bool in
            
            let categoryMatch = (scope == "All") || (beauty.category == scope)
            
            let stringMatch = beauty.name.rangeOfString(searchText)
            
            return categoryMatch && (stringMatch != nil)
            
        })
        
    }
    
//    func searchDisplayController(controller: UISearchDisplayController!,
//        shouldReloadTableForSearchString searchString: String!) -> Bool {
//        //当用户输入一个搜索队列时中他们会调用过滤方法。当用户更改搜索的字符串时，方法将被调用。
//        self.filterContentForSearchText(controller, searchString )
//         
//        return true
//    }
//    
//    
//    
//    func searchDisplayController(controller: UISearchDisplayController!, shouldReloadTableForSearchScope searchOption: Int) -> Bool {
//        //用于操作分类条的输入，方法将被调用。
//        self.filterContentForSearchText(self.searchDisplayController!.searchBar.text)
//        
//        return true
//        
//    }
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
