From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 29/30] tools headers: Syncronize mman.h ABI header
Date: Tue, 28 Nov 2017 12:02:19 -0300
Message-ID: <20171128150220.5064-30-acme@kernel.org>
References: <20171128150220.5064-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:45796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753782AbdK1PDy (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 28 Nov 2017 10:03:54 -0500
In-Reply-To: <20171128150220.5064-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Dan Williams <dan.j.williams@intel.com>, David Ahern <dsahern@gmail.com>, Jan Kara <jack@suse.cz>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To add support for the MAP_SYNC flag introduced in:

  b6fb293f2497 ("mm: Define MAP_SYNC and VM_SYNC flags")

Update tools/perf/trace/beauty/mmap.c to support that flag.

This silences this perf build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/asm-generic/mman.h' differs from latest version at 'include/uapi/asm-generic/mman.h'

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jan Kara <jack@suse.cz>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-14zyk3iywrj37c7g1eagmzbo@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/asm-generic/mman.h | 1 +
 tools/perf/trace/beauty/mmap.c        | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/tools/include/uapi/asm-generic/mman.h b/tools/include/uapi/asm-generic/mman.h
index 2dffcbf705b3..653687d9771b 100644
--- a/tools/include/uapi/asm-generic/mman.h
+++ b/tools/include/uapi/asm-generic/mman.h
@@ -13,6 +13,7 @@
 #define MAP_NONBLOCK	0x10000		/* do not block on IO */
 #define MAP_STACK	0x20000		/* give out an address that is best suited for process/thread stacks */
 #define MAP_HUGETLB	0x40000		/* create a huge page mapping */
+#define MAP_SYNC	0x80000		/* perform synchronous page faults for the mapping */
 
 /* Bits [26:31] are reserved, see mman-common.h for MAP_HUGETLB usage */
 
diff --git a/tools/perf/trace/beauty/mmap.c b/tools/perf/trace/beauty/mmap.c
index 9e1668b2c5d7..417e3ecfe9d7 100644
--- a/tools/perf/trace/beauty/mmap.c
+++ b/tools/perf/trace/beauty/mmap.c
@@ -62,6 +62,9 @@ static size_t syscall_arg__scnprintf_mmap_flags(char *bf, size_t size,
 	P_MMAP_FLAG(POPULATE);
 	P_MMAP_FLAG(STACK);
 	P_MMAP_FLAG(UNINITIALIZED);
+#ifdef MAP_SYNC
+	P_MMAP_FLAG(SYNC);
+#endif
 #undef P_MMAP_FLAG
 
 	if (flags)
-- 
2.13.6
