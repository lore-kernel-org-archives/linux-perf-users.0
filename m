From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 29/63] perf map: Allow map__next() to receive a NULL arg
Date: Thu,  7 Nov 2019 15:59:37 -0300
Message-ID: <20191107190011.23924-30-acme@kernel.org>
References: <20191107190011.23924-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191107190011.23924-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Just like free(), return NULL in that case, will simplify the
for_each_entry_safe() iterators.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-pbde2ucn49khnrebclys9pny@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/map.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index c9ba49566981..86d8d187f872 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -1007,7 +1007,7 @@ struct map *maps__first(struct maps *maps)
 	return NULL;
 }
 
-struct map *map__next(struct map *map)
+static struct map *__map__next(struct map *map)
 {
 	struct rb_node *next = rb_next(&map->rb_node);
 
@@ -1016,6 +1016,11 @@ struct map *map__next(struct map *map)
 	return NULL;
 }
 
+struct map *map__next(struct map *map)
+{
+	return map ? __map__next(map) : NULL;
+}
+
 struct kmap *__map__kmap(struct map *map)
 {
 	if (!map->dso || !map->dso->kernel)
-- 
2.21.0
