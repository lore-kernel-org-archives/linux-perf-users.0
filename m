From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 27/29] perf thread-stack: Allocate an array of thread stacks
Date: Thu,  3 Jan 2019 09:46:07 -0300
Message-ID: <20190103124609.29672-28-acme@kernel.org>
References: <20190103124609.29672-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190103124609.29672-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

In preparation for fixing thread stack processing for the idle task,
allocate an array of thread stacks.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20181221120620.9659-7-adrian.hunter@intel.com
[ No need to check for NULL when calling zfree(), noticed by Jiri Olsa ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/thread-stack.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/thread-stack.c b/tools/perf/util/thread-stack.c
index 03770af9e5cd..248ed3945bec 100644
--- a/tools/perf/util/thread-stack.c
+++ b/tools/perf/util/thread-stack.c
@@ -114,20 +114,25 @@ static int thread_stack__init(struct thread_stack *ts, struct thread *thread,
 static struct thread_stack *thread_stack__new(struct thread *thread,
 					      struct call_return_processor *crp)
 {
-	struct thread_stack *ts;
-
-	ts = zalloc(sizeof(struct thread_stack));
-	if (!ts)
-		return NULL;
-
-	ts->arr_sz = 1;
-
-	if (thread_stack__init(ts, thread, crp)) {
-		free(ts);
-		return NULL;
+	struct thread_stack *ts = thread->ts, *new_ts;
+	unsigned int old_sz = ts ? ts->arr_sz : 0;
+	unsigned int new_sz = 1;
+
+	if (!ts || new_sz > old_sz) {
+		new_ts = calloc(new_sz, sizeof(*ts));
+		if (!new_ts)
+			return NULL;
+		if (ts)
+			memcpy(new_ts, ts, old_sz * sizeof(*ts));
+		new_ts->arr_sz = new_sz;
+		zfree(&thread->ts);
+		thread->ts = new_ts;
+		ts = new_ts;
 	}
 
-	thread->ts = ts;
+	if (!ts->stack &&
+	    thread_stack__init(ts, thread, crp))
+		return NULL;
 
 	return ts;
 }
-- 
2.19.2
