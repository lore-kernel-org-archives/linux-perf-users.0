From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 23/27] perf machine: Use last_match threads cache only in single thread mode
Date: Wed, 25 Jul 2018 14:59:57 -0300
Message-ID: <20180725180001.15108-24-acme@kernel.org>
References: <20180725180001.15108-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180725180001.15108-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, David Ahern <dsahern@gmail.com>, Kan Liang <kan.liang@linux.intel.com>, Lukasz Odzioba <lukasz.odzioba@intel.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Wang Nan <wangnan0@huawei.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

There's an issue with using threads::last_match in multithread mode
which is enabled during the perf top synthesize. It might crash with
following assertion:

  perf: ...include/linux/refcount.h:109: refcount_inc:
        Assertion `!(!refcount_inc_not_zero(r))' failed.

The gdb backtrace looks like this:

  0x00007ffff50839fb in raise () from /lib64/libc.so.6
  (gdb)
  #0  0x00007ffff50839fb in raise () from /lib64/libc.so.6
  #1  0x00007ffff5085800 in abort () from /lib64/libc.so.6
  #2  0x00007ffff507c0da in __assert_fail_base () from /lib64/libc.so.6
  #3  0x00007ffff507c152 in __assert_fail () from /lib64/libc.so.6
  #4  0x0000000000535ff9 in refcount_inc (r=0x7fffe8009a70)
      at ...include/linux/refcount.h:109
  #5  0x0000000000536771 in thread__get (thread=0x7fffe8009a40)
      at util/thread.c:115
  #6  0x0000000000523cd0 in ____machine__findnew_thread (machine=0xbfde38,
      threads=0xbfdf28, pid=2, tid=2, create=true) at util/machine.c:432
  #7  0x0000000000523eb4 in __machine__findnew_thread (machine=0xbfde38,
      pid=2, tid=2) at util/machine.c:489
  #8  0x0000000000523f24 in machine__findnew_thread (machine=0xbfde38,
      pid=2, tid=2) at util/machine.c:499
  #9  0x0000000000526fbe in machine__process_fork_event (machine=0xbfde38,
  ...

The failing assertion is this one:

  REFCOUNT_WARN(!refcount_inc_not_zero(r), ...

the problem is that we don't serialize access to threads::last_match.
We serialize the access to the threads tree, but we don't care how's
threads::last_match being accessed. Both locked/unlocked paths use
that data and can set it. In multithreaded mode we can end up with
invalid object in thread__get call, like in following paths race:

  thread 1
    ...
    machine__findnew_thread
      down_write(&threads->lock);
      __machine__findnew_thread
        ____machine__findnew_thread
          th = threads->last_match;
          if (th->tid == tid) {
            thread__get

  thread 2
    ...
    machine__find_thread
      down_read(&threads->lock);
      __machine__findnew_thread
        ____machine__findnew_thread
          th = threads->last_match;
          if (th->tid == tid) {
            thread__get

  thread 3
    ...
    machine__process_fork_event
      machine__remove_thread
        __machine__remove_thread
          threads->last_match = NULL
          thread__put
      thread__put

Thread 1 and 2 might got stale last_match, before thread 3 clears
it. Thread 1 and 2 then race with thread 3's thread__put and they
might trigger the refcnt == 0 assertion above.

The patch is disabling the last_match cache for multiple thread
mode. It was originally meant for single thread scenarios, where
it's common to have multiple sequential searches of the same
thread.

In multithread mode this does not make sense, because top's threads
processes different /proc entries and so the 'struct threads' object
is queried for various threads. Moreover we'd need to add more locks
to make it work.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Lukasz Odzioba <lukasz.odzioba@intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/r/20180719143345.12963-4-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/machine.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 8992fcf42257..b300a3973448 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -413,8 +413,8 @@ static void machine__update_thread_pid(struct machine *machine,
  * the full rbtree:
  */
 static struct thread*
-threads__get_last_match(struct threads *threads, struct machine *machine,
-			int pid, int tid)
+__threads__get_last_match(struct threads *threads, struct machine *machine,
+			  int pid, int tid)
 {
 	struct thread *th;
 
@@ -431,12 +431,31 @@ threads__get_last_match(struct threads *threads, struct machine *machine,
 	return NULL;
 }
 
+static struct thread*
+threads__get_last_match(struct threads *threads, struct machine *machine,
+			int pid, int tid)
+{
+	struct thread *th = NULL;
+
+	if (perf_singlethreaded)
+		th = __threads__get_last_match(threads, machine, pid, tid);
+
+	return th;
+}
+
 static void
-threads__set_last_match(struct threads *threads, struct thread *th)
+__threads__set_last_match(struct threads *threads, struct thread *th)
 {
 	threads->last_match = th;
 }
 
+static void
+threads__set_last_match(struct threads *threads, struct thread *th)
+{
+	if (perf_singlethreaded)
+		__threads__set_last_match(threads, th);
+}
+
 /*
  * Caller must eventually drop thread->refcnt returned with a successful
  * lookup/new thread inserted.
-- 
2.14.4
