//
//  FirstViewController.swift
//  acgAR
//
//  Created by Konstantinos on 6/12/14.
//  Copyright (c) 2014 Konstantinos Loutas. All rights reserved.
//

import UIKit

class ARViewController: UIViewController {
    
    // Sample Location Data Table
    let arData = [
        ["id": "0", "title": "DEREE Gym", "lat": "38.005774", "lon": "23.833771"],
        ["id": "1", "title": "DEREE Library", "lat": "38.005060", "lon": "23.833697"],
        ["id": "2", "title": "DEREE Student Lounge", "lat": "38.004907", "lon": "23.833017"],
        ["id": "3", "title": "DEREE CN Building", "lat": "38.001973", "lon": "23.829602"]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Starting the PRARManager
        PRARManager.sharedManagerWithRadarAndSize(self.view.frame.size, andDelegate: self)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        // Emulate current location
        let currentLocationCoordinates = CLLocationCoordinate2DMake(38.005093, 23.833988)
        
        // Start PRARManager with our location data and current location
        PRARManager.sharedManager().startARWithData(self.arData, forLocation: currentLocationCoordinates)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Error displaying
    func alert(title:String, withDetails details:String) {
        var alert = UIAlertView(title: title, message: details, delegate: nil, cancelButtonTitle: "Ok")
        alert.show()
    }
    
}

// Implementing PRARManagerDelegate Conformance
extension ARViewController: PRARManagerDelegate {
    
    func prarDidSetupAR(arView:UIView, withCameraLayer cameraLayer:AVCaptureVideoPreviewLayer, andRadarView radar:UIView) {
        // Add arView and cameraLayer to current view
        self.view.layer.addSublayer(cameraLayer)
        self.view.addSubview(arView)
        
        // Make sure arView is the frontmost subview
        self.view.bringSubviewToFront(self.view.viewWithTag(Int(AR_VIEW_TAG)))
        
        // Add radar to current view
        self.view.addSubview(radar)
    }
    
    func prarUpdateFrame(arViewFrame:CGRect) {
        // Change the position of the arView based on how you are moving on
        let arView = self.view.viewWithTag(Int(AR_VIEW_TAG))
        arView.frame = arViewFrame
    }
    
    func prarGotProblem(problemTitle:String, withDetails problemDetails:String) {
        self.alert(problemTitle, withDetails: problemDetails)
    }
    
}