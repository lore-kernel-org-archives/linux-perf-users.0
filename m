From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 47/66] perf tools: No need to include internal/lib.h from util/util.h
Date: Wed, 25 Sep 2019 21:32:25 -0300
Message-ID: <20190926003244.13962-48-acme@kernel.org>
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

That was done just to have users of writen() and readn(), that before
had their prototypes in util/util.h to get it without having to add an
include for internal/lib.h, but the right way is to add it and by now
all places already do it.

Fix a fallout were readlink() was used but unistd.h was being obtained
by luck thru util.h -> internal/lib.h, now to check why unistd.h is
being included there...

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-lcnytgrtafey3kwlfog2rzzj@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/sdt.c | 1 +
 tools/perf/util/util.h | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/sdt.c b/tools/perf/tests/sdt.c
index cf1bd57d3023..60f0e9ee04fb 100644
--- a/tools/perf/tests/sdt.c
+++ b/tools/perf/tests/sdt.c
@@ -3,6 +3,7 @@
 #include <limits.h>
 #include <stdio.h>
 #include <stdlib.h>
+#include <unistd.h>
 #include <sys/epoll.h>
 #include <util/symbol.h>
 #include <linux/filter.h>
diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
index d6ae394e67c4..b78b73e5bb32 100644
--- a/tools/perf/util/util.h
+++ b/tools/perf/util/util.h
@@ -11,7 +11,6 @@
 #include <stddef.h>
 #include <linux/compiler.h>
 #include <sys/types.h>
-#include <internal/lib.h>
 
 /* General helper functions */
 void usage(const char *err) __noreturn;
-- 
2.21.0
