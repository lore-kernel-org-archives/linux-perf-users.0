From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 06/46] perf annotate: __symbol__acount_cycles doesn't need notes
Date: Tue,  5 Jun 2018 14:49:50 -0300
Message-ID: <20180605175030.32549-7-acme@kernel.org>
References: <20180605175030.32549-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180605175030.32549-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

It only operates on the notes->src->cyc_hist, just pass that to it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-zd1cu4zwmu21k0cxlr83y6vr@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 0f5ed6091e00..a7221f9fa504 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -741,14 +741,11 @@ void symbol__annotate_zero_histograms(struct symbol *sym)
 	pthread_mutex_unlock(&notes->lock);
 }
 
-static int __symbol__account_cycles(struct annotation *notes,
+static int __symbol__account_cycles(struct cyc_hist *ch,
 				    u64 start,
 				    unsigned offset, unsigned cycles,
 				    unsigned have_start)
 {
-	struct cyc_hist *ch;
-
-	ch = notes->src->cycles_hist;
 	/*
 	 * For now we can only account one basic block per
 	 * final jump. But multiple could be overlapping.
@@ -870,7 +867,7 @@ static int symbol__account_cycles(u64 addr, u64 start,
 			start = 0;
 	}
 	offset = addr - sym->start;
-	return __symbol__account_cycles(notes,
+	return __symbol__account_cycles(notes->src->cycles_hist,
 					start ? start - sym->start : 0,
 					offset, cycles,
 					!!start);
-- 
2.14.3
