From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 36/43] perf tools: Add mechanic to synthesise CoreSight trace packets
Date: Tue, 23 Jan 2018 10:12:44 -0300
Message-ID: <20180123131251.28197-37-acme@kernel.org>
References: <20180123131251.28197-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180123131251.28197-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Mathieu Poirier <mathieu.poirier@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Kim Phillips <kim.phillips@arm.com>, Mike Leach <mike.leach@arm.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Suzuki Poulouse <suzuki.poulose@arm.com>, linux-arm-kernel@lists.infradead.org, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Mathieu Poirier <mathieu.poirier@linaro.org>

Once decoded from trace packets information on trace range needs
to be communicated to the perf synthesis infrastructure so that it
is available to the perf tools built-in rendering tools and scripts.

Co-authored-by: Tor Jeremiassen <tor@ti.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Kim Phillips <kim.phillips@arm.com>
Cc: Mike Leach <mike.leach@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Suzuki Poulouse <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/1516211539-5166-10-git-send-email-mathieu.poirier@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cs-etm.c | 168 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 168 insertions(+)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 407095af1456..b9f0a53dfa65 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -453,6 +453,157 @@ static void  cs_etm__set_pid_tid_cpu(struct cs_etm_auxtrace *etm,
 	}
 }
 
+/*
+ * The cs etm packet encodes an instruction range between a branch target
+ * and the next taken branch. Generate sample accordingly.
+ */
+static int cs_etm__synth_branch_sample(struct cs_etm_queue *etmq,
+				       struct cs_etm_packet *packet)
+{
+	int ret = 0;
+	struct cs_etm_auxtrace *etm = etmq->etm;
+	struct perf_sample sample = {.ip = 0,};
+	union perf_event *event = etmq->event_buf;
+	u64 start_addr = packet->start_addr;
+	u64 end_addr = packet->end_addr;
+
+	event->sample.header.type = PERF_RECORD_SAMPLE;
+	event->sample.header.misc = PERF_RECORD_MISC_USER;
+	event->sample.header.size = sizeof(struct perf_event_header);
+
+	sample.ip = start_addr;
+	sample.pid = etmq->pid;
+	sample.tid = etmq->tid;
+	sample.addr = end_addr;
+	sample.id = etmq->etm->branches_id;
+	sample.stream_id = etmq->etm->branches_id;
+	sample.period = 1;
+	sample.cpu = packet->cpu;
+	sample.flags = 0;
+	sample.cpumode = PERF_RECORD_MISC_USER;
+
+	ret = perf_session__deliver_synth_event(etm->session, event, &sample);
+
+	if (ret)
+		pr_err(
+		"CS ETM Trace: failed to deliver instruction event, error %d\n",
+		ret);
+
+	return ret;
+}
+
+struct cs_etm_synth {
+	struct perf_tool dummy_tool;
+	struct perf_session *session;
+};
+
+static int cs_etm__event_synth(struct perf_tool *tool,
+			       union perf_event *event,
+			       struct perf_sample *sample __maybe_unused,
+			       struct machine *machine __maybe_unused)
+{
+	struct cs_etm_synth *cs_etm_synth =
+		      container_of(tool, struct cs_etm_synth, dummy_tool);
+
+	return perf_session__deliver_synth_event(cs_etm_synth->session,
+						 event, NULL);
+}
+
+static int cs_etm__synth_event(struct perf_session *session,
+			       struct perf_event_attr *attr, u64 id)
+{
+	struct cs_etm_synth cs_etm_synth;
+
+	memset(&cs_etm_synth, 0, sizeof(struct cs_etm_synth));
+	cs_etm_synth.session = session;
+
+	return perf_event__synthesize_attr(&cs_etm_synth.dummy_tool, attr, 1,
+					   &id, cs_etm__event_synth);
+}
+
+static int cs_etm__synth_events(struct cs_etm_auxtrace *etm,
+				struct perf_session *session)
+{
+	struct perf_evlist *evlist = session->evlist;
+	struct perf_evsel *evsel;
+	struct perf_event_attr attr;
+	bool found = false;
+	u64 id;
+	int err;
+
+	evlist__for_each_entry(evlist, evsel) {
+		if (evsel->attr.type == etm->pmu_type) {
+			found = true;
+			break;
+		}
+	}
+
+	if (!found) {
+		pr_debug("No selected events with CoreSight Trace data\n");
+		return 0;
+	}
+
+	memset(&attr, 0, sizeof(struct perf_event_attr));
+	attr.size = sizeof(struct perf_event_attr);
+	attr.type = PERF_TYPE_HARDWARE;
+	attr.sample_type = evsel->attr.sample_type & PERF_SAMPLE_MASK;
+	attr.sample_type |= PERF_SAMPLE_IP | PERF_SAMPLE_TID |
+			    PERF_SAMPLE_PERIOD;
+	if (etm->timeless_decoding)
+		attr.sample_type &= ~(u64)PERF_SAMPLE_TIME;
+	else
+		attr.sample_type |= PERF_SAMPLE_TIME;
+
+	attr.exclude_user = evsel->attr.exclude_user;
+	attr.exclude_kernel = evsel->attr.exclude_kernel;
+	attr.exclude_hv = evsel->attr.exclude_hv;
+	attr.exclude_host = evsel->attr.exclude_host;
+	attr.exclude_guest = evsel->attr.exclude_guest;
+	attr.sample_id_all = evsel->attr.sample_id_all;
+	attr.read_format = evsel->attr.read_format;
+
+	/* create new id val to be a fixed offset from evsel id */
+	id = evsel->id[0] + 1000000000;
+
+	if (!id)
+		id = 1;
+
+	if (etm->synth_opts.branches) {
+		attr.config = PERF_COUNT_HW_BRANCH_INSTRUCTIONS;
+		attr.sample_period = 1;
+		attr.sample_type |= PERF_SAMPLE_ADDR;
+		err = cs_etm__synth_event(session, &attr, id);
+		if (err)
+			return err;
+		etm->sample_branches = true;
+		etm->branches_sample_type = attr.sample_type;
+		etm->branches_id = id;
+	}
+
+	return 0;
+}
+
+static int cs_etm__sample(struct cs_etm_queue *etmq)
+{
+	int ret;
+	struct cs_etm_packet packet;
+
+	while (1) {
+		ret = cs_etm_decoder__get_packet(etmq->decoder, &packet);
+		if (ret <= 0)
+			return ret;
+
+		/*
+		 * If the packet contains an instruction range, generate an
+		 * instruction sequence event.
+		 */
+		if (packet.sample_type & CS_ETM_RANGE)
+			cs_etm__synth_branch_sample(etmq, &packet);
+	}
+
+	return 0;
+}
+
 static int cs_etm__run_decoder(struct cs_etm_queue *etmq)
 {
 	struct cs_etm_auxtrace *etm = etmq->etm;
@@ -494,6 +645,12 @@ static int cs_etm__run_decoder(struct cs_etm_queue *etmq)
 
 		etmq->offset += processed;
 		buffer_used += processed;
+
+		/*
+		 * Nothing to do with an error condition, let's hope the next
+		 * chunk will be better.
+		 */
+		err = cs_etm__sample(etmq);
 	} while (buffer.len > buffer_used);
 
 goto more;
@@ -828,6 +985,17 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
 		return 0;
 	}
 
+	if (session->itrace_synth_opts && session->itrace_synth_opts->set) {
+		etm->synth_opts = *session->itrace_synth_opts;
+	} else {
+		itrace_synth_opts__set_default(&etm->synth_opts);
+		etm->synth_opts.callchain = false;
+	}
+
+	err = cs_etm__synth_events(etm, session);
+	if (err)
+		goto err_free_queues;
+
 	err = auxtrace_queues__process_index(&etm->queues, session);
 	if (err)
 		goto err_free_queues;
-- 
2.14.3
