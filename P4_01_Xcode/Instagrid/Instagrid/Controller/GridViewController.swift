//
//  GridViewController.swift
//  Instagrid
//
//  Created by Mickael PAYAN on 15/01/2021.
//

import UIKit

class GridViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//    swiftlint:disable trailing_whitespace
//    swiftlint:disable line_length
    
    /// The grid with the different views.
    @IBOutlet weak private var gridView: UIView!
    @IBOutlet weak private var swipeGesture: UISwipeGestureRecognizer!
    @IBOutlet weak private var arrowSwipeToShareLabel: UILabel!
    @IBOutlet weak private var swipeToShareLabel: UILabel!
    
    /// Top left button = gridViewButtons[0] - Top right button = gridViewButtons[1]  - Bottom left button = gridViewButtons[2]  - Bottom right button = gridViewButtons[3]
    @IBOutlet var gridViewButtons: [UIButton]!
    
    /// The three buttons to change the selection appearance of the "GridView". First button on the left = updateGridButtons[0], second button in the middle = updateGridButtons[1] and the third on the right = updateGridButtons[2]. The same positions for the property updateGridButtonIsSelectedImageView.
    @IBOutlet var updateGridButtons: [UIButton]!
    @IBOutlet var updateGridButtonIsSelectedImageView: [UIImageView]!
    private var buttonSelected: UIButton?
    private var phoneOrientation: UIDeviceOrientation {
        get {
            return UIDevice.current.orientation
        }
    }
    
    override func viewWillLayoutSubviews() {
        if phoneOrientation.isPortrait == true {
            swipeToShareLabel.text = "Swipe up to share"
            arrowSwipeToShareLabel.transform = .identity
            swipeGesture.direction = .up
        } else {
            swipeToShareLabel.text = "Swipe left to share"
            arrowSwipeToShareLabel.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
            swipeGesture.direction = .left
        }
    }
    
    @IBAction private func changeAppareanceGridView(_ sender: UIButton) {
        displayTheSelectedButton()
        gridViewButtons.forEach { $0.isHidden = false }
        switch sender {
        case updateGridButtons[0]:
            gridViewButtons[1].isHidden = true
        case updateGridButtons[1]:
            gridViewButtons[3].isHidden = true
        default:
            break
        }
    }
    
    private func displayTheSelectedButton() {
        updateGridButtonIsSelectedImageView.forEach { $0.isHidden = true }
        if updateGridButtons[0].isTouchInside {
            updateGridButtonIsSelectedImageView[0].isHidden = false
        } else if updateGridButtons[1].isTouchInside {
            updateGridButtonIsSelectedImageView[1].isHidden = false
        } else if updateGridButtons[2].isTouchInside {
            updateGridButtonIsSelectedImageView[2].isHidden = false
        }
    }
    
    @IBAction private func selectButtonInGridToChangeImage(_ sender: UIButton) {
        buttonSelected = sender
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
    }
    
    //  swiftlint:disable:next colon
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        self.buttonSelected?.setImage(image, for: .normal)
        self.buttonSelected?.isSelected = true
        self.dismiss(animated: true, completion: nil)
    }
    
    private func checkIfTheGridViewIsComplete() -> Bool {
        for button in gridViewButtons where !button.isHidden && !button.isSelected {
            alertPopUp()
            return false
        }
        return true
    }
    
    private func alertPopUp() {
        let alert = UIAlertController(title: "Grid incomplete", message: "Select all images for swipe up and share.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    @IBAction private func swipeAction(_ sender: UISwipeGestureRecognizer) {
        guard checkIfTheGridViewIsComplete() else { return }
        switch sender.direction {
        case .up:
            self.animatedGridView(x: 0, y: -1000)
        case .left:
            self.animatedGridView(x: -1000, y: 0)
        default:
            break
        }
        shareCompleteGridView()
    }
    
    //  swiftlint:disable:next identifier_name
    private func animatedGridView(x: CGFloat, y: CGFloat) {
        UIView.animate(withDuration: 0.6, animations: {
            self.gridView.transform = CGAffineTransform(translationX: x, y: y)
        })
    }
    
    private func viewToImage(with view: UIView) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: view.bounds.size)
        let image = renderer.image { _ in
            view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        }
        return image
    }
    
    private func shareCompleteGridView() {
        let sharingImage = viewToImage(with: gridView)
        let activityViewController = UIActivityViewController(activityItems: [sharingImage], applicationActivities: nil)
        present(activityViewController, animated: true)
        activityViewController.completionWithItemsHandler = { (_, _, _, _) in
            UIView.animate(withDuration: 0.6, animations: {
                self.gridView.transform = .identity
            })
        }
    }
}
