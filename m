From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 1/8] perf hists: Fix crash in perf_hpp__reset_output_field()
Date: Thu, 19 Oct 2017 14:45:08 -0300
Message-ID: <20171019174515.7407-2-acme@kernel.org>
References: <20171019174515.7407-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171019174515.7407-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Andi Kleen <andi@firstfloor.org>, David Ahern <dsahern@gmail.com>, Jin Yao <yao.jin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Wang Nan <wangnan0@huawei.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Du Changbin reported crash [1] when calling perf_hpp__reset_output_field()
after unregistering field via perf_hpp__column_unregister().

This ends up in calling following list_del* sequence on
the same format:

  perf_hpp__column_unregister:
    list_del(&format->list);
  perf_hpp__reset_output_field:
    list_del_init(&fmt->list);

where the later list_del_init might touch already freed formats.

Fixing this by replacing list_del() with list_del_init() in
perf_hpp__column_unregister().

[1] http://marc.info/?l=linux-kernel&m=149059595826019&w=2

Reported-by: Changbin Du <changbin.du@intel.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/r/20171013083736.15037-2-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/hist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/ui/hist.c b/tools/perf/ui/hist.c
index ddb2c6fbdf91..6ee6b36bbc76 100644
--- a/tools/perf/ui/hist.c
+++ b/tools/perf/ui/hist.c
@@ -532,7 +532,7 @@ void perf_hpp_list__prepend_sort_field(struct perf_hpp_list *list,
 
 void perf_hpp__column_unregister(struct perf_hpp_fmt *format)
 {
-	list_del(&format->list);
+	list_del_init(&format->list);
 }
 
 void perf_hpp__cancel_cumulate(void)
-- 
2.13.6
