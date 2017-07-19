From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 18/86] perf trace beauty open flags: Do not depend on the system's O_LARGEFILE define
Date: Wed, 19 Jul 2017 11:28:42 -0300
Message-ID: <20170719142950.3747-19-acme@kernel.org>
References: <20170719142950.3747-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170719142950.3747-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

In x86_64 /usr/include/bits/fcntl.h sets it to zero, so just undef it
and use the standard 00100000 value when decoding the open flags arg.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-k28megguz5snwop9obvn9mcr@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/open_flags.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/trace/beauty/open_flags.c b/tools/perf/trace/beauty/open_flags.c
index 5fb57bed7ea2..e520112fdb6e 100644
--- a/tools/perf/trace/beauty/open_flags.c
+++ b/tools/perf/trace/beauty/open_flags.c
@@ -18,6 +18,9 @@
 #define O_TMPFILE	020000000
 #endif
 
+#undef O_LARGEFILE
+#define O_LARGEFILE	00100000
+
 size_t open__scnprintf_flags(unsigned long flags, char *bf, size_t size)
 {
 	int printed = 0;
-- 
2.9.4
