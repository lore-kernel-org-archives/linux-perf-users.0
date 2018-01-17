From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 06/32] perf evsel: Check if callchain is enabled before setting it up
Date: Wed, 17 Jan 2018 13:11:56 -0300
Message-ID: <20180117161222.15611-7-acme@kernel.org>
References: <20180117161222.15611-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180117161222.15611-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Hendrick Brueckner <brueckner@linux.vnet.ibm.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Thomas Richter <tmricht@linux.vnet.ibm.com>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The construct:

	if (callchain_param)
		perf_evsel__config_callchain(evsel, opts, &callchain_param);

happens in several places, so make perf_evsel__config_callchain() work
just like free(NULL), do nothing if param->enabled is not set.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Hendrick Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-ykk0qzxnxwx3o611ctjnmxav@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 4eea3b404507..efa2e629a669 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -651,9 +651,9 @@ int perf_evsel__group_desc(struct perf_evsel *evsel, char *buf, size_t size)
 	return ret;
 }
 
-void perf_evsel__config_callchain(struct perf_evsel *evsel,
-				  struct record_opts *opts,
-				  struct callchain_param *param)
+static void __perf_evsel__config_callchain(struct perf_evsel *evsel,
+					   struct record_opts *opts,
+					   struct callchain_param *param)
 {
 	bool function = perf_evsel__is_function_event(evsel);
 	struct perf_event_attr *attr = &evsel->attr;
@@ -699,6 +699,14 @@ void perf_evsel__config_callchain(struct perf_evsel *evsel,
 	}
 }
 
+void perf_evsel__config_callchain(struct perf_evsel *evsel,
+				  struct record_opts *opts,
+				  struct callchain_param *param)
+{
+	if (param->enabled)
+		return __perf_evsel__config_callchain(evsel, opts, param);
+}
+
 static void
 perf_evsel__reset_callgraph(struct perf_evsel *evsel,
 			    struct callchain_param *param)
-- 
2.14.3
