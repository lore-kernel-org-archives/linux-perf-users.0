From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 67/73] perf intel-pt: Fix instructions sampling rate
Date: Fri, 17 May 2019 16:36:05 -0300
Message-ID: <20190517193611.4974-68-acme@kernel.org>
References: <20190517193611.4974-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190517193611.4974-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@redhat.com>, stable@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

The timestamp used to determine if an instruction sample is made, is an
estimate based on the number of instructions since the last known
timestamp. A consequence is that it might go backwards, which results in
extra samples. Change it so that a sample is only made when the
timestamp goes forwards.

Note this does not affect a sampling period of 0 or sampling periods
specified as a count of instructions.

Example:

 Before:

 $ perf script --itrace=i10us
 ls 13812 [003] 2167315.222583:       3270 instructions:u:      7fac71e2e494 __GI___tunables_init+0xf4 (/lib/x86_64-linux-gnu/ld-2.28.so)
 ls 13812 [003] 2167315.222667:      30902 instructions:u:      7fac71e2da0f _dl_cache_libcmp+0x2f (/lib/x86_64-linux-gnu/ld-2.28.so)
 ls 13812 [003] 2167315.222667:         10 instructions:u:      7fac71e2d9ff _dl_cache_libcmp+0x1f (/lib/x86_64-linux-gnu/ld-2.28.so)
 ls 13812 [003] 2167315.222667:          8 instructions:u:      7fac71e2d9ea _dl_cache_libcmp+0xa (/lib/x86_64-linux-gnu/ld-2.28.so)
 ls 13812 [003] 2167315.222667:         14 instructions:u:      7fac71e2d9ea _dl_cache_libcmp+0xa (/lib/x86_64-linux-gnu/ld-2.28.so)
 ls 13812 [003] 2167315.222667:          6 instructions:u:      7fac71e2d9ff _dl_cache_libcmp+0x1f (/lib/x86_64-linux-gnu/ld-2.28.so)
 ls 13812 [003] 2167315.222667:         14 instructions:u:      7fac71e2d9ff _dl_cache_libcmp+0x1f (/lib/x86_64-linux-gnu/ld-2.28.so)
 ls 13812 [003] 2167315.222667:          4 instructions:u:      7fac71e2dab2 _dl_cache_libcmp+0xd2 (/lib/x86_64-linux-gnu/ld-2.28.so)
 ls 13812 [003] 2167315.222728:      16423 instructions:u:      7fac71e2477a _dl_map_object_deps+0x1ba (/lib/x86_64-linux-gnu/ld-2.28.so)
 ls 13812 [003] 2167315.222734:      12731 instructions:u:      7fac71e27938 _dl_name_match_p+0x68 (/lib/x86_64-linux-gnu/ld-2.28.so)
 ...

 After:
 $ perf script --itrace=i10us
 ls 13812 [003] 2167315.222583:       3270 instructions:u:      7fac71e2e494 __GI___tunables_init+0xf4 (/lib/x86_64-linux-gnu/ld-2.28.so)
 ls 13812 [003] 2167315.222667:      30902 instructions:u:      7fac71e2da0f _dl_cache_libcmp+0x2f (/lib/x86_64-linux-gnu/ld-2.28.so)
 ls 13812 [003] 2167315.222728:      16479 instructions:u:      7fac71e2477a _dl_map_object_deps+0x1ba (/lib/x86_64-linux-gnu/ld-2.28.so)
 ...

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: stable@vger.kernel.org
Fixes: f4aa081949e7b ("perf tools: Add Intel PT decoder")
Link: http://lkml.kernel.org/r/20190510124143.27054-2-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/intel-pt-decoder/intel-pt-decoder.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
index 872fab163585..26dbf11e071a 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -888,16 +888,20 @@ static uint64_t intel_pt_next_period(struct intel_pt_decoder *decoder)
 	timestamp = decoder->timestamp + decoder->timestamp_insn_cnt;
 	masked_timestamp = timestamp & decoder->period_mask;
 	if (decoder->continuous_period) {
-		if (masked_timestamp != decoder->last_masked_timestamp)
+		if (masked_timestamp > decoder->last_masked_timestamp)
 			return 1;
 	} else {
 		timestamp += 1;
 		masked_timestamp = timestamp & decoder->period_mask;
-		if (masked_timestamp != decoder->last_masked_timestamp) {
+		if (masked_timestamp > decoder->last_masked_timestamp) {
 			decoder->last_masked_timestamp = masked_timestamp;
 			decoder->continuous_period = true;
 		}
 	}
+
+	if (masked_timestamp < decoder->last_masked_timestamp)
+		return decoder->period_ticks;
+
 	return decoder->period_ticks - (timestamp - masked_timestamp);
 }
 
@@ -926,7 +930,10 @@ static void intel_pt_sample_insn(struct intel_pt_decoder *decoder)
 	case INTEL_PT_PERIOD_TICKS:
 		timestamp = decoder->timestamp + decoder->timestamp_insn_cnt;
 		masked_timestamp = timestamp & decoder->period_mask;
-		decoder->last_masked_timestamp = masked_timestamp;
+		if (masked_timestamp > decoder->last_masked_timestamp)
+			decoder->last_masked_timestamp = masked_timestamp;
+		else
+			decoder->last_masked_timestamp += decoder->period_ticks;
 		break;
 	case INTEL_PT_PERIOD_NONE:
 	case INTEL_PT_PERIOD_MTC:
-- 
2.20.1
