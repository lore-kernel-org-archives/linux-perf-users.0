From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 02/13] perf intel-pt: Fix TSC slip
Date: Fri, 29 Mar 2019 10:37:50 -0300
Message-ID: <20190329133801.21004-3-acme@kernel.org>
References: <20190329133801.21004-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190329133801.21004-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@redhat.com>, stable@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

A TSC packet can slip past MTC packets so that the timestamp appears to
go backwards. One estimate is that can be up to about 40 CPU cycles,
which is certainly less than 0x1000 TSC ticks, but accept slippage an
order of magnitude more to be on the safe side.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: stable@vger.kernel.org
Fixes: 79b58424b821c ("perf tools: Add Intel PT support for decoding MTC packets")
Link: http://lkml.kernel.org/r/20190325135135.18348-1-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../util/intel-pt-decoder/intel-pt-decoder.c  | 20 ++++++++-----------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
index 6e03db142091..872fab163585 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -251,19 +251,15 @@ struct intel_pt_decoder *intel_pt_decoder_new(struct intel_pt_params *params)
 		if (!(decoder->tsc_ctc_ratio_n % decoder->tsc_ctc_ratio_d))
 			decoder->tsc_ctc_mult = decoder->tsc_ctc_ratio_n /
 						decoder->tsc_ctc_ratio_d;
-
-		/*
-		 * Allow for timestamps appearing to backwards because a TSC
-		 * packet has slipped past a MTC packet, so allow 2 MTC ticks
-		 * or ...
-		 */
-		decoder->tsc_slip = multdiv(2 << decoder->mtc_shift,
-					decoder->tsc_ctc_ratio_n,
-					decoder->tsc_ctc_ratio_d);
 	}
-	/* ... or 0x100 paranoia */
-	if (decoder->tsc_slip < 0x100)
-		decoder->tsc_slip = 0x100;
+
+	/*
+	 * A TSC packet can slip past MTC packets so that the timestamp appears
+	 * to go backwards. One estimate is that can be up to about 40 CPU
+	 * cycles, which is certainly less than 0x1000 TSC ticks, but accept
+	 * slippage an order of magnitude more to be on the safe side.
+	 */
+	decoder->tsc_slip = 0x10000;
 
 	intel_pt_log("timestamp: mtc_shift %u\n", decoder->mtc_shift);
 	intel_pt_log("timestamp: tsc_ctc_ratio_n %u\n", decoder->tsc_ctc_ratio_n);
-- 
2.20.1
