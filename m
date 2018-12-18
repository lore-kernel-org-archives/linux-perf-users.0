From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 62/63] perf symbols: Relax checks on perf-PID.map ownership
Date: Tue, 18 Dec 2018 19:07:32 -0300
Message-ID: <20181218220733.15839-63-acme@kernel.org>
References: <20181218220733.15839-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181218220733.15839-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Frederic Weisbecker <fweisbec@gmail.com>, =?UTF-8?q?H=C3=ADtalo=20Silva?= <hitalos@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Pekka Enberg <penberg@kernel.org>, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Those are simple enough, and usually not produced by root, instead by
whatever user is running java, rust, Node.js JIT code that end up
generating those /tmp/perf-PID.map for resolution of symbols in the
anonymous executable maps.

Having to use --force to resolve symbols in 'perf top' is a distraction,
as recently I experienced when node.js symbols were not being resolved
by 'perf top'.

Acked-by: Ingo Molnar <mingo@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Hítalo Silva <hitalos@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lkml.kernel.org/n/tip-tk2jgo2v4v2yjuj28axbpppo@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/symbol.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index dcce74bae6de..01f2c7385e38 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1537,17 +1537,6 @@ int dso__load(struct dso *dso, struct map *map)
 	dso->adjust_symbols = 0;
 
 	if (perfmap) {
-		struct stat st;
-
-		if (lstat(map_path, &st) < 0)
-			goto out;
-
-		if (!symbol_conf.force && st.st_uid && (st.st_uid != geteuid())) {
-			pr_warning("File %s not owned by current user or root, "
-				   "ignoring it (use -f to override).\n", map_path);
-			goto out;
-		}
-
 		ret = dso__load_perf_map(map_path, dso);
 		dso->symtab_type = ret > 0 ? DSO_BINARY_TYPE__JAVA_JIT :
 					     DSO_BINARY_TYPE__NOT_FOUND;
-- 
2.19.2
