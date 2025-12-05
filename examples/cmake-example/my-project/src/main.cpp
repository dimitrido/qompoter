#include <iostream>
#include "mylibrary.h"

int main() {
    std::cout << MyLibrary::getGreeting() << std::endl;
    std::cout << "Library version: " << MyLibrary::getVersion() << std::endl;
    return 0;
}
