//
//  TextFieldAlertModifier.swift
//  CheckList2
//
//  Created by Vlad Kerov on 10.06.2022.
//

import Foundation
import SwiftUI

public struct TextFieldAlertModifier: ViewModifier {

    @State private var alertController: UIAlertController?

    @Binding var isPresented: Bool

    let title: String
    let text: String
    let placeholder: String
    let action: (String?) -> Void

    public func body(content: Content) -> some View {
        content.onChange(of: isPresented) { isPresented in
            if isPresented, alertController == nil {
                let alertController = makeAlertController()
                self.alertController = alertController
                guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
                    return
                }
                scene.windows.first?.rootViewController?.present(alertController, animated: true)
            } else if !isPresented, let alertController = alertController {
                alertController.dismiss(animated: true)
                self.alertController = nil
            }
        }
    }

    private func makeAlertController() -> UIAlertController {
        let controller = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        controller.addTextField {
            $0.placeholder = self.placeholder
            $0.text = self.text
        }
        controller.addAction(UIAlertAction(title: "Cancel", style: .cancel) { _ in
            self.action(nil)
            shutdown()
        })
        controller.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            self.action(controller.textFields?.first?.text)
            shutdown()
        })
        return controller
    }

    private func shutdown() {
        isPresented = false
        alertController = nil
    }

}
