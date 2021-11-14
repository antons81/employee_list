
Employee list

IOS Requiments:

    iOS 15.0 and above
 
Architecture:
 
    I have used Viper Architecture. Because it's clean and easy for refactoring. 
    Contains modular principe. Each Controller is like a Module, usuallyy not depend from ther controller
    
    
How it Works:

   It fetches API contacts from both independent servers.
   First, it's fetch from 1 server then from second one.
   Provide contacts sort by last name and then removing duplicates.
   Before it shows to the user, it's asking for phone contacts permissions and matching phone contacts with API contacts
   If contacts are matched, the have 'contact details' button on right side in the list and top right corner on contact details.
   By clicking this button, should open native cotact details screen.
   
    
 For Tester:
 
    Run the app, check if all conctas loaded, verify duplicates.
    Check if you give permission, then check with denied permission also. 
    If you denied permission to contacts, 'Detail button' will not show.
    Pull to refresh, will refresh all data from scratch
    
    
