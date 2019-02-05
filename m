From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 5/8] perf symbols: Add fallback definitions for GELF_ST_VISIBILITY()
Date: Tue,  5 Feb 2019 12:07:05 -0300
Message-ID: <20190205150708.9012-6-acme@kernel.org>
References: <20190205150708.9012-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190205150708.9012-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Michael Petlan <mpetlan@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Nick Clifton <nickc@redhat.com>, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Those aren't present in Alpine Linux 3.4 to edge, so provide fallback
defines to get the next patch building there keeping the build
bisectable.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Nick Clifton <nickc@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lkml.kernel.org/n/tip-03cg3gya2ju4ba2x6ibb9fuz@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/symbol-elf.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 66a84d5846c8..695a73940329 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -19,6 +19,20 @@
 #define EM_AARCH64	183  /* ARM 64 bit */
 #endif
 
+#ifndef ELF32_ST_VISIBILITY
+#define ELF32_ST_VISIBILITY(o)	((o) & 0x03)
+#endif
+
+/* For ELF64 the definitions are the same.  */
+#ifndef ELF64_ST_VISIBILITY
+#define ELF64_ST_VISIBILITY(o)	ELF32_ST_VISIBILITY (o)
+#endif
+
+/* How to extract information held in the st_other field.  */
+#ifndef GELF_ST_VISIBILITY
+#define GELF_ST_VISIBILITY(val)	ELF64_ST_VISIBILITY (val)
+#endif
+
 typedef Elf64_Nhdr GElf_Nhdr;
 
 #ifdef HAVE_CPLUS_DEMANGLE_SUPPORT
-- 
2.20.1
