From: William Cohen <wcohen@redhat.com>
Subject: Issue perf attaching to processes creating many short-live threads
Date: Fri, 23 Oct 2015 14:52:29 -0400
Message-ID: <562A81ED.70900@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000700020305020106010208"
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46770 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750922AbbJWSwb (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 23 Oct 2015 14:52:31 -0400
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "linux-perf-use." <linux-perf-users@vger.kernel.org>
Cc: =?UTF-8?B?5aSn5bmz5oCc?= <rei.odaira@gmail.com>

This is a multi-part message in MIME format.
--------------000700020305020106010208
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Earlier this month Rei Odeira found that the oprofile tool operf would
have problems attaching and monitoring a process that created many
very short-lived threads.  It looks like the kernel's perf tool also
has issues when attempting to attach and monitor a process that is
creating many short-lived threads.  Attached is the source code used to
reproduce the problem.  The code is compiled and run with the
following commands.  The arguments to the reproducer are the total
number of threads to spawn, the number of concurrent threads, and the
number of times each threads loops.  When run with "-1" as first argument
it will need to be stopped with a cntl-c.

$ gcc -o oprofile_multithread_test oprofile_multithread_test.c -lpthread
$ ./oprofile_multithread_test 
Usage: oprofile_multithread_test <number of spawns> <number of threads> <number of operations per thread>
$ ./oprofile_multithread_test -1 16 100000

Having the reproducer run as a child of perf works fine.

$ perf --version
perf version 4.2.3-200.fc22.x86_64
$ perf stat ./oprofile_multithread_test -1 16 1000000
^C./oprofile_multithread_test: Interrupt
failed to read counter stalled-cycles-backend

 Performance counter stats for './oprofile_multithread_test -1 16 1000000':

      54632.571382      task-clock (msec)         #    5.764 CPUs utilized          
            23,447      context-switches          #    0.429 K/sec                  
            16,153      cpu-migrations            #    0.296 K/sec                  
                86      page-faults               #    0.002 K/sec                  
   168,749,585,390      cycles                    #    3.089 GHz                    
   136,160,264,023      stalled-cycles-frontend   #   80.69% frontend cycles idle   
   <not supported>      stalled-cycles-backend   
    95,947,021,711      instructions              #    0.57  insns per cycle        
                                                  #    1.42  stalled cycles per insn
    16,018,454,088      branches                  #  293.203 M/sec                  
         6,990,932      branch-misses             #    0.04% of all branches        

       9.477617613 seconds time elapsed


However, when the starting the reproducer program and then attaching
to pid using '-p' one sometimes gets the following failure:

$ ./oprofile_multithread_test -1 16 100000 &
$ perf stat -p `pgrep oprofile_mul`
Error:
The sys_perf_event_open() syscall returned with 3 (No such process) for event (instructions).
/bin/dmesg may provide additional information.
No CONFIG_PERF_EVENTS=y kernel support configured?


I got the same results using perf built from a check out of the
current mainline linux kernel.  Shouldn't perf be able to attach to a
process regardless of how quickly it is creating threads?

-Will

--------------000700020305020106010208
Content-Type: text/x-csrc;
 name="oprofile_multithread_test.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="oprofile_multithread_test.c"

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <pthread.h>

static int num_ops;
static pthread_t *thr_array;


static void *
thr_main(void *arg)
{
  int i;
  int sum = 0;

  for (i = 0; i < num_ops; i++) {
    sum += i;
  }

  return (void *)(intptr_t)sum;
}

static void
spawn_thread(int thr)
{
  int ret;

  ret = pthread_create(&thr_array[thr], NULL, thr_main, NULL);
  if (ret != 0) {
    fprintf(stderr, "pthread_create: %s\n", strerror(ret));
    exit(1);
  }
}

static void
join_thread(int thr)
{
  int ret;

  ret = pthread_join(thr_array[thr], NULL);
  if (ret != 0) {
    fprintf(stderr, "pthread_join: %s\n", strerror(ret));
    exit(1);
  }
}

int
main(int argc, char *argv[])
{
  int num_spawns;
  int num_threads;
  int thr;
  int thr_saved;
  int ret;
  int spawn_count;

  if (argc != 4) {
    fprintf(stderr, "Usage: oprofile_multithread_test <number of spawns> <number of threads> <number of operations per thread>\n");
    exit(1);
  }

  num_spawns = atoi(argv[1]);
  num_threads = atoi(argv[2]);
  num_ops = atoi(argv[3]);
  if (num_threads < 1) {
    fprintf(stderr, "Number of threads must be positive.\n");
    exit(1);
  }

  thr_array = malloc(sizeof(pthread_t) * num_threads);
  if (thr_array == NULL) {
    fprintf(stderr, "Cannot allocate thr_array\n");
    exit(1);
  }

  spawn_count = 0;
  for (thr = 0; thr < num_threads; thr++) {
    spawn_thread(thr);
    spawn_count++;
  }

  thr = 0;
  while  (num_spawns < 0 ? 1 /* infinite loop */ : spawn_count < num_spawns) {
    join_thread(thr);
    spawn_thread(thr);
    thr = (thr + 1) % num_threads;
    spawn_count++;
  }

  thr_saved = thr;
  do {
    join_thread(thr);
    thr = (thr + 1) % num_threads;    
  } while (thr != thr_saved);

  free(thr_array);
}

--------------000700020305020106010208--
