From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 01/15] perf map: Use map->dso->kernel + map__kmaps() in map__kmaps()
Date: Tue, 12 Nov 2019 15:37:43 -0300
Message-ID: <20191112183757.28660-2-acme@kernel.org>
References: <20191112183757.28660-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191112183757.28660-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Its equivalent to using map->groups to obtain the machine struct.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-bdbazuj4ggrmzxdviaqdrdwh@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/map.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 466c9b035e19..a4d889c0fa88 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -244,18 +244,11 @@ struct map *map__new2(u64 start, struct dso *dso)
 	return map;
 }
 
-/*
- * Use this and __map__is_kmodule() for map instances that are in
- * machine->kmaps, and thus have map->groups->machine all properly set, to
- * disambiguate between the kernel and modules.
- *
- * When the need arises, introduce map__is_{kernel,kmodule)() that
- * checks (map->groups != NULL && map->groups->machine != NULL &&
- * map->dso->kernel) before calling __map__is_{kernel,kmodule}())
- */
 bool __map__is_kernel(const struct map *map)
 {
-	return machine__kernel_map(map->groups->machine) == map;
+	if (!map->dso->kernel)
+		return false;
+	return machine__kernel_map(map__kmaps((struct map *)map)->machine) == map;
 }
 
 bool __map__is_extra_kernel_map(const struct map *map)
-- 
2.21.0
