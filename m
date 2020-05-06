From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 40/91] perf intel-pt: Consolidate thread-stack use condition
Date: Wed,  6 May 2020 12:21:43 -0300
Message-ID: <20200506152234.21977-41-acme@kernel.org>
References: <20200506152234.21977-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200506152234.21977-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

The components of the condition do not change, so consolidate them in
one variable.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lore.kernel.org/lkml/20200429150751.12570-3-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/intel-pt.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index bdb84470f7d0..b3c45276b664 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -69,6 +69,7 @@ struct intel_pt {
 	bool est_tsc;
 	bool sync_switch;
 	bool mispred_all;
+	bool use_thread_stack;
 	int have_sched_switch;
 	u32 pmu_type;
 	u64 kernel_start;
@@ -2029,8 +2030,7 @@ static int intel_pt_sample(struct intel_pt_queue *ptq)
 	if (!(state->type & INTEL_PT_BRANCH))
 		return 0;
 
-	if (pt->synth_opts.callchain || pt->synth_opts.add_callchain ||
-	    pt->synth_opts.thread_stack)
+	if (pt->use_thread_stack)
 		thread_stack__event(ptq->thread, ptq->cpu, ptq->flags, state->from_ip,
 				    state->to_ip, ptq->insn_len,
 				    state->trace_nr, true, 0, 0);
@@ -3441,6 +3441,10 @@ int intel_pt_process_auxtrace_info(union perf_event *event,
 			goto err_delete_thread;
 	}
 
+	pt->use_thread_stack = pt->synth_opts.callchain ||
+			       pt->synth_opts.add_callchain ||
+			       pt->synth_opts.thread_stack;
+
 	err = intel_pt_synth_events(pt, session);
 	if (err)
 		goto err_delete_thread;
-- 
2.21.1
