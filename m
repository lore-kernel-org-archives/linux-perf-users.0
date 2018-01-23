From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 03/43] perf tools: Get rid of unused 'swapped' parameter from perf_event__synthesize_sample()
Date: Tue, 23 Jan 2018 10:12:11 -0300
Message-ID: <20180123131251.28197-4-acme@kernel.org>
References: <20180123131251.28197-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:46588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751973AbeAWNNI (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 23 Jan 2018 08:13:08 -0500
In-Reply-To: <20180123131251.28197-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>

From: Adrian Hunter <adrian.hunter@intel.com>

There is never a need to synthesize a 'swapped' sample, so all callers
to perf_event__synthesize_sample() pass 'false' as the value to
'swapped'. So get rid of the unused 'swapped' parameter.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/1516108492-21401-4-git-send-email-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-inject.c       |  3 +--
 tools/perf/tests/sample-parsing.c |  2 +-
 tools/perf/util/event.h           |  3 +--
 tools/perf/util/evsel.c           | 28 +---------------------------
 tools/perf/util/intel-bts.c       |  2 +-
 tools/perf/util/intel-pt.c        |  2 +-
 6 files changed, 6 insertions(+), 34 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 16a28547ca86..40fe919bbcf3 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -536,8 +536,7 @@ static int perf_inject__sched_stat(struct perf_tool *tool,
 	sample_sw.period = sample->period;
 	sample_sw.time	 = sample->time;
 	perf_event__synthesize_sample(event_sw, evsel->attr.sample_type,
-				      evsel->attr.read_format, &sample_sw,
-				      false);
+				      evsel->attr.read_format, &sample_sw);
 	build_id__mark_dso_hit(tool, event_sw, &sample_sw, evsel, machine);
 	return perf_event__repipe(tool, event_sw, &sample_sw, machine);
 }
diff --git a/tools/perf/tests/sample-parsing.c b/tools/perf/tests/sample-parsing.c
index 3ec6302b6498..0e2d00d69e6e 100644
--- a/tools/perf/tests/sample-parsing.c
+++ b/tools/perf/tests/sample-parsing.c
@@ -248,7 +248,7 @@ static int do_test(u64 sample_type, u64 sample_regs, u64 read_format)
 	event->header.size = sz;
 
 	err = perf_event__synthesize_sample(event, sample_type, read_format,
-					    &sample, false);
+					    &sample);
 	if (err) {
 		pr_debug("%s failed for sample_type %#"PRIx64", error %d\n",
 			 "perf_event__synthesize_sample", sample_type, err);
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index e5fbd6dd1b01..0f794744919c 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -775,8 +775,7 @@ size_t perf_event__sample_event_size(const struct perf_sample *sample, u64 type,
 				     u64 read_format);
 int perf_event__synthesize_sample(union perf_event *event, u64 type,
 				  u64 read_format,
-				  const struct perf_sample *sample,
-				  bool swapped);
+				  const struct perf_sample *sample);
 
 pid_t perf_event__synthesize_comm(struct perf_tool *tool,
 				  union perf_event *event, pid_t pid,
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 44032679180f..66fa45198a11 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2472,8 +2472,7 @@ size_t perf_event__sample_event_size(const struct perf_sample *sample, u64 type,
 
 int perf_event__synthesize_sample(union perf_event *event, u64 type,
 				  u64 read_format,
-				  const struct perf_sample *sample,
-				  bool swapped)
+				  const struct perf_sample *sample)
 {
 	u64 *array;
 	size_t sz;
@@ -2498,15 +2497,6 @@ int perf_event__synthesize_sample(union perf_event *event, u64 type,
 	if (type & PERF_SAMPLE_TID) {
 		u.val32[0] = sample->pid;
 		u.val32[1] = sample->tid;
-		if (swapped) {
-			/*
-			 * Inverse of what is done in perf_evsel__parse_sample
-			 */
-			u.val32[0] = bswap_32(u.val32[0]);
-			u.val32[1] = bswap_32(u.val32[1]);
-			u.val64 = bswap_64(u.val64);
-		}
-
 		*array = u.val64;
 		array++;
 	}
@@ -2534,13 +2524,6 @@ int perf_event__synthesize_sample(union perf_event *event, u64 type,
 	if (type & PERF_SAMPLE_CPU) {
 		u.val32[0] = sample->cpu;
 		u.val32[1] = 0;
-		if (swapped) {
-			/*
-			 * Inverse of what is done in perf_evsel__parse_sample
-			 */
-			u.val32[0] = bswap_32(u.val32[0]);
-			u.val64 = bswap_64(u.val64);
-		}
 		*array = u.val64;
 		array++;
 	}
@@ -2587,15 +2570,6 @@ int perf_event__synthesize_sample(union perf_event *event, u64 type,
 
 	if (type & PERF_SAMPLE_RAW) {
 		u.val32[0] = sample->raw_size;
-		if (WARN_ONCE(swapped,
-			      "Endianness of raw data not corrected!\n")) {
-			/*
-			 * Inverse of what is done in perf_evsel__parse_sample
-			 */
-			u.val32[0] = bswap_32(u.val32[0]);
-			u.val32[1] = bswap_32(u.val32[1]);
-			u.val64 = bswap_64(u.val64);
-		}
 		*array = u.val64;
 		array = (void *)array + sizeof(u32);
 
diff --git a/tools/perf/util/intel-bts.c b/tools/perf/util/intel-bts.c
index 7077bebc2fb0..72db2744876d 100644
--- a/tools/perf/util/intel-bts.c
+++ b/tools/perf/util/intel-bts.c
@@ -302,7 +302,7 @@ static int intel_bts_synth_branch_sample(struct intel_bts_queue *btsq,
 		event.sample.header.size = bts->branches_event_size;
 		ret = perf_event__synthesize_sample(&event,
 						    bts->branches_sample_type,
-						    0, &sample, false);
+						    0, &sample);
 		if (ret)
 			return ret;
 	}
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 2daf641beb85..3773d9c54f45 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -1102,7 +1102,7 @@ static int intel_pt_inject_event(union perf_event *event,
 				 struct perf_sample *sample, u64 type)
 {
 	event->header.size = perf_event__sample_event_size(sample, type, 0);
-	return perf_event__synthesize_sample(event, type, 0, sample, false);
+	return perf_event__synthesize_sample(event, type, 0, sample);
 }
 
 static inline int intel_pt_opt_inject(struct intel_pt *pt,
-- 
2.14.3
