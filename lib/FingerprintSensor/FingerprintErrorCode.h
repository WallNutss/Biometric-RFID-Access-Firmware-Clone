#ifndef FINGERPRINT_ERROR_CODE_H
#define FINGERPRINT_ERROR_CODE_H

enum FingerprintErrorCode {
    /// Fingerprint Error Code (100-200)

    FAILED_TO_CONVERT_IMAGE_TO_FEATURE      = -100,     /* Failed to convert the image to Fingerprint feature          */ 
    FAILED_IMAGE_CONVERSION_ERROR           = -101,     /* Failed when conversion image                                */
    FAILED_TO_MAKE_FINGERPRINT_MODEL        = -102,     /* Failed to create the final Fingerprint model                */
    FAILED_TO_CREATE_VERIFICATION_MODEL     = -103,     /* Failed to create the verification before model creation     */
    FAILED_TO_DELETE_FINGERPRINT_MODEL      = -104,     /* Failed to delete a Fingerprint model from sensor            */
    FAILED_TO_DELETE_ALL_FINGERPRINT_MODEL  = -105,     /* Failed to delete all the fingerprints model from sensor     */
    FAILED_TO_GET_FINGERPRINT_MODEL_ID      = -106,     /* Failed to get the Fingerprint ID associate with model       */
    FAILED_TO_CONNECT_FINGERPRINT_SENSOR    = -107,     /* Failed to connect or find the connected Fingerprint sensor  */
    FAILED_TO_INTIALIZE_FINGERPRINT         = -108,     /* Failed to initialize or setup the Fingerprint sensor        */
    
};

#endif
