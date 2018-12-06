From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 51/75] perf top: Use cond variable instead of a lock
Date: Thu,  6 Dec 2018 18:25:38 -0300
Message-ID: <20181206212602.20474-52-acme@kernel.org>
References: <20181206212602.20474-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181206212602.20474-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Use conditional variable logic to synchronize between the reading and
processing threads. Currently it's done by having mutex around rotation
code.

Using a POSIX cond variable to sync both threads after queues rotation:

  Process thread:

    - Detects data
    - Switches queues
    - Sets rotate variable
    - Waits in pthread_cond_wait()

  Read thread:

    - Detects rotate is set
    - Kicks the process thread with a pthread_cond_signal()

After this rotation is safely completed and both threads can continue
with the new queue.

Acked-by: David S. Miller <davem@davemloft.net>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/n/tip-3rdeg23rv3brvy1pwt3igvyw@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-top.c | 24 +++++++++++++++++-------
 tools/perf/util/top.h    |  4 +++-
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 75afeae7f04d..aad58643102e 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -846,13 +846,18 @@ static void perf_top__mmap_read_idx(struct perf_top *top, int idx)
 		if (ret && ret != -1)
 			break;
 
-		pthread_mutex_lock(&top->qe.lock);
 		ret = ordered_events__queue(top->qe.in, event, timestamp, 0);
-		pthread_mutex_unlock(&top->qe.lock);
-
-		perf_mmap__consume(md);
 		if (ret)
 			break;
+
+		perf_mmap__consume(md);
+
+		if (top->qe.rotate) {
+			pthread_mutex_lock(&top->qe.mutex);
+			top->qe.rotate = false;
+			pthread_cond_signal(&top->qe.cond);
+			pthread_mutex_unlock(&top->qe.mutex);
+		}
 	}
 
 	perf_mmap__read_done(md);
@@ -1059,9 +1064,12 @@ static void *process_thread(void *arg)
 			continue;
 		}
 
-		pthread_mutex_lock(&top->qe.lock);
 		out = rotate_queues(top);
-		pthread_mutex_unlock(&top->qe.lock);
+
+		pthread_mutex_lock(&top->qe.mutex);
+		top->qe.rotate = true;
+		pthread_cond_wait(&top->qe.cond, &top->qe.mutex);
+		pthread_mutex_unlock(&top->qe.mutex);
 
 		if (ordered_events__flush(out, OE_FLUSH__TOP))
 			pr_err("failed to process events\n");
@@ -1151,7 +1159,8 @@ static void init_process_thread(struct perf_top *top)
 	ordered_events__set_copy_on_queue(&top->qe.data[0], true);
 	ordered_events__set_copy_on_queue(&top->qe.data[1], true);
 	top->qe.in = &top->qe.data[0];
-	pthread_mutex_init(&top->qe.lock, NULL);
+	pthread_mutex_init(&top->qe.mutex, NULL);
+	pthread_cond_init(&top->qe.cond, NULL);
 }
 
 static int __cmd_top(struct perf_top *top)
@@ -1271,6 +1280,7 @@ static int __cmd_top(struct perf_top *top)
 out_join:
 	pthread_join(thread, NULL);
 out_join_thread:
+	pthread_cond_signal(&top->qe.cond);
 	pthread_join(thread_process, NULL);
 out_delete:
 	perf_session__delete(top->session);
diff --git a/tools/perf/util/top.h b/tools/perf/util/top.h
index 5f503293cfd8..5bce62ebcf14 100644
--- a/tools/perf/util/top.h
+++ b/tools/perf/util/top.h
@@ -44,7 +44,9 @@ struct perf_top {
 	struct {
 		struct ordered_events	*in;
 		struct ordered_events	 data[2];
-		pthread_mutex_t		 lock;
+		bool			 rotate;
+		pthread_mutex_t		 mutex;
+		pthread_cond_t		 cond;
 	} qe;
 };
 
-- 
2.19.2
