From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 40/57] perf tests: Remove needless headers for bp_account
Date: Mon, 21 Oct 2019 10:38:17 -0300
Message-ID: <20191021133834.25998-41-acme@kernel.org>
References: <20191021133834.25998-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191021133834.25998-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Leo Yan <leo.yan@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Brajeswar Ghosh <brajeswar.linux@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Olsa <jolsa@redhat.com>, Mark Rutland <mark.rutland@arm.com>, Michael Petlan <mpetlan@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Song Liu <songliubraving@fb.com>, Souptick Joarder <jrdr.linux@gmail.com>, Will Deacon <will@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Leo Yan <leo.yan@linaro.org>

A few headers are not needed and were introduced by copying from other
test file.  This patch removes the needless headers for the breakpoint
accounting testing.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Brajeswar Ghosh <brajeswar.linux@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Song Liu <songliubraving@fb.com>
Cc: Souptick Joarder <jrdr.linux@gmail.com>
Cc: Will Deacon <will@kernel.org>
Link: http://lore.kernel.org/lkml/20191018085531.6348-1-leo.yan@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/bp_account.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/tools/perf/tests/bp_account.c b/tools/perf/tests/bp_account.c
index 016bba2c142d..52ff7a462670 100644
--- a/tools/perf/tests/bp_account.c
+++ b/tools/perf/tests/bp_account.c
@@ -10,11 +10,7 @@
 #include <unistd.h>
 #include <string.h>
 #include <sys/ioctl.h>
-#include <time.h>
 #include <fcntl.h>
-#include <signal.h>
-#include <sys/mman.h>
-#include <linux/compiler.h>
 #include <linux/hw_breakpoint.h>
 
 #include "tests.h"
-- 
2.21.0
