From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 28/63] perf map: Check if the map still has some refcounts on exit
Date: Thu,  7 Nov 2019 15:59:36 -0300
Message-ID: <20191107190011.23924-29-acme@kernel.org>
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

We were checking just if it was still on some rb tree, but that is not
the only way that this map can still have references, map->refcnt is
there exactly for this, use it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-hany65tbeavsax7n3xvwl9pc@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/map.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index eec9b282c047..c9ba49566981 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -288,7 +288,7 @@ bool map__has_symbols(const struct map *map)
 
 static void map__exit(struct map *map)
 {
-	BUG_ON(!RB_EMPTY_NODE(&map->rb_node));
+	BUG_ON(refcount_read(&map->refcnt) != 0);
 	dso__zput(map->dso);
 }
 
-- 
2.21.0
