From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 25/47] perf symbols: Move symsrc prototypes to a separate header
Date: Sun,  1 Sep 2019 09:23:04 -0300
Message-ID: <20190901122326.5793-26-acme@kernel.org>
References: <20190901122326.5793-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190901122326.5793-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

So that we can remove dso.h from symbol.h and reduce the header
dependency tree.

Fixup cases where struct dso guts are needed but were obtained via
symbol.h, indirectly.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-ip683cegt306ncu3gsz7ii21@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/powerpc/util/sym-handling.c |  1 +
 tools/perf/builtin-probe.c                  |  1 +
 tools/perf/ui/browsers/map.c                |  1 +
 tools/perf/ui/gtk/annotate.c                |  1 +
 tools/perf/util/symbol-elf.c                |  1 +
 tools/perf/util/symbol-minimal.c            |  2 +
 tools/perf/util/symbol.c                    |  1 +
 tools/perf/util/symbol.h                    | 36 ++--------------
 tools/perf/util/symbol_fprintf.c            |  1 +
 tools/perf/util/symsrc.h                    | 46 +++++++++++++++++++++
 10 files changed, 58 insertions(+), 33 deletions(-)
 create mode 100644 tools/perf/util/symsrc.h

diff --git a/tools/perf/arch/powerpc/util/sym-handling.c b/tools/perf/arch/powerpc/util/sym-handling.c
index b0a67eaf2ce8..8a4b717e0a53 100644
--- a/tools/perf/arch/powerpc/util/sym-handling.c
+++ b/tools/perf/arch/powerpc/util/sym-handling.c
@@ -5,6 +5,7 @@
  */
 
 #include "debug.h"
+#include "dso.h"
 #include "symbol.h"
 #include "map.h"
 #include "probe-event.h"
diff --git a/tools/perf/builtin-probe.c b/tools/perf/builtin-probe.c
index 8950c05ef8fd..6dce1724a378 100644
--- a/tools/perf/builtin-probe.c
+++ b/tools/perf/builtin-probe.c
@@ -18,6 +18,7 @@
 
 #include "builtin.h"
 #include "namespaces.h"
+#include "util/build-id.h"
 #include "util/strlist.h"
 #include "util/strfilter.h"
 #include "util/symbol.h"
diff --git a/tools/perf/ui/browsers/map.c b/tools/perf/ui/browsers/map.c
index 4c545b92e20d..893b065971f6 100644
--- a/tools/perf/ui/browsers/map.c
+++ b/tools/perf/ui/browsers/map.c
@@ -8,6 +8,7 @@
 #include "../../util/util.h"
 #include "../../util/debug.h"
 #include "../../util/map.h"
+#include "../../util/dso.h"
 #include "../../util/symbol.h"
 #include "../browser.h"
 #include "../helpline.h"
diff --git a/tools/perf/ui/gtk/annotate.c b/tools/perf/ui/gtk/annotate.c
index d7f984436dec..8e744af24f7c 100644
--- a/tools/perf/ui/gtk/annotate.c
+++ b/tools/perf/ui/gtk/annotate.c
@@ -5,6 +5,7 @@
 #include "util/annotate.h"
 #include "util/evsel.h"
 #include "util/map.h"
+#include "util/dso.h"
 #include "util/symbol.h"
 #include "ui/helpline.h"
 #include <inttypes.h>
diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 6d22437e88ae..9428639872a6 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -10,6 +10,7 @@
 #include "map.h"
 #include "map_groups.h"
 #include "symbol.h"
+#include "symsrc.h"
 #include "demangle-java.h"
 #include "demangle-rust.h"
 #include "machine.h"
diff --git a/tools/perf/util/symbol-minimal.c b/tools/perf/util/symbol-minimal.c
index 3bc8b7e3300e..7e2813ec9498 100644
--- a/tools/perf/util/symbol-minimal.c
+++ b/tools/perf/util/symbol-minimal.c
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
+#include "dso.h"
 #include "symbol.h"
+#include "symsrc.h"
 #include "util.h"
 
 #include <errno.h>
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index b11a69681662..e5ffe61ad66b 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -25,6 +25,7 @@
 #include "machine.h"
 #include "map.h"
 #include "symbol.h"
+#include "symsrc.h"
 #include "strlist.h"
 #include "intlist.h"
 #include "namespaces.h"
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index 22660c7614a5..5a58407c2945 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -20,8 +20,7 @@
 #endif
 #include <elf.h>
 
-#include "dso.h"
-
+struct dso;
 struct map;
 struct map_groups;
 struct option;
@@ -148,37 +147,6 @@ struct addr_location {
 	s32	      socket;
 };
 
-struct symsrc {
-	char *name;
-	int fd;
-	enum dso_binary_type type;
-
-#ifdef HAVE_LIBELF_SUPPORT
-	Elf *elf;
-	GElf_Ehdr ehdr;
-
-	Elf_Scn *opdsec;
-	size_t opdidx;
-	GElf_Shdr opdshdr;
-
-	Elf_Scn *symtab;
-	GElf_Shdr symshdr;
-
-	Elf_Scn *dynsym;
-	size_t dynsym_idx;
-	GElf_Shdr dynshdr;
-
-	bool adjust_symbols;
-	bool is_64_bit;
-#endif
-};
-
-void symsrc__destroy(struct symsrc *ss);
-int symsrc__init(struct symsrc *ss, struct dso *dso, const char *name,
-		 enum dso_binary_type type);
-bool symsrc__has_symtab(struct symsrc *ss);
-bool symsrc__possibly_runtime(struct symsrc *ss);
-
 int dso__load(struct dso *dso, struct map *map);
 int dso__load_vmlinux(struct dso *dso, struct map *map,
 		      const char *vmlinux, bool vmlinux_allocated);
@@ -232,6 +200,8 @@ bool symbol__restricted_filename(const char *filename,
 int symbol__config_symfs(const struct option *opt __maybe_unused,
 			 const char *dir, int unset __maybe_unused);
 
+struct symsrc;
+
 int dso__load_sym(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 		  struct symsrc *runtime_ss, int kmodule);
 int dso__synthesize_plt_symbols(struct dso *dso, struct symsrc *ss);
diff --git a/tools/perf/util/symbol_fprintf.c b/tools/perf/util/symbol_fprintf.c
index 02e89b02c2ce..35c936ce33ef 100644
--- a/tools/perf/util/symbol_fprintf.c
+++ b/tools/perf/util/symbol_fprintf.c
@@ -3,6 +3,7 @@
 #include <inttypes.h>
 #include <stdio.h>
 
+#include "dso.h"
 #include "map.h"
 #include "symbol.h"
 
diff --git a/tools/perf/util/symsrc.h b/tools/perf/util/symsrc.h
new file mode 100644
index 000000000000..2665b4bde751
--- /dev/null
+++ b/tools/perf/util/symsrc.h
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __PERF_SYMSRC_
+#define __PERF_SYMSRC_ 1
+
+#include <stdbool.h>
+#include <stddef.h>
+#include "dso.h"
+
+#ifdef HAVE_LIBELF_SUPPORT
+#include <libelf.h>
+#include <gelf.h>
+#endif
+#include <elf.h>
+
+struct symsrc {
+	char		     *name;
+	int		     fd;
+	enum dso_binary_type type;
+
+#ifdef HAVE_LIBELF_SUPPORT
+	Elf		     *elf;
+	GElf_Ehdr	     ehdr;
+
+	Elf_Scn		     *opdsec;
+	size_t		     opdidx;
+	GElf_Shdr	     opdshdr;
+
+	Elf_Scn		     *symtab;
+	GElf_Shdr	     symshdr;
+
+	Elf_Scn		     *dynsym;
+	size_t		     dynsym_idx;
+	GElf_Shdr	     dynshdr;
+
+	bool		     adjust_symbols;
+	bool		     is_64_bit;
+#endif
+};
+
+int symsrc__init(struct symsrc *ss, struct dso *dso, const char *name, enum dso_binary_type type);
+void symsrc__destroy(struct symsrc *ss);
+
+bool symsrc__has_symtab(struct symsrc *ss);
+bool symsrc__possibly_runtime(struct symsrc *ss);
+
+#endif /* __PERF_SYMSRC_ */
-- 
2.21.0
