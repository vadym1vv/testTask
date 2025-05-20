# testTask
Test task app

Troubleshooting tips and common issues.  
    - On iPad, the 'Choose how you want to add a photo' dialog is displayed differently   due to .confirmationDialog behavior. On iPhone, it appears as intended according to the design.  
    - When a user takes a photo, it is always larger than 5MB. An additional   size-shrinking function has been applied  
Instructions on how to build the application.  
    - select your device and press Ctrl+R on xcode.  

Document any external APIs or libraries used, briefly explaining why you decided to
use this API/library.  
    - The API layer follows a structured pattern designed to reduce code redundancy according to: https://calincrist.com/the-perfect-ios-networking-layer-does-not-exists---part-1  

Provide a brief overview of the code structure and important modules.  
    - For users list page: the code handles paginated user loading, adjusting behavior based on the device type. On iPad, if fewer than 12 users are loaded, it increases the number of users requested and advances the page number by 2 instead of 1.  
    - Sign-up/users list page: the code structure follows the documented approach (see link above)  
