From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 24/36] perf tools: Fix up build in hardnened environments
Date: Wed,  6 Dec 2017 11:41:03 -0300
Message-ID: <20171206144115.15097-25-acme@kernel.org>
References: <20171206144115.15097-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171206144115.15097-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

On Fedora systems the perl and python CFLAGS/LDFLAGS include the
hardened specs from redhat-rpm-config package. We apply them only for
perl/python objects, which makes them not compatible with the rest of
the objects and the build fails with:

  /usr/bin/ld: perf-in.o: relocation R_X86_64_32 against `.rodata.str1.1' can not be used when making a shared object; recompile with -f
+PIC
  /usr/bin/ld: libperf.a(libperf-in.o): relocation R_X86_64_32S against `.text' can not be used when making a shared object; recompile w
+ith -fPIC
  /usr/bin/ld: final link failed: Nonrepresentable section on output
  collect2: error: ld returned 1 exit status
  make[2]: *** [Makefile.perf:507: perf] Error 1
  make[1]: *** [Makefile.perf:210: sub-make] Error 2
  make: *** [Makefile:69: all] Error 2

Mainly it's caused by perl/python objects being compiled with:

  -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1

which prevent the final link impossible, because it will check
for 'proper' objects with following option:

  -specs=/usr/lib/rpm/redhat/redhat-hardened-ld

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20171204082437.GC30564@krava
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.config | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index bf86c09ca889..808066c823f7 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -185,9 +185,7 @@ ifdef PYTHON_CONFIG
   PYTHON_EMBED_LDFLAGS := $(call strip-libs,$(PYTHON_EMBED_LDOPTS))
   PYTHON_EMBED_LIBADD := $(call grep-libs,$(PYTHON_EMBED_LDOPTS)) -lutil
   PYTHON_EMBED_CCOPTS := $(shell $(PYTHON_CONFIG_SQ) --cflags 2>/dev/null)
-  ifeq ($(CC_NO_CLANG), 1)
-    PYTHON_EMBED_CCOPTS := $(filter-out -specs=%,$(PYTHON_EMBED_CCOPTS))
-  endif
+  PYTHON_EMBED_CCOPTS := $(filter-out -specs=%,$(PYTHON_EMBED_CCOPTS))
   FLAGS_PYTHON_EMBED := $(PYTHON_EMBED_CCOPTS) $(PYTHON_EMBED_LDOPTS)
 endif
 
@@ -577,7 +575,6 @@ ifndef NO_GTK2
   endif
 endif
 
-
 ifdef NO_LIBPERL
   CFLAGS += -DNO_LIBPERL
 else
@@ -585,6 +582,8 @@ else
   PERL_EMBED_LDFLAGS = $(call strip-libs,$(PERL_EMBED_LDOPTS))
   PERL_EMBED_LIBADD = $(call grep-libs,$(PERL_EMBED_LDOPTS))
   PERL_EMBED_CCOPTS = $(shell perl -MExtUtils::Embed -e ccopts 2>/dev/null)
+  PERL_EMBED_CCOPTS := $(filter-out -specs=%,$(PERL_EMBED_CCOPTS))
+  PERL_EMBED_LDOPTS := $(filter-out -specs=%,$(PERL_EMBED_LDOPTS))
   FLAGS_PERL_EMBED=$(PERL_EMBED_CCOPTS) $(PERL_EMBED_LDOPTS)
 
   ifneq ($(feature-libperl), 1)
-- 
2.13.6
