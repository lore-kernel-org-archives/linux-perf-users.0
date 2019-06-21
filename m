From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 12/25] perf intel-pt: Add memory information to synthesized PEBS sample
Date: Fri, 21 Jun 2019 14:38:18 -0300
Message-ID: <20190621173831.13780-13-acme@kernel.org>
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

Add memory information from PEBS data in the Intel PT trace to the
synthesized PEBS sample. This provides sample types PERF_SAMPLE_ADDR,
PERF_SAMPLE_WEIGHT, and PERF_SAMPLE_TRANSACTION, but not
PERF_SAMPLE_DATA_SRC.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190610072803.10456-11-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/intel-pt.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index db00c13dc36f..bf7647897e8a 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -1766,6 +1766,33 @@ static int intel_pt_synth_pebs_sample(struct intel_pt_queue *ptq)
 		}
 	}
 
+	if (sample_type & PERF_SAMPLE_ADDR && items->has_mem_access_address)
+		sample.addr = items->mem_access_address;
+
+	if (sample_type & PERF_SAMPLE_WEIGHT) {
+		/*
+		 * Refer kernel's setup_pebs_adaptive_sample_data() and
+		 * intel_hsw_weight().
+		 */
+		if (items->has_mem_access_latency)
+			sample.weight = items->mem_access_latency;
+		if (!sample.weight && items->has_tsx_aux_info) {
+			/* Cycles last block */
+			sample.weight = (u32)items->tsx_aux_info;
+		}
+	}
+
+	if (sample_type & PERF_SAMPLE_TRANSACTION && items->has_tsx_aux_info) {
+		u64 ax = items->has_rax ? items->rax : 0;
+		/* Refer kernel's intel_hsw_transaction() */
+		u64 txn = (u8)(items->tsx_aux_info >> 32);
+
+		/* For RTM XABORTs also log the abort code from AX */
+		if (txn & PERF_TXN_TRANSACTION && ax & 1)
+			txn |= ((ax >> 24) & 0xff) << PERF_TXN_ABORT_SHIFT;
+		sample.transaction = txn;
+	}
+
 	return intel_pt_deliver_synth_event(pt, ptq, event, &sample, sample_type);
 }
 
-- 
2.20.1
