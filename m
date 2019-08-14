From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 12/28] tools build: Add capability-related feature detection
Date: Wed, 14 Aug 2019 15:40:35 -0300
Message-ID: <20190814184051.3125-13-acme@kernel.org>
References: <20190814184051.3125-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190814184051.3125-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Igor Lubashev <ilubashe@akamai.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Alexey Budankov <alexey.budankov@linux.intel.com>, James Morris <jmorris@namei.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Suzuki Poulouse <suzuki.poulose@arm.com>
List-Id: linux-perf-users.vger.kernel.org

From: Igor Lubashev <ilubashe@akamai.com>

Add utilities to help checking capabilities of the running procss.  Make
perf link with libcap, if it is available. If no libcap-dev[el], assume
no capabilities.

Committer testing:

  $ make O=/tmp/build/perf -C tools/perf install-bin
  make: Entering directory '/home/acme/git/perf/tools/perf'
    BUILD:   Doing 'make -j8' parallel build

  Auto-detecting system features:
  <SNIP>
  ...                        libbfd: [ on  ]
  ...                        libcap: [ OFF ]
  ...                        libelf: [ on  ]
  <SNIP>
  Makefile.config:833: No libcap found, disables capability support, please install libcap-devel/libcap-dev
  <SNIP>
  $ grep libcap /tmp/build/perf/FEATURE-DUMP
  feature-libcap=0
  $ cat /tmp/build/perf/feature/test-libcap.make.output
  test-libcap.c:2:10: fatal error: sys/capability.h: No such file or directory
      2 | #include <sys/capability.h>
        |          ^~~~~~~~~~~~~~~~~~
  compilation terminated.
  $

Now install libcap-devel and try again:

  $ make O=/tmp/build/perf -C tools/perf install-bin
  make: Entering directory '/home/acme/git/perf/tools/perf'
    BUILD:   Doing 'make -j8' parallel build
  Warning: Kernel ABI header at 'tools/include/linux/bits.h' differs from latest version at 'include/linux/bits.h'
  diff -u tools/include/linux/bits.h include/linux/bits.h
  Warning: Kernel ABI header at 'tools/arch/x86/include/asm/cpufeatures.h' differs from latest version at 'arch/x86/include/asm/cpufeatures.h'
  diff -u tools/arch/x86/include/asm/cpufeatures.h arch/x86/include/asm/cpufeatures.h

  Auto-detecting system features:
  <SNIP>
  ...                        libbfd: [ on  ]
  ...                        libcap: [ on  ]
  ...                        libelf: [ on  ]
  <SNIP>>
    CC       /tmp/build/perf/jvmti/libjvmti.o
  <SNIP>>
  $ grep libcap /tmp/build/perf/FEATURE-DUMP
  feature-libcap=1
  $ cat /tmp/build/perf/feature/test-libcap.make.output
  $ ldd /tmp/build/perf/feature/test-libcap.make.bin
  ldd: /tmp/build/perf/feature/test-libcap.make.bin: No such file or directory
  $ ldd /tmp/build/perf/feature/test-libcap.bin
  	linux-vdso.so.1 (0x00007ffc35bfe000)
  	libcap.so.2 => /lib64/libcap.so.2 (0x00007ff9c62ff000)
  	libc.so.6 => /lib64/libc.so.6 (0x00007ff9c6139000)
  	/lib64/ld-linux-x86-64.so.2 (0x00007ff9c6326000)
  $

Signed-off-by: Igor Lubashev <ilubashe@akamai.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: James Morris <jmorris@namei.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Suzuki Poulouse <suzuki.poulose@arm.com>
[ split from a larger patch ]
Link: http://lkml.kernel.org/r/8a1e76cf5c7c9796d0d4d240fbaa85305298aafa.1565188228.git.ilubashe@akamai.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/build/Makefile.feature      |  2 ++
 tools/build/feature/Makefile      |  4 ++++
 tools/build/feature/test-libcap.c | 20 ++++++++++++++++++++
 tools/perf/Makefile.config        | 11 +++++++++++
 tools/perf/Makefile.perf          |  2 ++
 5 files changed, 39 insertions(+)
 create mode 100644 tools/build/feature/test-libcap.c

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index 86b793dffbc4..8a19753cc26a 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -42,6 +42,7 @@ FEATURE_TESTS_BASIC :=                  \
         gtk2-infobar                    \
         libaudit                        \
         libbfd                          \
+        libcap                          \
         libelf                          \
         libelf-getphdrnum               \
         libelf-gelf_getnote             \
@@ -110,6 +111,7 @@ FEATURE_DISPLAY ?=              \
          gtk2                   \
          libaudit               \
          libbfd                 \
+         libcap                 \
          libelf                 \
          libnuma                \
          numa_num_possible_cpus \
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 0658b8cd0e53..8499385365c0 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -20,6 +20,7 @@ FILES=                                          \
          test-libbfd-liberty.bin                \
          test-libbfd-liberty-z.bin              \
          test-cplus-demangle.bin                \
+         test-libcap.bin			\
          test-libelf.bin                        \
          test-libelf-getphdrnum.bin             \
          test-libelf-gelf_getnote.bin           \
@@ -105,6 +106,9 @@ $(OUTPUT)test-fortify-source.bin:
 $(OUTPUT)test-bionic.bin:
 	$(BUILD)
 
+$(OUTPUT)test-libcap.bin:
+	$(BUILD) -lcap
+
 $(OUTPUT)test-libelf.bin:
 	$(BUILD) -lelf
 
diff --git a/tools/build/feature/test-libcap.c b/tools/build/feature/test-libcap.c
new file mode 100644
index 000000000000..d2a2e152195f
--- /dev/null
+++ b/tools/build/feature/test-libcap.c
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <sys/capability.h>
+#include <linux/capability.h>
+
+int main(void)
+{
+	cap_flag_value_t val;
+	cap_t caps = cap_get_proc();
+
+	if (!caps)
+		return 1;
+
+	if (cap_get_flag(caps, CAP_SYS_ADMIN, CAP_EFFECTIVE, &val) != 0)
+		return 1;
+
+	if (cap_free(caps) != 0)
+		return 1;
+
+	return 0;
+}
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index e4988f49ea79..9a06787fedc6 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -824,6 +824,17 @@ ifndef NO_LIBZSTD
   endif
 endif
 
+ifndef NO_LIBCAP
+  ifeq ($(feature-libcap), 1)
+    CFLAGS += -DHAVE_LIBCAP_SUPPORT
+    EXTLIBS += -lcap
+    $(call detected,CONFIG_LIBCAP)
+  else
+    msg := $(warning No libcap found, disables capability support, please install libcap-devel/libcap-dev);
+    NO_LIBCAP := 1
+  endif
+endif
+
 ifndef NO_BACKTRACE
   ifeq ($(feature-backtrace), 1)
     CFLAGS += -DHAVE_BACKTRACE_SUPPORT
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 67512a12276b..f9807d8c005b 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -88,6 +88,8 @@ include ../scripts/utilities.mak
 #
 # Define NO_LIBBPF if you do not want BPF support
 #
+# Define NO_LIBCAP if you do not want process capabilities considered by perf
+#
 # Define NO_SDT if you do not want to define SDT event in perf tools,
 # note that it doesn't disable SDT scanning support.
 #
-- 
2.21.0
