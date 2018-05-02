From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 30/52] perf symbols: Unexport symbol_type__is_a()
Date: Wed,  2 May 2018 12:19:20 -0300
Message-ID: <20180502151942.20542-31-acme@kernel.org>
References: <20180502151942.20542-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180502151942.20542-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Now this is only used in the symbols.c file, where it will finally
disappear when we remove the MAP_{FUNCTION,VARIABLE} split.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-a9t4d4hfrycczq9vpsk5sr8q@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/symbol.c | 2 +-
 tools/perf/util/symbol.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 7aa32372f08c..8d9967357354 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -70,7 +70,7 @@ static enum dso_binary_type binary_type_symtab[] = {
 
 #define DSO_BINARY_TYPE__SYMTAB_CNT ARRAY_SIZE(binary_type_symtab)
 
-bool symbol_type__is_a(char symbol_type, enum map_type map_type)
+static bool symbol_type__is_a(char symbol_type, enum map_type map_type)
 {
 	symbol_type = toupper(symbol_type);
 
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index 0e95d9478783..924f465307b1 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -300,7 +300,6 @@ size_t __symbol__fprintf_symname(const struct symbol *sym,
 				 bool unknown_as_addr, FILE *fp);
 size_t symbol__fprintf_symname(const struct symbol *sym, FILE *fp);
 size_t symbol__fprintf(struct symbol *sym, FILE *fp);
-bool symbol_type__is_a(char symbol_type, enum map_type map_type);
 bool symbol__restricted_filename(const char *filename,
 				 const char *restricted_filename);
 int symbol__config_symfs(const struct option *opt __maybe_unused,
-- 
2.14.3
