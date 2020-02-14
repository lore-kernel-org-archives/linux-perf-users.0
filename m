From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 08/23] perf maps: Move kmap::kmaps setup to maps__insert()
Date: Fri, 14 Feb 2020 16:10:42 -0300
Message-ID: <20200214191057.26266-9-acme@kernel.org>
References: <20200214191057.26266-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200214191057.26266-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, Kim Phillips <kim.phillips@amd.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Michael Petlan <mpetlan@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

So the kmaps pointer setup is centralized and we do not need to update
it in all those places (2 current places and few more missing) after
calling maps__insert().

Reported-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Tested-by: Kim Phillips <kim.phillips@amd.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20200210143218.24948-5-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/machine.c | 13 +------------
 tools/perf/util/map.c     | 10 ++++++++++
 2 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 0ad026561c7f..fb5c2cd44d30 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -981,7 +981,6 @@ int machine__create_extra_kernel_map(struct machine *machine,
 
 	kmap = map__kmap(map);
 
-	kmap->kmaps = &machine->kmaps;
 	strlcpy(kmap->name, xm->name, KMAP_NAME_LEN);
 
 	maps__insert(&machine->kmaps, map);
@@ -1091,9 +1090,6 @@ int __weak machine__create_extra_kernel_maps(struct machine *machine __maybe_unu
 static int
 __machine__create_kernel_maps(struct machine *machine, struct dso *kernel)
 {
-	struct kmap *kmap;
-	struct map *map;
-
 	/* In case of renewal the kernel map, destroy previous one */
 	machine__destroy_kernel_maps(machine);
 
@@ -1102,14 +1098,7 @@ __machine__create_kernel_maps(struct machine *machine, struct dso *kernel)
 		return -1;
 
 	machine->vmlinux_map->map_ip = machine->vmlinux_map->unmap_ip = identity__map_ip;
-	map = machine__kernel_map(machine);
-	kmap = map__kmap(map);
-	if (!kmap)
-		return -1;
-
-	kmap->kmaps = &machine->kmaps;
-	maps__insert(&machine->kmaps, map);
-
+	maps__insert(&machine->kmaps, machine->vmlinux_map);
 	return 0;
 }
 
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index cea05fc9595c..a08ca276098e 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -543,6 +543,16 @@ void maps__insert(struct maps *maps, struct map *map)
 	__maps__insert(maps, map);
 	++maps->nr_maps;
 
+	if (map->dso && map->dso->kernel) {
+		struct kmap *kmap = map__kmap(map);
+
+		if (kmap)
+			kmap->kmaps = maps;
+		else
+			pr_err("Internal error: kernel dso with non kernel map\n");
+	}
+
+
 	/*
 	 * If we already performed some search by name, then we need to add the just
 	 * inserted map and resort.
-- 
2.21.1
