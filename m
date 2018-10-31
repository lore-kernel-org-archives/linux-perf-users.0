From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 20/28] perf trace beauty: Use the mmap flags table generated from headers
Date: Wed, 31 Oct 2018 13:45:00 -0300
Message-ID: <20181031164508.4784-21-acme@kernel.org>
References: <20181031164508.4784-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181031164508.4784-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Instead of requiring us to go on and edit sources to add new flag.

  # perf trace -e *mmap sleep 0.1
     0.025 ( 0.005 ms): sleep/29876 mmap(len: 163746, prot: READ, flags: PRIVATE, fd: 3) = 0x7faa68ad1000
     0.059 ( 0.004 ms): sleep/29876 mmap(len: 8192, prot: READ|WRITE, flags: PRIVATE|ANONYMOUS) = 0x7faa68acf000
     0.069 ( 0.006 ms): sleep/29876 mmap(len: 3889792, prot: EXEC|READ, flags: PRIVATE|DENYWRITE, fd: 3) = 0x7faa6851f000
     0.086 ( 0.009 ms): sleep/29876 mmap(addr: 0x7faa688cb000, len: 24576, prot: READ|WRITE, flags: PRIVATE|FIXED|DENYWRITE, fd: 3, off: 1753088) = 0x7faa688cb000
     0.101 ( 0.005 ms): sleep/29876 mmap(addr: 0x7faa688d1000, len: 14976, prot: READ|WRITE, flags: PRIVATE|FIXED|ANONYMOUS) = 0x7faa688d1000
     0.348 ( 0.005 ms): sleep/29876 mmap(len: 111950656, prot: READ, flags: PRIVATE, fd: 3) = 0x7faa61a5b000
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-ggmoy6vxoygh5yim890ht0kf@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/mmap.c | 48 ++++++++++--------------------------------
 1 file changed, 11 insertions(+), 37 deletions(-)

diff --git a/tools/perf/trace/beauty/mmap.c b/tools/perf/trace/beauty/mmap.c
index 0605593552c6..c534bd96ef5c 100644
--- a/tools/perf/trace/beauty/mmap.c
+++ b/tools/perf/trace/beauty/mmap.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: LGPL-2.1
 #include <uapi/linux/mman.h>
+#include <linux/log2.h>
 
 static size_t syscall_arg__scnprintf_mmap_prot(char *bf, size_t size,
 					       struct syscall_arg *arg)
@@ -30,50 +31,23 @@ static size_t syscall_arg__scnprintf_mmap_prot(char *bf, size_t size,
 
 #define SCA_MMAP_PROT syscall_arg__scnprintf_mmap_prot
 
+static size_t mmap__scnprintf_flags(unsigned long flags, char *bf, size_t size)
+{
+#include "trace/beauty/generated/mmap_flags_array.c"
+       static DEFINE_STRARRAY(mmap_flags);
+
+       return strarray__scnprintf_flags(&strarray__mmap_flags, bf, size, flags);
+}
+
 static size_t syscall_arg__scnprintf_mmap_flags(char *bf, size_t size,
 						struct syscall_arg *arg)
 {
-	int printed = 0, flags = arg->val;
+	unsigned long flags = arg->val;
 
 	if (flags & MAP_ANONYMOUS)
 		arg->mask |= (1 << 4) | (1 << 5); /* Mask 4th ('fd') and 5th ('offset') args, ignored */
 
-#define	P_MMAP_FLAG(n) \
-	if (flags & MAP_##n) { \
-		printed += scnprintf(bf + printed, size - printed, "%s%s", printed ? "|" : "", #n); \
-		flags &= ~MAP_##n; \
-	}
-
-	P_MMAP_FLAG(SHARED);
-	P_MMAP_FLAG(PRIVATE);
-#ifdef MAP_32BIT
-	P_MMAP_FLAG(32BIT);
-#endif
-	P_MMAP_FLAG(ANONYMOUS);
-	P_MMAP_FLAG(DENYWRITE);
-	P_MMAP_FLAG(EXECUTABLE);
-	P_MMAP_FLAG(FILE);
-	P_MMAP_FLAG(FIXED);
-#ifdef MAP_FIXED_NOREPLACE
-	P_MMAP_FLAG(FIXED_NOREPLACE);
-#endif
-	P_MMAP_FLAG(GROWSDOWN);
-	P_MMAP_FLAG(HUGETLB);
-	P_MMAP_FLAG(LOCKED);
-	P_MMAP_FLAG(NONBLOCK);
-	P_MMAP_FLAG(NORESERVE);
-	P_MMAP_FLAG(POPULATE);
-	P_MMAP_FLAG(STACK);
-	P_MMAP_FLAG(UNINITIALIZED);
-#ifdef MAP_SYNC
-	P_MMAP_FLAG(SYNC);
-#endif
-#undef P_MMAP_FLAG
-
-	if (flags)
-		printed += scnprintf(bf + printed, size - printed, "%s%#x", printed ? "|" : "", flags);
-
-	return printed;
+	return mmap__scnprintf_flags(flags, bf, size);
 }
 
 #define SCA_MMAP_FLAGS syscall_arg__scnprintf_mmap_flags
-- 
2.14.4
