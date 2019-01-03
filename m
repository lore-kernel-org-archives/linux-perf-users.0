From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 23/29] perf thread-stack: Tidy thread_stack__bottom() usage
Date: Thu,  3 Jan 2019 09:46:03 -0300
Message-ID: <20190103124609.29672-24-acme@kernel.org>
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
tidy thread_stack__bottom() usage. Specifically, the parameter 'thread'
is not needed.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20181221120620.9659-3-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/thread-stack.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/thread-stack.c b/tools/perf/util/thread-stack.c
index 115dc4b27a1b..068c7c8db4be 100644
--- a/tools/perf/util/thread-stack.c
+++ b/tools/perf/util/thread-stack.c
@@ -449,7 +449,7 @@ static int thread_stack__pop_cp(struct thread *thread, struct thread_stack *ts,
 	return 1;
 }
 
-static int thread_stack__bottom(struct thread *thread, struct thread_stack *ts,
+static int thread_stack__bottom(struct thread_stack *ts,
 				struct perf_sample *sample,
 				struct addr_location *from_al,
 				struct addr_location *to_al, u64 ref)
@@ -474,7 +474,7 @@ static int thread_stack__bottom(struct thread *thread, struct thread_stack *ts,
 	if (!cp)
 		return -ENOMEM;
 
-	return thread_stack__push_cp(thread->ts, ip, sample->time, ref, cp,
+	return thread_stack__push_cp(ts, ip, sample->time, ref, cp,
 				     true, false);
 }
 
@@ -617,8 +617,7 @@ int thread_stack__process(struct thread *thread, struct comm *comm,
 
 	/* If the stack is empty, put the current symbol on the stack */
 	if (!ts->cnt) {
-		err = thread_stack__bottom(thread, ts, sample, from_al, to_al,
-					   ref);
+		err = thread_stack__bottom(ts, sample, from_al, to_al, ref);
 		if (err)
 			return err;
 	}
-- 
2.19.2
