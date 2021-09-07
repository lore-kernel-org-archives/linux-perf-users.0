Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4FEDC433EF
	for <linux-perf-users@archiver.kernel.org>; Tue,  7 Sep 2021 16:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABE6D61090
	for <linux-perf-users@archiver.kernel.org>; Tue,  7 Sep 2021 16:41:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbhIGQme (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 7 Sep 2021 12:42:34 -0400
Received: from mga07.intel.com ([134.134.136.100]:27264 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344690AbhIGQmd (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 7 Sep 2021 12:42:33 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10099"; a="283959502"
X-IronPort-AV: E=Sophos;i="5.85,274,1624345200"; 
   d="scan'208";a="283959502"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2021 09:38:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,274,1624345200"; 
   d="scan'208";a="430979291"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.174])
  by orsmga003.jf.intel.com with ESMTP; 07 Sep 2021 09:38:43 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Leo Yan <leo.yan@linaro.org>,
        Kan Liang <kan.liang@linux.intel.com>, x86@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 2/3] perf tools: Add support for PERF_RECORD_AUX_OUTPUT_HW_ID
Date:   Tue,  7 Sep 2021 19:39:02 +0300
Message-Id: <20210907163903.11820-3-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210907163903.11820-1-adrian.hunter@intel.com>
References: <20210907163903.11820-1-adrian.hunter@intel.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The PERF_RECORD_AUX_OUTPUT_HW_ID event provides a way to match AUX output
data like Intel PT PEBS-via-PT back to the event that it came from, by
providing a hardware ID that is present in the AUX output.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
---
 tools/include/uapi/linux/perf_event.h | 15 +++++++++++++++
 tools/lib/perf/include/perf/event.h   |  6 ++++++
 tools/perf/builtin-inject.c           |  4 +++-
 tools/perf/builtin-record.c           |  2 +-
 tools/perf/util/event.c               | 18 ++++++++++++++++++
 tools/perf/util/event.h               |  5 +++++
 tools/perf/util/machine.c             | 10 ++++++++++
 tools/perf/util/machine.h             |  2 ++
 tools/perf/util/session.c             |  5 +++++
 tools/perf/util/tool.h                |  1 +
 10 files changed, 66 insertions(+), 2 deletions(-)

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index f92880a15645..c89535de1ec8 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -1141,6 +1141,21 @@ enum perf_event_type {
 	 */
 	PERF_RECORD_TEXT_POKE			= 20,
 
+	/*
+	 * Data written to the AUX area by hardware due to aux_output, may need
+	 * to be matched to the event by an architecture-specific hardware ID.
+	 * This records the hardware ID, but requires sample_id to provide the
+	 * event ID. e.g. Intel PT uses this record to disambiguate PEBS-via-PT
+	 * records from multiple events.
+	 *
+	 * struct {
+	 *	struct perf_event_header	header;
+	 *	u64				hw_id;
+	 *	struct sample_id		sample_id;
+	 * };
+	 */
+	PERF_RECORD_AUX_OUTPUT_HW_ID		= 21,
+
 	PERF_RECORD_MAX,			/* non-ABI */
 };
 
diff --git a/tools/lib/perf/include/perf/event.h b/tools/lib/perf/include/perf/event.h
index 095d60144a70..acc4fa065ec7 100644
--- a/tools/lib/perf/include/perf/event.h
+++ b/tools/lib/perf/include/perf/event.h
@@ -289,6 +289,11 @@ struct perf_record_itrace_start {
 	__u32			 tid;
 };
 
+struct perf_record_aux_output_hw_id {
+	struct perf_event_header header;
+	__u64			hw_id;
+};
+
 struct perf_record_thread_map_entry {
 	__u64			 pid;
 	char			 comm[16];
@@ -414,6 +419,7 @@ union perf_event {
 	struct perf_record_auxtrace_error	auxtrace_error;
 	struct perf_record_aux			aux;
 	struct perf_record_itrace_start		itrace_start;
+	struct perf_record_aux_output_hw_id	aux_output_hw_id;
 	struct perf_record_switch		context_switch;
 	struct perf_record_thread_map		thread_map;
 	struct perf_record_cpu_map		cpu_map;
diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 6ad191e731fc..ac6c570029e3 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -815,7 +815,8 @@ static int __cmd_inject(struct perf_inject *inject)
 		inject->tool.auxtrace_info  = perf_event__process_auxtrace_info;
 		inject->tool.auxtrace	    = perf_event__process_auxtrace;
 		inject->tool.aux	    = perf_event__drop_aux;
-		inject->tool.itrace_start   = perf_event__drop_aux,
+		inject->tool.itrace_start   = perf_event__drop_aux;
+		inject->tool.aux_output_hw_id = perf_event__drop_aux;
 		inject->tool.ordered_events = true;
 		inject->tool.ordering_requires_timestamps = true;
 		/* Allow space in the header for new attributes */
@@ -882,6 +883,7 @@ int cmd_inject(int argc, const char **argv)
 			.lost_samples	= perf_event__repipe,
 			.aux		= perf_event__repipe,
 			.itrace_start	= perf_event__repipe,
+			.aux_output_hw_id = perf_event__repipe,
 			.context_switch	= perf_event__repipe,
 			.throttle	= perf_event__repipe,
 			.unthrottle	= perf_event__repipe,
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index b3509d9d20cc..71a08eeea252 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1409,7 +1409,7 @@ static int record__synthesize(struct record *rec, bool tail)
 		goto out;
 
 	/* Synthesize id_index before auxtrace_info */
-	if (rec->opts.auxtrace_sample_mode) {
+	if (rec->opts.auxtrace_sample_mode || rec->opts.full_auxtrace) {
 		err = perf_event__synthesize_id_index(tool,
 						      process_synthesized_event,
 						      session->evlist, machine);
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index ac706304afe9..fe24801f8e9f 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -57,6 +57,7 @@ static const char *perf_event__names[] = {
 	[PERF_RECORD_BPF_EVENT]			= "BPF_EVENT",
 	[PERF_RECORD_CGROUP]			= "CGROUP",
 	[PERF_RECORD_TEXT_POKE]			= "TEXT_POKE",
+	[PERF_RECORD_AUX_OUTPUT_HW_ID]		= "AUX_OUTPUT_HW_ID",
 	[PERF_RECORD_HEADER_ATTR]		= "ATTR",
 	[PERF_RECORD_HEADER_EVENT_TYPE]		= "EVENT_TYPE",
 	[PERF_RECORD_HEADER_TRACING_DATA]	= "TRACING_DATA",
@@ -237,6 +238,14 @@ int perf_event__process_itrace_start(struct perf_tool *tool __maybe_unused,
 	return machine__process_itrace_start_event(machine, event);
 }
 
+int perf_event__process_aux_output_hw_id(struct perf_tool *tool __maybe_unused,
+					 union perf_event *event,
+					 struct perf_sample *sample __maybe_unused,
+					 struct machine *machine)
+{
+	return machine__process_aux_output_hw_id_event(machine, event);
+}
+
 int perf_event__process_lost_samples(struct perf_tool *tool __maybe_unused,
 				     union perf_event *event,
 				     struct perf_sample *sample,
@@ -407,6 +416,12 @@ size_t perf_event__fprintf_itrace_start(union perf_event *event, FILE *fp)
 		       event->itrace_start.pid, event->itrace_start.tid);
 }
 
+size_t perf_event__fprintf_aux_output_hw_id(union perf_event *event, FILE *fp)
+{
+	return fprintf(fp, " hw_id: %#"PRI_lx64"\n",
+		       event->aux_output_hw_id.hw_id);
+}
+
 size_t perf_event__fprintf_switch(union perf_event *event, FILE *fp)
 {
 	bool out = event->header.misc & PERF_RECORD_MISC_SWITCH_OUT;
@@ -534,6 +549,9 @@ size_t perf_event__fprintf(union perf_event *event, struct machine *machine, FIL
 	case PERF_RECORD_TEXT_POKE:
 		ret += perf_event__fprintf_text_poke(event, machine, fp);
 		break;
+	case PERF_RECORD_AUX_OUTPUT_HW_ID:
+		ret += perf_event__fprintf_aux_output_hw_id(event, fp);
+		break;
 	default:
 		ret += fprintf(fp, "\n");
 	}
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index 19ad64f2bd83..95ffed66369c 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -330,6 +330,10 @@ int perf_event__process_itrace_start(struct perf_tool *tool,
 				     union perf_event *event,
 				     struct perf_sample *sample,
 				     struct machine *machine);
+int perf_event__process_aux_output_hw_id(struct perf_tool *tool,
+					 union perf_event *event,
+					 struct perf_sample *sample,
+					 struct machine *machine);
 int perf_event__process_switch(struct perf_tool *tool,
 			       union perf_event *event,
 			       struct perf_sample *sample,
@@ -397,6 +401,7 @@ size_t perf_event__fprintf_mmap2(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf_task(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf_aux(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf_itrace_start(union perf_event *event, FILE *fp);
+size_t perf_event__fprintf_aux_output_hw_id(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf_switch(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf_thread_map(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf_cpu_map(union perf_event *event, FILE *fp);
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index da19be7da284..c6b11cd82009 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -755,6 +755,14 @@ int machine__process_itrace_start_event(struct machine *machine __maybe_unused,
 	return 0;
 }
 
+int machine__process_aux_output_hw_id_event(struct machine *machine __maybe_unused,
+					    union perf_event *event)
+{
+	if (dump_trace)
+		perf_event__fprintf_aux_output_hw_id(event, stdout);
+	return 0;
+}
+
 int machine__process_switch_event(struct machine *machine __maybe_unused,
 				  union perf_event *event)
 {
@@ -2028,6 +2036,8 @@ int machine__process_event(struct machine *machine, union perf_event *event,
 		ret = machine__process_bpf(machine, event, sample); break;
 	case PERF_RECORD_TEXT_POKE:
 		ret = machine__process_text_poke(machine, event, sample); break;
+	case PERF_RECORD_AUX_OUTPUT_HW_ID:
+		ret = machine__process_aux_output_hw_id_event(machine, event); break;
 	default:
 		ret = -1;
 		break;
diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
index 7377ed6efdf1..a143087eeb47 100644
--- a/tools/perf/util/machine.h
+++ b/tools/perf/util/machine.h
@@ -124,6 +124,8 @@ int machine__process_aux_event(struct machine *machine,
 			       union perf_event *event);
 int machine__process_itrace_start_event(struct machine *machine,
 					union perf_event *event);
+int machine__process_aux_output_hw_id_event(struct machine *machine,
+					    union perf_event *event);
 int machine__process_switch_event(struct machine *machine,
 				  union perf_event *event);
 int machine__process_namespaces_event(struct machine *machine,
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 069c2cfdd3be..bdf1da9ea418 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -509,6 +509,8 @@ void perf_tool__fill_defaults(struct perf_tool *tool)
 		tool->bpf = perf_event__process_bpf;
 	if (tool->text_poke == NULL)
 		tool->text_poke = perf_event__process_text_poke;
+	if (tool->aux_output_hw_id == NULL)
+		tool->aux_output_hw_id = perf_event__process_aux_output_hw_id;
 	if (tool->read == NULL)
 		tool->read = process_event_sample_stub;
 	if (tool->throttle == NULL)
@@ -1000,6 +1002,7 @@ static perf_event__swap_op perf_event__swap_ops[] = {
 	[PERF_RECORD_NAMESPACES]	  = perf_event__namespaces_swap,
 	[PERF_RECORD_CGROUP]		  = perf_event__cgroup_swap,
 	[PERF_RECORD_TEXT_POKE]		  = perf_event__text_poke_swap,
+	[PERF_RECORD_AUX_OUTPUT_HW_ID]	  = perf_event__all64_swap,
 	[PERF_RECORD_HEADER_ATTR]	  = perf_event__hdr_attr_swap,
 	[PERF_RECORD_HEADER_EVENT_TYPE]	  = perf_event__event_type_swap,
 	[PERF_RECORD_HEADER_TRACING_DATA] = perf_event__tracing_data_swap,
@@ -1556,6 +1559,8 @@ static int machines__deliver_event(struct machines *machines,
 		return tool->bpf(tool, event, sample, machine);
 	case PERF_RECORD_TEXT_POKE:
 		return tool->text_poke(tool, event, sample, machine);
+	case PERF_RECORD_AUX_OUTPUT_HW_ID:
+		return tool->aux_output_hw_id(tool, event, sample, machine);
 	default:
 		++evlist->stats.nr_unknown_events;
 		return -1;
diff --git a/tools/perf/util/tool.h b/tools/perf/util/tool.h
index bbbc0dcd461f..ef873f2cc38f 100644
--- a/tools/perf/util/tool.h
+++ b/tools/perf/util/tool.h
@@ -53,6 +53,7 @@ struct perf_tool {
 			lost_samples,
 			aux,
 			itrace_start,
+			aux_output_hw_id,
 			context_switch,
 			throttle,
 			unthrottle,
-- 
2.17.1

