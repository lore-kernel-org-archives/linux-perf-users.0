From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 7/7] perf tools: Fix maps__find_symbol_by_name()
Date: Wed, 12 Sep 2018 15:55:09 -0300
Message-ID: <20180912185509.32187-8-acme@kernel.org>
References: <20180912185509.32187-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180912185509.32187-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@redhat.com>, stable@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Commit 1c5aae7710bb ("perf machine: Create maps for x86 PTI entry
trampolines") revealed a problem with maps__find_symbol_by_name() that
resulted in probes not being found e.g.

	$ sudo perf probe xsk_mmap
	xsk_mmap is out of .text, skip it.
	Probe point 'xsk_mmap' not found.
	   Error: Failed to add events.

maps__find_symbol_by_name() can optionally return the map of the found
symbol. It can get the map wrong because, in fact, the symbol is found
on the map's dso, not allowing for the possibility that the dso has more
than one map. Fix by always checking the map contains the symbol.

Reported-by: Björn Töpel <bjorn.topel@intel.com>
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Tested-by: Björn Töpel <bjorn.topel@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: stable@vger.kernel.org
Fixes: 1c5aae7710bb ("perf machine: Create maps for x86 PTI entry trampolines")
Link: http://lkml.kernel.org/r/20180907085116.25782-1-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/map.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 36d0763311ef..6a6929f208b4 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -576,6 +576,13 @@ struct symbol *map_groups__find_symbol(struct map_groups *mg,
 	return NULL;
 }
 
+static bool map__contains_symbol(struct map *map, struct symbol *sym)
+{
+	u64 ip = map->unmap_ip(map, sym->start);
+
+	return ip >= map->start && ip < map->end;
+}
+
 struct symbol *maps__find_symbol_by_name(struct maps *maps, const char *name,
 					 struct map **mapp)
 {
@@ -591,6 +598,10 @@ struct symbol *maps__find_symbol_by_name(struct maps *maps, const char *name,
 
 		if (sym == NULL)
 			continue;
+		if (!map__contains_symbol(pos, sym)) {
+			sym = NULL;
+			continue;
+		}
 		if (mapp != NULL)
 			*mapp = pos;
 		goto out;
-- 
2.14.4
