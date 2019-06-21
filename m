From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 24/25] perf build: Handle slang being in /usr/include and in /usr/include/slang/
Date: Fri, 21 Jun 2019 14:38:30 -0300
Message-ID: <20190621173831.13780-25-acme@kernel.org>
References: <20190621173831.13780-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190621173831.13780-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Florian Fainelli <f.fainelli@gmail.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

In some distros slang.h may be in a /usr/include 'slang' subdir, so use
the if slang is not explicitely disabled (by using NO_SLANG=1) and its
feature test for the common case (having /usr/include/slang.h) failed,
use the results for the test that checks if it is in slang/slang.h.

Change the only file in perf that includes slang.h to use
HAVE_SLANG_INCLUDE_SUBDIR and forget about this for good.

On a rhel6 system now we have:

  $ /tmp/build/perf/perf -vv | grep slang
                libslang: [ on  ]  # HAVE_SLANG_SUPPORT
  $ ldd /tmp/build/perf/perf | grep libslang
  	libslang.so.2 => /usr/lib64/libslang.so.2 (0x00007fa2d5a8d000)
  $ grep slang /tmp/build/perf/FEATURE-DUMP
  feature-libslang=0
  feature-libslang-include-subdir=1
  $ cat /etc/redhat-release
  CentOS release 6.10 (Final)
  $

While on fedora:29:

  $ /tmp/build/perf/perf -vv | grep slang
                libslang: [ on  ]  # HAVE_SLANG_SUPPORT
  $ ldd /tmp/build/perf/perf | grep slang
  	libslang.so.2 => /lib64/libslang.so.2 (0x00007f8eb11a7000)
  $ grep slang /tmp/build/perf/FEATURE-DUMP
  feature-libslang=1
  feature-libslang-include-subdir=1
  $
  $ cat /etc/fedora-release
  Fedora release 29 (Twenty Nine)
  $

The feature-libslang-include-subdir=1 line is because the 'gettid()'
test was added to test-all.c as the new glibc has an implementation for
that, so we soon should have it not failing, i.e. should be the common
case soon. Perhaps I should move it out till it becomes the norm...

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Fixes: 1955c8cf5e26 ("perf tools: Don't hardcode host include path for libslang")
Link: https://lkml.kernel.org/n/tip-bkgtpsu3uit821fuwsdhj9gd@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.config | 11 ++++++++---
 tools/perf/ui/libslang.h   |  5 +++++
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index e04b7a81d221..89ac5a1f1550 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -644,9 +644,14 @@ endif
 
 ifndef NO_SLANG
   ifneq ($(feature-libslang), 1)
-    msg := $(warning slang not found, disables TUI support. Please install slang-devel, libslang-dev or libslang2-dev);
-    NO_SLANG := 1
-  else
+    ifneq ($(feature-libslang-include-subdir), 1)
+      msg := $(warning slang not found, disables TUI support. Please install slang-devel, libslang-dev or libslang2-dev);
+      NO_SLANG := 1
+    else
+      CFLAGS += -DHAVE_SLANG_INCLUDE_SUBDIR
+    endif
+  endif
+  ifndef NO_SLANG
     # Fedora has /usr/include/slang/slang.h, but ubuntu /usr/include/slang.h
     CFLAGS += -DHAVE_SLANG_SUPPORT
     EXTLIBS += -lslang
diff --git a/tools/perf/ui/libslang.h b/tools/perf/ui/libslang.h
index c0686cda39a5..991e692b9b46 100644
--- a/tools/perf/ui/libslang.h
+++ b/tools/perf/ui/libslang.h
@@ -10,7 +10,12 @@
 #ifndef HAVE_LONG_LONG
 #define HAVE_LONG_LONG __GLIBC_HAVE_LONG_LONG
 #endif
+
+#ifdef HAVE_SLANG_INCLUDE_SUBDIR
+#include <slang/slang.h>
+#else
 #include <slang.h>
+#endif
 
 #if SLANG_VERSION < 20104
 #define slsmg_printf(msg, args...) \
-- 
2.20.1
