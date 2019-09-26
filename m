From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 48/66] libperf: Use sys/types.h to get ssize_t, not unistd.h
Date: Wed, 25 Sep 2019 21:32:26 -0300
Message-ID: <20190926003244.13962-49-acme@kernel.org>
References: <20190926003244.13962-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190926003244.13962-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The sys/types.h header looks more sensible, from its name we can gather
it should be there because of some needed typedef, and it is much
smaller than unistd.h, so use it and fix up the fallout in places where
it was being used for something else entirely but being obtained by
sheer luck, indirectly.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-49bn251httu22ymwgipeavmy@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/include/internal/lib.h | 2 +-
 tools/perf/util/mmap.c                | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/lib/include/internal/lib.h b/tools/perf/lib/include/internal/lib.h
index 9168b7d2a7e1..5175d491b2d4 100644
--- a/tools/perf/lib/include/internal/lib.h
+++ b/tools/perf/lib/include/internal/lib.h
@@ -2,7 +2,7 @@
 #ifndef __LIBPERF_INTERNAL_LIB_H
 #define __LIBPERF_INTERNAL_LIB_H
 
-#include <unistd.h>
+#include <sys/types.h>
 
 extern unsigned int page_size;
 
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index 12671d089748..a35dc57d5995 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -12,6 +12,7 @@
 #include <linux/zalloc.h>
 #include <stdlib.h>
 #include <string.h>
+#include <unistd.h> // sysconf()
 #ifdef HAVE_LIBNUMA_SUPPORT
 #include <numaif.h>
 #endif
-- 
2.21.0
