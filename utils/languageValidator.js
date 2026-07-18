let allowedLanguages = [];


function setLanguages(languages) {
    allowedLanguages = languages;
}


function isLanguageValid(language) {
    return allowedLanguages.includes(language);
}


function loadLanguages(connection) {

    connection.query("SELECT code FROM languages", (err, result) => {

        if (err) {
            console.log("Error getting languages. Error: " + err);
            return;
        }

        setLanguages(result.map(language => language.code));

        console.log("Allowed languages loaded:", allowedLanguages);
    });

}


module.exports = {isLanguageValid, loadLanguages};