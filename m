From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 22/29] perf thread-stack: Simplify some code in thread_stack__process()
Date: Thu,  3 Jan 2019 09:46:02 -0300
Message-ID: <20190103124609.29672-23-acme@kernel.org>
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
simplify some code in thread_stack__process().

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20181221120620.9659-2-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/thread-stack.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/tools/perf/util/thread-stack.c b/tools/perf/util/thread-stack.c
index 61a4286a74dc..115dc4b27a1b 100644
--- a/tools/perf/util/thread-stack.c
+++ b/tools/perf/util/thread-stack.c
@@ -593,17 +593,13 @@ int thread_stack__process(struct thread *thread, struct comm *comm,
 	struct thread_stack *ts = thread->ts;
 	int err = 0;
 
-	if (ts) {
-		if (!ts->crp) {
-			/* Supersede thread_stack__event() */
-			thread_stack__free(thread);
-			thread->ts = thread_stack__new(thread, crp);
-			if (!thread->ts)
-				return -ENOMEM;
-			ts = thread->ts;
-			ts->comm = comm;
-		}
-	} else {
+	if (ts && !ts->crp) {
+		/* Supersede thread_stack__event() */
+		thread_stack__free(thread);
+		ts = NULL;
+	}
+
+	if (!ts) {
 		thread->ts = thread_stack__new(thread, crp);
 		if (!thread->ts)
 			return -ENOMEM;
-- 
2.19.2
