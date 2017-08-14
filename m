From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 15/19] perf util: Take elf_name as const string in dso__demangle_sym
Date: Mon, 14 Aug 2017 13:27:37 -0300
Message-ID: <20170814162741.6101-16-acme@kernel.org>
References: <20170814162741.6101-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170814162741.6101-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Milian Wolff <milian.wolff@kdab.com>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Yao Jin <yao.jin@linux.intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Milian Wolff <milian.wolff@kdab.com>

The input string is not modified and thus can be passed in as a pointer
to const data.

Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Yao Jin <yao.jin@linux.intel.com>
Link: http://lkml.kernel.org/r/20170806212446.24925-3-milian.wolff@kdab.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/symbol-elf.c     | 2 +-
 tools/perf/util/symbol-minimal.c | 2 +-
 tools/perf/util/symbol.h         | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 502505cf236a..7cf18f14e152 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -391,7 +391,7 @@ int dso__synthesize_plt_symbols(struct dso *dso, struct symsrc *ss, struct map *
 	return 0;
 }
 
-char *dso__demangle_sym(struct dso *dso, int kmodule, char *elf_name)
+char *dso__demangle_sym(struct dso *dso, int kmodule, const char *elf_name)
 {
 	return demangle_sym(dso, kmodule, elf_name);
 }
diff --git a/tools/perf/util/symbol-minimal.c b/tools/perf/util/symbol-minimal.c
index 40bf5d4c0bfd..1a5aa35b0100 100644
--- a/tools/perf/util/symbol-minimal.c
+++ b/tools/perf/util/symbol-minimal.c
@@ -377,7 +377,7 @@ void symbol__elf_init(void)
 
 char *dso__demangle_sym(struct dso *dso __maybe_unused,
 			int kmodule __maybe_unused,
-			char *elf_name __maybe_unused)
+			const char *elf_name __maybe_unused)
 {
 	return NULL;
 }
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index 41ebba9a2eb2..f0b08810d7fa 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -306,7 +306,7 @@ int dso__load_sym(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 int dso__synthesize_plt_symbols(struct dso *dso, struct symsrc *ss,
 				struct map *map);
 
-char *dso__demangle_sym(struct dso *dso, int kmodule, char *elf_name);
+char *dso__demangle_sym(struct dso *dso, int kmodule, const char *elf_name);
 
 void __symbols__insert(struct rb_root *symbols, struct symbol *sym, bool kernel);
 void symbols__insert(struct rb_root *symbols, struct symbol *sym);
-- 
2.13.4
