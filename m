From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 01/22] perf script: Move map__fprintf_srccode() to near its only user
Date: Thu, 28 Nov 2019 10:40:06 -0300
Message-ID: <20191128134027.23726-2-acme@kernel.org>
References: <20191128134027.23726-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191128134027.23726-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

No need to have it elsewhere.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-8cw846pudpxo0xdkvi9qnvrh@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-script.c | 42 ++++++++++++++++++++++++++++++++++
 tools/perf/util/map.c       | 45 -------------------------------------
 tools/perf/util/map.h       |  5 -----
 3 files changed, 42 insertions(+), 50 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index f86c5cce5b2c..7b2f0922050c 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -932,6 +932,48 @@ static int grab_bb(u8 *buffer, u64 start, u64 end,
 	return len;
 }
 
+static int map__fprintf_srccode(struct map *map, u64 addr, FILE *fp, struct srccode_state *state)
+{
+	char *srcfile;
+	int ret = 0;
+	unsigned line;
+	int len;
+	char *srccode;
+
+	if (!map || !map->dso)
+		return 0;
+	srcfile = get_srcline_split(map->dso,
+				    map__rip_2objdump(map, addr),
+				    &line);
+	if (!srcfile)
+		return 0;
+
+	/* Avoid redundant printing */
+	if (state &&
+	    state->srcfile &&
+	    !strcmp(state->srcfile, srcfile) &&
+	    state->line == line) {
+		free(srcfile);
+		return 0;
+	}
+
+	srccode = find_sourceline(srcfile, line, &len);
+	if (!srccode)
+		goto out_free_line;
+
+	ret = fprintf(fp, "|%-8d %.*s", line, len, srccode);
+
+	if (state) {
+		state->srcfile = srcfile;
+		state->line = line;
+	}
+	return ret;
+
+out_free_line:
+	free(srcfile);
+	return ret;
+}
+
 static int print_srccode(struct thread *thread, u8 cpumode, uint64_t addr)
 {
 	struct addr_location al;
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 744bfbaf35cf..b59944eb469e 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -433,51 +433,6 @@ int map__fprintf_srcline(struct map *map, u64 addr, const char *prefix,
 	return ret;
 }
 
-int map__fprintf_srccode(struct map *map, u64 addr,
-			 FILE *fp,
-			 struct srccode_state *state)
-{
-	char *srcfile;
-	int ret = 0;
-	unsigned line;
-	int len;
-	char *srccode;
-
-	if (!map || !map->dso)
-		return 0;
-	srcfile = get_srcline_split(map->dso,
-				    map__rip_2objdump(map, addr),
-				    &line);
-	if (!srcfile)
-		return 0;
-
-	/* Avoid redundant printing */
-	if (state &&
-	    state->srcfile &&
-	    !strcmp(state->srcfile, srcfile) &&
-	    state->line == line) {
-		free(srcfile);
-		return 0;
-	}
-
-	srccode = find_sourceline(srcfile, line, &len);
-	if (!srccode)
-		goto out_free_line;
-
-	ret = fprintf(fp, "|%-8d %.*s", line, len, srccode);
-
-	if (state) {
-		state->srcfile = srcfile;
-		state->line = line;
-	}
-	return ret;
-
-out_free_line:
-	free(srcfile);
-	return ret;
-}
-
-
 void srccode_state_free(struct srccode_state *state)
 {
 	zfree(&state->srcfile);
diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index 5e8899883231..1f110b53b5f3 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -138,11 +138,6 @@ char *map__srcline(struct map *map, u64 addr, struct symbol *sym);
 int map__fprintf_srcline(struct map *map, u64 addr, const char *prefix,
 			 FILE *fp);
 
-struct srccode_state;
-
-int map__fprintf_srccode(struct map *map, u64 addr,
-			 FILE *fp, struct srccode_state *state);
-
 int map__load(struct map *map);
 struct symbol *map__find_symbol(struct map *map, u64 addr);
 struct symbol *map__find_symbol_by_name(struct map *map, const char *name);
-- 
2.21.0
