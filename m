From: Milian Wolff <milian.wolff@kdab.com>
Subject: [PATCH 2/7] perf util: take elf_name as const string in dso__demangle_sym
Date: Thu, 18 May 2017 21:34:06 +0200
Message-ID: <20170518193411.22380-3-milian.wolff@kdab.com>
References: <20170518193411.22380-1-milian.wolff@kdab.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170518193411.22380-1-milian.wolff@kdab.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux-kernel@vger.kernel.org
Cc: linux-perf-users@vger.kernel.org, Milian Wolff <milian.wolff@kdab.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Yao Jin <yao.jin@linux.intel.com>
List-Id: linux-perf-users.vger.kernel.org

The input string is not modified and thus can be passed
in as a pointer to const data.

Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Yao Jin <yao.jin@linux.intel.com>
Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
---
 tools/perf/util/symbol-elf.c     | 2 +-
 tools/perf/util/symbol-minimal.c | 2 +-
 tools/perf/util/symbol.h         | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index e7ee47f7377a..a3c4d0204439 100644
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
2.13.0
