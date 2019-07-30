From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 098/107] libperf: Add install targets
Date: Mon, 29 Jul 2019 23:56:01 -0300
Message-ID: <20190730025610.22603-99-acme@kernel.org>
References: <20190730025610.22603-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190730025610.22603-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Alexey Budankov <alexey.budankov@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Michael Petlan <mpetlan@redhat.com>, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Add install targets (mostly copied from tools/lib/bpf), it's now
possible to install libperf with:

  $ make DESTDIR=/tmp/krava  install
    INSTALL  libperf.a
    INSTALL  libperf.so
    INSTALL  libperf.so.0
    INSTALL  libperf.so.0.0.1
    INSTALL  headers
    INSTALL  libperf.pc

  $ find /tmp/krava/
  /tmp/krava/
  /tmp/krava/include
  /tmp/krava/include/perf
  /tmp/krava/include/perf/evsel.h
  /tmp/krava/include/perf/evlist.h
  /tmp/krava/include/perf/threadmap.h
  /tmp/krava/include/perf/cpumap.h
  /tmp/krava/include/perf/core.h
  /tmp/krava/lib64
  /tmp/krava/lib64/pkgconfig
  /tmp/krava/lib64/pkgconfig/libperf.pc
  /tmp/krava/lib64/libperf.so.0.0.1
  /tmp/krava/lib64/libperf.so.0
  /tmp/krava/lib64/libperf.so
  /tmp/krava/lib64/libperf.a

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-72-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/Makefile            | 69 +++++++++++++++++++++++++++++-
 tools/perf/lib/libperf.pc.template | 11 +++++
 2 files changed, 78 insertions(+), 2 deletions(-)
 create mode 100644 tools/perf/lib/libperf.pc.template

diff --git a/tools/perf/lib/Makefile b/tools/perf/lib/Makefile
index cd571ec648ad..f1b3d4c6d5f0 100644
--- a/tools/perf/lib/Makefile
+++ b/tools/perf/lib/Makefile
@@ -14,9 +14,31 @@ srctree := $(patsubst %/,%,$(dir $(srctree)))
 #$(info Determined 'srctree' to be $(srctree))
 endif
 
+INSTALL = install
+
+# Use DESTDIR for installing into a different root directory.
+# This is useful for building a package. The program will be
+# installed in this directory as if it was the root directory.
+# Then the build tool can move it later.
+DESTDIR ?=
+DESTDIR_SQ = '$(subst ','\'',$(DESTDIR))'
+
 include $(srctree)/tools/scripts/Makefile.include
 include $(srctree)/tools/scripts/Makefile.arch
 
+ifeq ($(LP64), 1)
+  libdir_relative = lib64
+else
+  libdir_relative = lib
+endif
+
+prefix ?=
+libdir = $(prefix)/$(libdir_relative)
+
+# Shell quotes
+libdir_SQ = $(subst ','\'',$(libdir))
+libdir_relative_SQ = $(subst ','\'',$(libdir_relative))
+
 ifeq ("$(origin V)", "command line")
   VERBOSE = $(V)
 endif
@@ -49,6 +71,8 @@ override CFLAGS += -fvisibility=hidden
 all:
 
 export srctree OUTPUT CC LD CFLAGS V
+export DESTDIR DESTDIR_SQ
+
 include $(srctree)/tools/build/Makefile.include
 
 VERSION_SCRIPT := libperf.map
@@ -60,6 +84,9 @@ VERSION       = $(LIBPERF_VERSION).$(LIBPERF_PATCHLEVEL).$(LIBPERF_EXTRAVERSION)
 LIBPERF_SO := $(OUTPUT)libperf.so.$(VERSION)
 LIBPERF_A  := $(OUTPUT)libperf.a
 LIBPERF_IN := $(OUTPUT)libperf-in.o
+LIBPERF_PC := $(OUTPUT)libperf.pc
+
+LIBPERF_ALL := $(LIBPERF_A) $(OUTPUT)libperf.so*
 
 $(LIBPERF_IN): FORCE
 	$(Q)$(MAKE) $(build)=libperf
@@ -74,14 +101,52 @@ $(LIBPERF_SO): $(LIBPERF_IN)
 	@ln -sf $(@F) $(OUTPUT)libperf.so.$(LIBPERF_VERSION)
 
 
-libs: $(LIBPERF_A) $(LIBPERF_SO)
+libs: $(LIBPERF_A) $(LIBPERF_SO) $(LIBPERF_PC)
 
 all: fixdep
 	$(Q)$(MAKE) libs
 
 clean:
 	$(call QUIET_CLEAN, libperf) $(RM) $(LIBPERF_A) \
-                *.o *~ *.a *.so *.so.$(VERSION) *.so.$(LIBPERF_VERSION) .*.d .*.cmd LIBPERF-CFLAGS
+                *.o *~ *.a *.so *.so.$(VERSION) *.so.$(LIBPERF_VERSION) .*.d .*.cmd LIBPERF-CFLAGS $(LIBPERF_PC)
+
+$(LIBPERF_PC):
+	$(QUIET_GEN)sed -e "s|@PREFIX@|$(prefix)|" \
+		-e "s|@LIBDIR@|$(libdir_SQ)|" \
+		-e "s|@VERSION@|$(VERSION)|" \
+		< libperf.pc.template > $@
+
+define do_install_mkdir
+	if [ ! -d '$(DESTDIR_SQ)$1' ]; then             \
+		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$1'; \
+	fi
+endef
+
+define do_install
+	if [ ! -d '$(DESTDIR_SQ)$2' ]; then             \
+		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$2'; \
+	fi;                                             \
+	$(INSTALL) $1 $(if $3,-m $3,) '$(DESTDIR_SQ)$2'
+endef
+
+install_lib: libs
+	$(call QUIET_INSTALL, $(LIBPERF_ALL)) \
+		$(call do_install_mkdir,$(libdir_SQ)); \
+		cp -fpR $(LIBPERF_ALL) $(DESTDIR)$(libdir_SQ)
+
+install_headers:
+	$(call QUIET_INSTALL, headers) \
+		$(call do_install,include/perf/core.h,$(prefix)/include/perf,644); \
+		$(call do_install,include/perf/cpumap.h,$(prefix)/include/perf,644); \
+		$(call do_install,include/perf/threadmap.h,$(prefix)/include/perf,644); \
+		$(call do_install,include/perf/evlist.h,$(prefix)/include/perf,644); \
+		$(call do_install,include/perf/evsel.h,$(prefix)/include/perf,644);
+
+install_pkgconfig: $(LIBPERF_PC)
+	$(call QUIET_INSTALL, $(LIBPERF_PC)) \
+		$(call do_install,$(LIBPERF_PC),$(libdir_SQ)/pkgconfig,644)
+
+install: install_lib install_headers install_pkgconfig
 
 FORCE:
 
diff --git a/tools/perf/lib/libperf.pc.template b/tools/perf/lib/libperf.pc.template
new file mode 100644
index 000000000000..117e4a237b55
--- /dev/null
+++ b/tools/perf/lib/libperf.pc.template
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+
+prefix=@PREFIX@
+libdir=@LIBDIR@
+includedir=${prefix}/include
+
+Name: libperf
+Description: perf library
+Version: @VERSION@
+Libs: -L${libdir} -lperf
+Cflags: -I${includedir}
-- 
2.21.0
