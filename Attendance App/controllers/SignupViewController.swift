import UIKit

// MARK: - SignupViewController

class SignupViewController: UIViewController {
    // UI elements
    private let headLabel = UILabel()
    private let nameLabel = UILabel()
    private let nameTextField = UITextField()
    private let emailLabel = UILabel()
    private let emailTextField = UITextField()
    private let signupButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
    }
    
    @objc func moveToNextScreen() {
            // Code to navigate to the next screen
            let nextViewController = SignupViewController()
            navigationController?.pushViewController(nextViewController, animated: true)
        }
    
    private func setupUI() {
        // Configure headLabel
        headLabel.text = "Attendance"
        headLabel.font = UIFont.boldSystemFont(ofSize: 24)
        headLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headLabel)
        
        // Configure nameLabel
        nameLabel.text = "Full Name:"
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameLabel)
        
        // Configure nameTextField
        nameTextField.placeholder = "Enter your full name"
        nameTextField.borderStyle = .roundedRect
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameTextField)
        
        // Configure emailLabel
        emailLabel.text = "Email:"
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(emailLabel)
        
        // Configure emailTextField
        emailTextField.placeholder = "Enter your email"
        emailTextField.borderStyle = .roundedRect
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(emailTextField)
        
        // Configure signupButton
        signupButton.setTitle("Signup", for: .normal)
        signupButton.backgroundColor = .blue
        signupButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(signupButton)
        
        // Add constraints
        NSLayoutConstraint.activate([
            // Constraints for headLabel
            headLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            headLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            // Constraints for nameLabel
            nameLabel.topAnchor.constraint(equalTo: headLabel.bottomAnchor, constant: 40),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60),

            // Constraints for nameTextField
            nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            // Constraints for emailLabel
            emailLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 16),
            emailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),

            // Constraints for emailTextField
            emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 8),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            // Constraints for signupButton
            signupButton.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 40),
            signupButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            signupButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            signupButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        // Add action for signupButton
        signupButton.addTarget(self, action: #selector(signupButtonTapped), for: .touchUpInside)
    }
    @objc private func signupButtonTapped() {
        guard let name = nameTextField.text, !name.isEmpty else {
            showAlert(title: "Error", message: "Please enter your name")
            return
        }
        
        guard let email = emailTextField.text, !email.isEmpty else {
            showAlert(title: "Error", message: "Please enter your email")
            return
        }
        
        guard isValidEmail(email) else {
            showAlert(title: "Error", message: "Please enter a valid email")
            return
        }
        
        let passwordSetupVC = PasswordSetupViewController()
        navigationController?.pushViewController(passwordSetupVC, animated: true)
    }
    
    // Validate email format
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    // Present UIAlertController
    private func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        // Present the alert controller using the current view controller
        present(alertController, animated: true, completion: nil)
    }
}
