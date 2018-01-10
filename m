From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 18/27] perf: Return empty callchain instead of NULL
Date: Wed, 10 Jan 2018 18:28:35 -0300
Message-ID: <20180110212844.12441-19-acme@kernel.org>
References: <20180110212844.12441-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180110212844.12441-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

It simplifies the code a bit, because we dump the callchain
Link: http://lkml.kernel.org/n/tip-uqp7qd6aif47g39glnbu95yl@git.kernel.org
even if it's empty. With 'empty' callchain we can remove
all the NULL-checking code paths.

Original-patch-from: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lkml.kernel.org/r/20180107160356.28203-7-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 kernel/events/core.c | 30 ++++++++++++------------------
 1 file changed, 12 insertions(+), 18 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 5fc1ded4b450..4e1a1bf8d867 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5815,19 +5815,11 @@ void perf_output_sample(struct perf_output_handle *handle,
 		perf_output_read(handle, event);
 
 	if (sample_type & PERF_SAMPLE_CALLCHAIN) {
-		if (data->callchain) {
-			int size = 1;
-
-			if (data->callchain)
-				size += data->callchain->nr;
-
-			size *= sizeof(u64);
+		int size = 1;
 
-			__output_copy(handle, data->callchain, size);
-		} else {
-			u64 nr = 0;
-			perf_output_put(handle, nr);
-		}
+		size += data->callchain->nr;
+		size *= sizeof(u64);
+		__output_copy(handle, data->callchain, size);
 	}
 
 	if (sample_type & PERF_SAMPLE_RAW) {
@@ -5980,6 +5972,8 @@ static u64 perf_virt_to_phys(u64 virt)
 	return phys_addr;
 }
 
+static struct perf_callchain_entry __empty_callchain = { .nr = 0, };
+
 static struct perf_callchain_entry *
 perf_callchain(struct perf_event *event, struct pt_regs *regs)
 {
@@ -5988,12 +5982,14 @@ perf_callchain(struct perf_event *event, struct pt_regs *regs)
 	/* Disallow cross-task user callchains. */
 	bool crosstask = event->ctx->task && event->ctx->task != current;
 	const u32 max_stack = event->attr.sample_max_stack;
+	struct perf_callchain_entry *callchain;
 
 	if (!kernel && !user)
-		return NULL;
+		return &__empty_callchain;
 
-	return get_perf_callchain(regs, 0, kernel, user,
-				  max_stack, crosstask, true);
+	callchain = get_perf_callchain(regs, 0, kernel, user,
+				       max_stack, crosstask, true);
+	return callchain ?: &__empty_callchain;
 }
 
 void perf_prepare_sample(struct perf_event_header *header,
@@ -6018,9 +6014,7 @@ void perf_prepare_sample(struct perf_event_header *header,
 		int size = 1;
 
 		data->callchain = perf_callchain(event, regs);
-
-		if (data->callchain)
-			size += data->callchain->nr;
+		size += data->callchain->nr;
 
 		header->size += size * sizeof(u64);
 	}
-- 
2.14.3
