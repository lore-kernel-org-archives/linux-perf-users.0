From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 09/24] perf tools: Remove duplicate headers
Date: Mon, 21 Jan 2019 20:56:51 -0300
Message-ID: <20190121235706.20005-10-acme@kernel.org>
References: <20190121235706.20005-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190121235706.20005-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Brajeswar Ghosh <brajeswar.linux@gmail.com>, Souptick Joarder <jrdr.linux@gmail.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Colin King <colin.king@canonical.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Sabyasachi Gupta <sabyasachi.linux@gmail.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Brajeswar Ghosh <brajeswar.linux@gmail.com>

Remove duplicate headers which are included more than once in the same
file.

Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>
Acked-by: Souptick Joarder <jrdr.linux@gmail.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Colin King <colin.king@canonical.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Link: http://lkml.kernel.org/r/20190115135916.GA3629@hp-pavilion-15-notebook-pc-brajeswar
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c     | 1 -
 tools/perf/tests/bp_account.c | 1 -
 tools/perf/util/dso.h         | 1 -
 tools/perf/util/zlib.c        | 1 -
 4 files changed, 4 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 63a3afc7f32b..e587808591e8 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -83,7 +83,6 @@
 #include <unistd.h>
 #include <sys/time.h>
 #include <sys/resource.h>
-#include <sys/wait.h>
 
 #include "sane_ctype.h"
 
diff --git a/tools/perf/tests/bp_account.c b/tools/perf/tests/bp_account.c
index a20cbc445426..57fc544aedb0 100644
--- a/tools/perf/tests/bp_account.c
+++ b/tools/perf/tests/bp_account.c
@@ -15,7 +15,6 @@
 #include <sys/mman.h>
 #include <linux/compiler.h>
 #include <linux/hw_breakpoint.h>
-#include <sys/ioctl.h>
 
 #include "tests.h"
 #include "debug.h"
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index 8c8a7abe809d..af2eda29660f 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -8,7 +8,6 @@
 #include <sys/types.h>
 #include <stdbool.h>
 #include "rwsem.h"
-#include <linux/types.h>
 #include <linux/bitops.h>
 #include "map.h"
 #include "namespaces.h"
diff --git a/tools/perf/util/zlib.c b/tools/perf/util/zlib.c
index 902ce6384f57..512ad7c09b13 100644
--- a/tools/perf/util/zlib.c
+++ b/tools/perf/util/zlib.c
@@ -6,7 +6,6 @@
 #include <sys/mman.h>
 #include <zlib.h>
 #include <linux/compiler.h>
-#include <unistd.h>
 
 #include "util/compress.h"
 #include "util/util.h"
-- 
2.20.1
