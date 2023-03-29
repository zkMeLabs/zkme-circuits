pragma circom 2.0.0;

include "lib/query/zkMeCredentialQuery.circom";

component main{public [userID, claimSchema, operator, value, timestamp]} = CredentialQuery(64);
