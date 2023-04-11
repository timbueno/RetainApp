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
    case sheetView(SheetViewModel)
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
        SheetView(model: model)
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

@MainActor
class BuggedSheetViewModel: ObservableObject {
  @Published var myText = "My Text"
  
  deinit {
    print("### Deinit: SheetViewModel")
  }
}

struct BuggedSheetView: View {
  
  @ObservedObject var model: BuggedSheetViewModel
  
  var body: some View {
    // TextField("Placeholder", text: self.$model.myText)
    List {
      Section("Stuff") {
        TextField("Placeholder", text: self.$model.myText)
      }
    }
  }
}


struct BuggedContentView_Previews: PreviewProvider {
  static var previews: some View {
    BuggedContentView(model: .init())
  }
}

