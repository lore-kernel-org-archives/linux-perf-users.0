From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 01/43] perf intel-pt/bts: Do not swap when synthesizing samples
Date: Tue, 23 Jan 2018 10:12:09 -0300
Message-ID: <20180123131251.28197-2-acme@kernel.org>
References: <20180123131251.28197-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180123131251.28197-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Both 'perf inject' and internal tools consume cpu endian samples, so
there is never a need to do any swapping when synthesizing samples.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/1516108492-21401-2-git-send-email-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/intel-bts.c |  6 +-----
 tools/perf/util/intel-pt.c  | 11 +++--------
 2 files changed, 4 insertions(+), 13 deletions(-)

diff --git a/tools/perf/util/intel-bts.c b/tools/perf/util/intel-bts.c
index 5325e65f9711..7077bebc2fb0 100644
--- a/tools/perf/util/intel-bts.c
+++ b/tools/perf/util/intel-bts.c
@@ -67,7 +67,6 @@ struct intel_bts {
 	u64				branches_sample_type;
 	u64				branches_id;
 	size_t				branches_event_size;
-	bool				synth_needs_swap;
 	unsigned long			num_events;
 };
 
@@ -303,8 +302,7 @@ static int intel_bts_synth_branch_sample(struct intel_bts_queue *btsq,
 		event.sample.header.size = bts->branches_event_size;
 		ret = perf_event__synthesize_sample(&event,
 						    bts->branches_sample_type,
-						    0, &sample,
-						    bts->synth_needs_swap);
+						    0, &sample, false);
 		if (ret)
 			return ret;
 	}
@@ -841,8 +839,6 @@ static int intel_bts_synth_events(struct intel_bts *bts,
 				__perf_evsel__sample_size(attr.sample_type);
 	}
 
-	bts->synth_needs_swap = evsel->needs_swap;
-
 	return 0;
 }
 
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 23f9ba676df0..2daf641beb85 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -104,8 +104,6 @@ struct intel_pt {
 	u64 pwrx_id;
 	u64 cbr_id;
 
-	bool synth_needs_swap;
-
 	u64 tsc_bit;
 	u64 mtc_bit;
 	u64 mtc_freq_bits;
@@ -1101,11 +1099,10 @@ static void intel_pt_prep_b_sample(struct intel_pt *pt,
 }
 
 static int intel_pt_inject_event(union perf_event *event,
-				 struct perf_sample *sample, u64 type,
-				 bool swapped)
+				 struct perf_sample *sample, u64 type)
 {
 	event->header.size = perf_event__sample_event_size(sample, type, 0);
-	return perf_event__synthesize_sample(event, type, 0, sample, swapped);
+	return perf_event__synthesize_sample(event, type, 0, sample, false);
 }
 
 static inline int intel_pt_opt_inject(struct intel_pt *pt,
@@ -1115,7 +1112,7 @@ static inline int intel_pt_opt_inject(struct intel_pt *pt,
 	if (!pt->synth_opts.inject)
 		return 0;
 
-	return intel_pt_inject_event(event, sample, type, pt->synth_needs_swap);
+	return intel_pt_inject_event(event, sample, type);
 }
 
 static int intel_pt_deliver_synth_b_event(struct intel_pt *pt,
@@ -2329,8 +2326,6 @@ static int intel_pt_synth_events(struct intel_pt *pt,
 		id += 1;
 	}
 
-	pt->synth_needs_swap = evsel->needs_swap;
-
 	return 0;
 }
 
-- 
2.14.3
