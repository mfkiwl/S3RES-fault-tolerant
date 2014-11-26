/*
 * Useful structs and what not for the plumber program.
 *
 * James Marshall
 */

#include <stdbool.h>
#include "../include/commtypes.h"

typedef enum {NONE, DMR, TMR} replication_t;

// Data structure for components that need to be initialized by the plumber
struct node {
	// Name... name / value pair in the config file
	// ex. local_nav := ArtPot
	char* name;
	char* value;
 	
	replication_t rep_strat;
	char* voter_name; // from config file: local_nav = (ArtPot)VoterB
	char* voter_timer; // easier to keep as a char* - needs to be to pass as an arg anyways

	// comm will need to be changed to multiple named pipes
	int pipe_count;
	struct typed_pipe pipes[PIPE_LIMIT];
};

struct nodelist {
	struct node* current;
	struct nodelist* next;
};

bool add_node(struct nodelist* nodes, char* Name, char* Value, replication_t rep_type, char* voter_name, char* voter_timer);

struct node* get_node(struct nodelist* nodes, char* Name);

void link_bench(struct node* n, comm_message_t type, int fd_in, int fd_out, bool timed);
void link_node(comm_message_t type, struct node* fromName, bool fromTimed, struct node* toName, bool toTimed);

void print_nodes(struct nodelist* nodes);

int launch_node(struct nodelist* nodes);
