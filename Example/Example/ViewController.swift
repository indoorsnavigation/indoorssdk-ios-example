//
//  ViewController.swift
//  Example
//
//  Created by Mac on 26.01.2023.
//

import UIKit
import IndoorsSDK

class ViewController: UIViewController {

	private var inApplication: INApplication!
	
	private lazy var map = INGlobalMapView(frame: self.view.bounds)
	
	override func viewDidLoad() {
		super.viewDidLoad()
		INCore.initialize(with: .default())
		setupConstraints()
		loadApplication()
	}

	func loadApplication() {
		INCore.sharedInstance().service.authorizeApplication(
			withClientId: "XxlIlEUxExc6hsUk0v7hOiTctyKicAD4RoRIYdJt",
			andClientSecret: "edELkEYTCWM36ufZv0emgIFPlYfxKHsLgPp7CXPJ8M2LnSap1BP2Bx3EuXrxtib1BH1hisSm6DwKNi80qA7GKbvORPB8L9flD5D5y7wAIrw2BdDlvfwBUARHtexLxWei")
		{ error in
			INCore.sharedInstance().service.loadApplications { applications, error in
				self.inApplication = (applications.firstObject as! INApplication)
				self.loadBuildings()
			}
		}
	}
	
	func loadBuildings() {
		let app = INCore.sharedInstance().service.currentApplication
		print("App name: \(app.name)")
		INCore.sharedInstance().service.loadBuildings(of: self.inApplication) { buildings, error in
			self.map.buildings = buildings
		}
	}
	
}

extension ViewController {
	func setupConstraints() {
		self.view.addSubview(map)
		
		NSLayoutConstraint.activate([
			NSLayoutConstraint(
				item: map,
				attribute: .top,
				relatedBy: .equal,
				toItem: self.view.safeAreaLayoutGuide,
				attribute: .top,
				multiplier: 1,
				constant: 0
			),
			NSLayoutConstraint(
				item: map,
				attribute: .bottom,
				relatedBy: .equal,
				toItem: self.view.safeAreaLayoutGuide,
				attribute: .bottom,
				multiplier: 1,
				constant: 0
			),
			NSLayoutConstraint(
				item: map,
				attribute: .leading,
				relatedBy: .equal,
				toItem: self.view.safeAreaLayoutGuide,
				attribute: .leading,
				multiplier: 1,
				constant: 0
			),
			NSLayoutConstraint(
				item: map,
				attribute: .trailing,
				relatedBy: .equal,
				toItem: self.view.safeAreaLayoutGuide,
				attribute: .trailing,
				multiplier: 1,
				constant: 0
			),
		])
	}
}

