From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 01/12] perf hists: Save the callchain_size in struct hist_entry
Date: Mon, 11 Jun 2018 14:47:59 -0300
Message-ID: <20180611174810.14815-2-acme@kernel.org>
References: <20180611174810.14815-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180611174810.14815-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jin Yao <yao.jin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

So that we can figure out the real size of the struct and also be able
to tell if callchains may be present in this histogram entry.

Since we can't always guarantee that from hist_entry->hists we can use
hists_to_evsel, to then look at evsel->attr.sample_type for
PERF_SAMPLE_CALLCHAIN, like with the 'perf c2c' tool, that uses plain
'struct hists' instances, we need another way of deciding if a specific
hist_entry instance has callchains associated with it, i.e. if its
hist_entry->callchain[0] has space allocated for.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-ptvndealxs1k7myluvu9flnq@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/hist.c | 6 ++++--
 tools/perf/util/sort.h | 2 ++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 52e8fda93a47..0441a92b855f 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -370,9 +370,11 @@ void hists__delete_entries(struct hists *hists)
 
 static int hist_entry__init(struct hist_entry *he,
 			    struct hist_entry *template,
-			    bool sample_self)
+			    bool sample_self,
+			    size_t callchain_size)
 {
 	*he = *template;
+	he->callchain_size = callchain_size;
 
 	if (symbol_conf.cumulate_callchain) {
 		he->stat_acc = malloc(sizeof(he->stat));
@@ -473,7 +475,7 @@ static struct hist_entry *hist_entry__new(struct hist_entry *template,
 
 	he = ops->new(callchain_size);
 	if (he) {
-		err = hist_entry__init(he, template, sample_self);
+		err = hist_entry__init(he, template, sample_self, callchain_size);
 		if (err) {
 			ops->free(he);
 			he = NULL;
diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
index 7cf2d5cc038e..9ab9257ed887 100644
--- a/tools/perf/util/sort.h
+++ b/tools/perf/util/sort.h
@@ -112,6 +112,8 @@ struct hist_entry {
 
 	char			level;
 	u8			filtered;
+
+	u16			callchain_size;
 	union {
 		/*
 		 * Since perf diff only supports the stdio output, TUI
-- 
2.14.3
