From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 45/53] perf tools: Fix split_kallsyms_for_kcore() for trampoline symbols
Date: Wed,  6 Feb 2019 15:48:55 -0300
Message-ID: <20190206184903.24054-46-acme@kernel.org>
References: <20190206184903.24054-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190206184903.24054-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, stable@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Kallsyms symbols do not have a size, so the size becomes the distance to
the next symbol.

Consequently the recently added trampoline symbols end up with large
sizes because the trampolines are some distance from one another and the
main kernel map.

However, symbols that end outside their map can disrupt the symbol tree
because, after mapping, it can appear incorrectly that they overlap
other symbols.

Add logic to truncate symbol size to the end of the corresponding map.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: stable@vger.kernel.org
Fixes: d83212d5dd67 ("kallsyms, x86: Export addresses of PTI entry trampolines")
Link: http://lkml.kernel.org/r/20190109091835.5570-2-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/symbol.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 7b194cf53cc0..758bf5f74e6e 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -718,6 +718,8 @@ static int map_groups__split_kallsyms_for_kcore(struct map_groups *kmaps, struct
 		}
 
 		pos->start -= curr_map->start - curr_map->pgoff;
+		if (pos->end > curr_map->end)
+			pos->end = curr_map->end;
 		if (pos->end)
 			pos->end -= curr_map->start - curr_map->pgoff;
 		symbols__insert(&curr_map->dso->symbols, pos);
-- 
2.20.1
