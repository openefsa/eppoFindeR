test_that("with blanks it throws NA", {
  expect_equal(gettingCountries(""), NA)
})

test_that("a char is the output", {
  expect_equal(is.character(gettingCountries("PPPO")), TRUE)
})

test_that("it throws errors if no params are provided", {
  expect_error(gettingCountries())
})

test_that("a concatenation of countries corresponding to the acronym is returned", {
  expect_equal(gettingCountries("EPPO"), "Albania,Algeria,Austria,Azerbaijan,Belarus,Belgium,Bosnia and Herzegovina,Bulgaria,Croatia,Cyprus,Czech Republic,Denmark,Estonia,Finland,France,Georgia,Germany,Greece,Guernsey,Hungary,Ireland,Israel,Italy,Jersey,Jordan,Kazakhstan,Kyrgyzstan,Latvia,Lithuania,Luxembourg,Malta,Moldova,Montenegro,Morocco,Netherlands,North Macedonia,Norway,Poland,Portugal,Romania,Russia,Serbia,Slovakia,Slovenia,Spain,Sweden,Switzerland,Tunisia,Türkiye,Ukraine,United Kingdom,Uzbekistan")
})

test_that("a concatenation of countries corresponding to the acronym is returned", {
  expect_equal(gettingCountries("OIRSA"), "Belize,Costa Rica,Dominican Republic,El Salvador,Guatemala,Honduras,Mexico,Nicaragua,Panama")
})

test_that("a concatenation of countries corresponding to the acronym is returned", {
  expect_equal(gettingCountries("EAEU"), "Armenia,Belarus,Kazakhstan,Kyrgyzstan,Russia")
})

test_that("a concatenation of countries corresponding to the acronym is returned", {
  expect_equal(gettingCountries("COSAVE"), "Argentina,Bolivia,Brazil,Chile,Paraguay,Peru,Uruguay")
})
test_that("a concatenation of countries corresponding to the acronym is returned", {
  expect_equal(gettingCountries("EU"), "Austria,Belgium,Bulgaria,Croatia,Cyprus,Czech Republic,Denmark,Estonia,Finland,France,Germany,Greece,Hungary,Ireland,Italy,Latvia,Lithuania,Luxembourg,Malta,Netherlands,Poland,Portugal,Romania,Slovakia,Slovenia,Spain,Sweden")
})

test_that("a concatenation of countries corresponding to the acronym is returned", {
  expect_equal(gettingCountries("APPPC"), "Australia,Bangladesh,Cambodia,China,East Timor,Fiji,French Polynesia,India,Indonesia,Korea Dem. People's Republic,Korea, Republic,Laos,Malaysia,Myanmar,Nepal,New Zealand,Pakistan,Papua New Guinea,Philippines,Samoa,Solomon Islands,Sri Lanka,Thailand,Tonga,Vietnam")
})

test_that("a concatenation of countries corresponding to the acronym is returned", {
  expect_equal(gettingCountries("CAHFSA"), "Antigua and Barbuda,Bahamas,Barbados,Belize,Dominica,Grenada,Guyana,Haiti,Jamaica,Montserrat,Saint Lucia,St Kitts-Nevis,St Vincent and the Grenadines,Suriname,Trinidad and Tobago")
})

test_that("a concatenation of countries corresponding to the acronym is returned", {
  expect_equal(gettingCountries("CAN"), "Bolivia,Colombia,Ecuador,Peru,Venezuela")
})

test_that("a concatenation of countries corresponding to the acronym is returned", {
  expect_equal(gettingCountries("IAPSC"), "Algeria,Angola,Benin,Botswana,Burkina Faso,Burundi,Cameroon,Cape Verde,Central African Republic,Chad,Comoros,Congo,Congo, Democratic Republic of the,Cote d'Ivoire,Djibouti,Egypt,Equatorial Guinea,Eritrea,Eswatini,Ethiopia,Gabon,Gambia,Ghana,Guinea,Guinea-Bissau,Kenya,Lesotho,Liberia,Libya,Madagascar,Malawi,Mali,Mauritania,Mauritius,Morocco,Mozambique,Namibia,Niger,Nigeria,Rwanda,Sao Tome & Principe,Senegal,Seychelles,Sierra Leone,Somalia,South Africa,South Sudan,Sudan,Tanzania,Togo,Tunisia,Uganda,Zaire,Zambia,Zimbabwe")
})

test_that("a concatenation of countries corresponding to the acronym is returned", {
  expect_equal(gettingCountries("NAPPO"), "Canada,Mexico,United States of America")
})

test_that("a concatenation of countries corresponding to the acronym is returned", {
  expect_equal(gettingCountries("NEPPO"), "Algeria,Egypt,Jordan,Libya,Malta,Morocco,Pakistan,South Sudan,Sudan,Syria,Tunisia")
})
