From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 17/86] perf trace beauty open flags: Support O_TMPFILE and O_NOFOLLOW
Date: Wed, 19 Jul 2017 11:28:41 -0300
Message-ID: <20170719142950.3747-18-acme@kernel.org>
References: <20170719142950.3747-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170719142950.3747-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The open syscall flags beautifier wasn't considering those flags, fix
it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-ukzoldh4arrl8x2uwjafd22h@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/open_flags.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/trace/beauty/open_flags.c b/tools/perf/trace/beauty/open_flags.c
index b3c7f1155d80..5fb57bed7ea2 100644
--- a/tools/perf/trace/beauty/open_flags.c
+++ b/tools/perf/trace/beauty/open_flags.c
@@ -14,6 +14,10 @@
 #define O_NOATIME	01000000
 #endif
 
+#ifndef O_TMPFILE
+#define O_TMPFILE	020000000
+#endif
+
 size_t open__scnprintf_flags(unsigned long flags, char *bf, size_t size)
 {
 	int printed = 0;
@@ -34,6 +38,8 @@ size_t open__scnprintf_flags(unsigned long flags, char *bf, size_t size)
 	P_FLAG(DIRECTORY);
 	P_FLAG(EXCL);
 	P_FLAG(LARGEFILE);
+	P_FLAG(NOFOLLOW);
+	P_FLAG(TMPFILE);
 	P_FLAG(NOATIME);
 	P_FLAG(NOCTTY);
 #ifdef O_NONBLOCK
-- 
2.9.4
