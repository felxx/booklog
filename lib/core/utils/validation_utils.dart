/// Utility class for common validations
class ValidationUtils {
  /// Validates email format using Supabase-compatible validation
  static bool isValidEmail(String email) {
    if (email.isEmpty) return false;
    
    final trimmedEmail = email.trim().toLowerCase();
    
    // Check minimum length
    if (trimmedEmail.length < 5) return false;
    
    // More restrictive email validation to match Supabase requirements
    // This pattern ensures the email starts and ends with alphanumeric characters
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9]([a-zA-Z0-9._%+-]*[a-zA-Z0-9])?@[a-zA-Z0-9]([a-zA-Z0-9.-]*[a-zA-Z0-9])?\.[a-zA-Z]{2,}$'
    );
    
    // Additional checks for common invalid patterns
    if (trimmedEmail.contains('..') || 
        trimmedEmail.startsWith('.') || 
        trimmedEmail.endsWith('.') ||
        trimmedEmail.contains('@.') ||
        trimmedEmail.contains('.@') ||
        trimmedEmail.contains('@@') ||
        trimmedEmail.split('@').length != 2) {
      return false;
    }
    
    // Check that domain part is valid
    final parts = trimmedEmail.split('@');
    if (parts.length != 2) return false;
    
    final localPart = parts[0];
    final domainPart = parts[1];
    
    // Local part validations
    if (localPart.isEmpty || localPart.length > 64) return false;
    if (localPart.startsWith('.') || localPart.endsWith('.')) return false;
    
    // Domain part validations  
    if (domainPart.isEmpty || domainPart.length > 255) return false;
    if (domainPart.startsWith('.') || domainPart.endsWith('.')) return false;
    if (domainPart.startsWith('-') || domainPart.endsWith('-')) return false;
    
    return emailRegex.hasMatch(trimmedEmail);
  }

  /// Validates password strength
  static bool isValidPassword(String password) {
    return password.length >= 6;
  }

  /// Validates username format
  static bool isValidUsername(String username) {
    if (username.isEmpty || username.length < 3) return false;
    
    // Allow letters, numbers, underscores, and hyphens
    final usernameRegex = RegExp(r'^[a-zA-Z0-9_-]{3,20}$');
    return usernameRegex.hasMatch(username.trim());
  }

  /// Get email validation error message
  static String? getEmailErrorMessage(String email) {
    if (email.isEmpty) return 'Email is required';
    if (!isValidEmail(email)) return 'Please enter a valid email address';
    return null;
  }

  /// Get password validation error message
  static String? getPasswordErrorMessage(String password) {
    if (password.isEmpty) return 'Password is required';
    if (!isValidPassword(password)) return 'Password must be at least 6 characters long';
    return null;
  }

  /// Get username validation error message
  static String? getUsernameErrorMessage(String username) {
    if (username.isEmpty) return 'Username is required';
    if (username.length < 3) return 'Username must be at least 3 characters long';
    if (username.length > 20) return 'Username must be at most 20 characters long';
    if (!isValidUsername(username)) return 'Username can only contain letters, numbers, underscores, and hyphens';
    return null;
  }
}
