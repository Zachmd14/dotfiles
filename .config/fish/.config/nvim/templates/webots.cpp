#include <webots/Robot.hpp>

#define TIME_STEP 64

// All the webots classes are defined in the "webots" namespace
using namespace webots;

int main(int argc, char **argv) {
  Robot *robot = new Robot();

  while (robot->step(TIME_STEP) != -1)
    ;

  delete robot;

  return 0;
}
