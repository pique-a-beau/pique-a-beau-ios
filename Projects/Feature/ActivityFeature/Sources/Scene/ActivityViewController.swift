import BaseFeature
import DeviceActivity
import FamilyControls
import ManagedSettings
import SwiftUI
import UIKit

public final class ActivityViewController: BaseViewController {
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

struct ExampleView: View {
    @State var model: ActivityViewModel

    @State private var context: DeviceActivityReport.Context = .barGraph
    @State private var filter = DeviceActivityFilter(
        segment: .daily(
            during: Calendar.current.dateInterval(of: .weekOfYear, for: .now)!
        ),
//        users: .children,
        devices: .init([.iPhone])
    )

    var body: some View {
        VStack {
            DeviceActivityReport(
                DeviceActivityReport.Context(rawValue: "Total Activity"), // the context of your extension
                filter: DeviceActivityFilter(
                    segment: .daily(
                        during: Calendar.current.dateInterval(of: .weekOfYear, for: .now)!
                    ),
                    users: .all, // or .children
                    devices: .init([.iPhone]), // .iPad, .mac, .iPod are also available
                    applications: model.selection.applicationTokens,
                    categories: model.selection.categoryTokens,
                    webDomains: model.selection.webDomainTokens
                    // you can decide which kind of data to show - apps, categories, and/or web domains
                )
            )

            Picker(selection: $context, label: Text("Context: ")) {
                Text("Bar Graph")
                    .tag(DeviceActivityReport.Context.barGraph)

                Text("Pie Chart")
                    .tag(DeviceActivityReport.Context.pieChart)
            }
        }
    }

    private func formantTime(form duration: TimeInterval) -> String? {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .short
        return formatter.string(from: duration)
    }
}

extension DeviceActivityReport.Context {
    static let barGraph = Self("barGraph")
    static let pieChart = Self("pieChart")
}
