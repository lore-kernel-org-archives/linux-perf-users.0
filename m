From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 68/91] perf evsel: Ditch perf_evsel__cmp(), not used for quite a while
Date: Wed,  6 May 2020 12:22:11 -0300
Message-ID: <20200506152234.21977-69-acme@kernel.org>
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

In 4c358d5cf361 ("perf stat: Replace transaction event possition check
with id check") all its uses were removed, so ditch it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 4246cadaf96e..8d61109087a1 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -265,12 +265,6 @@ static inline bool evsel__match2(struct evsel *e1, struct evsel *e2)
 	       (e1->core.attr.config == e2->core.attr.config);
 }
 
-#define perf_evsel__cmp(a, b)			\
-	((a) &&					\
-	 (b) &&					\
-	 (a)->core.attr.type == (b)->core.attr.type &&	\
-	 (a)->core.attr.config == (b)->core.attr.config)
-
 int perf_evsel__read_counter(struct evsel *evsel, int cpu, int thread);
 
 int __perf_evsel__read_on_cpu(struct evsel *evsel,
-- 
2.21.1
