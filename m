From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 69/85] perf intel-pt: Add reposition parameter to intel_pt_get_data()
Date: Tue, 11 Jun 2019 15:58:55 -0300
Message-ID: <20190611185911.11645-70-acme@kernel.org>
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

When the decoder gets the next trace buffer, some state is reset if the
buffer is not consecutive to the previous buffer. Add a parameter
'reposition' so that can be done also to support a "fast forward"
facility.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190604130017.31207-8-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../util/intel-pt-decoder/intel-pt-decoder.c    | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
index 70bff7bb79f3..dde6a7a97a7a 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -502,7 +502,7 @@ static void intel_pt_reposition(struct intel_pt_decoder *decoder)
 	decoder->have_tma = false;
 }
 
-static int intel_pt_get_data(struct intel_pt_decoder *decoder)
+static int intel_pt_get_data(struct intel_pt_decoder *decoder, bool reposition)
 {
 	struct intel_pt_buffer buffer = { .buf = 0, };
 	int ret;
@@ -519,7 +519,7 @@ static int intel_pt_get_data(struct intel_pt_decoder *decoder)
 		intel_pt_log("No more data\n");
 		return -ENODATA;
 	}
-	if (!buffer.consecutive) {
+	if (!buffer.consecutive || reposition) {
 		intel_pt_reposition(decoder);
 		decoder->ref_timestamp = buffer.ref_timestamp;
 		decoder->state.trace_nr = buffer.trace_nr;
@@ -531,10 +531,11 @@ static int intel_pt_get_data(struct intel_pt_decoder *decoder)
 	return 0;
 }
 
-static int intel_pt_get_next_data(struct intel_pt_decoder *decoder)
+static int intel_pt_get_next_data(struct intel_pt_decoder *decoder,
+				  bool reposition)
 {
 	if (!decoder->next_buf)
-		return intel_pt_get_data(decoder);
+		return intel_pt_get_data(decoder, reposition);
 
 	decoder->buf = decoder->next_buf;
 	decoder->len = decoder->next_len;
@@ -553,7 +554,7 @@ static int intel_pt_get_split_packet(struct intel_pt_decoder *decoder)
 	len = decoder->len;
 	memcpy(buf, decoder->buf, len);
 
-	ret = intel_pt_get_data(decoder);
+	ret = intel_pt_get_data(decoder, false);
 	if (ret) {
 		decoder->pos += old_len;
 		return ret < 0 ? ret : -EINVAL;
@@ -879,7 +880,7 @@ static int intel_pt_get_next_packet(struct intel_pt_decoder *decoder)
 		decoder->len -= decoder->pkt_step;
 
 		if (!decoder->len) {
-			ret = intel_pt_get_next_data(decoder);
+			ret = intel_pt_get_next_data(decoder, false);
 			if (ret)
 				return ret;
 		}
@@ -2369,7 +2370,7 @@ static int intel_pt_get_split_psb(struct intel_pt_decoder *decoder,
 	decoder->pos += decoder->len;
 	decoder->len = 0;
 
-	ret = intel_pt_get_next_data(decoder);
+	ret = intel_pt_get_next_data(decoder, false);
 	if (ret)
 		return ret;
 
@@ -2395,7 +2396,7 @@ static int intel_pt_scan_for_psb(struct intel_pt_decoder *decoder)
 	intel_pt_log("Scanning for PSB\n");
 	while (1) {
 		if (!decoder->len) {
-			ret = intel_pt_get_next_data(decoder);
+			ret = intel_pt_get_next_data(decoder, false);
 			if (ret)
 				return ret;
 		}
-- 
2.20.1
