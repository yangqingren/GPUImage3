import GPUImage
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var renderView: RenderView!

    var picture: PictureInput!
    var filter: SaturationAdjustment!
    
    lazy var imageView: UIImageView = {
        let view = UIImageView(frame: self.view.bounds)
        view.contentMode = .scaleAspectFit
        return view
    }()

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        // Filtering image for saving
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.imageView)

        self.runFilter()
    }
    
    

    func runFilter() {
        let group = OperationGroup()
        let blur1 = GaussianBlur()
        let blur2 = GaussianBlur()
        group.configureGroup { input, output in
            input --> blur1 --> blur2 --> output
        }
        let testImage = UIImage(named: "IMG_1009.jpg")!
        let filteredImage = testImage.filterWithOperation(group)
        self.imageView.image = filteredImage
        blur1.inputTextures.removeAll()
        blur2.inputTextures.removeAll()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.runFilter()
        }
    }
}
