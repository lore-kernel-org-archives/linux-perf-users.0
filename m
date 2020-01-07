From: Namhyung Kim <namhyung@kernel.org>
Subject: [PATCHSET 0/9] perf: Improve cgroup profiling (v4)
Date: Tue,  7 Jan 2020 22:34:52 +0900
Message-ID: <20200107133501.327117-1-namhyung@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, Stephane Eranian <eranian@google.com>, LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

Hello,

This work is to improve cgroup profiling in perf.  Currently it only
supports profiling tasks in a specific cgroup and there's no way to
identify which cgroup the current sample belongs to.  So I added
PERF_SAMPLE_CGROUP to add cgroup id into each sample.  It's a 64-bit
integer having file handle of the cgroup.  And kernel also generates
PERF_RECORD_CGROUP event for new groups to correlate the cgroup id and
cgroup name (path in the cgroup filesystem).  The cgroup id can be
read from userspace by name_to_handle_at() system call so it can
synthesize the CGROUP event for existing groups.

So why do we want this?  Systems running a large number of jobs in
different cgroups want to profiling such jobs precisely. This includes
container hosting systems widely used today. Currently perf supports
namespace tracking but the systems may not use (cgroup) namespace for
their jobs. Also it'd be more intuitive to see cgroup names (as
they're given by user or sysadmin) rather than numeric
cgroup/namespace id even if they use the namespaces.

From Stephane Eranian:
> In data centers you care about attributing samples to a job not such
> much to a process.  A job may have multiple processes which may come
> and go. The cgroup on the other hand stays around for the entire
> lifetime of the job. It is much easier to map a cgroup name to a
> particular job than it is to map a pid back to a job name,
> especially for offline post-processing.

Note that this only works for "perf_event" cgroups (obviously) so if
users are still using cgroup-v1 interface, they need to have same
hierarchy for subsystem(s) want to profile with it.

 * Changes from v3:
  - staticize perf_event_cgroup()
  - fix sample parsing test

 * Changes from v2:
  - remove path_len from cgroup_event
  - bail out if kernel doesn't support cgroup sampling
  - add some description in the Kconfig

 * Changes from v1:
  - use new cgroup id (= file handle)

The code is available at perf/cgroup-v4 branch in

  git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git


The testing result looks something like this:

  [root@qemu build]# ./perf record --all-cgroups ./cgtest
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.009 MB perf.data (150 samples) ]
  
  [root@qemu build]# ./perf report -s cgroup,comm --stdio
  # To display the perf.data header info, please use --header/--header-only options.
  #
  #
  # Total Lost Samples: 0
  #
  # Samples: 150  of event 'cpu-clock:pppH'
  # Event count (approx.): 37500000
  #
  # Overhead  cgroup      Command
  # ........  ..........  .......
  #
      32.00%  /sub/cgrp2  looper2
      28.00%  /sub/cgrp1  looper1
      25.33%  /sub        looper0
       4.00%  /           cgtest 
       4.00%  /sub        cgtest 
       3.33%  /sub/cgrp2  cgtest 
       2.67%  /sub/cgrp1  cgtest 
       0.67%  /           looper0


The test program (cgtest) follows.

Thanks,
Namhyung


Cc: Tejun Heo <tj@kernel.org>
Cc: Li Zefan <lizefan@huawei.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>


-------8<-----------------------------------------8<----------------
#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <sched.h>
#include <errno.h>
#include <sys/stat.h>
#include <sys/wait.h>
#include <sys/prctl.h>
#include <sys/mount.h>

char cgbase[] = "/sys/fs/cgroup/perf_event";

void mkcgrp(char *name) {
  char buf[256];

  snprintf(buf, sizeof(buf), "%s%s", cgbase, name);
  if (mkdir(buf, 0755) < 0)
    perror("mkdir");
}

void rmcgrp(char *name) {
  char buf[256];

  snprintf(buf, sizeof(buf), "%s%s", cgbase, name);
  if (rmdir(buf) < 0)
    perror("rmdir");
}

void setcgrp(char *name) {
  char buf[256];
  int fd;

  snprintf(buf, sizeof(buf), "%s%s/tasks", cgbase, name);

  fd = open(buf, O_WRONLY);
  if (fd > 0) {
    if (write(fd, "0\n", 2) != 2)
      perror("write");
    close(fd);
  }
}

void create_sub_cgroup(int idx) {
  char buf[128];

  snprintf(buf, sizeof(buf), "/sub/cgrp%d", idx);
  mkcgrp(buf);
}

void remove_sub_cgroup(int idx) {
  char buf[128];

  snprintf(buf, sizeof(buf), "/sub/cgrp%d", idx);
  rmcgrp(buf);
}

void set_sub_cgroup(int idx) {
  char buf[128];

  snprintf(buf, sizeof(buf), "/sub/cgrp%d", idx);
  setcgrp(buf);
}

void set_task_name(int idx) {
  char buf[16];

  snprintf(buf, sizeof(buf), "looper%d", idx);
  prctl(PR_SET_NAME, buf, 0, 0, 0);
}

void loop(unsigned max) {
  volatile unsigned int count = 1;

  while (count++ != max) {
    asm volatile ("pause");
  }
}

void worker(int idx, unsigned cnt, int new_ns) {
  int oldns;

  create_sub_cgroup(idx);
  set_sub_cgroup(idx);

  if (new_ns) {
    if (unshare(CLONE_NEWCGROUP) < 0)
      perror("unshare");

#if 0  /* FIXME */
    if (unshare(CLONE_NEWNS) < 0)
      perror("unshare");

    if (mount("none", "/sys", NULL, MS_REMOUNT | MS_REC | MS_SLAVE, NULL) < 0)
      perror("mount --make-rslave");

    sleep(1);
    if (umount("/sys/fs/cgroup/perf_event") < 0)
      perror("umount");

    if (mount("cgroup", "/sys/fs/cgroup/perf_event", "cgroup",
              MS_NODEV | MS_NOEXEC | MS_NOSUID, "perf_event") < 0)
      perror("mount again");
#endif
  }

  if (fork() == 0) {
    set_task_name(idx);
    loop(cnt);
    exit(0);
  }
  wait(NULL);
}

int main(int argc, char *argv[])
{
  int i, nr = 2;
  int new_ns = 1;
  unsigned cnt = 1000000;
  int fd;

  if (argc > 1)
    nr = atoi(argv[1]);
  if (argc > 2)
    cnt = atoi(argv[2]);
  if (argc > 3)
    new_ns = atoi(argv[3]);

  mkcgrp("/sub");
  setcgrp("/sub");

  for (i = 0; i < nr; i++) {
    if (fork() == 0) {
      worker(i+1, cnt, new_ns);
      exit(0);
    }
  }

  set_task_name(0);
  loop(cnt);

  for (i = 0; i < nr; i++)
    wait(NULL);

  for (i = 0; i < nr; i++)
    remove_sub_cgroup(i+1);

  setcgrp("/");
  rmcgrp("/sub");

  return 0;
}
-------8<-----------------------------------------8<----------------


Namhyung Kim (9):
  perf/core: Add PERF_RECORD_CGROUP event
  perf/core: Add PERF_SAMPLE_CGROUP feature
  perf tools: Basic support for CGROUP event
  perf tools: Maintain cgroup hierarchy
  perf report: Add 'cgroup' sort key
  perf record: Support synthesizing cgroup events
  perf record: Add --all-cgroups option
  perf top: Add --all-cgroups option
  perf script: Add --show-cgroup-events option

 include/linux/perf_event.h                |   1 +
 include/uapi/linux/perf_event.h           |  16 ++-
 init/Kconfig                              |   3 +-
 kernel/events/core.c                      | 133 ++++++++++++++++++++++
 tools/include/uapi/linux/perf_event.h     |  16 ++-
 tools/lib/perf/include/perf/event.h       |   7 ++
 tools/perf/Documentation/perf-record.txt  |   5 +-
 tools/perf/Documentation/perf-report.txt  |   1 +
 tools/perf/Documentation/perf-script.txt  |   3 +
 tools/perf/Documentation/perf-top.txt     |   4 +
 tools/perf/builtin-diff.c                 |   1 +
 tools/perf/builtin-record.c               |  10 ++
 tools/perf/builtin-report.c               |   1 +
 tools/perf/builtin-script.c               |  41 +++++++
 tools/perf/builtin-top.c                  |   9 ++
 tools/perf/tests/sample-parsing.c         |   6 +-
 tools/perf/util/cgroup.c                  |  75 +++++++++++-
 tools/perf/util/cgroup.h                  |  16 ++-
 tools/perf/util/event.c                   |  19 ++++
 tools/perf/util/event.h                   |   6 +
 tools/perf/util/evsel.c                   |  17 ++-
 tools/perf/util/evsel.h                   |   1 +
 tools/perf/util/hist.c                    |   7 ++
 tools/perf/util/hist.h                    |   1 +
 tools/perf/util/machine.c                 |  19 ++++
 tools/perf/util/machine.h                 |   3 +
 tools/perf/util/perf_event_attr_fprintf.c |   2 +
 tools/perf/util/record.h                  |   1 +
 tools/perf/util/session.c                 |   8 ++
 tools/perf/util/sort.c                    |  31 +++++
 tools/perf/util/sort.h                    |   2 +
 tools/perf/util/synthetic-events.c        | 127 +++++++++++++++++++++
 tools/perf/util/synthetic-events.h        |   1 +
 tools/perf/util/tool.h                    |   2 +
 34 files changed, 581 insertions(+), 14 deletions(-)


base-commit: 6c4798d3f08b81c2c52936b10e0fa872590c96ae
-- 
2.24.1.735.g03f4e72817-goog
