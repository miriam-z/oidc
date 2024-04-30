import ballerina/http;

// service / on new http:Listener(9090) {

//     resource function get greeting(string name) returns string|error {
         
//         if name is "" {
//             return error("name should not be empty!");
//         }
//         return "\n * * * * * " + "Hey there, " + name + "! * * * * *\n\n";
//     }
// }


http:JwtValidatorConfig config = {
   issuer: "https://api.asgardeo.io/t/fortresscomputingtech/oauth2/token",
   audience: "uO8mCBoYJFHvfVn_aBfORQAiZ7Ya",
   signatureConfig: {
       jwksConfig: {
           url: "https://api.asgardeo.io/t/fortresscomputingtech/oauth2/jwks"
       }
   }
};
 
listener http:Listener securedEP = new (9090,
   secureSocket = {
   key: {
       certFile: "./resources/public.crt",
       keyFile: "./resources/private.key"
   }
}
);
 
@http:ServiceConfig {
   auth: [
       {
           jwtValidatorConfig: config
       }
   ]
}
service / on securedEP {
 
   resource function get greeting(string name) returns string {
       return "\n * * * * * " + "Hey there, " + name + "! * * * * *\n\n"
       + "* * * * * You just accessed a secure message * * * * * ! \n\n";
   }
}