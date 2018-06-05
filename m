From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 31/46] perf hists: Do not allocate space for callchains for evsels without them
Date: Tue,  5 Jun 2018 14:50:15 -0300
Message-ID: <20180605175030.32549-32-acme@kernel.org>
References: <20180605175030.32549-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180605175030.32549-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

This is another case were a big switch for callchains,
symbol_conf.use_callchain, is inconvenient, as we can have both events
with and without callchains, no point in checking a single switch to
decide to allocate space for callchains.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-62q64m7x7kqpb4g7boqc2nde@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/hist.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 34864c87cd3c..496913eeed75 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -461,14 +461,19 @@ static struct hist_entry *hist_entry__new(struct hist_entry *template,
 					  bool sample_self)
 {
 	struct hist_entry_ops *ops = template->ops;
+	struct perf_evsel *evsel = hists_to_evsel(template->hists);
 	size_t callchain_size = 0;
 	struct hist_entry *he;
 	int err = 0;
 
 	if (!ops)
 		ops = template->ops = &default_ops;
-
-	if (symbol_conf.use_callchain)
+	/*
+	 * It is possible to have callchains for some evsels but not for others,
+	 * e.g.:  'perf record -e cycles,cache-misses/max-stack=10/', so lets
+	 * not waste space for that.
+	 */
+	if (symbol_conf.use_callchain && evsel__has_callchain(evsel))
 		callchain_size = sizeof(struct callchain_root);
 
 	he = ops->new(callchain_size);
-- 
2.14.3
