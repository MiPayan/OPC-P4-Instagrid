//
//  GridViewController.swift
//  Instagrid
//
//  Created by Mickael PAYAN on 15/01/2021.
//

import UIKit

class GridViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    /// The grid with the different views, and the gesture recognizer to swipe up to share.
    @IBOutlet weak private var gridView: UIView!
    @IBOutlet weak private var swipeGesture: UISwipeGestureRecognizer!
    
    @IBOutlet weak private var arrowSwipeToShareLabel: UILabel!
    @IBOutlet weak private var swipeToShareLabel: UILabel!
    
    ///
    @IBOutlet weak private var topLeftButton: UIButton!
    @IBOutlet weak private var topRightButton: UIButton!
    @IBOutlet weak private var bottomLeftButton: UIButton!
    @IBOutlet weak private var bottomRightButton: UIButton!
    
    /// The three buttons to change the selection appearance of the "GridView".
    @IBOutlet weak private var firstButton: UIButton!
    @IBOutlet weak private var secondButton: UIButton!
    @IBOutlet weak private var thirdButton: UIButton!
    @IBOutlet weak private var firstButtonIsSelectedImageView: UIImageView!
    @IBOutlet weak private var secondButtonIsSelectedImageView: UIImageView!
    @IBOutlet weak private var thirdButtonIsSelectedImageView: UIImageView!
    
    private var buttonSelected: UIButton?
    private var imageSelectedView: UIImageView?
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
        topLeftButton.isHidden = false
        topRightButton.isHidden = false
        bottomLeftButton.isHidden = false
        bottomRightButton.isHidden = false
        switch sender {
        case firstButton:
            topRightButton.isHidden = true
        case secondButton:
            bottomRightButton.isHidden = true
        default:
            break
        }
    }
    
    private func displayTheSelectedButton() {
        firstButtonIsSelectedImageView.isHidden = true
        secondButtonIsSelectedImageView.isHidden = true
        thirdButtonIsSelectedImageView.isHidden = true
        if firstButton.isTouchInside {
            firstButtonIsSelectedImageView.isHidden = false
        } else if secondButton.isTouchInside {
            secondButtonIsSelectedImageView.isHidden = false
        } else if thirdButton.isTouchInside {
            thirdButtonIsSelectedImageView.isHidden = false
        }
    }
    
    @IBAction private func selectButtonInGridToChangeImage(_ sender: UIButton) {
        buttonSelected = sender
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        picker.sourceType = .photoLibrary;
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        self.buttonSelected?.setImage(image, for: .normal)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction private func swipeUpAction(_ sender: UISwipeGestureRecognizer) {
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
    
    private func animatedGridView(x: CGFloat, y: CGFloat) {
        UIView.animate(withDuration: 0.6, animations: {
            self.gridView.transform = CGAffineTransform(translationX: x, y: y)
        })
    }
    
    private func reverseGridAnimation() {
        UIView.animate(withDuration: 0.6, animations: {
            self.gridView.transform = .identity
        })
    }
    
    private func viewToImage(with view: UIView) -> UIImage   {
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
            self.reverseGridAnimation()
        }
    }
}
