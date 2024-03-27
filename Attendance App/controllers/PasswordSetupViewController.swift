import UIKit

class PasswordSetupViewController: UIViewController {
    private let headLabel = UILabel()
    private let passwordLabel = UILabel()
    private let passwordTextField = UITextField()
    private let confirmPasswordLabel = UILabel()
    private let confirmPasswordTextField = UITextField()
    private let confirmButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
    }
    
    private func setupUI() {
        
        headLabel.text = "Attendance"
        headLabel.font = UIFont.boldSystemFont(ofSize: 24)
        headLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headLabel)
        
        // Configure passwordLabel
        passwordLabel.text = "Password:"
        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(passwordLabel)
        
        // Configure passwordTextField
        passwordTextField.placeholder = "Enter your password"
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.isSecureTextEntry = true
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(passwordTextField)
        
        // Configure confirmPasswordLabel
        confirmPasswordLabel.text = "Confirm Password:"
        confirmPasswordLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(confirmPasswordLabel)
        
        // Configure confirmPasswordTextField
        confirmPasswordTextField.placeholder = "Confirm your password"
        confirmPasswordTextField.borderStyle = .roundedRect
        confirmPasswordTextField.isSecureTextEntry = true
        confirmPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(confirmPasswordTextField)
        
        // Configure confirmButton
        confirmButton.setTitle("Confirm", for: .normal)
        confirmButton.backgroundColor = .blue
        confirmButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(confirmButton)
        
        // Add action for confirmButton
        confirmButton.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
        
        // Add constraints for all UI elements to position them properly within the view
        NSLayoutConstraint.activate([
            
            headLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            headLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            // Constraints for nameLabel
            passwordLabel.topAnchor.constraint(equalTo: headLabel.bottomAnchor, constant: 40),
            passwordLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60),

            // Constraints for nameTextField
            passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 8),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            // Constraints for emailLabel
            confirmPasswordLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 16),
            confirmPasswordLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),

            // Constraints for emailTextField
            confirmPasswordTextField.topAnchor.constraint(equalTo: confirmPasswordLabel.bottomAnchor, constant: 8),
            confirmPasswordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            confirmPasswordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            // Constraints for confirmButton
            confirmButton.topAnchor.constraint(equalTo: confirmPasswordTextField.bottomAnchor, constant: 40),
            confirmButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            confirmButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            confirmButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    private let databaseManager = DatabaseManager()

    @objc private func confirmButtonTapped() {
        guard let password = passwordTextField.text, !password.isEmpty else {
            showAlert(title: "Error", message: "Please enter your password")
            return
        }

        let user = User(name: "", email: "", password: password)
        databaseManager.saveUserToDatabase(user)
        
        // Move to sign-in screen
        let signinVC = SigninViewController()
        navigationController?.pushViewController(signinVC, animated: true)
    }

    private func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}
