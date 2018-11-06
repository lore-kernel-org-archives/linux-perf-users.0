From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 15/18] perf intel-pt: Add MTC and CYC timestamps to debug log
Date: Tue,  6 Nov 2018 09:06:09 -0300
Message-ID: <20181106120612.8262-16-acme@kernel.org>
References: <20181106120612.8262-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181106120612.8262-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

One cause of decoding errors is un-synchronized side-band data.
Timestamps are needed to debug such cases. TSC packet timestamps are
logged. Log also MTC and CYC timestamps.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Link: http://lkml.kernel.org/r/20181105073505.8129-3-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/intel-pt-decoder/intel-pt-decoder.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
index 58f6a9ceb590..4503f3ca45ab 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -1474,6 +1474,8 @@ static void intel_pt_calc_mtc_timestamp(struct intel_pt_decoder *decoder)
 		decoder->have_calc_cyc_to_tsc = false;
 		intel_pt_calc_cyc_to_tsc(decoder, true);
 	}
+
+	intel_pt_log_to("Setting timestamp", decoder->timestamp);
 }
 
 static void intel_pt_calc_cbr(struct intel_pt_decoder *decoder)
@@ -1514,6 +1516,8 @@ static void intel_pt_calc_cyc_timestamp(struct intel_pt_decoder *decoder)
 		decoder->timestamp = timestamp;
 
 	decoder->timestamp_insn_cnt = 0;
+
+	intel_pt_log_to("Setting timestamp", decoder->timestamp);
 }
 
 /* Walk PSB+ packets when already in sync. */
-- 
2.14.4
