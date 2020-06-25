@isTest
global class CountryCalloutMock implements HttpCalloutMock {
    global HttpResponse respond(HttpRequest req) {
        String body = '[{"regionalBlocs":[],"name":"United States Minor Outlying Islands","alpha2Code":"UM","alpha3Code":"UMI","capital":"","region":"Americas","subregion":"Northern America"},{"regionalBlocs":[{"acronym":"AU","name":"African Union","otherAcronyms":[],"otherNames":["الاتحاد الأفريقي","Union africaine","União Africana","Unión Africana","Umoja wa Afrika"]}],"name":"Tanzania, United Republic of","alpha2Code":"TZ","alpha3Code":"TZA","capital":"Dodoma","region":"Africa","subregion":"Eastern Africa"},{"regionalBlocs":[{"acronym":"AL","name":"Arab League","otherAcronyms":[],"otherNames":["جامعة الدول العربية","Jāmiʻat ad-Duwal al-ʻArabīyah","League of Arab States"]}],"name":"United Arab Emirates","alpha2Code":"AE","alpha3Code":"ARE","capital":"Abu Dhabi","region":"Asia","subregion":"Western Asia"},{"regionalBlocs":[{"acronym":"EU","name":"European Union","otherAcronyms":[],"otherNames":[]}],"name":"United Kingdom of Great Britain and Northern Ireland","alpha2Code":"GB","alpha3Code":"GBR","capital":"London","region":"Europe","subregion":"Northern Europe"},{"regionalBlocs":[{"acronym":"NAFTA","name":"North American Free Trade Agreement","otherAcronyms":[],"otherNames":["Tratado de Libre Comercio de América del Norte","Accord de Libre-échange Nord-Américain"]}],"name":"United States of America","alpha2Code":"US","alpha3Code":"USA","capital":"Washington, D.C.","region":"Americas","subregion":"Northern America"},{"regionalBlocs":[{"acronym":"PA","name":"Pacific Alliance","otherAcronyms":[],"otherNames":["Alianza del Pacífico"]},{"acronym":"NAFTA","name":"North American Free Trade Agreement","otherAcronyms":[],"otherNames":["Tratado de Libre Comercio de América del Norte","Accord de Libre-échange Nord-Américain"]}],"name":"Mexico","alpha2Code":"MX","alpha3Code":"MEX","capital":"Mexico City","region":"Americas","subregion":"Central America"}]';

        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody(body);
        res.setStatusCode(200);
        return res;
    }
}