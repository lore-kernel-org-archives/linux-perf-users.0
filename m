From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 23/47] perf symbol: Move C++ demangle defines to the only file using it
Date: Sun,  1 Sep 2019 09:23:02 -0300
Message-ID: <20190901122326.5793-24-acme@kernel.org>
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

No need to have it generally available in such a critical header as
symbol.h.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-es1ufxv7bihiumytn5dm3drn@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/symbol-elf.c | 6 ++++++
 tools/perf/util/symbol.h     | 6 ------
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 7d504dc22108..6d22437e88ae 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -40,6 +40,12 @@
 
 typedef Elf64_Nhdr GElf_Nhdr;
 
+#ifndef DMGL_PARAMS
+#define DMGL_NO_OPTS     0              /* For readability... */
+#define DMGL_PARAMS      (1 << 0)       /* Include function args */
+#define DMGL_ANSI        (1 << 1)       /* Include const, volatile, etc */
+#endif
+
 #ifdef HAVE_CPLUS_DEMANGLE_SUPPORT
 extern char *cplus_demangle(const char *, int);
 
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index 159c59652a5c..bcc0d84a42b8 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -40,12 +40,6 @@ Elf_Scn *elf_section_by_name(Elf *elf, GElf_Ehdr *ep,
 			     GElf_Shdr *shp, const char *name, size_t *idx);
 #endif
 
-#ifndef DMGL_PARAMS
-#define DMGL_NO_OPTS     0              /* For readability... */
-#define DMGL_PARAMS      (1 << 0)       /* Include function args */
-#define DMGL_ANSI        (1 << 1)       /* Include const, volatile, etc */
-#endif
-
 /** struct symbol - symtab entry
  *
  * @ignore - resolvable but tools ignore it (e.g. idle routines)
-- 
2.21.0
