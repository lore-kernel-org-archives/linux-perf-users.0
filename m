From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 35/60] perf evsel: Add support for synthesized sample type
Date: Mon, 20 Apr 2020 08:52:51 -0300
Message-ID: <20200420115316.18781-36-acme@kernel.org>
References: <20200420115316.18781-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200420115316.18781-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

For reporting purposes, an evsel sample can have a callchain synthesized
from AUX area data. Add support for keeping track of synthesized sample
types. Note, the recorded sample_type cannot be changed because it is
needed to continue to parse events.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lore.kernel.org/lkml/20200401101613.6201-11-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.h | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 53187c501ee8..e64ed4202cab 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -104,6 +104,14 @@ struct evsel {
 		perf_evsel__sb_cb_t	*cb;
 		void			*data;
 	} side_band;
+	/*
+	 * For reporting purposes, an evsel sample can have a callchain
+	 * synthesized from AUX area data. Keep track of synthesized sample
+	 * types here. Note, the recorded sample_type cannot be changed because
+	 * it is needed to continue to parse events.
+	 * See also evsel__has_callchain().
+	 */
+	__u64			synth_sample_type;
 };
 
 struct perf_missing_features {
@@ -398,7 +406,12 @@ static inline bool perf_evsel__has_branch_hw_idx(const struct evsel *evsel)
 
 static inline bool evsel__has_callchain(const struct evsel *evsel)
 {
-	return (evsel->core.attr.sample_type & PERF_SAMPLE_CALLCHAIN) != 0;
+	/*
+	 * For reporting purposes, an evsel sample can have a recorded callchain
+	 * or a callchain synthesized from AUX area data.
+	 */
+	return evsel->core.attr.sample_type & PERF_SAMPLE_CALLCHAIN ||
+	       evsel->synth_sample_type & PERF_SAMPLE_CALLCHAIN;
 }
 
 struct perf_env *perf_evsel__env(struct evsel *evsel);
-- 
2.21.1
