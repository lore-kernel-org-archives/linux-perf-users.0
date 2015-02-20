From: Benjamin Moody <benjamin.moody@gmail.com>
Subject: Bizarre results from perf event API
Date: Fri, 20 Feb 2015 23:26:10 +0000
Message-ID: <CAAk6P0UvfKGhaFJKKdRkVcZbx+XNoJLGgKtw3f-hVuNfGSjNDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:42197 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754615AbbBTX0L (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 20 Feb 2015 18:26:11 -0500
Received: by iecrp18 with SMTP id rp18so11593917iec.9
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Feb 2015 15:26:10 -0800 (PST)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

I'm trying to write a program that uses the Linux perf event API to
track the CPU usage of an arbitrary task.  I'm following the
documentation at <http://linux.die.net/man/2/perf_event_open>.

My program (highly simplified version shown below) seems to work most
of the time, and as far as I can tell, it should be measuring exactly
the same thing as what 'perf stat -e instructions:uD' measures.
However, when I try measuring the performance of a certain large
proprietary application, I get *completely* different results from my
program and from perf stat.  (The results from perf are somewhat
believable; mine are not.)

For example:

  perf stat -e instructions:uD $APP         => perf says   6157957531

  mystat $APP                               => mystat says  854145434

  mystat perf stat -e instructions:uD $APP  => perf says   6158468700
                                               mystat says  856605022

  perf stat -e instructions:uD mystat $APP  => mystat says  854139621
                                               perf says   6159312914

Especially the latter two results make no sense to me, as both perf
and my program are supposed to be counting the total number of
instructions from all descendant processes.

I have tried looking at the system calls with strace, I've tried
looking at them with gdb.  I cannot see any relevant difference
between what my program is doing, and what the perf tool does.  I am
at my wits' end here.  Can anyone see what might cause my program to
be counting fewer events than perf does?

(If there's a better place to ask this question, please let me know!)

Benjamin Moody

---- mystat.c ----

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <errno.h>
#include <unistd.h>
#include <sys/wait.h>
#include <sys/ioctl.h>
#include <linux/perf_event.h>
#include <asm/unistd.h>

static int perf_event_open(struct perf_event_attr *hw_event,
                           pid_t pid, int cpu, int group_fd,
                           unsigned long flags)
{
  int fd = syscall(__NR_perf_event_open, hw_event, pid, cpu, group_fd, flags);
  return fd;
}

static int read_perf_counter(int fd, long long *value)
{
  long long v[3];

  errno = EIO;

  if (read(fd, v, sizeof(v)) != sizeof(v))
    return 0;

  if (v[0] <= 0 || v[1] <= 0 || v[2] <= 0)
    return 0;

  if (v[1] == v[2])
    *value = v[0];
  else
    *value = (double) v[0] * v[1] / v[2];
  return 1;
}

int main(int argc, char **argv)
{
  int event_fd;
  struct perf_event_attr pe;
  pid_t child;
  long long event_count;
  int status;

  memset(&pe, 0, sizeof(pe));
  pe.size = sizeof(pe);

  pe.type = PERF_TYPE_HARDWARE;
  pe.config = PERF_COUNT_HW_INSTRUCTIONS;

  pe.read_format = (PERF_FORMAT_TOTAL_TIME_ENABLED
                    | PERF_FORMAT_TOTAL_TIME_RUNNING);

  pe.pinned = 1;                /* always track */

  pe.exclude_kernel = 1;        /* only count userspace instructions */
  pe.exclude_hv = 1;            /* (not kernel or hypervisor) */

  pe.disabled = 1;              /* counter initially disabled */
  pe.inherit = 1;               /* track all descendant processes */
  pe.enable_on_exec = 1;        /* start counting when we exec the
                                   child process */

  event_fd = perf_event_open(&pe, getpid(), -1, -1, 0);
  if (event_fd < 0) {
    fprintf(stderr, "cannot track performance: %s\n", strerror(errno));
    return 126;
  }

  child = fork();
  if (child < 0) {
    fprintf(stderr, "cannot create process: %s\n", strerror(errno));
    return 126;
  }
  else if (child == 0) {
    execvp(argv[1], &argv[1]);
    fprintf(stderr, "unable to execute command: %s\n",
            strerror(errno));
    exit(127);
  }

  while (waitpid(child, &status, 0) != child) ;

  ioctl(event_fd, PERF_EVENT_IOC_DISABLE, 0);
  if (!read_perf_counter(event_fd, &event_count)) {
    fprintf(stderr, "unable to read performance data: %s\n",
            strerror(errno));
    close(event_fd);
    return 126;
  }

  close(event_fd);

  printf("Total instructions: %lld\n", event_count);
  return 0;
}

---- end of mystat.c ----
