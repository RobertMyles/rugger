#' @export
teams <- function() {
  
    tm <- c("New Zealand", "Ireland", "Wales", "England", "South Africa",
                "Australia", "Scotland", "Fiji", "France", "Argentina", "Japan",
                "USA", "Georgia", "Tonga", "Italy", "Samoa", "Uruguay", "Romania",
                "Russia", "Canada", "Spain", "Namibia", "Netherlands", "Hong Kong",
                "Belgium", "Germany", "Portugal", "Brazil", "Chile", "Korea", 
                "Switzerland", "Kenya", "Poland", "Lithuania", "Ukraine", "Colombia",
                "Czechia", "Paraguay", "Malta", "Zimbabwe", "Tunisia", "Uganda", 
                "Sri Lanka", "Cote D'Ivoire", "Sweden", "Morocco", "Malaysia", 
                "Croatia", "Mexico", "Trinidad & Tobago", "Madagascar", 
                "Cayman Islands", "Philippines", "Cook Islands", "Senegal", 
                "Moldova", "Latvia", "Guyana", "Singapore", "Kazakhstan", 
                "Venezuela", "Israel", "Chinese Taipei", "Jamaica", "Luxembourg", 
                "Hungary", "Zambia", "Papua New Guinea", "Slovenia", "Guam", 
                "United Arab Emirates", "Nigeria", "Botswana", "Bermuda", 
                "Bosnia & Herzegovina", "Andorra", "Thailand", "Peru", "Austria", 
                "St Vincent and Grenadines", "Denmark", "Barbados", "India", 
                "Tahiti", "Bahamas", "Serbia", "China", "Swaziland", "Ghana", 
                "Uzbekistan", "Bulgaria", "Pakistan", "Mauritius", "Norway", 
                "Rwanda", "Costa Rica", "Finland", "Indonesia", "Niue Island", 
                "Cameroon", "Solomon Islands", "Monaco", "Greece", "Vanuatu",
                "American Samoa") %>% str_sort()
    
    tm
}
