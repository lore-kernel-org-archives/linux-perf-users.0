From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 13/15] perf data: Add callchain to CTF conversion
Date: Fri, 28 Jul 2017 17:00:19 -0300
Message-ID: <20170728200021.11389-14-acme@kernel.org>
References: <20170728200021.11389-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170728200021.11389-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, =?UTF-8?q?Genevi=C3=A8ve=20Bastien?= <gbastien@versatic.net>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Francis Deslauriers <francis.deslauriers@efficios.com>, Julien Desfossez <jdesfossez@efficios.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Geneviève Bastien <gbastien@versatic.net>

The field perf_callchain, if available, is added to the sampling events
during the CTF conversion. It is an array of u64 values.  The
perf_callchain_size field contains the size of the array.

It will allow the analysis of sampling data in trace visualization tools
like Trace Compass. Possible analyses with those data: dynamic
flamegraphs, correlation with other tracing data like a userspace trace.

Here follows a babeltrace CTF output of a trace with callchain:

  $ babeltrace ./myctftrace
  [17:38:45.672760285] (+?.?????????) cycles:ppp: { cpu_id = 0 }, { perf_ip = 0xFFFFFFFF81063EE4, perf_tid = 25841, perf_pid = 25774, perf_period = 1, perf_callchain_size = 7, perf_callchain = [ [0] = 0xFFFFFFFFFFFFFF80, [1] = 0xFFFFFFFF81063EE4, [2] = 0xFFFFFFFF8100C770, [3] = 0xFFFFFFFF81006EC6, [4] = 0xFFFFFFFF8118245E, [5] = 0xFFFFFFFF810A9224, [6] = 0xFFFFFFFF8164A4C6 ] }
  [17:38:45.672777672] (+0.000017387) cycles:ppp: { cpu_id = 0 }, { perf_ip = 0xFFFFFFFF81063EE4, perf_tid = 25841, perf_pid = 25774, perf_period = 1, perf_callchain_size = 8, perf_callchain = [ [0] = 0xFFFFFFFFFFFFFF80, [1] = 0xFFFFFFFF81063EE4, [2] = 0xFFFFFFFF8100C770, [3] = 0xFFFFFFFF81006EC6, [4] = 0xFFFFFFFF8118245E, [5] = 0xFFFFFFFF810A9224, [6] = 0xFFFFFFFF8164A4C6, [7] = 0xFFFFFFFF8164ABAD ] }
  [17:38:45.672786700] (+0.000009028) cycles:ppp: { cpu_id = 0 }, { perf_ip = 0xFFFFFFFF81063EE4, perf_tid = 25841, perf_pid = 25774, perf_period = 70, perf_callchain_size = 3, perf_callchain = [ [0] = 0xFFFFFFFFFFFFFF80, [1] = 0xFFFFFFFF81063EE4, [2] = 0xFFFFFFFF8100C770 ] }

Signed-off-by: Geneviève Bastien <gbastien@versatic.net>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Francis Deslauriers <francis.deslauriers@efficios.com>
Cc: Julien Desfossez <jdesfossez@efficios.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20170727181205.24843-1-gbastien@versatic.net
[ Removed PERF_SAMPLE_CALLCHAIN from the TODO list, jolsa ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/data-convert-bt.c | 92 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 91 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/data-convert-bt.c b/tools/perf/util/data-convert-bt.c
index 3149b70799fd..eeb2590a3ddf 100644
--- a/tools/perf/util/data-convert-bt.c
+++ b/tools/perf/util/data-convert-bt.c
@@ -506,6 +506,81 @@ add_bpf_output_values(struct bt_ctf_event_class *event_class,
 	return ret;
 }
 
+static int
+add_callchain_output_values(struct bt_ctf_event_class *event_class,
+		      struct bt_ctf_event *event,
+		      struct ip_callchain *callchain)
+{
+	struct bt_ctf_field_type *len_type, *seq_type;
+	struct bt_ctf_field *len_field, *seq_field;
+	unsigned int nr_elements = callchain->nr;
+	unsigned int i;
+	int ret;
+
+	len_type = bt_ctf_event_class_get_field_by_name(
+			event_class, "perf_callchain_size");
+	len_field = bt_ctf_field_create(len_type);
+	if (!len_field) {
+		pr_err("failed to create 'perf_callchain_size' for callchain output event\n");
+		ret = -1;
+		goto put_len_type;
+	}
+
+	ret = bt_ctf_field_unsigned_integer_set_value(len_field, nr_elements);
+	if (ret) {
+		pr_err("failed to set field value for perf_callchain_size\n");
+		goto put_len_field;
+	}
+	ret = bt_ctf_event_set_payload(event, "perf_callchain_size", len_field);
+	if (ret) {
+		pr_err("failed to set payload to perf_callchain_size\n");
+		goto put_len_field;
+	}
+
+	seq_type = bt_ctf_event_class_get_field_by_name(
+			event_class, "perf_callchain");
+	seq_field = bt_ctf_field_create(seq_type);
+	if (!seq_field) {
+		pr_err("failed to create 'perf_callchain' for callchain output event\n");
+		ret = -1;
+		goto put_seq_type;
+	}
+
+	ret = bt_ctf_field_sequence_set_length(seq_field, len_field);
+	if (ret) {
+		pr_err("failed to set length of 'perf_callchain'\n");
+		goto put_seq_field;
+	}
+
+	for (i = 0; i < nr_elements; i++) {
+		struct bt_ctf_field *elem_field =
+			bt_ctf_field_sequence_get_field(seq_field, i);
+
+		ret = bt_ctf_field_unsigned_integer_set_value(elem_field,
+				((u64 *)(callchain->ips))[i]);
+
+		bt_ctf_field_put(elem_field);
+		if (ret) {
+			pr_err("failed to set callchain[%d]\n", i);
+			goto put_seq_field;
+		}
+	}
+
+	ret = bt_ctf_event_set_payload(event, "perf_callchain", seq_field);
+	if (ret)
+		pr_err("failed to set payload for raw_data\n");
+
+put_seq_field:
+	bt_ctf_field_put(seq_field);
+put_seq_type:
+	bt_ctf_field_type_put(seq_type);
+put_len_field:
+	bt_ctf_field_put(len_field);
+put_len_type:
+	bt_ctf_field_type_put(len_type);
+	return ret;
+}
+
 static int add_generic_values(struct ctf_writer *cw,
 			      struct bt_ctf_event *event,
 			      struct perf_evsel *evsel,
@@ -519,7 +594,6 @@ static int add_generic_values(struct ctf_writer *cw,
 	 *   PERF_SAMPLE_TIME         - not needed as we have it in
 	 *                              ctf event header
 	 *   PERF_SAMPLE_READ         - TODO
-	 *   PERF_SAMPLE_CALLCHAIN    - TODO
 	 *   PERF_SAMPLE_RAW          - tracepoint fields are handled separately
 	 *   PERF_SAMPLE_BRANCH_STACK - TODO
 	 *   PERF_SAMPLE_REGS_USER    - TODO
@@ -720,6 +794,7 @@ static int process_sample_event(struct perf_tool *tool,
 	struct bt_ctf_event_class *event_class;
 	struct bt_ctf_event *event;
 	int ret;
+	unsigned long type = evsel->attr.sample_type;
 
 	if (WARN_ONCE(!priv, "Failed to setup all events.\n"))
 		return 0;
@@ -751,6 +826,13 @@ static int process_sample_event(struct perf_tool *tool,
 			return -1;
 	}
 
+	if (type & PERF_SAMPLE_CALLCHAIN) {
+		ret = add_callchain_output_values(event_class,
+				event, sample->callchain);
+		if (ret)
+			return -1;
+	}
+
 	if (perf_evsel__is_bpf_output(evsel)) {
 		ret = add_bpf_output_values(event_class, event, sample);
 		if (ret)
@@ -1043,6 +1125,14 @@ static int add_generic_types(struct ctf_writer *cw, struct perf_evsel *evsel,
 	if (type & PERF_SAMPLE_TRANSACTION)
 		ADD_FIELD(event_class, cw->data.u64, "perf_transaction");
 
+	if (type & PERF_SAMPLE_CALLCHAIN) {
+		ADD_FIELD(event_class, cw->data.u32, "perf_callchain_size");
+		ADD_FIELD(event_class,
+			bt_ctf_field_type_sequence_create(
+				cw->data.u64_hex, "perf_callchain_size"),
+			"perf_callchain");
+	}
+
 #undef ADD_FIELD
 	return 0;
 }
-- 
2.9.4
