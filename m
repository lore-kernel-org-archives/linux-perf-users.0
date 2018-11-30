From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 17/22] tools build feature: Check if libaio is available
Date: Fri, 30 Nov 2018 15:26:47 -0300
Message-ID: <20181130182652.23620-18-acme@kernel.org>
References: <20181130182652.23620-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181130182652.23620-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Alexey Budankov <alexey.budankov@linux.intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Alexey Budankov <alexey.budankov@linux.intel.com>

This will be used by 'perf record' to speed up reading the perf ring
buffer.

Committer testing:

  $ make -C tools/perf O=/tmp/build/perf
  make: Entering directory '/home/acme/git/perf/tools/perf'
    BUILD:   Doing 'make -j8' parallel build

  Auto-detecting system features:
  ...                         dwarf: [ on  ]
  ...            dwarf_getlocations: [ on  ]
  ...                         glibc: [ on  ]
  ...                          gtk2: [ OFF ]
  ...                      libaudit: [ OFF ]
  ...                        libbfd: [ OFF ]
  ...                        libelf: [ on  ]
  ...                       libnuma: [ OFF ]
  ...        numa_num_possible_cpus: [ OFF ]
  ...                       libperl: [ OFF ]
  ...                     libpython: [ OFF ]
  ...                      libslang: [ on  ]
  ...                     libcrypto: [ on  ]
  ...                     libunwind: [ on  ]
  ...            libdw-dwarf-unwind: [ on  ]
  ...                          zlib: [ on  ]
  ...                          lzma: [ on  ]
  ...                     get_cpuid: [ on  ]
  ...                           bpf: [ on  ]
  ...                        libaio: [ on  ]

  $ ls -la /tmp/build/perf/feature/test-libaio.*
  -rwxrwxr-x. 1 acme acme 18296 Nov 26 08:49 /tmp/build/perf/feature/test-libaio.bin
  -rw-rw-r--. 1 acme acme  1165 Nov 26 08:49 /tmp/build/perf/feature/test-libaio.d
  -rw-rw-r--. 1 acme acme     0 Nov 26 08:49 /tmp/build/perf/feature/test-libaio.make.output
  $
  $ grep -i aio /tmp/build/perf/FEATURE-DUMP
  feature-libaio=1
  $

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Reviewed-by: Jiri Olsa <jolsa@redhat.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/5fcda10c-6c63-68df-383a-c6d9e5d1f918@linux.intel.com
[ split from a larger patch ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/build/Makefile.feature      |  6 ++++--
 tools/build/feature/Makefile      |  6 +++++-
 tools/build/feature/test-all.c    |  5 +++++
 tools/build/feature/test-libaio.c | 16 ++++++++++++++++
 tools/perf/Makefile.config        |  6 ++++++
 tools/perf/Makefile.perf          |  7 ++++++-
 6 files changed, 42 insertions(+), 4 deletions(-)
 create mode 100644 tools/build/feature/test-libaio.c

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index 8a123834a2a3..d47b8f73e2e7 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -70,7 +70,8 @@ FEATURE_TESTS_BASIC :=                  \
         sched_getcpu			\
         sdt				\
         setns				\
-        libopencsd
+        libopencsd			\
+        libaio
 
 # FEATURE_TESTS_BASIC + FEATURE_TESTS_EXTRA is the complete list
 # of all feature tests
@@ -116,7 +117,8 @@ FEATURE_DISPLAY ?=              \
          zlib                   \
          lzma                   \
          get_cpuid              \
-         bpf
+         bpf			\
+         libaio
 
 # Set FEATURE_CHECK_(C|LD)FLAGS-all for all FEATURE_TESTS features.
 # If in the future we need per-feature checks/flags for features not
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 38c22e122cb0..2dbcc0d00f52 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -61,7 +61,8 @@ FILES=                                          \
          test-libopencsd.bin			\
          test-clang.bin				\
          test-llvm.bin				\
-         test-llvm-version.bin
+         test-llvm-version.bin			\
+         test-libaio.bin
 
 FILES := $(addprefix $(OUTPUT),$(FILES))
 
@@ -297,6 +298,9 @@ $(OUTPUT)test-clang.bin:
 
 -include $(OUTPUT)*.d
 
+$(OUTPUT)test-libaio.bin:
+	$(BUILD) -lrt
+
 ###############################
 
 clean:
diff --git a/tools/build/feature/test-all.c b/tools/build/feature/test-all.c
index 58f01b950195..20cdaa4fc112 100644
--- a/tools/build/feature/test-all.c
+++ b/tools/build/feature/test-all.c
@@ -174,6 +174,10 @@
 # include "test-libopencsd.c"
 #undef main
 
+#define main main_test_libaio
+# include "test-libaio.c"
+#undef main
+
 int main(int argc, char *argv[])
 {
 	main_test_libpython();
@@ -214,6 +218,7 @@ int main(int argc, char *argv[])
 	main_test_sdt();
 	main_test_setns();
 	main_test_libopencsd();
+	main_test_libaio();
 
 	return 0;
 }
diff --git a/tools/build/feature/test-libaio.c b/tools/build/feature/test-libaio.c
new file mode 100644
index 000000000000..932133c9a265
--- /dev/null
+++ b/tools/build/feature/test-libaio.c
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <aio.h>
+
+int main(void)
+{
+	struct aiocb aiocb;
+
+	aiocb.aio_fildes  = 0;
+	aiocb.aio_offset  = 0;
+	aiocb.aio_buf     = 0;
+	aiocb.aio_nbytes  = 0;
+	aiocb.aio_reqprio = 0;
+	aiocb.aio_sigevent.sigev_notify = 1 /*SIGEV_NONE*/;
+
+	return (int)aio_return(&aiocb);
+}
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index c643d5e0c26b..b66f97a04b12 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -365,6 +365,12 @@ ifeq ($(feature-glibc), 1)
   CFLAGS += -DHAVE_GLIBC_SUPPORT
 endif
 
+ifeq ($(feature-libaio), 1)
+  ifndef NO_AIO
+    CFLAGS += -DHAVE_AIO_SUPPORT
+  endif
+endif
+
 ifdef NO_DWARF
   NO_LIBDW_DWARF_UNWIND := 1
 endif
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 239e7b3270f4..67e9adbe6ee8 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -101,8 +101,13 @@ include ../scripts/utilities.mak
 # Define LIBCLANGLLVM if you DO want builtin clang and llvm support.
 # When selected, pass LLVM_CONFIG=/path/to/llvm-config to `make' if
 # llvm-config is not in $PATH.
-
+#
 # Define NO_CORESIGHT if you do not want support for CoreSight trace decoding.
+#
+# Define NO_AIO if you do not want support of Posix AIO based trace
+# streaming for record mode. Currently Posix AIO trace streaming is
+# supported only when linking with glibc.
+#
 
 # As per kernel Makefile, avoid funny character set dependencies
 unexport LC_ALL
-- 
2.19.1
