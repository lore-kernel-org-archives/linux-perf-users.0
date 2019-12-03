From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 12/23] perf machine: Fill map_symbol->maps in append_inlines() to fix segfault
Date: Tue,  3 Dec 2019 10:55:55 -0300
Message-ID: <20191203135606.24902-13-acme@kernel.org>
References: <20191203135606.24902-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191203135606.24902-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

I forgot to fill in the map_symbol->maps field in append_inlines() which
then makes code down the line segfault when trying to deref it.

It doesn't make any sense to have an addr_location with its 'map' member
not NULL while its 'maps' is NULL, after all al->maps is where al->map
is in.

It is done that way so that we don't have to have in each 'struct map' a
pointer to the 'struct maps' it is in, as we had in the past when we
would have 'map->mg', before 'struct maps' was combined with 'struct
map_groups', because there was always a one-to-one relationship for
these structs.

This fixes a segfault when processing DWARF callgraphs in 'perf report'.

Reported-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Fixes: 08f6680e627e ("perf tools: Add a 'struct map_groups' pointer to 'struct map_symbol'")
Link: http://lore.kernel.org/lkml/20191129160631.GD26963@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/machine.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 416d174d223c..c8c5410315e8 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2446,6 +2446,7 @@ static int append_inlines(struct callchain_cursor *cursor, struct map_symbol *ms
 
 	list_for_each_entry(ilist, &inline_node->val, list) {
 		struct map_symbol ilist_ms = {
+			.maps = ms->maps,
 			.map = map,
 			.sym = ilist->symbol,
 		};
-- 
2.21.0
