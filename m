From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 76/91] perf evsel: Rename perf_evsel__store_ids() to evsel__store_id()
Date: Wed,  6 May 2020 12:22:19 -0300
Message-ID: <20200506152234.21977-77-acme@kernel.org>
References: <20200506152234.21977-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200506152234.21977-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

As it is a 'struct evsel' method, not part of tools/lib/perf/, aka
libperf, to whom the perf_ prefix belongs.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 2 +-
 tools/perf/util/evsel.c   | 2 +-
 tools/perf/util/evsel.h   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 188b2f957856..b2a971961364 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -636,7 +636,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 			stat_config.unit_width = l;
 
 		if (perf_evsel__should_store_id(counter) &&
-		    perf_evsel__store_ids(counter, evsel_list))
+		    evsel__store_ids(counter, evsel_list))
 			return -1;
 	}
 
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 32d178a3f933..f3e60c45d59a 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2588,7 +2588,7 @@ static int store_evsel_ids(struct evsel *evsel, struct evlist *evlist)
 	return 0;
 }
 
-int perf_evsel__store_ids(struct evsel *evsel, struct evlist *evlist)
+int evsel__store_ids(struct evsel *evsel, struct evlist *evlist)
 {
 	struct perf_cpu_map *cpus = evsel->core.cpus;
 	struct perf_thread_map *threads = evsel->core.threads;
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index d76111c2d6a8..351c0aaf2a11 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -403,5 +403,5 @@ static inline bool evsel__has_br_stack(const struct evsel *evsel)
 
 struct perf_env *evsel__env(struct evsel *evsel);
 
-int perf_evsel__store_ids(struct evsel *evsel, struct evlist *evlist);
+int evsel__store_ids(struct evsel *evsel, struct evlist *evlist);
 #endif /* __PERF_EVSEL_H */
-- 
2.21.1
