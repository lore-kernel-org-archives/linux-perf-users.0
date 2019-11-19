From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 07/25] perf map_groups: Add a front end cache for map lookups by name
Date: Tue, 19 Nov 2019 08:32:27 -0300
Message-ID: <20191119113245.19593-8-acme@kernel.org>
References: <20191119113245.19593-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191119113245.19593-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Lets see if it helps:

First look at the probeable lines for the function that does lookups by
name in a map_groups struct:

  # perf probe -x ~/bin/perf -L map_groups__find_by_name
  <map_groups__find_by_name@/home/acme/git/perf/tools/perf/util/symbol.c:0>
        0  struct map *map_groups__find_by_name(struct map_groups *mg, const char *name)
        1  {
        2         struct maps *maps = &mg->maps;
                  struct map *map;

        5         down_read(&maps->lock);

        7         if (mg->last_search_by_name && strcmp(mg->last_search_by_name->dso->short_name, name) == 0) {
        8                 map = mg->last_search_by_name;
        9                 goto out_unlock;
                  }

       12         maps__for_each_entry(maps, map)
       13                 if (strcmp(map->dso->short_name, name) == 0) {
       14                         mg->last_search_by_name = map;
       15                         goto out_unlock;
                          }

       18         map = NULL;

           out_unlock:
       21         up_read(&maps->lock);
       22         return map;
       23  }

           int dso__load_vmlinux(struct dso *dso, struct map *map,
                                const char *vmlinux, bool vmlinux_allocated)

  #

Now add a probe to the place where we reuse the last search:

  # perf probe -x ~/bin/perf map_groups__find_by_name:8
  Added new event:
    probe_perf:map_groups__find_by_name (on map_groups__find_by_name:8 in /home/acme/bin/perf)

  You can now use it in all perf tools, such as:

  	perf record -e probe_perf:map_groups__find_by_name -aR sleep 1

  #

Now lets do a system wide 'perf stat' counting those events:

  # perf stat -e probe_perf:*

Leave it running and lets do a 'perf top', then, after a while, stop the
'perf stat':

  # perf stat -e probe_perf:*
  ^C
   Performance counter stats for 'system wide':

               3,603      probe_perf:map_groups__find_by_name

        44.565253139 seconds time elapsed
  #

yeah, good to have.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-tcz37g3nxv3tvxw3q90vga3p@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/map.c        | 9 +++++++++
 tools/perf/util/map_groups.h | 6 ++----
 tools/perf/util/symbol.c     | 9 ++++++++-
 3 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 49e353eaa337..d0899df77baa 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -572,6 +572,7 @@ void map_groups__init(struct map_groups *mg, struct machine *machine)
 {
 	maps__init(&mg->maps);
 	mg->machine = machine;
+	mg->last_search_by_name = NULL;
 	refcount_set(&mg->refcnt, 1);
 }
 
@@ -580,6 +581,14 @@ void map_groups__insert(struct map_groups *mg, struct map *map)
 	maps__insert(&mg->maps, map);
 }
 
+void map_groups__remove(struct map_groups *mg, struct map *map)
+{
+	if (mg->last_search_by_name == map)
+		mg->last_search_by_name = NULL;
+
+	maps__remove(&mg->maps, map);
+}
+
 static void __maps__purge(struct maps *maps)
 {
 	struct map *pos, *next;
diff --git a/tools/perf/util/map_groups.h b/tools/perf/util/map_groups.h
index 26fc68bd4f60..f2a3158572eb 100644
--- a/tools/perf/util/map_groups.h
+++ b/tools/perf/util/map_groups.h
@@ -36,6 +36,7 @@ struct symbol *maps__find_symbol_by_name(struct maps *maps, const char *name, st
 struct map_groups {
 	struct maps	 maps;
 	struct machine	 *machine;
+	struct map	 *last_search_by_name;
 	refcount_t	 refcnt;
 #ifdef HAVE_LIBUNWIND_SUPPORT
 	void				*addr_space;
@@ -70,10 +71,7 @@ size_t map_groups__fprintf(struct map_groups *mg, FILE *fp);
 
 void map_groups__insert(struct map_groups *mg, struct map *map);
 
-static inline void map_groups__remove(struct map_groups *mg, struct map *map)
-{
-	maps__remove(&mg->maps, map);
-}
+void map_groups__remove(struct map_groups *mg, struct map *map);
 
 static inline struct map *map_groups__find(struct map_groups *mg, u64 addr)
 {
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 0fb9bd8bcf0d..b146d87176e7 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1767,9 +1767,16 @@ struct map *map_groups__find_by_name(struct map_groups *mg, const char *name)
 
 	down_read(&maps->lock);
 
+	if (mg->last_search_by_name && strcmp(mg->last_search_by_name->dso->short_name, name) == 0) {
+		map = mg->last_search_by_name;
+		goto out_unlock;
+	}
+
 	maps__for_each_entry(maps, map)
-		if (strcmp(map->dso->short_name, name) == 0)
+		if (strcmp(map->dso->short_name, name) == 0) {
+			mg->last_search_by_name = map;
 			goto out_unlock;
+		}
 
 	map = NULL;
 
-- 
2.21.0
