function isPasswordValid(password) {

    if (!password) {
        return false;
    }

    return (
        password.length >= 8 &&
        /[A-Z]/.test(password) &&
        /\d/.test(password) &&
        /[!@#$%^&*]/.test(password)
    );

}

module.exports = isPasswordValid;