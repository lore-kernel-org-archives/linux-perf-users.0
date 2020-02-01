From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 6/6] perf maps: Add missing unlock to maps__insert() error case
Date: Sat,  1 Feb 2020 09:03:30 +0100
Message-ID: <20200201080330.13211-7-acme@kernel.org>
References: <20200201080330.13211-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200201080330.13211-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Cengiz Can <cengiz@kernel.wtf>, Adrian Hunter <adrian.hunter@intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Cengiz Can <cengiz@kernel.wtf>

`tools/perf/util/map.c` has a function named `maps__insert` that
acquires a write lock if its in multithread context.

Even though this lock is released when function successfully completes,
there's a branch that is executed when `maps_by_name == NULL` that
returns from this function without releasing the write lock.

Added an `up_write` to release the lock when this happens.

Fixes: a7c2b572e217 ("perf map_groups: Auto sort maps by name, if needed")
Signed-off-by: Cengiz Can <cengiz@kernel.wtf>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lore.kernel.org/lkml/20200120141553.23934-1-cengiz@kernel.wtf
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/map.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index fdd5bddb3075..f67960bedebb 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -549,6 +549,7 @@ void maps__insert(struct maps *maps, struct map *map)
 
 			if (maps_by_name == NULL) {
 				__maps__free_maps_by_name(maps);
+				up_write(&maps->lock);
 				return;
 			}
 
-- 
2.21.1
