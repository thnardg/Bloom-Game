import SwiftUI
import SpriteKit

struct MyView: UIViewControllerRepresentable{
    typealias UIViewControllerType = GameViewController
    
    func makeUIViewController(context: Context) -> GameViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard
            let viewController = storyboard.instantiateInitialViewController()
        else{
            fatalError("Cannot load ViewController from main storyboard")
        }
        return viewController as! GameViewController
    }
    
    func updateUIViewController(_ uiViewController: GameViewController, context: Context) {
        // Updates the state of the specified view controller with new information from SwiftUI.
    }
}
struct ControllerView_Previews: PreviewProvider {
    static var previews: some View {
        MyView()
            .ignoresSafeArea()
    }
}
