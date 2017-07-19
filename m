From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 20/86] perf trace beauty open flags: Move RDRW to the start of the output
Date: Wed, 19 Jul 2017 11:28:44 -0300
Message-ID: <20170719142950.3747-21-acme@kernel.org>
References: <20170719142950.3747-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170719142950.3747-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

We were getting:

 62597.859 ( 0.005 ms): TaskSchedulerF/18107 fcntl(fd: 194, cmd: GETFL) = LARGEFILE|RDWR

Instead of the more familiar (from looking at strace output):

 62597.859 ( 0.005 ms): TaskSchedulerF/18107 fcntl(fd: 194, cmd: GETFL) = RDWR|LARGEFILE

Fix it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-d4d9nd88t4bu9y9odbrcb5z6@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/open_flags.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/trace/beauty/open_flags.c b/tools/perf/trace/beauty/open_flags.c
index e520112fdb6e..3c20683d8cfb 100644
--- a/tools/perf/trace/beauty/open_flags.c
+++ b/tools/perf/trace/beauty/open_flags.c
@@ -33,6 +33,7 @@ size_t open__scnprintf_flags(unsigned long flags, char *bf, size_t size)
 		flags &= ~O_##n; \
 	}
 
+	P_FLAG(RDWR);
 	P_FLAG(APPEND);
 	P_FLAG(ASYNC);
 	P_FLAG(CLOEXEC);
@@ -53,7 +54,6 @@ size_t open__scnprintf_flags(unsigned long flags, char *bf, size_t size)
 #ifdef O_PATH
 	P_FLAG(PATH);
 #endif
-	P_FLAG(RDWR);
 #ifdef O_DSYNC
 	if ((flags & O_SYNC) == O_SYNC)
 		printed += scnprintf(bf + printed, size - printed, "%s%s", printed ? "|" : "", "SYNC");
-- 
2.9.4
