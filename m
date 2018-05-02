From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 09/52] perf symbols: Use __map__is_kernel() instead of ad-hoc equivalent code
Date: Wed,  2 May 2018 12:18:59 -0300
Message-ID: <20180502151942.20542-10-acme@kernel.org>
References: <20180502151942.20542-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180502151942.20542-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Shorter, should be equivalent code, use it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-q90olng8sfkvrnsrwu7xnul6@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/symbol.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 1466814ebada..2b6292cff719 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1163,7 +1163,6 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
 			   const char *kallsyms_filename)
 {
 	struct map_groups *kmaps = map__kmaps(map);
-	struct machine *machine;
 	struct kcore_mapfn_data md;
 	struct map *old_map, *new_map, *replacement_map = NULL;
 	bool is_64_bit;
@@ -1174,10 +1173,8 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
 	if (!kmaps)
 		return -EINVAL;
 
-	machine = kmaps->machine;
-
 	/* This function requires that the map is the kernel map */
-	if (map != machine->vmlinux_maps[map->type])
+	if (!__map__is_kernel(map))
 		return -EINVAL;
 
 	if (!filename_from_kallsyms_filename(kcore_filename, "kcore",
-- 
2.14.3
