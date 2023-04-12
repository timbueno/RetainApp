//
//  ContentView.swift
//  RetainApp
//
//  Created by Tim Bueno on 4/11/23.
//

import CasePaths
import SwiftUI
import SwiftUINavigation

@MainActor
class BuggedContentViewModel: ObservableObject {
  
  @Published var destination: Destination?
  
  enum Destination {
    case sheetView(BuggedSheetViewModel)
  }
  
  func tappedPresent() {
    self.destination = .sheetView(.init())
  }
  
  func tappedDismiss() {
    self.destination = nil
  }
}

struct BuggedContentView: View {
  
  @ObservedObject var model: BuggedContentViewModel
  
  var body: some View {
    Button("Present") {
      self.model.tappedPresent()
    }
    .sheet(unwrapping: self.$model.destination, case: /BuggedContentViewModel.Destination.sheetView) { $model in
      NavigationView {
        BuggedSheetView(model: model)
          .toolbar {
            ToolbarItem(placement: .cancellationAction) {
              Button("Cancel") {
                self.model.tappedDismiss()
              }
            }
          }
      }
    }
  }
}

class BuggedSheetViewModel: ObservableObject {
  
  @Published var myText = "Text"
  @Published var id = UUID()
  
  deinit {
    print("### Deinit: BuggedSheetViewModel \(self.id.uuidString)")
  }
}

struct BuggedSheetView: View {
  
  @ObservedObject var model: BuggedSheetViewModel
  
  var body: some View {
    Form {
      Section("My Section") {
        TextField("Placeholder", text: self.$model.myText)
        Text(self.model.id.uuidString)
      }
    }
  }
}




struct BuggedContentView_Previews: PreviewProvider {
  static var previews: some View {
    BuggedContentView(model: .init())
  }
}

