Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457AE185B52;
	Tue, 17 Sep 2024 22:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726612115; cv=none; b=NqTjKZCKnwFVuyQL8UNGFkD1VXmibKe/S9Dh37wvYalwxJt8p5x35a342d0uA4edakmHPZPRKpo687y/fKuJt1Qbz5S/43w/fMoHytTufACJQ7fUj98VOIOlp3J2kgMihi/GBZgElfnwQQESYd5leXV6Idr5rEwNAla5oV5du5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726612115; c=relaxed/simple;
	bh=K7l6H1M0VsgZ0Q9hGEHVvdzK+luyXkqGAYtG/d8TRtw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VwE7WSQHyQuuekzZL1gTBggg5KQWeme9Z36KROVLq4sOHp+VYCareXdBcqpgOzVOmEH5pHGe5aPL44NXq7Ldfn2817d6UsAzSZWlbGeh1hfyIX/8YOXQbtAe3Yofpybaoy6fK4OKiQtPqYyfrwKyAGqHUGxPTOmJdSm0sPsvofk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JdrH6xjY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JdrH6xjY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C5FEC4AF09;
	Tue, 17 Sep 2024 22:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726612114;
	bh=K7l6H1M0VsgZ0Q9hGEHVvdzK+luyXkqGAYtG/d8TRtw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JdrH6xjYP6ma2ao23XO+nRPVflgUiHDJRL5yOvCDRxqjIplzqB6NGb7Y29d8sdOLY
	 NVYznZcEB0T/+BlmIDIBi2wpBD8XmJfzUalEjWdfPd3PxgFwn02MkWuP5ePPazWnzI
	 jO6vD3hdTX2rLcW6WzZrTuMAbFNOc+O+NbKhMJD2aUIZDv3e7j8IkN7CFZ7ksR+hgM
	 vpEI1oncnWC/D64aIME8hNBsASOYMFJOEVI86vAT9J8GA3Stj86F/9R1JoUZCPIIC7
	 t8Coutmi1Zrn3lpZAXU9hZXe1GR0SEoFmy02vtEFiFrWy/RJKRNTMgsKh3SDmNx0zZ
	 D23uMs3ple29Q==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Indu Bhagat <indu.bhagat@oracle.com>,
	linux-toolchains@vger.kernel.org
Subject: [PATCH 2/5] perf tools: Minimal DEFERRED_CALLCHAIN support
Date: Tue, 17 Sep 2024 15:28:17 -0700
Message-ID: <20240917222820.197594-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
In-Reply-To: <20240917222820.197594-1-namhyung@kernel.org>
References: <20240917222820.197594-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new event type for deferred callchains and a new callback for the
struct perf_tool.  For now it doesn't actually handle the deferred
callchains but it just marks the sample if it has the PERF_CONTEXT_
USER_DEFFERED in the callchain array.

At least, perf report can dump the raw data with this change.  Actually
this requires the next commit to enable attr.defer_callchain, but if you
already have a data file, it'll show the following result.

  $ perf report -D
  ...
  0x5fe0@perf.data [0x40]: event: 22
  .
  . ... raw event: size 64 bytes
  .  0000:  16 00 00 00 02 00 40 00 02 00 00 00 00 00 00 00  ......@.........
  .  0010:  00 fe ff ff ff ff ff ff 4b d3 3f 25 45 7f 00 00  ........K.?%E...
  .  0020:  21 03 00 00 21 03 00 00 43 02 12 ab 05 00 00 00  !...!...C.......
  .  0030:  00 00 00 00 00 00 00 00 09 00 00 00 00 00 00 00  ................

  0 24344920643 0x5fe0 [0x40]: PERF_RECORD_CALLCHAIN_DEFERRED(IP, 0x2): 801/801: 0
  ... FP chain: nr:2
  .....  0: fffffffffffffe00
  .....  1: 00007f45253fd34b
  : unhandled!

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/lib/perf/include/perf/event.h       |  7 +++++++
 tools/perf/util/event.c                   |  1 +
 tools/perf/util/evsel.c                   | 15 +++++++++++++++
 tools/perf/util/machine.c                 |  1 +
 tools/perf/util/perf_event_attr_fprintf.c |  1 +
 tools/perf/util/sample.h                  |  3 ++-
 tools/perf/util/session.c                 | 17 +++++++++++++++++
 tools/perf/util/tool.c                    |  1 +
 tools/perf/util/tool.h                    |  3 ++-
 9 files changed, 47 insertions(+), 2 deletions(-)

diff --git a/tools/lib/perf/include/perf/event.h b/tools/lib/perf/include/perf/event.h
index 37bb7771d9143466..f643a6a2b9fc2279 100644
--- a/tools/lib/perf/include/perf/event.h
+++ b/tools/lib/perf/include/perf/event.h
@@ -151,6 +151,12 @@ struct perf_record_switch {
 	__u32			 next_prev_tid;
 };
 
+struct perf_record_callchain_deferred {
+	struct perf_event_header header;
+	__u64			 nr;
+	__u64			 ips[];
+};
+
 struct perf_record_header_attr {
 	struct perf_event_header header;
 	struct perf_event_attr	 attr;
@@ -494,6 +500,7 @@ union perf_event {
 	struct perf_record_read			read;
 	struct perf_record_throttle		throttle;
 	struct perf_record_sample		sample;
+	struct perf_record_callchain_deferred	callchain_deferred;
 	struct perf_record_bpf_event		bpf;
 	struct perf_record_ksymbol		ksymbol;
 	struct perf_record_text_poke_event	text_poke;
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index aac96d5d19170091..8cdec373db44deac 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -58,6 +58,7 @@ static const char *perf_event__names[] = {
 	[PERF_RECORD_CGROUP]			= "CGROUP",
 	[PERF_RECORD_TEXT_POKE]			= "TEXT_POKE",
 	[PERF_RECORD_AUX_OUTPUT_HW_ID]		= "AUX_OUTPUT_HW_ID",
+	[PERF_RECORD_CALLCHAIN_DEFERRED]	= "CALLCHAIN_DEFERRED",
 	[PERF_RECORD_HEADER_ATTR]		= "ATTR",
 	[PERF_RECORD_HEADER_EVENT_TYPE]		= "EVENT_TYPE",
 	[PERF_RECORD_HEADER_TRACING_DATA]	= "TRACING_DATA",
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index dbf9c8cee3c5658f..701092d6b1b64124 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2676,6 +2676,18 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 	data->data_src = PERF_MEM_DATA_SRC_NONE;
 	data->vcpu = -1;
 
+	if (event->header.type == PERF_RECORD_CALLCHAIN_DEFERRED) {
+		const u64 max_callchain_nr = UINT64_MAX / sizeof(u64);
+
+		data->callchain = (struct ip_callchain *)&event->callchain_deferred.nr;
+		if (data->callchain->nr > max_callchain_nr)
+			return -EFAULT;
+
+		if (evsel->core.attr.sample_id_all)
+			perf_evsel__parse_id_sample(evsel, event, data);
+		return 0;
+	}
+
 	if (event->header.type != PERF_RECORD_SAMPLE) {
 		if (!evsel->core.attr.sample_id_all)
 			return 0;
@@ -2806,6 +2818,9 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 		if (data->callchain->nr > max_callchain_nr)
 			return -EFAULT;
 		sz = data->callchain->nr * sizeof(u64);
+		if (evsel->core.attr.defer_callchain && data->callchain->nr >= 1 &&
+		    data->callchain->ips[data->callchain->nr - 1] == PERF_CONTEXT_USER_DEFERRED)
+			data->deferred_callchain = true;
 		OVERFLOW_CHECK(array, sz, max_size);
 		array = (void *)array + sz;
 	}
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index fad227b625d155c5..f367577c91ffa016 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2085,6 +2085,7 @@ static int add_callchain_ip(struct thread *thread,
 				*cpumode = PERF_RECORD_MISC_KERNEL;
 				break;
 			case PERF_CONTEXT_USER:
+			case PERF_CONTEXT_USER_DEFERRED:
 				*cpumode = PERF_RECORD_MISC_USER;
 				break;
 			default:
diff --git a/tools/perf/util/perf_event_attr_fprintf.c b/tools/perf/util/perf_event_attr_fprintf.c
index 59fbbba796974058..113845b35110262a 100644
--- a/tools/perf/util/perf_event_attr_fprintf.c
+++ b/tools/perf/util/perf_event_attr_fprintf.c
@@ -321,6 +321,7 @@ int perf_event_attr__fprintf(FILE *fp, struct perf_event_attr *attr,
 	PRINT_ATTRf(inherit_thread, p_unsigned);
 	PRINT_ATTRf(remove_on_exec, p_unsigned);
 	PRINT_ATTRf(sigtrap, p_unsigned);
+	PRINT_ATTRf(defer_callchain, p_unsigned);
 
 	PRINT_ATTRn("{ wakeup_events, wakeup_watermark }", wakeup_events, p_unsigned, false);
 	PRINT_ATTRf(bp_type, p_unsigned);
diff --git a/tools/perf/util/sample.h b/tools/perf/util/sample.h
index 70b2c3135555ec26..010659dc80f88652 100644
--- a/tools/perf/util/sample.h
+++ b/tools/perf/util/sample.h
@@ -108,7 +108,8 @@ struct perf_sample {
 		u16 p_stage_cyc;
 		u16 retire_lat;
 	};
-	bool no_hw_idx;		/* No hw_idx collected in branch_stack */
+	bool no_hw_idx;			/* No hw_idx collected in branch_stack */
+	bool deferred_callchain;	/* Has deferred user callchains */
 	char insn[MAX_INSN];
 	void *raw_data;
 	struct ip_callchain *callchain;
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index dbaf07bf6c5fb88c..1248a0317a2f164a 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -714,6 +714,7 @@ static perf_event__swap_op perf_event__swap_ops[] = {
 	[PERF_RECORD_CGROUP]		  = perf_event__cgroup_swap,
 	[PERF_RECORD_TEXT_POKE]		  = perf_event__text_poke_swap,
 	[PERF_RECORD_AUX_OUTPUT_HW_ID]	  = perf_event__all64_swap,
+	[PERF_RECORD_CALLCHAIN_DEFERRED]  = perf_event__all64_swap,
 	[PERF_RECORD_HEADER_ATTR]	  = perf_event__hdr_attr_swap,
 	[PERF_RECORD_HEADER_EVENT_TYPE]	  = perf_event__event_type_swap,
 	[PERF_RECORD_HEADER_TRACING_DATA] = perf_event__tracing_data_swap,
@@ -1107,6 +1108,19 @@ static void dump_sample(struct evsel *evsel, union perf_event *event,
 		sample_read__printf(sample, evsel->core.attr.read_format);
 }
 
+static void dump_deferred_callchain(struct evsel *evsel, union perf_event *event,
+				    struct perf_sample *sample)
+{
+	if (!dump_trace)
+		return;
+
+	printf("(IP, 0x%x): %d/%d: %#" PRIx64 "\n",
+	       event->header.misc, sample->pid, sample->tid, sample->ip);
+
+	if (evsel__has_callchain(evsel))
+		callchain__printf(evsel, sample);
+}
+
 static void dump_read(struct evsel *evsel, union perf_event *event)
 {
 	struct perf_record_read *read_event = &event->read;
@@ -1327,6 +1341,9 @@ static int machines__deliver_event(struct machines *machines,
 		return tool->text_poke(tool, event, sample, machine);
 	case PERF_RECORD_AUX_OUTPUT_HW_ID:
 		return tool->aux_output_hw_id(tool, event, sample, machine);
+	case PERF_RECORD_CALLCHAIN_DEFERRED:
+		dump_deferred_callchain(evsel, event, sample);
+		return tool->callchain_deferred(tool, event, sample, evsel, machine);
 	default:
 		++evlist->stats.nr_unknown_events;
 		return -1;
diff --git a/tools/perf/util/tool.c b/tools/perf/util/tool.c
index 3b7f390f26eb427d..e78f16de912ed9e2 100644
--- a/tools/perf/util/tool.c
+++ b/tools/perf/util/tool.c
@@ -259,6 +259,7 @@ void perf_tool__init(struct perf_tool *tool, bool ordered_events)
 	tool->read = process_event_sample_stub;
 	tool->throttle = process_event_stub;
 	tool->unthrottle = process_event_stub;
+	tool->callchain_deferred = process_event_sample_stub;
 	tool->attr = process_event_synth_attr_stub;
 	tool->event_update = process_event_synth_event_update_stub;
 	tool->tracing_data = process_event_synth_tracing_data_stub;
diff --git a/tools/perf/util/tool.h b/tools/perf/util/tool.h
index db1c7642b0d1564d..9987bbde6d5e0565 100644
--- a/tools/perf/util/tool.h
+++ b/tools/perf/util/tool.h
@@ -42,7 +42,8 @@ enum show_feature_header {
 
 struct perf_tool {
 	event_sample	sample,
-			read;
+			read,
+			callchain_deferred;
 	event_op	mmap,
 			mmap2,
 			comm,
-- 
2.46.0.792.g87dc391469-goog

