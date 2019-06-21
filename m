From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 08/25] perf intel-pt: Synthesize PEBS sample basic information
Date: Fri, 21 Jun 2019 14:38:14 -0300
Message-ID: <20190621173831.13780-9-acme@kernel.org>
References: <20190621173831.13780-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190621173831.13780-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Synthesize a PEBS sample using basic information (ip, timestamp) only.
Other PEBS information will be added in later patches.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190610072803.10456-7-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/intel-pt.c | 52 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 50 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index a2d90b2f1f11..979519b00a74 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -1547,9 +1547,57 @@ static int intel_pt_synth_pwrx_sample(struct intel_pt_queue *ptq)
 					    pt->pwr_events_sample_type);
 }
 
-static int intel_pt_synth_pebs_sample(struct intel_pt_queue *ptq __maybe_unused)
+static int intel_pt_synth_pebs_sample(struct intel_pt_queue *ptq)
 {
-	return 0;
+	const struct intel_pt_blk_items *items = &ptq->state->items;
+	struct perf_sample sample = { .ip = 0, };
+	union perf_event *event = ptq->event_buf;
+	struct intel_pt *pt = ptq->pt;
+	struct perf_evsel *evsel = pt->pebs_evsel;
+	u64 sample_type = evsel->attr.sample_type;
+	u64 id = evsel->id[0];
+	u8 cpumode;
+
+	if (intel_pt_skip_event(pt))
+		return 0;
+
+	intel_pt_prep_a_sample(ptq, event, &sample);
+
+	sample.id = id;
+	sample.stream_id = id;
+
+	if (!evsel->attr.freq)
+		sample.period = evsel->attr.sample_period;
+
+	/* No support for non-zero CS base */
+	if (items->has_ip)
+		sample.ip = items->ip;
+	else if (items->has_rip)
+		sample.ip = items->rip;
+	else
+		sample.ip = ptq->state->from_ip;
+
+	/* No support for guest mode at this time */
+	cpumode = sample.ip < ptq->pt->kernel_start ?
+		  PERF_RECORD_MISC_USER :
+		  PERF_RECORD_MISC_KERNEL;
+
+	event->sample.header.misc = cpumode | PERF_RECORD_MISC_EXACT_IP;
+
+	sample.cpumode = cpumode;
+
+	if (sample_type & PERF_SAMPLE_TIME) {
+		u64 timestamp = 0;
+
+		if (items->has_timestamp)
+			timestamp = items->timestamp;
+		else if (!pt->timeless_decoding)
+			timestamp = ptq->timestamp;
+		if (timestamp)
+			sample.time = tsc_to_perf_time(timestamp, &pt->tc);
+	}
+
+	return intel_pt_deliver_synth_event(pt, ptq, event, &sample, sample_type);
 }
 
 static int intel_pt_synth_error(struct intel_pt *pt, int code, int cpu,
-- 
2.20.1
