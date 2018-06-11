From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 03/12] perf hists browser gtk: Use hist_entry__has_callchains()
Date: Mon, 11 Jun 2018 14:48:01 -0300
Message-ID: <20180611174810.14815-4-acme@kernel.org>
References: <20180611174810.14815-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180611174810.14815-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jin Yao <yao.jin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Since we can't go from struct hists to struct evsel for all cases (c2c
is an exception) and we have access to the hist_entry, use
hist_entry__has_callchains() in the GTK+ hists browser to figure out
if callchains are available.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-8owkgrruzzi5emvblwh4e6le@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/gtk/hists.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/ui/gtk/hists.c b/tools/perf/ui/gtk/hists.c
index b085f1b3e34d..4ab663ec3e5e 100644
--- a/tools/perf/ui/gtk/hists.c
+++ b/tools/perf/ui/gtk/hists.c
@@ -382,7 +382,7 @@ static void perf_gtk__show_hists(GtkWidget *window, struct hists *hists,
 			gtk_tree_store_set(store, &iter, col_idx++, s, -1);
 		}
 
-		if (hists__has_callchains(hists) &&
+		if (hist_entry__has_callchains(h) &&
 		    symbol_conf.use_callchain && hists__has(hists, sym)) {
 			if (callchain_param.mode == CHAIN_GRAPH_REL)
 				total = symbol_conf.cumulate_callchain ?
-- 
2.14.3
