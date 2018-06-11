From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 02/12] perf hists: Make hist_entry__has_callchains() work with 'perf c2c'
Date: Mon, 11 Jun 2018 14:48:00 -0300
Message-ID: <20180611174810.14815-3-acme@kernel.org>
References: <20180611174810.14815-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180611174810.14815-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Since 'perf c2c' uses 'struct hists' not allocated together with a
'struct perf_evsel' instance, we can't go from a 'struct hist_entry'
pointer to a 'struct perf_evsel' via he->hists, so, instead, check if
space was set aside for hist_entry->callchain[0] at hist_entry__new()
time.

Reported-by: Jin Yao <yao.jin@linux.intel.com>
Reported-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Fixes: fabd37b837f6 ("perf hists: Check if a hist_entry has callchains before using them")
Link: https://lkml.kernel.org/n/tip-e8ife8djvvvwmeze3s4yodii@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/sort.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
index 9ab9257ed887..8bf302cafcec 100644
--- a/tools/perf/util/sort.h
+++ b/tools/perf/util/sort.h
@@ -155,7 +155,7 @@ struct hist_entry {
 
 static __pure inline bool hist_entry__has_callchains(struct hist_entry *he)
 {
-	return hists__has_callchains(he->hists);
+	return he->callchain_size != 0;
 }
 
 static inline bool hist_entry__has_pairs(struct hist_entry *he)
-- 
2.14.3
