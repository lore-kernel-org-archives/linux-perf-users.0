From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 22/27] perf machine: Add threads__set_last_match function
Date: Wed, 25 Jul 2018 14:59:56 -0300
Message-ID: <20180725180001.15108-23-acme@kernel.org>
References: <20180725180001.15108-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180725180001.15108-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, David Ahern <dsahern@gmail.com>, Kan Liang <kan.liang@linux.intel.com>, Lukasz Odzioba <lukasz.odzioba@intel.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Wang Nan <wangnan0@huawei.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Separating threads::last_match cache set into separate
threads__set_last_match function.  This will be useful in following
patch.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Lukasz Odzioba <lukasz.odzioba@intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/r/20180719143345.12963-3-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/machine.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index df41aa1a4cf9..8992fcf42257 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -431,6 +431,12 @@ threads__get_last_match(struct threads *threads, struct machine *machine,
 	return NULL;
 }
 
+static void
+threads__set_last_match(struct threads *threads, struct thread *th)
+{
+	threads->last_match = th;
+}
+
 /*
  * Caller must eventually drop thread->refcnt returned with a successful
  * lookup/new thread inserted.
@@ -453,7 +459,7 @@ static struct thread *____machine__findnew_thread(struct machine *machine,
 		th = rb_entry(parent, struct thread, rb_node);
 
 		if (th->tid == tid) {
-			threads->last_match = th;
+			threads__set_last_match(threads, th);
 			machine__update_thread_pid(machine, th, pid);
 			return thread__get(th);
 		}
@@ -490,7 +496,7 @@ static struct thread *____machine__findnew_thread(struct machine *machine,
 		 * It is now in the rbtree, get a ref
 		 */
 		thread__get(th);
-		threads->last_match = th;
+		threads__set_last_match(threads, th);
 		++threads->nr;
 	}
 
@@ -1648,7 +1654,7 @@ static void __machine__remove_thread(struct machine *machine, struct thread *th,
 	struct threads *threads = machine__threads(machine, th->tid);
 
 	if (threads->last_match == th)
-		threads->last_match = NULL;
+		threads__set_last_match(threads, NULL);
 
 	BUG_ON(refcount_read(&th->refcnt) == 0);
 	if (lock)
-- 
2.14.4
