Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 400C9C433F5
	for <linux-perf-users@archiver.kernel.org>; Tue,  7 Sep 2021 16:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28A2760F13
	for <linux-perf-users@archiver.kernel.org>; Tue,  7 Sep 2021 16:41:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344858AbhIGQmm (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 7 Sep 2021 12:42:42 -0400
Received: from mga07.intel.com ([134.134.136.100]:27264 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344732AbhIGQmi (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 7 Sep 2021 12:42:38 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10099"; a="283959539"
X-IronPort-AV: E=Sophos;i="5.85,274,1624345200"; 
   d="scan'208";a="283959539"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2021 09:38:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,274,1624345200"; 
   d="scan'208";a="430979316"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.174])
  by orsmga003.jf.intel.com with ESMTP; 07 Sep 2021 09:38:46 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Leo Yan <leo.yan@linaro.org>,
        Kan Liang <kan.liang@linux.intel.com>, x86@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 3/3] perf intel-pt: Add support for PERF_RECORD_AUX_OUTPUT_HW_ID
Date:   Tue,  7 Sep 2021 19:39:03 +0300
Message-Id: <20210907163903.11820-4-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210907163903.11820-1-adrian.hunter@intel.com>
References: <20210907163903.11820-1-adrian.hunter@intel.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Originally, software only supported redirecting at most one PEBS event to
Intel PT (PEBS-via-PT) because it was not able to differentiate one event
from another. To overcome that, add support for the
PERF_RECORD_AUX_OUTPUT_HW_ID side-band event.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/Documentation/perf-intel-pt.txt |  7 +-
 tools/perf/util/intel-pt.c                 | 85 +++++++++++++++++++++-
 2 files changed, 87 insertions(+), 5 deletions(-)

diff --git a/tools/perf/Documentation/perf-intel-pt.txt b/tools/perf/Documentation/perf-intel-pt.txt
index 184ba62420f0..19f792876085 100644
--- a/tools/perf/Documentation/perf-intel-pt.txt
+++ b/tools/perf/Documentation/perf-intel-pt.txt
@@ -1144,7 +1144,12 @@ Recording is selected by using the aux-output config term e.g.
 
 	perf record -c 10000 -e '{intel_pt/branch=0/,cycles/aux-output/ppp}' uname
 
-Note that currently, software only supports redirecting at most one PEBS event.
+Originally, software only supported redirecting at most one PEBS event because it
+was not able to differentiate one event from another. To overcome that, more recent
+kernels and perf tools add support for the PERF_RECORD_AUX_OUTPUT_HW_ID side-band event.
+To check for the presence of that event in a PEBS-via-PT trace:
+
+	perf script -D --no-itrace | grep PERF_RECORD_AUX_OUTPUT_HW_ID
 
 To display PEBS events from the Intel PT trace, use the itrace 'o' option e.g.
 
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 6f852b305e92..1073c56a512c 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -111,6 +111,7 @@ struct intel_pt {
 	u64 cbr_id;
 	u64 psb_id;
 
+	bool single_pebs;
 	bool sample_pebs;
 	struct evsel *pebs_evsel;
 
@@ -148,6 +149,14 @@ enum switch_state {
 	INTEL_PT_SS_EXPECTING_SWITCH_IP,
 };
 
+/* applicable_counters is 64-bits */
+#define INTEL_PT_MAX_PEBS 64
+
+struct intel_pt_pebs_event {
+	struct evsel *evsel;
+	u64 id;
+};
+
 struct intel_pt_queue {
 	struct intel_pt *pt;
 	unsigned int queue_nr;
@@ -189,6 +198,7 @@ struct intel_pt_queue {
 	u64 last_br_cyc_cnt;
 	unsigned int cbr_seen;
 	char insn[INTEL_PT_INSN_BUF_SZ];
+	struct intel_pt_pebs_event pebs[INTEL_PT_MAX_PEBS];
 };
 
 static void intel_pt_dump(struct intel_pt *pt __maybe_unused,
@@ -1978,15 +1988,13 @@ static void intel_pt_add_lbrs(struct branch_stack *br_stack,
 	}
 }
 
-static int intel_pt_synth_pebs_sample(struct intel_pt_queue *ptq)
+static int intel_pt_do_synth_pebs_sample(struct intel_pt_queue *ptq, struct evsel *evsel, u64 id)
 {
 	const struct intel_pt_blk_items *items = &ptq->state->items;
 	struct perf_sample sample = { .ip = 0, };
 	union perf_event *event = ptq->event_buf;
 	struct intel_pt *pt = ptq->pt;
-	struct evsel *evsel = pt->pebs_evsel;
 	u64 sample_type = evsel->core.attr.sample_type;
-	u64 id = evsel->core.id[0];
 	u8 cpumode;
 	u64 regs[8 * sizeof(sample.intr_regs.mask)];
 
@@ -2112,6 +2120,45 @@ static int intel_pt_synth_pebs_sample(struct intel_pt_queue *ptq)
 	return intel_pt_deliver_synth_event(pt, event, &sample, sample_type);
 }
 
+static int intel_pt_synth_single_pebs_sample(struct intel_pt_queue *ptq)
+{
+	struct intel_pt *pt = ptq->pt;
+	struct evsel *evsel = pt->pebs_evsel;
+	u64 id = evsel->core.id[0];
+
+	return intel_pt_do_synth_pebs_sample(ptq, evsel, id);
+}
+
+static int intel_pt_synth_pebs_sample(struct intel_pt_queue *ptq)
+{
+	const struct intel_pt_blk_items *items = &ptq->state->items;
+	struct intel_pt_pebs_event *pe;
+	struct intel_pt *pt = ptq->pt;
+	int err = -EINVAL;
+	int hw_id;
+
+	if (!items->has_applicable_counters || !items->applicable_counters) {
+		if (!pt->single_pebs)
+			pr_err("PEBS-via-PT record with no applicable_counters\n");
+		return intel_pt_synth_single_pebs_sample(ptq);
+	}
+
+	for_each_set_bit(hw_id, &items->applicable_counters, INTEL_PT_MAX_PEBS) {
+		pe = &ptq->pebs[hw_id];
+		if (!pe->evsel) {
+			if (!pt->single_pebs)
+				pr_err("PEBS-via-PT record with no matching event, hw_id %d\n",
+				       hw_id);
+			return intel_pt_synth_single_pebs_sample(ptq);
+		}
+		err = intel_pt_do_synth_pebs_sample(ptq, pe->evsel, pe->id);
+		if (err)
+			return err;
+	}
+
+	return err;
+}
+
 static int intel_pt_synth_error(struct intel_pt *pt, int code, int cpu,
 				pid_t pid, pid_t tid, u64 ip, u64 timestamp)
 {
@@ -2882,6 +2929,30 @@ static int intel_pt_process_itrace_start(struct intel_pt *pt,
 					event->itrace_start.tid);
 }
 
+static int intel_pt_process_aux_output_hw_id(struct intel_pt *pt,
+					     union perf_event *event,
+					     struct perf_sample *sample)
+{
+	u64 hw_id = event->aux_output_hw_id.hw_id;
+	struct auxtrace_queue *queue;
+	struct intel_pt_queue *ptq;
+	struct evsel *evsel;
+
+	queue = auxtrace_queues__sample_queue(&pt->queues, sample, pt->session);
+	evsel = evlist__id2evsel_strict(pt->session->evlist, sample->id);
+	if (!queue || !queue->priv || !evsel || hw_id > INTEL_PT_MAX_PEBS) {
+		pr_err("Bad AUX output hardware ID\n");
+		return -EINVAL;
+	}
+
+	ptq = queue->priv;
+
+	ptq->pebs[hw_id].evsel = evsel;
+	ptq->pebs[hw_id].id = sample->id;
+
+	return 0;
+}
+
 static int intel_pt_find_map(struct thread *thread, u8 cpumode, u64 addr,
 			     struct addr_location *al)
 {
@@ -3009,6 +3080,8 @@ static int intel_pt_process_event(struct perf_session *session,
 		err = intel_pt_process_switch(pt, sample);
 	else if (event->header.type == PERF_RECORD_ITRACE_START)
 		err = intel_pt_process_itrace_start(pt, event, sample);
+	else if (event->header.type == PERF_RECORD_AUX_OUTPUT_HW_ID)
+		err = intel_pt_process_aux_output_hw_id(pt, event, sample);
 	else if (event->header.type == PERF_RECORD_SWITCH ||
 		 event->header.type == PERF_RECORD_SWITCH_CPU_WIDE)
 		err = intel_pt_context_switch(pt, event, sample);
@@ -3393,9 +3466,13 @@ static void intel_pt_setup_pebs_events(struct intel_pt *pt)
 
 	evlist__for_each_entry(pt->session->evlist, evsel) {
 		if (evsel->core.attr.aux_output && evsel->core.id) {
+			if (pt->single_pebs) {
+				pt->single_pebs = false;
+				return;
+			}
+			pt->single_pebs = true;
 			pt->sample_pebs = true;
 			pt->pebs_evsel = evsel;
-			return;
 		}
 	}
 }
-- 
2.17.1

