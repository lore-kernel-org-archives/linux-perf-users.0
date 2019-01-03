From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 03/29] perf build: Don't unconditionally link the libbfd feature test to -liberty and -lz
Date: Thu,  3 Jan 2019 09:45:43 -0300
Message-ID: <20190103124609.29672-4-acme@kernel.org>
References: <20190103124609.29672-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190103124609.29672-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Mathieu Poirier <mathieu.poirier@linaro.org>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Stanislav Fomichev <sdf@google.com>

Current libbfd feature test unconditionally links against -liberty and -lz.
While it's required on some systems (e.g. opensuse), it's completely
unnecessary on the others, where only -lbdf is sufficient (debian).
This patch streamlines (and renames) the following feature checks:

feature-libbfd           - only link against -lbfd (debian),
                           see commit 2cf9040714f3 ("perf tools: Fix bfd
			   dependency libraries detection")
feature-libbfd-liberty   - link against -lbfd and -liberty
feature-libbfd-liberty-z - link against -lbfd, -liberty and -lz (opensuse),
                           see commit 280e7c48c3b8 ("perf tools: fix BFD
			   detection on opensuse")

(feature-liberty{,-z} were renamed to feature-libbfd-liberty{,z}
for clarity)

The main motivation is to fix this feature test for bpftool which is
currently broken on debian (libbfd feature shows OFF, but we still
unconditionally link against -lbfd and it works).

Tested on debian with only -lbfd installed (without -liberty); I'd
appreciate if somebody on the other systems can test this new detection
method.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/4dfc634cfcfb236883971b5107cf3c28ec8a31be.1542328222.git.sdf@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/build/Makefile.feature |  4 ++--
 tools/build/feature/Makefile | 10 ++++----
 tools/perf/Makefile.config   | 44 +++++++++++++++++++-----------------
 3 files changed, 30 insertions(+), 28 deletions(-)

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index d47b8f73e2e7..5467c6bf9ceb 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -82,8 +82,8 @@ FEATURE_TESTS_EXTRA :=                  \
          cplus-demangle                 \
          hello                          \
          libbabeltrace                  \
-         liberty                        \
-         liberty-z                      \
+         libbfd-liberty                 \
+         libbfd-liberty-z               \
          libunwind-debug-frame          \
          libunwind-debug-frame-arm      \
          libunwind-debug-frame-aarch64  \
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 2dbcc0d00f52..7ceb4441b627 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -17,8 +17,8 @@ FILES=                                          \
          test-libbfd.bin                        \
          test-disassembler-four-args.bin        \
          test-reallocarray.bin			\
-         test-liberty.bin                       \
-         test-liberty-z.bin                     \
+         test-libbfd-liberty.bin                \
+         test-libbfd-liberty-z.bin              \
          test-cplus-demangle.bin                \
          test-libelf.bin                        \
          test-libelf-getphdrnum.bin             \
@@ -210,7 +210,7 @@ $(OUTPUT)test-libpython-version.bin:
 	$(BUILD)
 
 $(OUTPUT)test-libbfd.bin:
-	$(BUILD) -DPACKAGE='"perf"' -lbfd -lz -liberty -ldl
+	$(BUILD) -DPACKAGE='"perf"' -lbfd -ldl
 
 $(OUTPUT)test-disassembler-four-args.bin:
 	$(BUILD) -DPACKAGE='"perf"' -lbfd -lopcodes
@@ -218,10 +218,10 @@ $(OUTPUT)test-disassembler-four-args.bin:
 $(OUTPUT)test-reallocarray.bin:
 	$(BUILD)
 
-$(OUTPUT)test-liberty.bin:
+$(OUTPUT)test-libbfd-liberty.bin:
 	$(CC) $(CFLAGS) -Wall -Werror -o $@ test-libbfd.c -DPACKAGE='"perf"' $(LDFLAGS) -lbfd -ldl -liberty
 
-$(OUTPUT)test-liberty-z.bin:
+$(OUTPUT)test-libbfd-liberty-z.bin:
 	$(CC) $(CFLAGS) -Wall -Werror -o $@ test-libbfd.c -DPACKAGE='"perf"' $(LDFLAGS) -lbfd -ldl -liberty -lz
 
 $(OUTPUT)test-cplus-demangle.bin:
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 07c1857c3d7a..b441c88cafa1 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -702,18 +702,20 @@ endif
 
 ifeq ($(feature-libbfd), 1)
   EXTLIBS += -lbfd
+else
+  # we are on a system that requires -liberty and (maybe) -lz
+  # to link against -lbfd; test each case individually here
 
   # call all detections now so we get correct
   # status in VF output
-  $(call feature_check,liberty)
-  $(call feature_check,liberty-z)
-  $(call feature_check,cplus-demangle)
+  $(call feature_check,libbfd-liberty)
+  $(call feature_check,libbfd-liberty-z)
 
-  ifeq ($(feature-liberty), 1)
-    EXTLIBS += -liberty
+  ifeq ($(feature-libbfd-liberty), 1)
+    EXTLIBS += -lbfd -liberty
   else
-    ifeq ($(feature-liberty-z), 1)
-      EXTLIBS += -liberty -lz
+    ifeq ($(feature-libbfd-liberty-z), 1)
+      EXTLIBS += -lbfd -liberty -lz
     endif
   endif
 endif
@@ -723,24 +725,24 @@ ifdef NO_DEMANGLE
 else
   ifdef HAVE_CPLUS_DEMANGLE_SUPPORT
     EXTLIBS += -liberty
-    CFLAGS += -DHAVE_CPLUS_DEMANGLE_SUPPORT
   else
-    ifneq ($(feature-libbfd), 1)
-      ifneq ($(feature-liberty), 1)
-        ifneq ($(feature-liberty-z), 1)
-          # we dont have neither HAVE_CPLUS_DEMANGLE_SUPPORT
-          # or any of 'bfd iberty z' trinity
-          ifeq ($(feature-cplus-demangle), 1)
-            EXTLIBS += -liberty
-            CFLAGS += -DHAVE_CPLUS_DEMANGLE_SUPPORT
-          else
-            msg := $(warning No bfd.h/libbfd found, please install binutils-dev[el]/zlib-static/libiberty-dev to gain symbol demangling)
-            CFLAGS += -DNO_DEMANGLE
-          endif
-        endif
+    ifeq ($(filter -liberty,$(EXTLIBS)),)
+      $(call feature_check,cplus-demangle)
+
+      # we dont have neither HAVE_CPLUS_DEMANGLE_SUPPORT
+      # or any of 'bfd iberty z' trinity
+      ifeq ($(feature-cplus-demangle), 1)
+        EXTLIBS += -liberty
+      else
+        msg := $(warning No bfd.h/libbfd found, please install binutils-dev[el]/zlib-static/libiberty-dev to gain symbol demangling)
+        CFLAGS += -DNO_DEMANGLE
       endif
     endif
   endif
+
+  ifneq ($(filter -liberty,$(EXTLIBS)),)
+    CFLAGS += -DHAVE_CPLUS_DEMANGLE_SUPPORT
+  endif
 endif
 
 ifneq ($(filter -lbfd,$(EXTLIBS)),)
-- 
2.19.2
