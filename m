From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 25/40] perf tools: Add EXCLUDE_EXTLIBS and EXTRA_PERFLIBS to makefile
Date: Wed, 26 Jul 2017 11:17:15 -0300
Message-ID: <20170726141730.30750-26-acme@kernel.org>
References: <20170726141730.30750-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170726141730.30750-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, David Carrillo-Cisneros <davidcc@google.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, Kees Kook <keescook@chromium.org>, Paul Turner <pjt@google.com>, Stephane Eranian <eranian@google.com>, Sudeep Holla <sudeep.holla@arm.com>, Wang Nan <wangnan0@huawei.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: David Carrillo-Cisneros <davidcc@google.com>

The goal is to allow users to override linking of libraries that
were automatically added to PERFLIBS.

EXCLUDE_EXTLIBS contains linker flags to be removed from LIBS
while EXTRA_PERFLIBS contains linker flags to be added.

My use case is to force certain library to be build statically,
e.g. for libelf:

  EXCLUDE_EXTLIBS=-lelf EXTRA_PERFLIBS=path/libelf.a

Signed-off-by: David Carrillo-Cisneros <davidcc@google.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Elena Reshetova <elena.reshetova@intel.com>
Cc: Kees Kook <keescook@chromium.org>
Cc: Paul Turner <pjt@google.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/r/20170719011839.99399-3-davidcc@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.perf | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 5008f51a08a2..100a6c1670c8 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -33,6 +33,11 @@ include ../scripts/utilities.mak
 #
 # Define EXTRA_CFLAGS=-m64 or EXTRA_CFLAGS=-m32 as appropriate for cross-builds.
 #
+# Define EXCLUDE_EXTLIBS=-lmylib to exclude libmylib from the auto-generated
+# EXTLIBS.
+#
+# Define EXTRA_PERFLIBS to pass extra libraries to PERFLIBS.
+#
 # Define NO_DWARF if you do not want debug-info analysis feature at all.
 #
 # Define WERROR=0 to disable treating any warnings as errors.
@@ -352,7 +357,8 @@ ifdef ASCIIDOC8
   export ASCIIDOC8
 endif
 
-LIBS = -Wl,--whole-archive $(PERFLIBS) -Wl,--no-whole-archive -Wl,--start-group $(EXTLIBS) -Wl,--end-group
+EXTLIBS := $(call filter-out,$(EXCLUDE_EXTLIBS),$(EXTLIBS))
+LIBS = -Wl,--whole-archive $(PERFLIBS) $(EXTRA_PERFLIBS) -Wl,--no-whole-archive -Wl,--start-group $(EXTLIBS) -Wl,--end-group
 
 ifeq ($(USE_CLANG), 1)
   CLANGLIBS_LIST = AST Basic CodeGen Driver Frontend Lex Tooling Edit Sema Analysis Parse Serialization
-- 
2.9.4
