pragma circom 2.0.0;
include "../../../node_modules/circomlib/circuits/mux1.circom";
include "../../../node_modules/circomlib/circuits/bitify.circom";
include "../../../node_modules/circomlib/circuits/comparators.circom";
include "query.circom";


template CredentialQuery(valueArraySize) {

    /* issuerClaim signals */
    signal input issuerClaim[4];

    /* userID ownership signals */
    signal input userID;

    /* current time */
    signal input timestamp;

    /** Query */
    signal input claimSchema;
    signal input operator;
    signal input value[valueArraySize];

    // Verify that claims are issued to designated identities
    issuerClaim[0] === userID;

    // Verify issuerClaim schema
    issuerClaim[1] === claimSchema;

    // Verify the expiration time of the issue
    // timestamp < expirationComp.expiration
    component lt = LessEqThan(252); 
    lt.in[0] <== timestamp;
    lt.in[1] <== issuerClaim[2];
    component res = Mux1();
    res.c[0] <== 1;
    res.c[1] <== lt.out;
    res.s <== 3;
    res.out === 1;

    // query
    component q = Query(valueArraySize);
    q.in <== issuerClaim[3];
    q.operator <== operator;
    for(var i = 0; i<valueArraySize; i++) {
        q.value[i] <== value[i];
    }
    q.out === 1;
}
