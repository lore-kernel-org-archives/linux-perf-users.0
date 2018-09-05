From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 76/77] perf map: Turn some pr_warning() to pr_debug()
Date: Wed,  5 Sep 2018 19:04:39 -0300
Message-ID: <20180905220440.20256-77-acme@kernel.org>
References: <20180905220440.20256-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180905220440.20256-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Annoying when using it with --stdio/--stdio2, so just turn them debug,
we can get those using -v.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-t3684lkugnf1w4lwcmpj9ivm@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/map.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 36d0763311ef..3f07a587c8e6 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -320,12 +320,11 @@ int map__load(struct map *map)
 			build_id__sprintf(map->dso->build_id,
 					  sizeof(map->dso->build_id),
 					  sbuild_id);
-			pr_warning("%s with build id %s not found",
-				   name, sbuild_id);
+			pr_debug("%s with build id %s not found", name, sbuild_id);
 		} else
-			pr_warning("Failed to open %s", name);
+			pr_debug("Failed to open %s", name);
 
-		pr_warning(", continuing without symbols\n");
+		pr_debug(", continuing without symbols\n");
 		return -1;
 	} else if (nr == 0) {
 #ifdef HAVE_LIBELF_SUPPORT
@@ -334,12 +333,11 @@ int map__load(struct map *map)
 
 		if (len > sizeof(DSO__DELETED) &&
 		    strcmp(name + real_len + 1, DSO__DELETED) == 0) {
-			pr_warning("%.*s was updated (is prelink enabled?). "
+			pr_debug("%.*s was updated (is prelink enabled?). "
 				"Restart the long running apps that use it!\n",
 				   (int)real_len, name);
 		} else {
-			pr_warning("no symbols found in %s, maybe install "
-				   "a debug package?\n", name);
+			pr_debug("no symbols found in %s, maybe install a debug package?\n", name);
 		}
 #endif
 		return -1;
@@ -701,8 +699,7 @@ static int maps__fixup_overlappings(struct maps *maps, struct map *map, FILE *fp
 		if (verbose >= 2) {
 
 			if (use_browser) {
-				pr_warning("overlapping maps in %s "
-					   "(disable tui for more info)\n",
+				pr_debug("overlapping maps in %s (disable tui for more info)\n",
 					   map->dso->name);
 			} else {
 				fputs("overlapping maps:\n", fp);
-- 
2.14.4
