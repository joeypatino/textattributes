import UIKit
import TextAttribute

class ViewController: UIViewController {
    private let label = UILabel()
    private let string = """
The quick brown fox jumped over the lazy brown dog
Jived fox nymph grabs quick waltz.
Glib jocks quiz nymph to vex dwarf.
Sphinx of black quartz, judge my vow.
How vexingly quick daft zebras jump!
The five boxing wizards jump quickly.
Pack my box with five dozen liquor jugs.
""".attributed()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        label.numberOfLines = 0
        
        label.attributedText = string
            .addingAttributes([.font(.boldSystemFont(ofSize: 22.0)), .lineSpacing(8.0), .kern(2.0), .textAlignment(.center)])
            .addingAttribute(.foregroundColor(UIColor.black.withAlphaComponent(0.2)), toOccurencesOfString: "[aeiou]", options: [.regularExpression])
    }
}
