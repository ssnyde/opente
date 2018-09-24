/* vxi11_cmd.c
 * Copyright (C) 2006 Steve D. Sharples
 *
 * A simple interactive utility that allows you to send commands and queries to
 * a device enabled with the VXI11 RPC ethernet protocol. Uses the files
 * generated by rpcgen vxi11.x, and the vxi11_user.h user libraries.
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
 * 
 * The author's email address is steve.sharples@nottingham.ac.uk
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

#include "vxi11_user.h"
#define BUF_LEN 4194304
#define BILLION 1000000000L

#ifdef WIN32
#define strncasecmp(a, b, c) stricmp(a, b)
#endif

int main(int argc, char *argv[])
{

	char *device_ip;
	char *device_name = NULL;
	char cmd[256];
	char buf[BUF_LEN];
	int ret;
	long bytes_returned;
	VXI11_CLINK *clink;

	if (argc < 2) {
		printf("usage: %s your.inst.ip.addr [device_name]\n", argv[0]);
		exit(1);
	}

	device_ip = argv[1];
	if (argc > 2) {
		device_name = argv[2];
	}
	if(vxi11_open_device(&clink, device_ip, device_name)){
		printf("Error: could not open device %s, quitting\n",
		       device_ip);
		exit(2);
	}

	while (1) {
		memset(cmd, 0, 256);	// initialize command string
		memset(buf, 0, BUF_LEN);	// initialize buffer
		printf("Input command or query ('q' to exit): ");
		fgets(cmd, 256, stdin);
		cmd[strlen(cmd) - 1] = 0;	// just gets rid of the \n
		if (strncasecmp(cmd, "q", 1) == 0) {
			break;
		}

		if (vxi11_send(clink, cmd, strlen(cmd)) < 0) {
			break;
		}
		if (strstr(cmd, "?") != 0) {
		  struct timespec start, end;
		  unsigned diff;
		  clock_gettime(CLOCK_MONOTONIC, &start);
		  bytes_returned = vxi11_receive(clink, buf, BUF_LEN);
			clock_gettime(CLOCK_MONOTONIC, &end);
			diff = BILLION * (end.tv_sec - start.tv_sec) + end.tv_nsec - start.tv_nsec;
			printf("vxi11_receive took %d seconds", diff);
			printf("Got %ld bytes\n\r", bytes_returned);
			if (bytes_returned > 0) {
				printf("%s\n", buf);
			} else if (bytes_returned == -15) {
				printf("*** [ NOTHING RECEIVED ] ***\n");
			} else {
				break;
			}
		}
	}

	ret = vxi11_close_device(clink, device_ip);
	return 0;
}
