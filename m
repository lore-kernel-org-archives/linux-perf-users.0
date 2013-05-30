From: rjs@netti.fi (Riku Saikkonen)
Subject: Using perf and cgroups to profile part of a long-running program
Date: Fri, 31 May 2013 02:45:44 +0300
Message-ID: <87y5awf2vr.fsf@anar.lloke.localnet>
References: <4F22D8D9.3010108@rgmadvisors.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from vs17.mail.saunalahti.fi ([62.142.117.198]:35118 "EHLO
	vs17.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751259Ab3E3Xxz (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 30 May 2013 19:53:55 -0400
Received: from vams (localhost [127.0.0.1])
	by vs17.mail.saunalahti.fi (Postfix) with SMTP id F176810004C
	for <linux-perf-users@vger.kernel.org>; Fri, 31 May 2013 02:47:25 +0300 (EEST)
Received: from gw03.mail.saunalahti.fi (gw03.mail.saunalahti.fi [195.197.172.111])
	by vs17.mail.saunalahti.fi (Postfix) with ESMTP id DFE4C10004C
	for <linux-perf-users@vger.kernel.org>; Fri, 31 May 2013 02:47:25 +0300 (EEST)
Received: from anar.lloke.localnet (a88-112-121-171.elisa-laajakaista.fi [88.112.121.171])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by gw03.mail.saunalahti.fi (Postfix) with ESMTP id B81B5216685
	for <linux-perf-users@vger.kernel.org>; Fri, 31 May 2013 02:47:24 +0300 (EEST)
In-Reply-To: <4F22D8D9.3010108@rgmadvisors.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi,

This thread from a year and a half ago:

    http://comments.gmane.org/gmane.linux.kernel/1244915
    (or http://permalink.gmane.org/gmane.linux.kernel.perf.user/790
    for the initial post)

talks about profiling part of a long-running program using perf, and
notes that prctl(PR_TASK_PERF_EVENTS_DISABLE) does not work for this.
(By the way, as noted in the thread, its documentation in
tools/perf/design.txt is not very helpful - I was initially misled and
tried to use it just like the original poster in the thread above.)

The discussion in the thread was inconclusive, but talks about whether
there should be better self-profiling support and/or some kind of
user-defined contexts for events that could be used to select when
events are counted. For a use case and more on the latter, see:

    http://permalink.gmane.org/gmane.linux.kernel.perf.user/984

I'd like to point out something that wasn't mentioned in the above
thread: cgroups actually provide a rudimentary way for co-operating
user-space code to select when perf should count events and when it
should not. The code to be profiled should simply switch itself to a
specific cgroup (say "doperf") when it wants perf to count events, and
switch back when it doesn't; and perf should be run with -G doperf to
count events only in this cgroup. I give a full example below that uses
this approach to profile only part of a program.

I also have a few questions:

 - Has something changed after the above discussion, i.e., is there some
   other support in the perf tools to (maybe co-operatively) profile
   only part of a program? (I did not find any...)

 - Does this cgroup approach feel like the proper thing to do, i.e.,
   should I be doing this kind of thing with perf and cgroups at all?

   I found very little documentation on this, and I wasn't sure if there
   would be too much overhead, or even if the perf cgroup support worked
   like this at all. But it appears to work. (For instance, I feared
   that -G would just be a shorthand for specifying an explicit list of
   pids to monitor - but it isn't, since later changes to the list of
   processes in a given cgroup are noticed.)

 - I had to use -a in "perf stat -e branch-misses -a -G doperf
   ./perftest_cg" below, and thus run perf as root. Without -a I got the
   error "both cgroup and no-aggregation modes only available in
   system-wide mode". I guess this is because the -G option profiles the
   full cgroup and not only the subprocess executed by perf stat. Maybe
   the API and/or toolset could be changed to allow using -G as a
   non-root user, perhaps by adding an option to profile a specific
   pid/command only when it is part of the given cgroup?

(I also know about the PAPI library http://icl.cs.utk.edu/papi/ which is
a non-Linux-specific user-space library for self-profiling using the
hardware performance counters, and uses the perf kernel API on Linux. It
would perhaps be a better choice for self-profiling hardware events like
in the example below, but it of course works completely differently from
the rather nice perf toolset. So the cgroup approach provides a way to
use the perf tools and still select which parts of the program to
profile.)

My perf-with-cgroup example follows. I hope I'm using cgroups correctly
(I don't really know much about them) - at least it appears to work...

/*
 * An example for profiling part of a program by using perf cgroup support
 * (needs libcgroup; I used version 0.38 from Debian package libcgroup-dev)
 *
 * This example demonstrates branch prediction misses caused by
 * looping through a random array and branching based on the value of
 * each element; since random data cannot be predicted, about one half
 * of the predictions should be incorrect. (For an explanation of the
 * phenomenon, see <http://stackoverflow.com/questions/11227809>.)
 *
 * Compile:
 * $ gcc -Wall -g -O6 -march=native -DNO_CGROUPS -DNO_TEST_CODE -o perftest_notest perftest.c
 * $ gcc -Wall -g -O6 -march=native -DNO_CGROUPS -o perftest_nocg perftest.c
 * $ gcc -Wall -g -O6 -march=native -o perftest_cg perftest.c -lcgroup
 *
 * Test without using cgroups:
 * $ perf stat -e branch-misses ./perftest_nocg
 * $ perf stat -e branch-misses ./perftest_notest
 * (The difference of the two results should be about LOOPSZ/2 =
 * 50000000 branch misses. This non-cgroup approach works here, but
 * would not work in more complex code, e.g., if the deinitialization
 * code acts substantially differently when the actual code to be
 * tested is removed.)
 *
 * Initialize cgroups for test below (# = run as root; change /mnt to whatever):
 * # mount -t cgroup -o perf_event myperf /mnt
 * # cgcreate -g perf_event:doperf     # or just mkdir /mnt/doperf
 *
 * Test with cgroups (should give about LOOPSZ/2 branch misses):
 * # perf stat -e branch-misses -a -G doperf ./perftest_cg
 * or (if you want to run perftest_cg as a non-root user):
 * # perf stat -e branch-misses -a -G doperf sleep 10
 * $ ./perftest_cg
 *
 * Deinitialize the cgroups:
 * # rmdir /mnt/doperf     # I can't find a tool like cgcreate for removing
 * # umount /mnt
 */

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#ifndef NO_CGROUPS
#include <libcgroup.h>
#endif

#ifndef ASZ
#define ASZ 100000000
#endif

#ifndef LOOPSZ
#define LOOPSZ ASZ
#endif

#ifndef NO_CGROUPS
struct cgroup *cg_doperf, *cg_original;
#endif

int count = 0;

/*
 * Use a non-inlined function to force the compiler to create a branch
 * that calls it instead of, e.g., a conditional move instruction.
 */
__attribute__((noinline)) void inc_count(void) {
  count++;
}

void do_test(void) {
  int i;
  int *a = malloc(ASZ * sizeof(int));

  srandom(1);

  for (i = 0; i < ASZ; i++)
    a[i] = (random() > RAND_MAX/2);

  /*
   * Now everything has been initialized; we are interested in
   * profiling only the code that follows.
   */

#ifndef NO_TEST_CODE

#ifndef NO_CGROUPS
  cgroup_attach_task(cg_doperf);
#endif

  for (i = 0; i < LOOPSZ; i++)
    if (a[i])
      inc_count();

#ifndef NO_CGROUPS
  cgroup_attach_task(cg_original);
#endif

#endif

  /*
   * End of interesting code; the following should not be profiled.
   */

  printf("%d\n", count);      /* the value should be about LOOPSZ/2 */
  free(a);
}

int main(void) {
#ifndef NO_CGROUPS
  char *cpath = NULL;

  cgroup_init();

  cgroup_get_current_controller_path(getpid(), "perf_event", &cpath);
  cg_original = cgroup_new_cgroup(cpath);
  free(cpath);
  cgroup_add_controller(cg_original, "perf_event");

  cg_doperf = cgroup_new_cgroup("doperf");
  cgroup_add_controller(cg_doperf, "perf_event");
#endif

  do_test();

#ifndef NO_CGROUPS
  cgroup_free(&cg_doperf);
  cgroup_free(&cg_original);
#endif

  return 0;
}
