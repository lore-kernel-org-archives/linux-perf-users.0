From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 13/18] perf tools: Robustify detection of clang binary
Date: Tue, 29 Aug 2017 16:42:49 -0300
Message-ID: <20170829194254.1338-14-acme@kernel.org>
References: <20170829194254.1338-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170829194254.1338-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, David Carrillo-Cisneros <davidcc@google.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Paul Turner <pjt@google.com>, Stephane Eranian <eranian@google.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: David Carrillo-Cisneros <davidcc@google.com>

Prior to this patch, make scripts tested for CLANG with ifeq ($(CC),
clang), failing to detect CLANG binaries with different names. Fix it by
testing for the existence of __clang__ macro in the list of compiler
defined macros.

Signed-off-by: David Carrillo-Cisneros <davidcc@google.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Paul Turner <pjt@google.com>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20170827075442.108534-5-davidcc@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/api/Makefile                 | 2 +-
 tools/lib/subcmd/Makefile              | 2 +-
 tools/perf/Makefile.config             | 4 ++--
 tools/perf/util/intel-pt-decoder/Build | 2 +-
 tools/scripts/Makefile.include         | 4 +++-
 5 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/tools/lib/api/Makefile b/tools/lib/api/Makefile
index 2538675731c7..4563ba7ede6f 100644
--- a/tools/lib/api/Makefile
+++ b/tools/lib/api/Makefile
@@ -19,7 +19,7 @@ LIBFILE = $(OUTPUT)libapi.a
 CFLAGS := $(EXTRA_WARNINGS) $(EXTRA_CFLAGS)
 CFLAGS += -ggdb3 -Wall -Wextra -std=gnu99 -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=2 -fPIC
 
-ifeq ($(CC), clang)
+ifeq ($(CC_NO_CLANG), 0)
   CFLAGS += -O3
 else
   CFLAGS += -O6
diff --git a/tools/lib/subcmd/Makefile b/tools/lib/subcmd/Makefile
index 3d1c3b5b5150..7e9f03c97e4c 100644
--- a/tools/lib/subcmd/Makefile
+++ b/tools/lib/subcmd/Makefile
@@ -21,7 +21,7 @@ LIBFILE = $(OUTPUT)libsubcmd.a
 CFLAGS := $(EXTRA_WARNINGS) $(EXTRA_CFLAGS)
 CFLAGS += -ggdb3 -Wall -Wextra -std=gnu99 -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=2 -fPIC
 
-ifeq ($(CC), clang)
+ifeq ($(CC_NO_CLANG), 0)
   CFLAGS += -O3
 else
   CFLAGS += -O6
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 6a64c6bbd9a5..63f534a0902f 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -148,7 +148,7 @@ ifndef DEBUG
 endif
 
 ifeq ($(DEBUG),0)
-ifeq ($(CC), clang)
+ifeq ($(CC_NO_CLANG), 0)
   CFLAGS += -O3
 else
   CFLAGS += -O6
@@ -184,7 +184,7 @@ ifdef PYTHON_CONFIG
   PYTHON_EMBED_LDFLAGS := $(call strip-libs,$(PYTHON_EMBED_LDOPTS))
   PYTHON_EMBED_LIBADD := $(call grep-libs,$(PYTHON_EMBED_LDOPTS)) -lutil
   PYTHON_EMBED_CCOPTS := $(shell $(PYTHON_CONFIG_SQ) --cflags 2>/dev/null)
-  ifeq ($(CC), clang)
+  ifeq ($(CC_NO_CLANG), 1)
     PYTHON_EMBED_CCOPTS := $(filter-out -specs=%,$(PYTHON_EMBED_CCOPTS))
   endif
   FLAGS_PYTHON_EMBED := $(PYTHON_EMBED_CCOPTS) $(PYTHON_EMBED_LDOPTS)
diff --git a/tools/perf/util/intel-pt-decoder/Build b/tools/perf/util/intel-pt-decoder/Build
index 7aca5d6d7e1f..10e0814bb8d2 100644
--- a/tools/perf/util/intel-pt-decoder/Build
+++ b/tools/perf/util/intel-pt-decoder/Build
@@ -25,6 +25,6 @@ $(OUTPUT)util/intel-pt-decoder/intel-pt-insn-decoder.o: util/intel-pt-decoder/in
 
 CFLAGS_intel-pt-insn-decoder.o += -I$(OUTPUT)util/intel-pt-decoder
 
-ifneq ($(CC), clang)
+ifeq ($(CC_NO_CLANG), 1)
   CFLAGS_intel-pt-insn-decoder.o += -Wno-override-init
 endif
diff --git a/tools/scripts/Makefile.include b/tools/scripts/Makefile.include
index ccad8ce925e4..1e8b6116ba3c 100644
--- a/tools/scripts/Makefile.include
+++ b/tools/scripts/Makefile.include
@@ -39,7 +39,9 @@ EXTRA_WARNINGS += -Wundef
 EXTRA_WARNINGS += -Wwrite-strings
 EXTRA_WARNINGS += -Wformat
 
-ifneq ($(CC), clang)
+CC_NO_CLANG := $(shell $(CC) -dM -E -x c /dev/null | grep -Fq "__clang__"; echo $$?)
+
+ifeq ($(CC_NO_CLANG), 1)
 EXTRA_WARNINGS += -Wstrict-aliasing=3
 endif
 
-- 
2.13.5
