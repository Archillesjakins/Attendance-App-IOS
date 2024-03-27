import UIKit

class SigninViewController: UIViewController {
    private let headLabel = UILabel()
    private let emailLabel = UILabel()
    private let emailTextField = UITextField()
    private let passwordLabel = UILabel()
    private let passwordTextField = UITextField()
    private let signinButton = UIButton()
    
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
        
        // Configure emailLabel
        emailLabel.text = "Email:"
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(emailLabel)
        
        // Configure emailTextField
        emailTextField.placeholder = "Enter your email"
        emailTextField.borderStyle = .roundedRect
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(emailTextField)
        
        // Configure passwordLabel
        passwordLabel.text = "Password:"
        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(passwordLabel)
        
        // Configure passwordTextField
        passwordTextField.placeholder = "Enter your password"
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.isSecureTextEntry = true // for password input
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(passwordTextField)
        
        // Configure signinButton
        signinButton.setTitle("Sign In", for: .normal)
        signinButton.backgroundColor = .blue
        signinButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(signinButton)
        
        // Add action for signinButton
        signinButton.addTarget(self, action: #selector(signinButtonTapped), for: .touchUpInside)
        
        // Add constraints for all UI elements to position them properly within the view
        NSLayoutConstraint.activate([
            headLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            headLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            // Constraints for emailLabel
            emailLabel.topAnchor.constraint(equalTo: headLabel.bottomAnchor, constant: 40),
            emailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            // Constraints for emailTextField
            emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 8),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            // Constraints for passwordLabel
            passwordLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 16),
            passwordLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            // Constraints for passwordTextField
            passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 8),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            // Constraints for signinButton
            signinButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 40),
            signinButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            signinButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            signinButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func signinButtonTapped() {
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            showAlert(title: "Error", message: "Please enter your email and password")
            return
        }
        
        let HomeViewVC = HomeViewController()
        navigationController?.pushViewController(HomeViewVC, animated: true)

        
        // Call the authenticateUser function with entered email and password
        authenticateUser(email: email, password: password)
    }
    
    private func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    private func authenticateUser(email: String, password: String) {
        fetchDataFromAPI(email: email, password: password)
    }
    
    private func fetchDataFromAPI(email: String, password: String) {
        let urlString = "https://jsonplaceholder.typicode.com/todos"
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        let session = URLSession.shared
        
        session.dataTask(with: url) { data, response, error in
            if let error = error {
                // Handle error when there's no internet connection
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid response")
                return
            }
            
            if !(200...299).contains(httpResponse.statusCode) {
                // Handle error when data is not fetched successfully
                print("Error: Data not fetched successfully. Status code: \(httpResponse.statusCode)")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            // Data fetched successfully
            // You can parse and handle the data here
            print("Data received: \(String(data: data, encoding: .utf8) ?? "")")
            
        }.resume()
        
        
    }
    
}
