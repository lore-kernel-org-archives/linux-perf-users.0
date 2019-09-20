From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 07/31] perf tools: Remove needless builtin.h include directives
Date: Fri, 20 Sep 2019 11:25:18 -0300
Message-ID: <20190920142542.12047-8-acme@kernel.org>
References: <20190920142542.12047-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190920142542.12047-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Now that builtin.h isn't included by any other header, we can check
where it is really needed, i.e. we can remove it and be sure that it
isn't being obtained indirectly.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-mn7jheex85iw9qo6tlv26hb2@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/bench/numa.c            | 1 -
 tools/perf/bench/sched-messaging.c | 1 -
 tools/perf/bench/sched-pipe.c      | 1 -
 tools/perf/util/jitdump.c          | 1 -
 4 files changed, 4 deletions(-)

diff --git a/tools/perf/bench/numa.c b/tools/perf/bench/numa.c
index 62b8ef4bcb1f..5797253b9700 100644
--- a/tools/perf/bench/numa.c
+++ b/tools/perf/bench/numa.c
@@ -9,7 +9,6 @@
 /* For the CLR_() macros */
 #include <pthread.h>
 
-#include "../builtin.h"
 #include <subcmd/parse-options.h>
 #include "../util/cloexec.h"
 
diff --git a/tools/perf/bench/sched-messaging.c b/tools/perf/bench/sched-messaging.c
index c63eb9a46346..6e499b32bf00 100644
--- a/tools/perf/bench/sched-messaging.c
+++ b/tools/perf/bench/sched-messaging.c
@@ -12,7 +12,6 @@
 
 #include "../util/util.h"
 #include <subcmd/parse-options.h>
-#include "../builtin.h"
 #include "bench.h"
 
 /* Test groups of 20 processes spraying to 20 receivers */
diff --git a/tools/perf/bench/sched-pipe.c b/tools/perf/bench/sched-pipe.c
index 35b07f197d48..edd40aafa318 100644
--- a/tools/perf/bench/sched-pipe.c
+++ b/tools/perf/bench/sched-pipe.c
@@ -11,7 +11,6 @@
  */
 #include "../util/util.h"
 #include <subcmd/parse-options.h>
-#include "../builtin.h"
 #include "bench.h"
 
 #include <unistd.h>
diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
index b80f29bfc7bb..00db9957fdb0 100644
--- a/tools/perf/util/jitdump.c
+++ b/tools/perf/util/jitdump.c
@@ -27,7 +27,6 @@
 #include "jit.h"
 #include "jitdump.h"
 #include "genelf.h"
-#include "../builtin.h"
 
 #include <linux/ctype.h>
 #include <linux/zalloc.h>
-- 
2.21.0
