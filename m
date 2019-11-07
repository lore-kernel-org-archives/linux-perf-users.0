From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 31/63] perf map_groups: Introduce for_each_entry() and for_each_entry_safe() iterators
Date: Thu,  7 Nov 2019 15:59:39 -0300
Message-ID: <20191107190011.23924-32-acme@kernel.org>
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

To reduce boilerplate, providing a more compact form to iterate over the
maps in a map_group.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-gc3go6fmdn30twusg91t2q56@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/map_groups.c |  9 ++++-----
 tools/perf/util/map_groups.h  |  9 ++++-----
 tools/perf/util/symbol.c      | 24 ++++--------------------
 tools/perf/util/vdso.c        |  4 ++--
 4 files changed, 14 insertions(+), 32 deletions(-)

diff --git a/tools/perf/tests/map_groups.c b/tools/perf/tests/map_groups.c
index 594fdaca4f71..b52adad55f8d 100644
--- a/tools/perf/tests/map_groups.c
+++ b/tools/perf/tests/map_groups.c
@@ -18,17 +18,16 @@ static int check_maps(struct map_def *merged, unsigned int size, struct map_grou
 	struct map *map;
 	unsigned int i = 0;
 
-	map = map_groups__first(mg);
-	while (map) {
+	map_groups__for_each_entry(mg, map) {
+		if (i > 0)
+			TEST_ASSERT_VAL("less maps expected", (map && i < size) || (!map && i == size));
+
 		TEST_ASSERT_VAL("wrong map start",  map->start == merged[i].start);
 		TEST_ASSERT_VAL("wrong map end",    map->end == merged[i].end);
 		TEST_ASSERT_VAL("wrong map name",  !strcmp(map->dso->name, merged[i].name));
 		TEST_ASSERT_VAL("wrong map refcnt", refcount_read(&map->refcnt) == 2);
 
 		i++;
-		map = map_groups__next(map);
-
-		TEST_ASSERT_VAL("less maps expected", (map && i < size) || (!map && i == size));
 	}
 
 	return TEST_OK;
diff --git a/tools/perf/util/map_groups.h b/tools/perf/util/map_groups.h
index ce3ade32babd..bfbdbf5a443a 100644
--- a/tools/perf/util/map_groups.h
+++ b/tools/perf/util/map_groups.h
@@ -89,12 +89,11 @@ static inline struct map *map_groups__find(struct map_groups *mg, u64 addr)
 	return maps__find(&mg->maps, addr);
 }
 
-struct map *map_groups__first(struct map_groups *mg);
+#define map_groups__for_each_entry(mg, map) \
+	for (map = maps__first(&mg->maps); map; map = map__next(map))
 
-static inline struct map *map_groups__next(struct map *map)
-{
-	return map__next(map);
-}
+#define map_groups__for_each_entry_safe(mg, map, next) \
+	for (map = maps__first(&mg->maps), next = map__next(map); map; map = next, next = map__next(map))
 
 struct symbol *map_groups__find_symbol(struct map_groups *mg, u64 addr, struct map **mapp);
 struct symbol *map_groups__find_symbol_by_name(struct map_groups *mg, const char *name, struct map **mapp);
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 042140fc4d36..a4bd61cbc2a0 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1049,11 +1049,6 @@ int compare_proc_modules(const char *from, const char *to)
 	return ret;
 }
 
-struct map *map_groups__first(struct map_groups *mg)
-{
-	return maps__first(&mg->maps);
-}
-
 static int do_validate_kcore_modules(const char *filename,
 				  struct map_groups *kmaps)
 {
@@ -1065,13 +1060,10 @@ static int do_validate_kcore_modules(const char *filename,
 	if (err)
 		return err;
 
-	old_map = map_groups__first(kmaps);
-	while (old_map) {
-		struct map *next = map_groups__next(old_map);
+	map_groups__for_each_entry(kmaps, old_map) {
 		struct module_info *mi;
 
 		if (!__map__is_kmodule(old_map)) {
-			old_map = next;
 			continue;
 		}
 
@@ -1081,8 +1073,6 @@ static int do_validate_kcore_modules(const char *filename,
 			err = -EINVAL;
 			goto out;
 		}
-
-		old_map = next;
 	}
 out:
 	delete_modules(&modules);
@@ -1185,9 +1175,7 @@ int map_groups__merge_in(struct map_groups *kmaps, struct map *new_map)
 	struct map *old_map;
 	LIST_HEAD(merged);
 
-	for (old_map = map_groups__first(kmaps); old_map;
-	     old_map = map_groups__next(old_map)) {
-
+	map_groups__for_each_entry(kmaps, old_map) {
 		/* no overload with this one */
 		if (new_map->end < old_map->start ||
 		    new_map->start >= old_map->end)
@@ -1260,7 +1248,7 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
 {
 	struct map_groups *kmaps = map__kmaps(map);
 	struct kcore_mapfn_data md;
-	struct map *old_map, *new_map, *replacement_map = NULL;
+	struct map *old_map, *new_map, *replacement_map = NULL, *next;
 	struct machine *machine;
 	bool is_64_bit;
 	int err, fd;
@@ -1307,10 +1295,7 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
 	}
 
 	/* Remove old maps */
-	old_map = map_groups__first(kmaps);
-	while (old_map) {
-		struct map *next = map_groups__next(old_map);
-
+	map_groups__for_each_entry_safe(kmaps, old_map, next) {
 		/*
 		 * We need to preserve eBPF maps even if they are
 		 * covered by kcore, because we need to access
@@ -1318,7 +1303,6 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
 		 */
 		if (old_map != map && !__map__is_bpf_prog(old_map))
 			map_groups__remove(kmaps, old_map);
-		old_map = next;
 	}
 	machine->trampolines_mapped = false;
 
diff --git a/tools/perf/util/vdso.c b/tools/perf/util/vdso.c
index ba4b4395f35d..6e00793c10ee 100644
--- a/tools/perf/util/vdso.c
+++ b/tools/perf/util/vdso.c
@@ -142,9 +142,9 @@ static enum dso_type machine__thread_dso_type(struct machine *machine,
 					      struct thread *thread)
 {
 	enum dso_type dso_type = DSO__TYPE_UNKNOWN;
-	struct map *map = map_groups__first(thread->mg);
+	struct map *map;
 
-	for (; map ; map = map_groups__next(map)) {
+	map_groups__for_each_entry(thread->mg, map) {
 		struct dso *dso = map->dso;
 		if (!dso || dso->long_name[0] != '/')
 			continue;
-- 
2.21.0
