import DeviceActivity
import FamilyControls
import ManagedSettings
import ManagedSettingsUI
import SwiftUI

extension DeviceActivityName {
    static let daily = Self("daily")
}

extension ManagedSettingsStore.Name {
    static let social = Self("social")
}

let schedule = DeviceActivitySchedule(
    intervalStart: DateComponents(hour: 15, minute: 34),
    intervalEnd: DateComponents(hour: 15, minute: 35),
    repeats: true
)

class ScheduleModel {
    static func setSchedule() {
        print("Setting up the schedule")
    }
}

class MyMonitor: DeviceActivityMonitor {
    let model: ActivityViewModel
    let center: DeviceActivityCenter

    init(
        model: ActivityViewModel,
        center: DeviceActivityCenter
    ) {
        self.model = model
        self.center = center
    }

    override func intervalDidStart(for activity: DeviceActivityName) {
        super.intervalDidStart(for: activity)

        do {
            try center.startMonitoring(.daily, during: schedule)
        } catch {
            print("monitoring Error")
        }
    }

    override func intervalDidEnd(for activity: DeviceActivityName) {
        super.intervalDidEnd(for: activity)

        center.stopMonitoring()
    }
}
