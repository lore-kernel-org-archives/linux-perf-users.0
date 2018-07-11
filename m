From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 14/14] perf tools: Use python-config --includes rather than --cflags
Date: Wed, 11 Jul 2018 16:43:05 -0400
Message-ID: <20180711204305.12924-15-acme@kernel.org>
References: <20180711204305.12924-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180711204305.12924-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jeremy Cline <jcline@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jeremy Cline <jcline@redhat.com>

Builds started failing in Fedora on Python 3.7 with:

    `.gnu.debuglto_.debug_macro' referenced in section
    `.gnu.debuglto_.debug_macro' of
    util/scripting-engines/trace-event-python.o: defined in discarded
    section

In Fedora, Python 3.7 added -flto to the list of --cflags and since it
was only applied to util/scripting-engines/trace-event-python.c and
scripts/python/Perf-Trace-Util/Context.c, linking failed.

It's not the first time the addition of flags has broken builds: commit
c6707fdef7e2 ("perf tools: Fix up build in hardnened environments")
appears to have fixed a similar problem. "python-config --includes"
provides the proper -I flags and doesn't introduce additional CFLAGS.

Signed-off-by: Jeremy Cline <jcline@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180710154612.6285-1-jcline@redhat.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.config | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index b5ac356ba323..f5a3b402589e 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -207,8 +207,7 @@ ifdef PYTHON_CONFIG
   PYTHON_EMBED_LDOPTS := $(shell $(PYTHON_CONFIG_SQ) --ldflags 2>/dev/null)
   PYTHON_EMBED_LDFLAGS := $(call strip-libs,$(PYTHON_EMBED_LDOPTS))
   PYTHON_EMBED_LIBADD := $(call grep-libs,$(PYTHON_EMBED_LDOPTS)) -lutil
-  PYTHON_EMBED_CCOPTS := $(shell $(PYTHON_CONFIG_SQ) --cflags 2>/dev/null)
-  PYTHON_EMBED_CCOPTS := $(filter-out -specs=%,$(PYTHON_EMBED_CCOPTS))
+  PYTHON_EMBED_CCOPTS := $(shell $(PYTHON_CONFIG_SQ) --includes 2>/dev/null)
   FLAGS_PYTHON_EMBED := $(PYTHON_EMBED_CCOPTS) $(PYTHON_EMBED_LDOPTS)
 endif
 
-- 
2.14.4
