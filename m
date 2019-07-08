From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 3/8] perf thread: Allow references to thread objects after machine__exit()
Date: Mon,  8 Jul 2019 12:42:02 -0300
Message-ID: <20190708154207.11403-4-acme@kernel.org>
References: <20190708154207.11403-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190708154207.11403-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Wei Li <liwei391@huawei.com>, Adrian Hunter <adrian.hunter@intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Zhipeng Xie <xiezhipeng1@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Threads are created when we either synthesize PERF_RECORD_FORK events
for pre-existing threads or when we receive PERF_RECORD_FORK events from
the kernel as new threads get created.

We then keep them in machine->threads[].entries rb trees till when we
receive a PERF_RECORD_EXIT, i.e. that thread terminated.

The thread object has a reference count that is grabbed when, for
instance, we keep that thread referenced in struct hist_entry, in 'perf
report' and 'perf top'.

When we receive a PERF_RECORD_EXIT we remove the thread object from the
rb tree and move it to the corresponding machine->threads[].dead list,
then we do a thread__put(), dropping the reference we had for keeping it
in the rb tree.

In thread__put() we were assuming that when the reference count hit zero
we should remove it from the dead list by simply doing a
list_del_init(&thread->node).

That works well when all the thread lifetime is during the machine that
has the list heads lifetime, since we know that we can do the
list_del_init() and it will update the 'dead' list_head.

But in 'perf sched lat' we were doing:

    machine__new() (via perf_session__new)

    process events, grabbing refcounts to keep those thread objects
    in 'perf sched' local data structures.

    machine__exit() (via perf_session__delete) which would delete the
    'dead' list heads.

    And then doing the final thread__put() for the refcounts 'perf sched'
    rightfully obtained for keeping those thread object references.

    b00m, since thread__put() would do the list_del_init() touching
    a dead dead list head.

Fix it by removing all the dead threads from machine->threads[].dead at
machine__exit(), since whatever is there should have refcounts taken by
things like 'perf sched lat', and make thread__put() check if the thread
is in a linked list before removing it from that list.

Reported-by: Wei Li <liwei391@huawei.com>
Link: https://lkml.kernel.org/r/20190508143648.8153-1-liwei391@huawei.com
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Zhipeng Xie <xiezhipeng1@huawei.com>
Link: https://lkml.kernel.org/r/20190704194355.GI10740@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/machine.c | 25 +++++++++++++++++++++++--
 tools/perf/util/thread.c  | 23 ++++++++++++++++++++---
 2 files changed, 43 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index dc7aafe45a2b..e00dc413652d 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -209,6 +209,18 @@ void machine__exit(struct machine *machine)
 
 	for (i = 0; i < THREADS__TABLE_SIZE; i++) {
 		struct threads *threads = &machine->threads[i];
+		struct thread *thread, *n;
+		/*
+		 * Forget about the dead, at this point whatever threads were
+		 * left in the dead lists better have a reference count taken
+		 * by who is using them, and then, when they drop those references
+		 * and it finally hits zero, thread__put() will check and see that
+		 * its not in the dead threads list and will not try to remove it
+		 * from there, just calling thread__delete() straight away.
+		 */
+		list_for_each_entry_safe(thread, n, &threads->dead, node)
+			list_del_init(&thread->node);
+
 		exit_rwsem(&threads->lock);
 	}
 }
@@ -1758,9 +1770,11 @@ static void __machine__remove_thread(struct machine *machine, struct thread *th,
 	if (threads->last_match == th)
 		threads__set_last_match(threads, NULL);
 
-	BUG_ON(refcount_read(&th->refcnt) == 0);
 	if (lock)
 		down_write(&threads->lock);
+
+	BUG_ON(refcount_read(&th->refcnt) == 0);
+
 	rb_erase_cached(&th->rb_node, &threads->entries);
 	RB_CLEAR_NODE(&th->rb_node);
 	--threads->nr;
@@ -1770,9 +1784,16 @@ static void __machine__remove_thread(struct machine *machine, struct thread *th,
 	 * will be called and we will remove it from the dead_threads list.
 	 */
 	list_add_tail(&th->node, &threads->dead);
+
+	/*
+	 * We need to do the put here because if this is the last refcount,
+	 * then we will be touching the threads->dead head when removing the
+	 * thread.
+	 */
+	thread__put(th);
+
 	if (lock)
 		up_write(&threads->lock);
-	thread__put(th);
 }
 
 void machine__remove_thread(struct machine *machine, struct thread *th)
diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index b413ba5b9835..7bfb740d2ede 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -125,10 +125,27 @@ void thread__put(struct thread *thread)
 {
 	if (thread && refcount_dec_and_test(&thread->refcnt)) {
 		/*
-		 * Remove it from the dead_threads list, as last reference
-		 * is gone.
+		 * Remove it from the dead threads list, as last reference is
+		 * gone, if it is in a dead threads list.
+		 *
+		 * We may not be there anymore if say, the machine where it was
+		 * stored was already deleted, so we already removed it from
+		 * the dead threads and some other piece of code still keeps a
+		 * reference.
+		 *
+		 * This is what 'perf sched' does and finally drops it in
+		 * perf_sched__lat(), where it calls perf_sched__read_events(),
+		 * that processes the events by creating a session and deleting
+		 * it, which ends up destroying the list heads for the dead
+		 * threads, but before it does that it removes all threads from
+		 * it using list_del_init().
+		 *
+		 * So we need to check here if it is in a dead threads list and
+		 * if so, remove it before finally deleting the thread, to avoid
+		 * an use after free situation.
 		 */
-		list_del_init(&thread->node);
+		if (!list_empty(&thread->node))
+			list_del_init(&thread->node);
 		thread__delete(thread);
 	}
 }
-- 
2.20.1
