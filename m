From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 04/40] perf trace beauty mmap: Ignore 'fd' and 'offset' args for MAP_ANONYMOUS
Date: Wed, 26 Jul 2017 11:16:54 -0300
Message-ID: <20170726141730.30750-5-acme@kernel.org>
References: <20170726141730.30750-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170726141730.30750-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Just suppress them, not used by the kernel.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-atpt07y2x9a8ttlwja94ow3j@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/mmap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/trace/beauty/mmap.c b/tools/perf/trace/beauty/mmap.c
index af1cfde6b97b..754558f9009d 100644
--- a/tools/perf/trace/beauty/mmap.c
+++ b/tools/perf/trace/beauty/mmap.c
@@ -34,6 +34,9 @@ static size_t syscall_arg__scnprintf_mmap_flags(char *bf, size_t size,
 {
 	int printed = 0, flags = arg->val;
 
+	if (flags & MAP_ANONYMOUS)
+		arg->mask |= (1 << 4) | (1 << 5); /* Mask 4th ('fd') and 5th ('offset') args, ignored */
+
 #define	P_MMAP_FLAG(n) \
 	if (flags & MAP_##n) { \
 		printed += scnprintf(bf + printed, size - printed, "%s%s", printed ? "|" : "", #n); \
-- 
2.9.4
