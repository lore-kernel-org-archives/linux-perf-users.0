From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 67/85] perf intel-pt: Factor out intel_pt_8b_tsc()
Date: Tue, 11 Jun 2019 15:58:53 -0300
Message-ID: <20190611185911.11645-68-acme@kernel.org>
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

Factor out intel_pt_8b_tsc() so it can be reused.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190604130017.31207-6-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../util/intel-pt-decoder/intel-pt-decoder.c  | 26 ++++++++++++-------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
index 13123b195083..c06dceb774e9 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -1369,6 +1369,21 @@ static int intel_pt_mode_tsx(struct intel_pt_decoder *decoder, bool *no_tip)
 	return 0;
 }
 
+static uint64_t intel_pt_8b_tsc(uint64_t timestamp, uint64_t ref_timestamp)
+{
+	timestamp |= (ref_timestamp & (0xffULL << 56));
+
+	if (timestamp < ref_timestamp) {
+		if (ref_timestamp - timestamp > (1ULL << 55))
+			timestamp += (1ULL << 56);
+	} else {
+		if (timestamp - ref_timestamp > (1ULL << 55))
+			timestamp -= (1ULL << 56);
+	}
+
+	return timestamp;
+}
+
 static void intel_pt_calc_tsc_timestamp(struct intel_pt_decoder *decoder)
 {
 	uint64_t timestamp;
@@ -1376,15 +1391,8 @@ static void intel_pt_calc_tsc_timestamp(struct intel_pt_decoder *decoder)
 	decoder->have_tma = false;
 
 	if (decoder->ref_timestamp) {
-		timestamp = decoder->packet.payload |
-			    (decoder->ref_timestamp & (0xffULL << 56));
-		if (timestamp < decoder->ref_timestamp) {
-			if (decoder->ref_timestamp - timestamp > (1ULL << 55))
-				timestamp += (1ULL << 56);
-		} else {
-			if (timestamp - decoder->ref_timestamp > (1ULL << 55))
-				timestamp -= (1ULL << 56);
-		}
+		timestamp = intel_pt_8b_tsc(decoder->packet.payload,
+					    decoder->ref_timestamp);
 		decoder->tsc_timestamp = timestamp;
 		decoder->timestamp = timestamp;
 		decoder->ref_timestamp = 0;
-- 
2.20.1
