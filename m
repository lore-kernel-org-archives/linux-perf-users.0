From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 15/22] perf tools: Allow to link with libbpf dynamicaly
Date: Thu, 28 Nov 2019 10:40:20 -0300
Message-ID: <20191128134027.23726-16-acme@kernel.org>
References: <20191128134027.23726-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20191128134027.23726-1-acme@kernel.org>
Sender: netdev-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, Andrii Nakryiko <andriin@fb.com>, Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <brouer@redhat.com>, Martin KaFai Lau <kafai@fb.com>, Michael Petlan <mpetlan@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Currently we support only static linking with kernel's libbpf
(tools/lib/bpf). This patch adds libbpf package detection and support to
link perf with it dynamically.

The libbpf package status is displayed with:

  $ make VF=1
  Auto-detecting system features:
  ...
  ...                        libbpf: [ on  ]

It's not checked by default, because it's quite new.  Once it's on most
distros we can switch it on.

For the same reason it's not added to the test-all check.

Perf does not need advanced version of libbpf, so we can check just for
the base bpf_object__open function.

Adding new compile variable to detect libbpf package and link bpf
dynamically:

  $ make LIBBPF_DYNAMIC=1
    ...
    LINK     perf
  $ ldd perf | grep bpf
    libbpf.so.0 => /lib64/libbpf.so.0 (0x00007f46818bc000)

If libbpf is not installed, build stops with:

  Makefile.config:486: *** Error: No libbpf devel library found,\
  please install libbpf-devel.  Stop.

Committer testing:

  $ make LIBBPF_DYNAMIC=1 -C tools/perf O=/tmp/build/perf
  make: Entering directory '/home/acme/git/perf/tools/perf'
    BUILD:   Doing 'make -j8' parallel build
  Makefile.config:493: *** Error: No libbpf devel library found, please install libbpf-devel.  Stop.
  make[1]: *** [Makefile.perf:225: sub-make] Error 2
  make: *** [Makefile:70: all] Error 2
  make: Leaving directory '/home/acme/git/perf/tools/perf'
  $

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Toke Høiland-Jørgensen <toke@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andriin@fb.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Jesper Dangaard Brouer <brouer@redhat.com>
Cc: Martin KaFai Lau <kafai@fb.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Song Liu <songliubraving@fb.com>
Cc: Yonghong Song <yhs@fb.com>
Cc: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org
Link: http://lore.kernel.org/lkml/20191126121253.28253-1-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/build/Makefile.feature      |  3 ++-
 tools/build/feature/Makefile      |  4 ++++
 tools/build/feature/test-libbpf.c |  7 +++++++
 tools/perf/Makefile.config        | 10 ++++++++++
 tools/perf/Makefile.perf          |  6 +++++-
 5 files changed, 28 insertions(+), 2 deletions(-)
 create mode 100644 tools/build/feature/test-libbpf.c

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index 8a19753cc26a..574c2e0b9d20 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -96,7 +96,8 @@ FEATURE_TESTS_EXTRA :=                  \
          cxx                            \
          llvm                           \
          llvm-version                   \
-         clang
+         clang                          \
+         libbpf
 
 FEATURE_TESTS ?= $(FEATURE_TESTS_BASIC)
 
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 8499385365c0..f30a89046aa3 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -53,6 +53,7 @@ FILES=                                          \
          test-zlib.bin                          \
          test-lzma.bin                          \
          test-bpf.bin                           \
+         test-libbpf.bin                        \
          test-get_cpuid.bin                     \
          test-sdt.bin                           \
          test-cxx.bin                           \
@@ -270,6 +271,9 @@ $(OUTPUT)test-get_cpuid.bin:
 $(OUTPUT)test-bpf.bin:
 	$(BUILD)
 
+$(OUTPUT)test-libbpf.bin:
+	$(BUILD) -lbpf
+
 $(OUTPUT)test-sdt.bin:
 	$(BUILD)
 
diff --git a/tools/build/feature/test-libbpf.c b/tools/build/feature/test-libbpf.c
new file mode 100644
index 000000000000..a508756cf4cc
--- /dev/null
+++ b/tools/build/feature/test-libbpf.c
@@ -0,0 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <bpf/libbpf.h>
+
+int main(void)
+{
+	return bpf_object__open("test") ? 0 : -1;
+}
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 1783427da9b0..c90f4146e5a2 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -483,6 +483,16 @@ ifndef NO_LIBELF
     ifeq ($(feature-bpf), 1)
       CFLAGS += -DHAVE_LIBBPF_SUPPORT
       $(call detected,CONFIG_LIBBPF)
+
+      # detecting libbpf without LIBBPF_DYNAMIC, so make VF=1 shows libbpf detection status
+      $(call feature_check,libbpf)
+      ifdef LIBBPF_DYNAMIC
+        ifeq ($(feature-libbpf), 1)
+          EXTLIBS += -lbpf
+        else
+          dummy := $(error Error: No libbpf devel library found, please install libbpf-devel);
+        endif
+      endif
     endif
 
     ifndef NO_DWARF
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 1cd294468a1f..eae5d5e95952 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -116,6 +116,8 @@ include ../scripts/utilities.mak
 #
 # Define TCMALLOC to enable tcmalloc heap profiling.
 #
+# Define LIBBPF_DYNAMIC to enable libbpf dynamic linking.
+#
 
 # As per kernel Makefile, avoid funny character set dependencies
 unexport LC_ALL
@@ -360,7 +362,9 @@ export PERL_PATH
 
 PERFLIBS = $(LIBAPI) $(LIBTRACEEVENT) $(LIBSUBCMD) $(LIBPERF)
 ifndef NO_LIBBPF
-  PERFLIBS += $(LIBBPF)
+  ifndef LIBBPF_DYNAMIC
+    PERFLIBS += $(LIBBPF)
+  endif
 endif
 
 # We choose to avoid "if .. else if .. else .. endif endif"
-- 
2.21.0
