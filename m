From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 33/86] tools build: Add test for setns()
Date: Wed, 19 Jul 2017 11:28:57 -0300
Message-ID: <20170719142950.3747-34-acme@kernel.org>
References: <20170719142950.3747-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170719142950.3747-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Krister Johansen <kjlx@templeofstupid.com>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

And provide an alternative implementation to keep perf building on older
distros as we're about to add initial support for namespaces.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Krister Johansen <kjlx@templeofstupid.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-bqdwijunhjlvps1ardykhw1i@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/build/Makefile.feature     | 3 ++-
 tools/build/feature/Makefile     | 6 +++++-
 tools/build/feature/test-all.c   | 5 +++++
 tools/build/feature/test-setns.c | 7 +++++++
 tools/perf/Makefile.config       | 5 +++++
 tools/perf/util/Build            | 4 ++++
 tools/perf/util/setns.c          | 8 ++++++++
 tools/perf/util/util.h           | 4 ++++
 8 files changed, 40 insertions(+), 2 deletions(-)
 create mode 100644 tools/build/feature/test-setns.c
 create mode 100644 tools/perf/util/setns.c

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index 523911f316ce..c71a05b9c984 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -64,7 +64,8 @@ FEATURE_TESTS_BASIC :=                  \
         get_cpuid                       \
         bpf                             \
         sched_getcpu			\
-        sdt
+        sdt				\
+        setns
 
 # FEATURE_TESTS_BASIC + FEATURE_TESTS_EXTRA is the complete list
 # of all feature tests
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index e35e4e5ad192..ee2546ddf028 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -49,7 +49,8 @@ FILES=                                          \
          test-sdt.bin                           \
          test-cxx.bin                           \
          test-jvmti.bin				\
-         test-sched_getcpu.bin
+         test-sched_getcpu.bin			\
+         test-setns.bin
 
 FILES := $(addprefix $(OUTPUT),$(FILES))
 
@@ -95,6 +96,9 @@ $(OUTPUT)test-glibc.bin:
 $(OUTPUT)test-sched_getcpu.bin:
 	$(BUILD)
 
+$(OUTPUT)test-setns.bin:
+	$(BUILD)
+
 DWARFLIBS := -ldw
 ifeq ($(findstring -static,${LDFLAGS}),-static)
 DWARFLIBS += -lelf -lebl -lz -llzma -lbz2
diff --git a/tools/build/feature/test-all.c b/tools/build/feature/test-all.c
index cc6c7c01f4ca..b5cfc6445771 100644
--- a/tools/build/feature/test-all.c
+++ b/tools/build/feature/test-all.c
@@ -153,6 +153,10 @@
 # include "test-sdt.c"
 #undef main
 
+#define main main_test_setns
+# include "test-setns.c"
+#undef main
+
 int main(int argc, char *argv[])
 {
 	main_test_libpython();
@@ -188,6 +192,7 @@ int main(int argc, char *argv[])
 	main_test_libcrypto();
 	main_test_sched_getcpu();
 	main_test_sdt();
+	main_test_setns();
 
 	return 0;
 }
diff --git a/tools/build/feature/test-setns.c b/tools/build/feature/test-setns.c
new file mode 100644
index 000000000000..1f714d2a658b
--- /dev/null
+++ b/tools/build/feature/test-setns.c
@@ -0,0 +1,7 @@
+#define _GNU_SOURCE
+#include <sched.h>
+
+int main(void)
+{
+	return setns(0, 0);
+}
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index bdf0e87f9b29..37d203c4cd1f 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -330,6 +330,11 @@ ifeq ($(feature-sched_getcpu), 1)
   CFLAGS += -DHAVE_SCHED_GETCPU_SUPPORT
 endif
 
+ifeq ($(feature-setns), 1)
+  CFLAGS += -DHAVE_SETNS_SUPPORT
+  $(call detected,CONFIG_SETNS)
+endif
+
 ifndef NO_LIBELF
   CFLAGS += -DHAVE_LIBELF_SUPPORT
   EXTLIBS += -lelf
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 79dea95a7f68..7580fe4d5d30 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -104,6 +104,10 @@ ifndef CONFIG_LIBELF
 libperf-y += symbol-minimal.o
 endif
 
+ifndef CONFIG_SETNS
+libperf-y += setns.o
+endif
+
 libperf-$(CONFIG_DWARF) += probe-finder.o
 libperf-$(CONFIG_DWARF) += dwarf-aux.o
 libperf-$(CONFIG_DWARF) += dwarf-regs.o
diff --git a/tools/perf/util/setns.c b/tools/perf/util/setns.c
new file mode 100644
index 000000000000..ce8fc290fce8
--- /dev/null
+++ b/tools/perf/util/setns.c
@@ -0,0 +1,8 @@
+#include "util.h"
+#include <unistd.h>
+#include <sys/syscall.h>
+
+int setns(int fd, int nstype)
+{
+	return syscall(__NR_setns, fd, nstype);
+}
diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
index 2c9e58a45310..1e5fe1d9ec32 100644
--- a/tools/perf/util/util.h
+++ b/tools/perf/util/util.h
@@ -58,4 +58,8 @@ const char *perf_tip(const char *dirpath);
 int sched_getcpu(void);
 #endif
 
+#ifndef HAVE_SETNS_SUPPORT
+int setns(int fd, int nstype);
+#endif
+
 #endif /* GIT_COMPAT_UTIL_H */
-- 
2.9.4
