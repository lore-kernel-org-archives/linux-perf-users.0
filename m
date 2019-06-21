From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 06/25] perf intel-pt: Prepare to synthesize PEBS samples
Date: Fri, 21 Jun 2019 14:38:12 -0300
Message-ID: <20190621173831.13780-7-acme@kernel.org>
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

Add infrastructure to prepare for synthesizing PEBS samples but leave
the actual synthesis to later patches.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190610072803.10456-5-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/intel-pt.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 893cef494a43..cc91c1413c22 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -101,6 +101,9 @@ struct intel_pt {
 	u64 pwrx_id;
 	u64 cbr_id;
 
+	bool sample_pebs;
+	struct perf_evsel *pebs_evsel;
+
 	u64 tsc_bit;
 	u64 mtc_bit;
 	u64 mtc_freq_bits;
@@ -1535,6 +1538,11 @@ static int intel_pt_synth_pwrx_sample(struct intel_pt_queue *ptq)
 					    pt->pwr_events_sample_type);
 }
 
+static int intel_pt_synth_pebs_sample(struct intel_pt_queue *ptq __maybe_unused)
+{
+	return 0;
+}
+
 static int intel_pt_synth_error(struct intel_pt *pt, int code, int cpu,
 				pid_t pid, pid_t tid, u64 ip, u64 timestamp)
 {
@@ -1622,6 +1630,16 @@ static int intel_pt_sample(struct intel_pt_queue *ptq)
 		ptq->ipc_cyc_cnt = ptq->state->tot_cyc_cnt;
 	}
 
+	/*
+	 * Do PEBS first to allow for the possibility that the PEBS timestamp
+	 * precedes the current timestamp.
+	 */
+	if (pt->sample_pebs && state->type & INTEL_PT_BLK_ITEMS) {
+		err = intel_pt_synth_pebs_sample(ptq);
+		if (err)
+			return err;
+	}
+
 	if (pt->sample_pwr_events && (state->type & INTEL_PT_PWR_EVT)) {
 		if (state->type & INTEL_PT_CBR_CHG) {
 			err = intel_pt_synth_cbr_sample(ptq);
-- 
2.20.1
