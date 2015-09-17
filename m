From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: build tests for older =?utf-8?Q?systems_?=
 =?utf-8?Q?=5Bwas=5D_Re=3A_Linux_4=2E3-rc1_build_error_with_older_elfutils?=
 =?utf-8?Q?_=22util=2Fsymbol-elf=2Ec=3A41=3A5=3A_error=3A_no_previous_prot?=
 =?utf-8?B?b3R5cGUgZm9yIOKAmGVsZl9nZXRwaGRybnVt4oCZIg==?=
Date: Thu, 17 Sep 2015 13:09:44 -0300
Message-ID: <20150917160944.GM11551@kernel.org>
References: <CAHTgTXVPtzyRuW5tYGuC4Ssxpzgc8uFvnXirbvtrCXbJ7f9RnA@mail.gmail.com>
 <55FA5D8F.6000502@intel.com>
 <20150917140619.GK11551@kernel.org>
 <20150917143708.GL11551@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:42200 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752109AbbIQQJv (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 17 Sep 2015 12:09:51 -0400
Content-Disposition: inline
In-Reply-To: <20150917143708.GL11551@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Vinson Lee <vlee@twopensource.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>, Srikar Dronamraju <srikar@linux.vnet.ibm.com>, Wang Nan <wangnan0@huawei.com>, Victor Kamensky <victor.kamensky@linaro.org>, LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org

Adrian,

	I'm adding the following two patches to my perf/urgent branch, one is
related to Intel PT, please take a look.

- Arnaldo

From d98dccdf3346c8c9fd74574786927bef215db426 Mon Sep 17 00:00:00 2001
From: Arnaldo Carvalho de Melo <acme@redhat.com>
Date: Thu, 17 Sep 2015 12:54:30 -0300
Subject: [PATCH] tools build: Add test for presence of __get_cpuid() gcc
 builtin

The auxtrace code needed by Intel PT uses the __get_cpuid() gcc builtin,
that is not present in old systems, breaking the build.

Add a test to check for that builtin and disable AUXTRACE in those
systems.

  [acme@rhel5 linux]$  make NO_LIBPERL=1 -C tools/perf O=/tmp/build/perf install-bin
  make: Entering directory `/home/acme/git/linux/tools/perf'
    BUILD:   Doing 'make -j2' parallel build

  Auto-detecting system features:
  <SNIP>
  ...                          lzma: [ on  ]
  ...                     get_cpuid: [ OFF ]
  <SNIP>
  config/Makefile:630: Your gcc lacks the __get_cpuid() builtin, disables support for auxtrace/Intel PT, please install a newer gcc
    MKDIR    /tmp/build/perf/util/
  <SNIP>

This fixes the build on old systems such as RHEL/CentOS 5.11.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: David Ahern <dsahern@gmail.com>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Victor Kamensky <victor.kamensky@linaro.org>
Cc: Vinson Lee <vlee@twopensource.com>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-d4puslul0jltoodzpx9r4sje@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/build/Makefile.feature         | 6 ++++--
 tools/build/feature/Makefile         | 6 +++++-
 tools/build/feature/test-all.c       | 5 +++++
 tools/build/feature/test-get_cpuid.c | 7 +++++++
 tools/perf/config/Makefile           | 9 +++++++--
 5 files changed, 28 insertions(+), 5 deletions(-)
 create mode 100644 tools/build/feature/test-get_cpuid.c

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index 970242098a7c..c8fe6d177119 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -52,7 +52,8 @@ FEATURE_TESTS ?=			\
 	timerfd				\
 	libdw-dwarf-unwind		\
 	zlib				\
-	lzma
+	lzma				\
+	get_cpuid
 
 FEATURE_DISPLAY ?=			\
 	dwarf				\
@@ -69,7 +70,8 @@ FEATURE_DISPLAY ?=			\
 	libunwind			\
 	libdw-dwarf-unwind		\
 	zlib				\
-	lzma
+	lzma				\
+	get_cpuid
 
 # Set FEATURE_CHECK_(C|LD)FLAGS-all for all FEATURE_TESTS features.
 # If in the future we need per-feature checks/flags for features not
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index e13a42bd0274..e43a2971bf56 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -35,7 +35,8 @@ FILES=					\
 	test-compile-x32.bin		\
 	test-zlib.bin			\
 	test-lzma.bin			\
-	test-bpf.bin
+	test-bpf.bin			\
+	test-get_cpuid.bin
 
 CC := $(CROSS_COMPILE)gcc -MD
 PKG_CONFIG := $(CROSS_COMPILE)pkg-config
@@ -166,6 +167,9 @@ test-zlib.bin:
 test-lzma.bin:
 	$(BUILD) -llzma
 
+test-get_cpuid.bin:
+	$(BUILD)
+
 test-bpf.bin:
 	$(BUILD)
 
diff --git a/tools/build/feature/test-all.c b/tools/build/feature/test-all.c
index 7a8cdbad3e1b..33cf6f20bd4e 100644
--- a/tools/build/feature/test-all.c
+++ b/tools/build/feature/test-all.c
@@ -121,6 +121,10 @@
 # include "test-lzma.c"
 #undef main
 
+#define main main_test_get_cpuid
+# include "test-get_cpuid.c"
+#undef main
+
 int main(int argc, char *argv[])
 {
 	main_test_libpython();
@@ -148,6 +152,7 @@ int main(int argc, char *argv[])
 	main_test_zlib();
 	main_test_pthread_attr_setaffinity_np();
 	main_test_lzma();
+	main_test_get_cpuid();
 
 	return 0;
 }
diff --git a/tools/build/feature/test-get_cpuid.c b/tools/build/feature/test-get_cpuid.c
new file mode 100644
index 000000000000..d7a2c407130d
--- /dev/null
+++ b/tools/build/feature/test-get_cpuid.c
@@ -0,0 +1,7 @@
+#include <cpuid.h>
+
+int main(void)
+{
+	unsigned int eax = 0, ebx = 0, ecx = 0, edx = 0;
+	return __get_cpuid(0x15, &eax, &ebx, &ecx, &edx);
+}
diff --git a/tools/perf/config/Makefile b/tools/perf/config/Makefile
index 053e65b04dc3..38a08539f4bf 100644
--- a/tools/perf/config/Makefile
+++ b/tools/perf/config/Makefile
@@ -626,8 +626,13 @@ ifdef LIBBABELTRACE
 endif
 
 ifndef NO_AUXTRACE
-  $(call detected,CONFIG_AUXTRACE)
-  CFLAGS += -DHAVE_AUXTRACE_SUPPORT
+  ifeq ($(feature-get_cpuid), 0)
+    msg := $(warning Your gcc lacks the __get_cpuid() builtin, disables support for auxtrace/Intel PT, please install a newer gcc);
+    NO_AUXTRACE := 1
+  else
+    $(call detected,CONFIG_AUXTRACE)
+    CFLAGS += -DHAVE_AUXTRACE_SUPPORT
+  endif
 endif
 
 # Among the variables below, these:
-- 
2.1.0

From c8a029b981fb77fc7a6261eddc27f7b558676f45 Mon Sep 17 00:00:00 2001
From: Arnaldo Carvalho de Melo <acme@redhat.com>
Date: Thu, 17 Sep 2015 12:20:28 -0300
Subject: [PATCH] tools build: Add test for presence of
 numa_num_possible_cpus() in libnuma

The existing numa test checks only if numa.h and numa_available() are
present, but that can be satisfied with an old libnuma that is not
enough for the 'perf bench numa' entry, so add a test to check for that:

  [acme@rhel5 linux]$  make NO_AUXTRACE=1 NO_LIBPERL=1 -C tools/perf O=/tmp/build/perf install-bin
  make: Entering directory `/home/acme/git/linux/tools/perf'
    BUILD:   Doing 'make -j2' parallel build

  Auto-detecting system features:
  ...                        libelf: [ on  ]
  ...                       libnuma: [ on  ]
  ...        numa_num_possible_cpus: [ OFF ]
  ...                       libperl: [ on  ]

  <SNIP>
  config/Makefile:577: Old numa library found, disables 'perf bench numa mem' benchmark, please install numactl-devel/libnuma-devel/libnuma-dev >= 2.0.8
    INSTALL  binaries
  <SNIP>

This fixes the build on old systems such as RHEL/CentOS 5.11.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: David Ahern <dsahern@gmail.com>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Victor Kamensky <victor.kamensky@linaro.org>
Cc: Vinson Lee <vlee@twopensource.com>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-zqriqkezppi2de2iyjin1tnc@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/build/Makefile.feature                      |  2 ++
 tools/build/feature/Makefile                      |  4 ++++
 tools/build/feature/test-all.c                    |  5 +++++
 tools/build/feature/test-numa_num_possible_cpus.c |  6 ++++++
 tools/perf/config/Makefile                        | 11 ++++++++---
 5 files changed, 25 insertions(+), 3 deletions(-)
 create mode 100644 tools/build/feature/test-numa_num_possible_cpus.c

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index 2975632d51e2..970242098a7c 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -41,6 +41,7 @@ FEATURE_TESTS ?=			\
 	libelf-getphdrnum		\
 	libelf-mmap			\
 	libnuma				\
+	numa_num_possible_cpus		\
 	libperl				\
 	libpython			\
 	libpython-version		\
@@ -61,6 +62,7 @@ FEATURE_DISPLAY ?=			\
 	libbfd				\
 	libelf				\
 	libnuma				\
+	numa_num_possible_cpus		\
 	libperl				\
 	libpython			\
 	libslang			\
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 74ca42093d70..e13a42bd0274 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -19,6 +19,7 @@ FILES=					\
 	test-libelf-getphdrnum.bin	\
 	test-libelf-mmap.bin		\
 	test-libnuma.bin		\
+	test-numa_num_possible_cpus.bin	\
 	test-libperl.bin		\
 	test-libpython.bin		\
 	test-libpython-version.bin	\
@@ -87,6 +88,9 @@ test-libelf-getphdrnum.bin:
 test-libnuma.bin:
 	$(BUILD) -lnuma
 
+test-numa_num_possible_cpus.bin:
+	$(BUILD) -lnuma
+
 test-libunwind.bin:
 	$(BUILD) -lelf
 
diff --git a/tools/build/feature/test-all.c b/tools/build/feature/test-all.c
index 84689a67814a..7a8cdbad3e1b 100644
--- a/tools/build/feature/test-all.c
+++ b/tools/build/feature/test-all.c
@@ -77,6 +77,10 @@
 # include "test-libnuma.c"
 #undef main
 
+#define main main_test_numa_num_possible_cpus
+# include "test-numa_num_possible_cpus.c"
+#undef main
+
 #define main main_test_timerfd
 # include "test-timerfd.c"
 #undef main
@@ -136,6 +140,7 @@ int main(int argc, char *argv[])
 	main_test_libbfd();
 	main_test_backtrace();
 	main_test_libnuma();
+	main_test_numa_num_possible_cpus();
 	main_test_timerfd();
 	main_test_stackprotector_all();
 	main_test_libdw_dwarf_unwind();
diff --git a/tools/build/feature/test-numa_num_possible_cpus.c b/tools/build/feature/test-numa_num_possible_cpus.c
new file mode 100644
index 000000000000..2606e94b0659
--- /dev/null
+++ b/tools/build/feature/test-numa_num_possible_cpus.c
@@ -0,0 +1,6 @@
+#include <numa.h>
+
+int main(void)
+{
+	return numa_num_possible_cpus();
+}
diff --git a/tools/perf/config/Makefile b/tools/perf/config/Makefile
index 827557fc7511..053e65b04dc3 100644
--- a/tools/perf/config/Makefile
+++ b/tools/perf/config/Makefile
@@ -573,9 +573,14 @@ ifndef NO_LIBNUMA
     msg := $(warning No numa.h found, disables 'perf bench numa mem' benchmark, please install numactl-devel/libnuma-devel/libnuma-dev);
     NO_LIBNUMA := 1
   else
-    CFLAGS += -DHAVE_LIBNUMA_SUPPORT
-    EXTLIBS += -lnuma
-    $(call detected,CONFIG_NUMA)
+    ifeq ($(feature-numa_num_possible_cpus), 0)
+      msg := $(warning Old numa library found, disables 'perf bench numa mem' benchmark, please install numactl-devel/libnuma-devel/libnuma-dev >= 2.0.8);
+      NO_LIBNUMA := 1
+    else
+      CFLAGS += -DHAVE_LIBNUMA_SUPPORT
+      EXTLIBS += -lnuma
+      $(call detected,CONFIG_NUMA)
+    endif
   endif
 endif
 
-- 
2.1.0
