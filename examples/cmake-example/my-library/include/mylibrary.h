#ifndef MYLIBRARY_H
#define MYLIBRARY_H

#include <string>

namespace MyLibrary {
    /**
     * Returns a greeting message
     */
    std::string getGreeting();
    
    /**
     * Returns the library version
     */
    std::string getVersion();
}

#endif // MYLIBRARY_H
