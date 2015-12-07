//
//  InstagramProfileController.swift
//  comblie
//
//  Created by Cal on 10/27/15.
//  Copyright © 2015 Comblie. All rights reserved.
//

import UIKit

class InstagramProfileController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var screenSize : CGSize!
    var itemsInRow : CGFloat!
    var spacesInRow : CGFloat!
    var totalItemSpace : CGFloat!
    var numberOfPhotos : CGFloat!
    var spacing : CGFloat!

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileImageBackground: UIView!
    @IBOutlet weak var gridContainer: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var gridContainerHeight: NSLayoutConstraint!
    @IBOutlet weak var header: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    
        override func viewDidLoad() {
        super.viewDidLoad()
            
            self.collectionView.dataSource = self
            self.collectionView.delegate = self
            
            self.spacing = 6
            self.numberOfPhotos = 17
            self.screenSize = UIScreen.mainScreen().bounds.size
        self.itemsInRow = 3
            self.spacesInRow = itemsInRow+1
            self.totalItemSpace = screenSize.width - (spacesInRow*spacing)
            
            let requiredRows = ceil(numberOfPhotos/itemsInRow)
            let calculatedGridHeight = requiredRows * (totalItemSpace/itemsInRow) + spacing*(requiredRows+1)
            self.gridContainerHeight.constant = calculatedGridHeight
            
            self.profileImage.layer.cornerRadius = CGFloat(self.profileImage.frame.height/2)
            self.profileImageBackground.layer.cornerRadius = CGFloat(self.profileImageBackground.frame.height/2)
            
    }
    
    override func viewDidAppear(animated: Bool) {
        self.scrollView.contentSize = CGSize(width: gridContainer.frame.width, height: gridContainer.frame.height + header.frame.height)
    }


    // MARK: UICollectionView
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return spacing
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return spacing
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: totalItemSpace/itemsInRow, height: totalItemSpace/itemsInRow)
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Int(numberOfPhotos)
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("photo", forIndexPath: indexPath) as! InstagramPhotoCell
        
        if (indexPath.row % 2 == 0) {
            cell.photoImage.image = UIImage(named: "vinebackground")
        }
        
        return cell
    }
    
    // MARK: Action
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        // Triggers when a photo is selected
        print("Selected Photo")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
