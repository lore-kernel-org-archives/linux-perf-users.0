From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 2/8] perf hists: Add extra integrity checks to fmt_free()
Date: Thu, 19 Oct 2017 14:45:09 -0300
Message-ID: <20171019174515.7407-3-acme@kernel.org>
References: <20171019174515.7407-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171019174515.7407-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Andi Kleen <andi@firstfloor.org>, Changbin Du <changbin.du@intel.com>, David Ahern <dsahern@gmail.com>, Jin Yao <yao.jin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Wang Nan <wangnan0@huawei.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Make sure the struct perf_hpp_fmt is properly unhooked before we free
it.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: Changbin Du <changbin.du@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/r/20171013083736.15037-3-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/hist.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/perf/ui/hist.c b/tools/perf/ui/hist.c
index 6ee6b36bbc76..db79017a6e56 100644
--- a/tools/perf/ui/hist.c
+++ b/tools/perf/ui/hist.c
@@ -606,6 +606,13 @@ void perf_hpp__append_sort_keys(struct perf_hpp_list *list)
 
 static void fmt_free(struct perf_hpp_fmt *fmt)
 {
+	/*
+	 * At this point fmt should be completely
+	 * unhooked, if not it's a bug.
+	 */
+	BUG_ON(!list_empty(&fmt->list));
+	BUG_ON(!list_empty(&fmt->sort_list));
+
 	if (fmt->free)
 		fmt->free(fmt);
 }
-- 
2.13.6
