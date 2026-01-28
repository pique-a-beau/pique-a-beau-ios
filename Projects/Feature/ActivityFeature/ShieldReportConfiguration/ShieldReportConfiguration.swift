//
//  ShieldReportConfiguration.swift
//  ShieldReportConfiguration
//
//  Created by 정명곤 on 8/30/25.
//

import DeviceActivity
import SwiftUI

@main
struct ShieldReportConfiguration: DeviceActivityReportExtension {
    var body: some DeviceActivityReportScene {
        // Create a report for each DeviceActivityReport.Context that your app supports.
        TotalActivityReport { totalActivity in
            TotalActivityView(totalActivity: totalActivity)
        }
        // Add more reports here...
    }
}
