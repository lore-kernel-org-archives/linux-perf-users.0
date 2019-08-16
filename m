From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 17/17] perf unwind: Remove unnecessary test
Date: Fri, 16 Aug 2019 17:16:53 -0300
Message-ID: <20190816201653.19332-18-acme@kernel.org>
References: <20190816201653.19332-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190816201653.19332-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, John Keeping <john@metanate.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Konstantin Khlebnikov <khlebnikov@yandex-team.ru>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: John Keeping <john@metanate.com>

If dwarf_callchain_users is false, then unwind__prepare_access() will
not set unwind_libunwind_ops so the remaining test here is sufficient.

Signed-off-by: John Keeping <john@metanate.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: john keeping <john@metanate.com>
Link: http://lkml.kernel.org/r/20190815100146.28842-3-john@metanate.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/unwind-libunwind.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/tools/perf/util/unwind-libunwind.c b/tools/perf/util/unwind-libunwind.c
index b843f9d0a9ea..6499b22b158b 100644
--- a/tools/perf/util/unwind-libunwind.c
+++ b/tools/perf/util/unwind-libunwind.c
@@ -69,18 +69,12 @@ int unwind__prepare_access(struct map_groups *mg, struct map *map,
 
 void unwind__flush_access(struct map_groups *mg)
 {
-	if (!dwarf_callchain_users)
-		return;
-
 	if (mg->unwind_libunwind_ops)
 		mg->unwind_libunwind_ops->flush_access(mg);
 }
 
 void unwind__finish_access(struct map_groups *mg)
 {
-	if (!dwarf_callchain_users)
-		return;
-
 	if (mg->unwind_libunwind_ops)
 		mg->unwind_libunwind_ops->finish_access(mg);
 }
-- 
2.21.0
