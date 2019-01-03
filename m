From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 26/29] perf thread-stack: Factor out thread_stack__init()
Date: Thu,  3 Jan 2019 09:46:06 -0300
Message-ID: <20190103124609.29672-27-acme@kernel.org>
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
factor out thread_stack__init().

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20181221120620.9659-6-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/thread-stack.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/thread-stack.c b/tools/perf/util/thread-stack.c
index a5f7b9d8fc23..03770af9e5cd 100644
--- a/tools/perf/util/thread-stack.c
+++ b/tools/perf/util/thread-stack.c
@@ -93,6 +93,24 @@ static int thread_stack__grow(struct thread_stack *ts)
 	return 0;
 }
 
+static int thread_stack__init(struct thread_stack *ts, struct thread *thread,
+			      struct call_return_processor *crp)
+{
+	int err;
+
+	err = thread_stack__grow(ts);
+	if (err)
+		return err;
+
+	if (thread->mg && thread->mg->machine)
+		ts->kernel_start = machine__kernel_start(thread->mg->machine);
+	else
+		ts->kernel_start = 1ULL << 63;
+	ts->crp = crp;
+
+	return 0;
+}
+
 static struct thread_stack *thread_stack__new(struct thread *thread,
 					      struct call_return_processor *crp)
 {
@@ -104,17 +122,11 @@ static struct thread_stack *thread_stack__new(struct thread *thread,
 
 	ts->arr_sz = 1;
 
-	if (thread_stack__grow(ts)) {
+	if (thread_stack__init(ts, thread, crp)) {
 		free(ts);
 		return NULL;
 	}
 
-	if (thread->mg && thread->mg->machine)
-		ts->kernel_start = machine__kernel_start(thread->mg->machine);
-	else
-		ts->kernel_start = 1ULL << 63;
-	ts->crp = crp;
-
 	thread->ts = ts;
 
 	return ts;
-- 
2.19.2
