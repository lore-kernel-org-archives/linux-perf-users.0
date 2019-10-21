From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 46/57] libperf: Link static tests with libapi.a
Date: Mon, 21 Oct 2019 10:38:23 -0300
Message-ID: <20191021133834.25998-47-acme@kernel.org>
References: <20191021133834.25998-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191021133834.25998-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Alexey Budankov <alexey.budankov@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Jin Yao <yao.jin@linux.intel.com>, Michael Petlan <mpetlan@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Stephane Eranian <eranian@google.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Both static and dynamic tests needs to link with libapi.a, because it's
using its functions. Also include path for libapi includes.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lore.kernel.org/lkml/20191017105918.20873-5-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/Makefile       | 1 +
 tools/perf/lib/tests/Makefile | 6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/perf/lib/Makefile b/tools/perf/lib/Makefile
index 0889c9c3ec19..0f233638ef1f 100644
--- a/tools/perf/lib/Makefile
+++ b/tools/perf/lib/Makefile
@@ -107,6 +107,7 @@ else
 endif
 
 LIBAPI = $(API_PATH)libapi.a
+export LIBAPI
 
 $(LIBAPI): FORCE
 	$(Q)$(MAKE) -C $(LIB_DIR) O=$(OUTPUT) $(OUTPUT)libapi.a
diff --git a/tools/perf/lib/tests/Makefile b/tools/perf/lib/tests/Makefile
index 1ee4e9ba848b..a43cd08c5c03 100644
--- a/tools/perf/lib/tests/Makefile
+++ b/tools/perf/lib/tests/Makefile
@@ -16,13 +16,13 @@ all:
 
 include $(srctree)/tools/scripts/Makefile.include
 
-INCLUDE = -I$(srctree)/tools/perf/lib/include -I$(srctree)/tools/include
+INCLUDE = -I$(srctree)/tools/perf/lib/include -I$(srctree)/tools/include -I$(srctree)/tools/lib
 
 $(TESTS_A): FORCE
-	$(QUIET_LINK)$(CC) $(INCLUDE) $(CFLAGS) -o $@ $(subst -a,.c,$@) ../libperf.a
+	$(QUIET_LINK)$(CC) $(INCLUDE) $(CFLAGS) -o $@ $(subst -a,.c,$@) ../libperf.a $(LIBAPI)
 
 $(TESTS_SO): FORCE
-	$(QUIET_LINK)$(CC) $(INCLUDE) $(CFLAGS) -L.. -o $@ $(subst -so,.c,$@) -lperf
+	$(QUIET_LINK)$(CC) $(INCLUDE) $(CFLAGS) -L.. -o $@ $(subst -so,.c,$@) $(LIBAPI) -lperf
 
 all: $(TESTS_A) $(TESTS_SO)
 
-- 
2.21.0
