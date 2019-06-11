From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 66/85] perf intel-pt: Add lookahead callback
Date: Tue, 11 Jun 2019 15:58:52 -0300
Message-ID: <20190611185911.11645-67-acme@kernel.org>
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

Add a callback function to enable the decoder to lookahead at subsequent
trace buffers. This will be used to implement a "fast forward" facility
which will be needed to support efficient time interval filtering.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190604130017.31207-5-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/intel-pt-decoder/intel-pt-decoder.c | 2 ++
 tools/perf/util/intel-pt-decoder/intel-pt-decoder.h | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
index 9eb778f9c911..13123b195083 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -104,6 +104,7 @@ struct intel_pt_decoder {
 			 uint64_t *insn_cnt_ptr, uint64_t *ip, uint64_t to_ip,
 			 uint64_t max_insn_cnt, void *data);
 	bool (*pgd_ip)(uint64_t ip, void *data);
+	int (*lookahead)(void *data, intel_pt_lookahead_cb_t cb, void *cb_data);
 	void *data;
 	struct intel_pt_state state;
 	const unsigned char *buf;
@@ -233,6 +234,7 @@ struct intel_pt_decoder *intel_pt_decoder_new(struct intel_pt_params *params)
 	decoder->get_trace          = params->get_trace;
 	decoder->walk_insn          = params->walk_insn;
 	decoder->pgd_ip             = params->pgd_ip;
+	decoder->lookahead          = params->lookahead;
 	decoder->data               = params->data;
 	decoder->return_compression = params->return_compression;
 	decoder->branch_enable      = params->branch_enable;
diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h
index 6a61773dc44b..de36254c6ac9 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h
@@ -102,12 +102,15 @@ struct intel_pt_buffer {
 	uint64_t trace_nr;
 };
 
+typedef int (*intel_pt_lookahead_cb_t)(struct intel_pt_buffer *, void *);
+
 struct intel_pt_params {
 	int (*get_trace)(struct intel_pt_buffer *buffer, void *data);
 	int (*walk_insn)(struct intel_pt_insn *intel_pt_insn,
 			 uint64_t *insn_cnt_ptr, uint64_t *ip, uint64_t to_ip,
 			 uint64_t max_insn_cnt, void *data);
 	bool (*pgd_ip)(uint64_t ip, void *data);
+	int (*lookahead)(void *data, intel_pt_lookahead_cb_t cb, void *cb_data);
 	void *data;
 	bool return_compression;
 	bool branch_enable;
-- 
2.20.1
