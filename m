From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 06/17] perf evsel: Add comment for 'idx' member in 'struct perf_sample_id
Date: Tue, 20 Aug 2019 16:27:22 -0300
Message-ID: <20190820192733.19180-7-acme@kernel.org>
References: <20190820192733.19180-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190820192733.19180-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Michael Petlan <mpetlan@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

The 'idx' member was added as preparation for AUX area sampling. Add a
comment to describe why.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/83ff264f-84c3-5372-8976-dd9293d20c6f@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 9cd6e3ae479a..efe08065838f 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -23,6 +23,13 @@ struct perf_sample_id {
 	struct hlist_node 	node;
 	u64		 	id;
 	struct evsel		*evsel;
+       /*
+	* 'idx' will be used for AUX area sampling. A sample will have AUX area
+	* data that will be queued for decoding, where there are separate
+	* queues for each CPU (per-cpu tracing) or task (per-thread tracing).
+	* The sample ID can be used to lookup 'idx' which is effectively the
+	* queue number.
+	*/
 	int			idx;
 	int			cpu;
 	pid_t			tid;
-- 
2.21.0
