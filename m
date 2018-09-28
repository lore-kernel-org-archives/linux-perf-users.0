From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 4/6] perf report: Use the offset address to find inline frames
Date: Fri, 28 Sep 2018 09:25:37 -0300
Message-ID: <20180928122539.29326-5-acme@kernel.org>
References: <20180928122539.29326-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180928122539.29326-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Milian Wolff <milian.wolff@kdab.com>, Jin Yao <yao.jin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, Sandipan Das <sandipan@linux.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Milian Wolff <milian.wolff@kdab.com>

To correctly find inlined frames, we have to use the file offset instead
of the virtual memory address. This was already fixed for displaying
srcline information while displaying in commit 2a9d5050dc84fa20 ("perf
script: Show correct offsets for DWARF-based unwinding"). We just need
to use the same corrected address also when trying to find inline
frames.

This is another follow-up to commit 19610184693c ("perf script: Show
virtual addresses instead of offsets").

Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Sandipan Das <sandipan@linux.ibm.com>
Fixes: 19610184693c ("perf script: Show virtual addresses instead of offsets")
Link: http://lkml.kernel.org/r/20180926135207.30263-2-milian.wolff@kdab.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/machine.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 0cb4f8bf3ca7..73a651f10a0f 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2317,9 +2317,6 @@ static int unwind_entry(struct unwind_entry *entry, void *arg)
 	if (symbol_conf.hide_unresolved && entry->sym == NULL)
 		return 0;
 
-	if (append_inlines(cursor, entry->map, entry->sym, entry->ip) == 0)
-		return 0;
-
 	/*
 	 * Convert entry->ip from a virtual address to an offset in
 	 * its corresponding binary.
@@ -2327,6 +2324,9 @@ static int unwind_entry(struct unwind_entry *entry, void *arg)
 	if (entry->map)
 		addr = map__map_ip(entry->map, entry->ip);
 
+	if (append_inlines(cursor, entry->map, entry->sym, addr) == 0)
+		return 0;
+
 	srcline = callchain_srcline(entry->map, entry->sym, addr);
 	return callchain_cursor_append(cursor, entry->ip,
 				       entry->map, entry->sym,
-- 
2.14.4
