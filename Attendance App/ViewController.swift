import UIKit

class ViewController: UIViewController {
    
    private let headLabel: UILabel = {
        let label = UILabel()
        label.text = "ATTENDANCE NOTES"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 36)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let subLabel: UILabel = {
        let label = UILabel()
        label.text = "Take the best records right on your palm"
        label.textColor = .gray
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.moveToNextScreen), userInfo: nil, repeats: false)
    }
    
    @objc func moveToNextScreen() {
            // Code to navigate to the next screen
            let nextViewController = SignupViewController()
            navigationController?.pushViewController(nextViewController, animated: true)
        }
    
    private func setupUI() {
        // Add headLabel
        view.addSubview(headLabel)
        
        // Add subLabel
        view.addSubview(subLabel)
        
        // Add signupButton
        let signupButton = UIButton(type: .system)
        signupButton.setTitle("Let's go", for: .normal)
        signupButton.addTarget(self, action: #selector(signupButtonTapped), for: .touchUpInside)
        signupButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(signupButton)
        
        // Add constraints
        NSLayoutConstraint.activate([
            // Constraints for headLabel
            headLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            headLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -80), // Adjust vertical position
            
            // Constraints for subLabel
            subLabel.topAnchor.constraint(equalTo: headLabel.bottomAnchor, constant: 30),
            subLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            // Constraints for signupButton
            signupButton.topAnchor.constraint(equalTo: subLabel.bottomAnchor, constant: 20),
            signupButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc private func signupButtonTapped() {
        let signupVC = SignupViewController()
        navigationController?.pushViewController(signupVC, animated: true)
    }
}
