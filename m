From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 04/12] perf hists: Reimplement hists__has_callchains()
Date: Mon, 11 Jun 2018 14:48:02 -0300
Message-ID: <20180611174810.14815-5-acme@kernel.org>
References: <20180611174810.14815-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180611174810.14815-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jin Yao <yao.jin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

There are places where we have only access to struct hists and need to
know if any of its hist_entries has callchains, like when drawing
headers for the various output modes (stdio, TUI, etc), so, when adding
a new hist_entry, check if it has callchains, storing this info for
later use by hists__has_callchains().

This reimplementation is necessary because not always a 'struct hists'
is allocated together with a 'struct perf evsel', so we can't go from
'hists' to 'perf_event_attr.sample_type & PERF_SAMPLE_CALLCHAIN'.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-hg5g7yddjio3ljwyqnnaj5dt@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/hist.c | 6 ++++--
 tools/perf/util/hist.h | 4 ++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 0441a92b855f..828cb9794c76 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -621,9 +621,11 @@ __hists__add_entry(struct hists *hists,
 		.raw_data = sample->raw_data,
 		.raw_size = sample->raw_size,
 		.ops = ops,
-	};
+	}, *he = hists__findnew_entry(hists, &entry, al, sample_self);
 
-	return hists__findnew_entry(hists, &entry, al, sample_self);
+	if (!hists->has_callchains && he && he->callchain_size != 0)
+		hists->has_callchains = true;
+	return he;
 }
 
 struct hist_entry *hists__add_entry(struct hists *hists,
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index 06607c434949..73049f7f0f60 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -85,6 +85,7 @@ struct hists {
 	struct events_stats	stats;
 	u64			event_stream;
 	u16			col_len[HISTC_NR_COLS];
+	bool			has_callchains;
 	int			socket_filter;
 	struct perf_hpp_list	*hpp_list;
 	struct list_head	hpp_formats;
@@ -222,8 +223,7 @@ static inline struct hists *evsel__hists(struct perf_evsel *evsel)
 
 static __pure inline bool hists__has_callchains(struct hists *hists)
 {
-	const struct perf_evsel *evsel = hists_to_evsel(hists);
-	return evsel__has_callchain(evsel);
+	return hists->has_callchains;
 }
 
 int hists__init(void);
-- 
2.14.3
