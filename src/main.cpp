#include <iostream>
#include <string>

#include <utils/utils.h>

int main(int argc, char *argv[])
{
    std::string name = "";

    if (argc >= 2)
    {
        name = argv[1];
    }
    else
    {
        std::cout << "Enter your name:" << std::endl;
        std::cin >> name;
    }

    std::cout << utils::Hello(name) << std::endl;

    return 0;
}