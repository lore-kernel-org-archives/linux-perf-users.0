From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 14/63] perf tools: Add missing sigqueue() prototype for systems lacking it
Date: Tue, 18 Dec 2018 19:06:44 -0300
Message-ID: <20181218220733.15839-15-acme@kernel.org>
References: <20181218220733.15839-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181218220733.15839-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

There are systems such as the Android NDK API level 24 has the
sigqueue() function but doesn't provide a prototype, adding noise to the
build:

  util/evlist.c: In function 'perf_evlist__prepare_workload':
  util/evlist.c:1494:4: warning: implicit declaration of function 'sigqueue' [-Wimplicit-function-declaration]
      if (sigqueue(getppid(), SIGUSR1, val))
      ^
  util/evlist.c:1494:4: warning: nested extern declaration of 'sigqueue' [-Wnested-externs]

Define a LACKS_SIGQUEUE_PROTOTYPE define so that code needing that can
get a prototype.

Checked in the bionic git repo to be available since level 23:

https://android.googlesource.com/platform/bionic/+/master/libc/include/signal.h#123

  int sigqueue(pid_t __pid, int __signal, const union sigval __value) __INTRODUCED_IN(23);

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-lmhpev1uni9kdrv7j29glyov@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.config | 1 +
 tools/perf/util/evlist.c   | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index b66f97a04b12..265a9225e5fc 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -294,6 +294,7 @@ ifndef NO_BIONIC
   $(call feature_check,bionic)
   ifeq ($(feature-bionic), 1)
     BIONIC := 1
+    CFLAGS += -DLACKS_SIGQUEUE_PROTOTYPE
     EXTLIBS := $(filter-out -lrt,$(EXTLIBS))
     EXTLIBS := $(filter-out -lpthread,$(EXTLIBS))
   endif
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index e90575192209..8c902276d4b4 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -34,6 +34,10 @@
 #include <linux/log2.h>
 #include <linux/err.h>
 
+#ifdef LACKS_SIGQUEUE_PROTOTYPE
+int sigqueue(pid_t pid, int sig, const union sigval value);
+#endif
+
 #define FD(e, x, y) (*(int *)xyarray__entry(e->fd, x, y))
 #define SID(e, x, y) xyarray__entry(e->sample_id, x, y)
 
-- 
2.19.2
