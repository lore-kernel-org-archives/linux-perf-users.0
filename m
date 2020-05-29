From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 1/2] perf build: Group the NO_SYSCALL_TABLE logic
Date: Fri, 29 May 2020 12:55:51 -0300
Message-ID: <20200529155552.463-2-acme@kernel.org>
References: <20200529155552.463-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200529155552.463-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To help in allowing to disable it from the make command line.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.config | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index ae325f79e598..93fb7510a9a9 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -23,12 +23,26 @@ include $(srctree)/tools/scripts/Makefile.arch
 $(call detected_var,SRCARCH)
 
 NO_PERF_REGS := 1
+
 NO_SYSCALL_TABLE := 1
 
+ifeq ($(SRCARCH),x86)
+  ifeq (${IS_64_BIT}, 1)
+    NO_SYSCALL_TABLE := 0
+  endif
+else
+  ifneq ($(SRCARCH),$(filter $(SRCARCH),powerpc arm64 s390))
+    NO_SYSCALL_TABLE := 0
+  endif
+endif
+
+ifneq ($(NO_SYSCALL_TABLE),1)
+  CFLAGS += -DHAVE_SYSCALL_TABLE_SUPPORT
+endif
+
 # Additional ARCH settings for ppc
 ifeq ($(SRCARCH),powerpc)
   NO_PERF_REGS := 0
-  NO_SYSCALL_TABLE := 0
   CFLAGS += -I$(OUTPUT)arch/powerpc/include/generated
   LIBUNWIND_LIBS := -lunwind -lunwind-ppc64
 endif
@@ -37,7 +51,6 @@ endif
 ifeq ($(SRCARCH),x86)
   $(call detected,CONFIG_X86)
   ifeq (${IS_64_BIT}, 1)
-    NO_SYSCALL_TABLE := 0
     CFLAGS += -DHAVE_ARCH_X86_64_SUPPORT -I$(OUTPUT)arch/x86/include/generated
     ARCH_INCLUDE = ../../arch/x86/lib/memcpy_64.S ../../arch/x86/lib/memset_64.S
     LIBUNWIND_LIBS = -lunwind-x86_64 -lunwind -llzma
@@ -55,7 +68,6 @@ endif
 
 ifeq ($(SRCARCH),arm64)
   NO_PERF_REGS := 0
-  NO_SYSCALL_TABLE := 0
   CFLAGS += -I$(OUTPUT)arch/arm64/include/generated
   LIBUNWIND_LIBS = -lunwind -lunwind-aarch64
 endif
@@ -70,7 +82,6 @@ endif
 
 ifeq ($(ARCH),s390)
   NO_PERF_REGS := 0
-  NO_SYSCALL_TABLE := 0
   CFLAGS += -fPIC -I$(OUTPUT)arch/s390/include/generated
 endif
 
@@ -78,10 +89,6 @@ ifeq ($(NO_PERF_REGS),0)
   $(call detected,CONFIG_PERF_REGS)
 endif
 
-ifneq ($(NO_SYSCALL_TABLE),1)
-  CFLAGS += -DHAVE_SYSCALL_TABLE_SUPPORT
-endif
-
 # So far there's only x86 and arm libdw unwind support merged in perf.
 # Disable it on all other architectures in case libdw unwind
 # support is detected in system. Add supported architectures
-- 
2.25.3
