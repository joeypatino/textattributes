import UIKit
import TextAttribute

class ViewController: UIViewController {
    private let label = UILabel()
    private let string = "The quick brown fox jumped over the lazy brown dog".attributed()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        label.numberOfLines = 0
        label.attributedText = string
    }
}

