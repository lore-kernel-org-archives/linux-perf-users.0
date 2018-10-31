From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 27/28] perf intel-pt: Insert callchain context into synthesized callchains
Date: Wed, 31 Oct 2018 13:45:07 -0300
Message-ID: <20181031164508.4784-28-acme@kernel.org>
References: <20181031164508.4784-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181031164508.4784-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>, "David S . Miller" <davem@davemloft.net>, Leo Yan <leo.yan@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, stable@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

In the absence of a fallback, callchains must encode also the callchain
context. Do that now there is no fallback.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: stable@vger.kernel.org # 4.19
Link: http://lkml.kernel.org/r/100ea2ec-ed14-b56d-d810-e0a6d2f4b069@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/intel-pt.c     |  6 ++++--
 tools/perf/util/thread-stack.c | 44 +++++++++++++++++++++++++++++++++---------
 tools/perf/util/thread-stack.h |  2 +-
 3 files changed, 40 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index ffa385a029b3..60732213d16a 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -759,7 +759,8 @@ static struct intel_pt_queue *intel_pt_alloc_queue(struct intel_pt *pt,
 	if (pt->synth_opts.callchain) {
 		size_t sz = sizeof(struct ip_callchain);
 
-		sz += pt->synth_opts.callchain_sz * sizeof(u64);
+		/* Add 1 to callchain_sz for callchain context */
+		sz += (pt->synth_opts.callchain_sz + 1) * sizeof(u64);
 		ptq->chain = zalloc(sz);
 		if (!ptq->chain)
 			goto out_free;
@@ -1160,7 +1161,8 @@ static void intel_pt_prep_sample(struct intel_pt *pt,
 
 	if (pt->synth_opts.callchain) {
 		thread_stack__sample(ptq->thread, ptq->chain,
-				     pt->synth_opts.callchain_sz, sample->ip);
+				     pt->synth_opts.callchain_sz + 1,
+				     sample->ip, pt->kernel_start);
 		sample->callchain = ptq->chain;
 	}
 
diff --git a/tools/perf/util/thread-stack.c b/tools/perf/util/thread-stack.c
index c091635bf7dc..61a4286a74dc 100644
--- a/tools/perf/util/thread-stack.c
+++ b/tools/perf/util/thread-stack.c
@@ -310,20 +310,46 @@ void thread_stack__free(struct thread *thread)
 	}
 }
 
+static inline u64 callchain_context(u64 ip, u64 kernel_start)
+{
+	return ip < kernel_start ? PERF_CONTEXT_USER : PERF_CONTEXT_KERNEL;
+}
+
 void thread_stack__sample(struct thread *thread, struct ip_callchain *chain,
-			  size_t sz, u64 ip)
+			  size_t sz, u64 ip, u64 kernel_start)
 {
-	size_t i;
+	u64 context = callchain_context(ip, kernel_start);
+	u64 last_context;
+	size_t i, j;
 
-	if (!thread || !thread->ts)
-		chain->nr = 1;
-	else
-		chain->nr = min(sz, thread->ts->cnt + 1);
+	if (sz < 2) {
+		chain->nr = 0;
+		return;
+	}
 
-	chain->ips[0] = ip;
+	chain->ips[0] = context;
+	chain->ips[1] = ip;
+
+	if (!thread || !thread->ts) {
+		chain->nr = 2;
+		return;
+	}
+
+	last_context = context;
+
+	for (i = 2, j = 1; i < sz && j <= thread->ts->cnt; i++, j++) {
+		ip = thread->ts->stack[thread->ts->cnt - j].ret_addr;
+		context = callchain_context(ip, kernel_start);
+		if (context != last_context) {
+			if (i >= sz - 1)
+				break;
+			chain->ips[i++] = context;
+			last_context = context;
+		}
+		chain->ips[i] = ip;
+	}
 
-	for (i = 1; i < chain->nr; i++)
-		chain->ips[i] = thread->ts->stack[thread->ts->cnt - i].ret_addr;
+	chain->nr = i;
 }
 
 struct call_return_processor *
diff --git a/tools/perf/util/thread-stack.h b/tools/perf/util/thread-stack.h
index b7e41c4ebfdd..f97c00a8c251 100644
--- a/tools/perf/util/thread-stack.h
+++ b/tools/perf/util/thread-stack.h
@@ -84,7 +84,7 @@ int thread_stack__event(struct thread *thread, u32 flags, u64 from_ip,
 			u64 to_ip, u16 insn_len, u64 trace_nr);
 void thread_stack__set_trace_nr(struct thread *thread, u64 trace_nr);
 void thread_stack__sample(struct thread *thread, struct ip_callchain *chain,
-			  size_t sz, u64 ip);
+			  size_t sz, u64 ip, u64 kernel_start);
 int thread_stack__flush(struct thread *thread);
 void thread_stack__free(struct thread *thread);
 size_t thread_stack__depth(struct thread *thread);
-- 
2.14.4
