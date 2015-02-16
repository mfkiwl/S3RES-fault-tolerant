#include <signal.h>

#include "../include/taslimited.h"
#include "../include/commtypes.h"
#include "../include/fd_client.h"

#define TIMEOUT_SIGNAL SIGRTMIN + 0 // The voter's watchdog timer
#define RESTART_SIGNAL SIGRTMIN + 1 // Voter to replica signal to fork itself
#define SDC_SIM_SIGNAL SIGRTMIN + 2 // For inserting simulated SDCs

int initReplica(void);
static void restartHandler(int signo, siginfo_t *si, void *unused);
