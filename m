From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 68/85] perf intel-pt: Factor out intel_pt_reposition()
Date: Tue, 11 Jun 2019 15:58:54 -0300
Message-ID: <20190611185911.11645-69-acme@kernel.org>
References: <20190611185911.11645-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190611185911.11645-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Jin Yao <yao.jin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Factor out intel_pt_reposition() so it can be reused.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190604130017.31207-7-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/intel-pt-decoder/intel-pt-decoder.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
index c06dceb774e9..70bff7bb79f3 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -494,6 +494,14 @@ static inline void intel_pt_update_sample_time(struct intel_pt_decoder *decoder)
 	decoder->sample_insn_cnt = decoder->timestamp_insn_cnt;
 }
 
+static void intel_pt_reposition(struct intel_pt_decoder *decoder)
+{
+	decoder->ip = 0;
+	decoder->pkt_state = INTEL_PT_STATE_NO_PSB;
+	decoder->timestamp = 0;
+	decoder->have_tma = false;
+}
+
 static int intel_pt_get_data(struct intel_pt_decoder *decoder)
 {
 	struct intel_pt_buffer buffer = { .buf = 0, };
@@ -512,11 +520,8 @@ static int intel_pt_get_data(struct intel_pt_decoder *decoder)
 		return -ENODATA;
 	}
 	if (!buffer.consecutive) {
-		decoder->ip = 0;
-		decoder->pkt_state = INTEL_PT_STATE_NO_PSB;
+		intel_pt_reposition(decoder);
 		decoder->ref_timestamp = buffer.ref_timestamp;
-		decoder->timestamp = 0;
-		decoder->have_tma = false;
 		decoder->state.trace_nr = buffer.trace_nr;
 		intel_pt_log("Reference timestamp 0x%" PRIx64 "\n",
 			     decoder->ref_timestamp);
-- 
2.20.1
