From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 02/18] perf tools: Fix static build with newer toolchains
Date: Tue, 29 Aug 2017 16:42:38 -0300
Message-ID: <20170829194254.1338-3-acme@kernel.org>
References: <20170829194254.1338-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170829194254.1338-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

We can't pass --dynamic-list list into static build anymore, because
compilers starts to scream about that. Fedora 26 started to fail build
with following error:

  $ make LDFLAGS=-static
  ...
  /usr/bin/ld: dynamic STT_GNU_IFUNC symbol `strcmp' with pointer equality in `/usr/lib/gcc/x86_64-redhat-linux/7/../../../../lib64/libc.a(strcmp.o
+)' can not be used when making an executable; recompile with -fPIE and relink with -pie

There's no sense for --dynamic-list in static build, because there's no
.dynsym table in static binary. Consequently the traceevent plugins have
never worked with static build, but it was quietly passed by.

To fix this in future I think we should add support to compile plugins
within the perf binary directly for static build.

Reported-and-Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/n/tip-jeg6a7ff9j9hlqn8k4gllzvv@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.perf | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 70ddc65f898d..a700a079a218 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -279,7 +279,13 @@ LIBTRACEEVENT = $(TE_PATH)libtraceevent.a
 export LIBTRACEEVENT
 
 LIBTRACEEVENT_DYNAMIC_LIST = $(TE_PATH)libtraceevent-dynamic-list
-LIBTRACEEVENT_DYNAMIC_LIST_LDFLAGS = -Xlinker --dynamic-list=$(LIBTRACEEVENT_DYNAMIC_LIST)
+
+#
+# The static build has no dynsym table, so this does not work for
+# static build. Looks like linker starts to scream about that now
+# (in Fedora 26) so we need to switch it off for static build.
+DYNAMIC_LIST_LDFLAGS               = -Xlinker --dynamic-list=$(LIBTRACEEVENT_DYNAMIC_LIST)
+LIBTRACEEVENT_DYNAMIC_LIST_LDFLAGS = $(if $(findstring -static,$(LDFLAGS)),,$(DYNAMIC_LIST_LDFLAGS))
 
 LIBAPI = $(API_PATH)libapi.a
 export LIBAPI
-- 
2.13.5
