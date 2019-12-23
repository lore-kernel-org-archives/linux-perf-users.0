From: Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 3/9] perf tools: Basic support for CGROUP event
Date: Mon, 23 Dec 2019 15:07:53 +0900
Message-ID: <20191223060759.841176-4-namhyung@kernel.org>
References: <20191223060759.841176-1-namhyung@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191223060759.841176-1-namhyung@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, Stephane Eranian <eranian@google.com>, LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

Implement basic functionality to support cgroup tracking.  Each cgroup
can be identified by inode number which can be read from userspace
too.  The actual cgroup processing will come in the later patch.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/include/uapi/linux/perf_event.h     | 16 ++++++++++++++--
 tools/perf/builtin-diff.c                 |  1 +
 tools/perf/builtin-report.c               |  1 +
 tools/perf/lib/include/perf/event.h       |  7 +++++++
 tools/perf/util/event.c                   | 18 ++++++++++++++++++
 tools/perf/util/event.h                   |  6 ++++++
 tools/perf/util/evsel.c                   |  6 ++++++
 tools/perf/util/machine.c                 | 12 ++++++++++++
 tools/perf/util/machine.h                 |  3 +++
 tools/perf/util/perf_event_attr_fprintf.c |  2 ++
 tools/perf/util/session.c                 |  4 ++++
 tools/perf/util/tool.h                    |  1 +
 12 files changed, 75 insertions(+), 2 deletions(-)

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index 377d794d3105..3a81e9806cb1 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -142,8 +142,9 @@ enum perf_event_sample_format {
 	PERF_SAMPLE_REGS_INTR			= 1U << 18,
 	PERF_SAMPLE_PHYS_ADDR			= 1U << 19,
 	PERF_SAMPLE_AUX				= 1U << 20,
+	PERF_SAMPLE_CGROUP			= 1U << 21,
 
-	PERF_SAMPLE_MAX = 1U << 21,		/* non-ABI */
+	PERF_SAMPLE_MAX = 1U << 22,		/* non-ABI */
 
 	__PERF_SAMPLE_CALLCHAIN_EARLY		= 1ULL << 63, /* non-ABI; internal use */
 };
@@ -377,7 +378,8 @@ struct perf_event_attr {
 				ksymbol        :  1, /* include ksymbol events */
 				bpf_event      :  1, /* include bpf events */
 				aux_output     :  1, /* generate AUX records instead of events */
-				__reserved_1   : 32;
+				cgroup         :  1, /* include cgroup events */
+				__reserved_1   : 31;
 
 	union {
 		__u32		wakeup_events;	  /* wakeup every n events */
@@ -1006,6 +1008,16 @@ enum perf_event_type {
 	 */
 	PERF_RECORD_BPF_EVENT			= 18,
 
+	/*
+	 * struct {
+	 *	struct perf_event_header	header;
+	 *	u64				id;
+	 *	char				path[];
+	 *	struct sample_id		sample_id;
+	 * };
+	 */
+	PERF_RECORD_CGROUP			= 19,
+
 	PERF_RECORD_MAX,			/* non-ABI */
 };
 
diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index f8b6ae557d8b..83d4094bf152 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -455,6 +455,7 @@ static struct perf_diff pdiff = {
 		.fork	= perf_event__process_fork,
 		.lost	= perf_event__process_lost,
 		.namespaces = perf_event__process_namespaces,
+		.cgroup = perf_event__process_cgroup,
 		.ordered_events = true,
 		.ordering_requires_timestamps = true,
 	},
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 387311c67264..6ff0037b98ea 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1093,6 +1093,7 @@ int cmd_report(int argc, const char **argv)
 			.mmap2		 = perf_event__process_mmap2,
 			.comm		 = perf_event__process_comm,
 			.namespaces	 = perf_event__process_namespaces,
+			.cgroup		 = perf_event__process_cgroup,
 			.exit		 = perf_event__process_exit,
 			.fork		 = perf_event__process_fork,
 			.lost		 = perf_event__process_lost,
diff --git a/tools/perf/lib/include/perf/event.h b/tools/perf/lib/include/perf/event.h
index 18106899cb4e..69b44d2cc0f5 100644
--- a/tools/perf/lib/include/perf/event.h
+++ b/tools/perf/lib/include/perf/event.h
@@ -105,6 +105,12 @@ struct perf_record_bpf_event {
 	__u8			 tag[BPF_TAG_SIZE];  // prog tag
 };
 
+struct perf_record_cgroup {
+	struct perf_event_header header;
+	__u64			 id;
+	char			 path[PATH_MAX];
+};
+
 struct perf_record_sample {
 	struct perf_event_header header;
 	__u64			 array[];
@@ -352,6 +358,7 @@ union perf_event {
 	struct perf_record_mmap2		mmap2;
 	struct perf_record_comm			comm;
 	struct perf_record_namespaces		namespaces;
+	struct perf_record_cgroup		cgroup;
 	struct perf_record_fork			fork;
 	struct perf_record_lost			lost;
 	struct perf_record_lost_samples		lost_samples;
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index c5447ff516a2..824c038e5c33 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -54,6 +54,7 @@ static const char *perf_event__names[] = {
 	[PERF_RECORD_NAMESPACES]		= "NAMESPACES",
 	[PERF_RECORD_KSYMBOL]			= "KSYMBOL",
 	[PERF_RECORD_BPF_EVENT]			= "BPF_EVENT",
+	[PERF_RECORD_CGROUP]			= "CGROUP",
 	[PERF_RECORD_HEADER_ATTR]		= "ATTR",
 	[PERF_RECORD_HEADER_EVENT_TYPE]		= "EVENT_TYPE",
 	[PERF_RECORD_HEADER_TRACING_DATA]	= "TRACING_DATA",
@@ -180,6 +181,12 @@ size_t perf_event__fprintf_namespaces(union perf_event *event, FILE *fp)
 	return ret;
 }
 
+size_t perf_event__fprintf_cgroup(union perf_event *event, FILE *fp)
+{
+	return fprintf(fp, " cgroup: %" PRI_lu64 " %s\n",
+		       event->cgroup.id, event->cgroup.path);
+}
+
 int perf_event__process_comm(struct perf_tool *tool __maybe_unused,
 			     union perf_event *event,
 			     struct perf_sample *sample,
@@ -196,6 +203,14 @@ int perf_event__process_namespaces(struct perf_tool *tool __maybe_unused,
 	return machine__process_namespaces_event(machine, event, sample);
 }
 
+int perf_event__process_cgroup(struct perf_tool *tool __maybe_unused,
+			       union perf_event *event,
+			       struct perf_sample *sample,
+			       struct machine *machine)
+{
+	return machine__process_cgroup_event(machine, event, sample);
+}
+
 int perf_event__process_lost(struct perf_tool *tool __maybe_unused,
 			     union perf_event *event,
 			     struct perf_sample *sample,
@@ -417,6 +432,9 @@ size_t perf_event__fprintf(union perf_event *event, FILE *fp)
 	case PERF_RECORD_NAMESPACES:
 		ret += perf_event__fprintf_namespaces(event, fp);
 		break;
+	case PERF_RECORD_CGROUP:
+		ret += perf_event__fprintf_cgroup(event, fp);
+		break;
 	case PERF_RECORD_MMAP2:
 		ret += perf_event__fprintf_mmap2(event, fp);
 		break;
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index 85223159737c..0ad3ba22817d 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -135,6 +135,7 @@ struct perf_sample {
 	u32 raw_size;
 	u64 data_src;
 	u64 phys_addr;
+	u64 cgroup;
 	u32 flags;
 	u16 insn_len;
 	u8  cpumode;
@@ -321,6 +322,10 @@ int perf_event__process_namespaces(struct perf_tool *tool,
 				   union perf_event *event,
 				   struct perf_sample *sample,
 				   struct machine *machine);
+int perf_event__process_cgroup(struct perf_tool *tool,
+			       union perf_event *event,
+			       struct perf_sample *sample,
+			       struct machine *machine);
 int perf_event__process_mmap(struct perf_tool *tool,
 			     union perf_event *event,
 			     struct perf_sample *sample,
@@ -376,6 +381,7 @@ size_t perf_event__fprintf_switch(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf_thread_map(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf_cpu_map(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf_namespaces(union perf_event *event, FILE *fp);
+size_t perf_event__fprintf_cgroup(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf_ksymbol(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf_bpf(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf(union perf_event *event, FILE *fp);
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index a69e64236120..0f5a67603139 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2250,6 +2250,12 @@ int perf_evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 		array++;
 	}
 
+	data->cgroup = 0;
+	if (type & PERF_SAMPLE_CGROUP) {
+		data->cgroup = *array;
+		array++;
+	}
+
 	if (type & PERF_SAMPLE_AUX) {
 		OVERFLOW_CHECK_u64(array);
 		sz = *array++;
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index c8c5410315e8..2c3223bec561 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -654,6 +654,16 @@ int machine__process_namespaces_event(struct machine *machine __maybe_unused,
 	return err;
 }
 
+int machine__process_cgroup_event(struct machine *machine __maybe_unused,
+				  union perf_event *event,
+				  struct perf_sample *sample __maybe_unused)
+{
+	if (dump_trace)
+		perf_event__fprintf_cgroup(event, stdout);
+
+	return 0;
+}
+
 int machine__process_lost_event(struct machine *machine __maybe_unused,
 				union perf_event *event, struct perf_sample *sample __maybe_unused)
 {
@@ -1880,6 +1890,8 @@ int machine__process_event(struct machine *machine, union perf_event *event,
 		ret = machine__process_mmap_event(machine, event, sample); break;
 	case PERF_RECORD_NAMESPACES:
 		ret = machine__process_namespaces_event(machine, event, sample); break;
+	case PERF_RECORD_CGROUP:
+		ret = machine__process_cgroup_event(machine, event, sample); break;
 	case PERF_RECORD_MMAP2:
 		ret = machine__process_mmap2_event(machine, event, sample); break;
 	case PERF_RECORD_FORK:
diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
index be0a930eca89..fa1be9ea00fa 100644
--- a/tools/perf/util/machine.h
+++ b/tools/perf/util/machine.h
@@ -128,6 +128,9 @@ int machine__process_switch_event(struct machine *machine,
 int machine__process_namespaces_event(struct machine *machine,
 				      union perf_event *event,
 				      struct perf_sample *sample);
+int machine__process_cgroup_event(struct machine *machine,
+				  union perf_event *event,
+				  struct perf_sample *sample);
 int machine__process_mmap_event(struct machine *machine, union perf_event *event,
 				struct perf_sample *sample);
 int machine__process_mmap2_event(struct machine *machine, union perf_event *event,
diff --git a/tools/perf/util/perf_event_attr_fprintf.c b/tools/perf/util/perf_event_attr_fprintf.c
index 651203126c71..a37a89c747d8 100644
--- a/tools/perf/util/perf_event_attr_fprintf.c
+++ b/tools/perf/util/perf_event_attr_fprintf.c
@@ -35,6 +35,7 @@ static void __p_sample_type(char *buf, size_t size, u64 value)
 		bit_name(BRANCH_STACK), bit_name(REGS_USER), bit_name(STACK_USER),
 		bit_name(IDENTIFIER), bit_name(REGS_INTR), bit_name(DATA_SRC),
 		bit_name(WEIGHT), bit_name(PHYS_ADDR), bit_name(AUX),
+		bit_name(CGROUP),
 		{ .name = NULL, }
 	};
 #undef bit_name
@@ -131,6 +132,7 @@ int perf_event_attr__fprintf(FILE *fp, struct perf_event_attr *attr,
 	PRINT_ATTRf(ksymbol, p_unsigned);
 	PRINT_ATTRf(bpf_event, p_unsigned);
 	PRINT_ATTRf(aux_output, p_unsigned);
+	PRINT_ATTRf(cgroup, p_unsigned);
 
 	PRINT_ATTRn("{ wakeup_events, wakeup_watermark }", wakeup_events, p_unsigned);
 	PRINT_ATTRf(bp_type, p_unsigned);
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index d0d7d25b23e3..6b4c12d48c3f 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -471,6 +471,8 @@ void perf_tool__fill_defaults(struct perf_tool *tool)
 		tool->comm = process_event_stub;
 	if (tool->namespaces == NULL)
 		tool->namespaces = process_event_stub;
+	if (tool->cgroup == NULL)
+		tool->cgroup = process_event_stub;
 	if (tool->fork == NULL)
 		tool->fork = process_event_stub;
 	if (tool->exit == NULL)
@@ -1434,6 +1436,8 @@ static int machines__deliver_event(struct machines *machines,
 		return tool->comm(tool, event, sample, machine);
 	case PERF_RECORD_NAMESPACES:
 		return tool->namespaces(tool, event, sample, machine);
+	case PERF_RECORD_CGROUP:
+		return tool->cgroup(tool, event, sample, machine);
 	case PERF_RECORD_FORK:
 		return tool->fork(tool, event, sample, machine);
 	case PERF_RECORD_EXIT:
diff --git a/tools/perf/util/tool.h b/tools/perf/util/tool.h
index 2abbf668b8de..472ef5eb4068 100644
--- a/tools/perf/util/tool.h
+++ b/tools/perf/util/tool.h
@@ -46,6 +46,7 @@ struct perf_tool {
 			mmap2,
 			comm,
 			namespaces,
+			cgroup,
 			fork,
 			exit,
 			lost,
-- 
2.24.1.735.g03f4e72817-goog
