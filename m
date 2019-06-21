From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 07/25] perf intel-pt: Factor out common sample preparation for re-use
Date: Fri, 21 Jun 2019 14:38:13 -0300
Message-ID: <20190621173831.13780-8-acme@kernel.org>
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

Factor out common sample preparation for re-use when synthesizing PEBS
samples.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190610072803.10456-6-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/intel-pt.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index cc91c1413c22..a2d90b2f1f11 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -1182,28 +1182,37 @@ static inline bool intel_pt_skip_event(struct intel_pt *pt)
 	       pt->num_events++ < pt->synth_opts.initial_skip;
 }
 
+static void intel_pt_prep_a_sample(struct intel_pt_queue *ptq,
+				   union perf_event *event,
+				   struct perf_sample *sample)
+{
+	event->sample.header.type = PERF_RECORD_SAMPLE;
+	event->sample.header.size = sizeof(struct perf_event_header);
+
+	sample->pid = ptq->pid;
+	sample->tid = ptq->tid;
+	sample->cpu = ptq->cpu;
+	sample->insn_len = ptq->insn_len;
+	memcpy(sample->insn, ptq->insn, INTEL_PT_INSN_BUF_SZ);
+}
+
 static void intel_pt_prep_b_sample(struct intel_pt *pt,
 				   struct intel_pt_queue *ptq,
 				   union perf_event *event,
 				   struct perf_sample *sample)
 {
+	intel_pt_prep_a_sample(ptq, event, sample);
+
 	if (!pt->timeless_decoding)
 		sample->time = tsc_to_perf_time(ptq->timestamp, &pt->tc);
 
 	sample->ip = ptq->state->from_ip;
 	sample->cpumode = intel_pt_cpumode(pt, sample->ip);
-	sample->pid = ptq->pid;
-	sample->tid = ptq->tid;
 	sample->addr = ptq->state->to_ip;
 	sample->period = 1;
-	sample->cpu = ptq->cpu;
 	sample->flags = ptq->flags;
-	sample->insn_len = ptq->insn_len;
-	memcpy(sample->insn, ptq->insn, INTEL_PT_INSN_BUF_SZ);
 
-	event->sample.header.type = PERF_RECORD_SAMPLE;
 	event->sample.header.misc = sample->cpumode;
-	event->sample.header.size = sizeof(struct perf_event_header);
 }
 
 static int intel_pt_inject_event(union perf_event *event,
-- 
2.20.1
