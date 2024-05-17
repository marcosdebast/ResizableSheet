//
//  FormSheetWrapper.swift
//  ResizableSheetWrapper
//
//  Created by Marcos Debastiani on 17/05/24.
//

import SwiftUI

class ResizableSheetWrapper<Content: View>: UIViewController, UIPopoverPresentationControllerDelegate {
    let width: CGFloat
    let height: CGFloat

    var content: () -> Content
    var onDismiss: (() -> Void)?
    
    private var hostVC: UIHostingController<Content>?
    
    required init?(coder: NSCoder) { fatalError("") }
    
    init(width: CGFloat, height: CGFloat, content: @escaping () -> Content) {
        self.width = width
        self.height = height
        self.content = content
        super.init(nibName: nil, bundle: nil)
    }
    
    func show() {
        guard hostVC == nil else { return }
        let vc = UIHostingController(rootView: content())
        
        vc.view.sizeToFit()
        vc.preferredContentSize = CGSize(width: width, height: height)
        
        vc.modalPresentationStyle = .formSheet
        vc.presentationController?.delegate = self
        hostVC = vc
        self.present(vc, animated: true, completion: nil)
    }
    
    func hide() {
        guard let vc = self.hostVC, !vc.isBeingDismissed else { return }
        dismiss(animated: true, completion: nil)
        hostVC = nil
    }
    
    func presentationControllerWillDismiss(_ presentationController: UIPresentationController) {
        hostVC = nil
        self.onDismiss?()
    }
}

struct ResizableSheet<Content: View> : UIViewControllerRepresentable {
    @Binding var show: Bool
    
    let width: CGFloat
    let height: CGFloat
    
    let content: () -> Content
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ResizableSheet<Content>>) -> ResizableSheetWrapper<Content> {
        let vc = ResizableSheetWrapper(width: width, height: height, content: content)
        vc.onDismiss = { self.show = false }
        return vc
    }
    
    func updateUIViewController(_ uiViewController: ResizableSheetWrapper<Content>, context: UIViewControllerRepresentableContext<ResizableSheet<Content>>) {
        if show {
            uiViewController.content = content
            uiViewController.show()
        } else {
            uiViewController.hide()
        }
    }
}

extension View {
    public func resizableSheet<Content: View>(isPresented: Binding<Bool>, width: CGFloat, height: CGFloat, @ViewBuilder content: @escaping () -> Content) -> some View {
        self.background(ResizableSheet(show: isPresented, width: width, height: height, content: content))
    }
}
