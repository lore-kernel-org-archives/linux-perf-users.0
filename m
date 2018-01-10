From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 04/27] perf tools: Fix compile error with libunwind x86
Date: Wed, 10 Jan 2018 18:28:21 -0300
Message-ID: <20180110212844.12441-5-acme@kernel.org>
References: <20180110212844.12441-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180110212844.12441-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Wang Nan <wangnan0@huawei.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Wang Nan <wangnan0@huawei.com>

Fix a compile error:

 ...
   CC       util/libunwind/x86_32.o
 In file included from util/libunwind/x86_32.c:33:0:
 util/libunwind/../../arch/x86/util/unwind-libunwind.c: In function 'libunwind__x86_reg_id':
 util/libunwind/../../arch/x86/util/unwind-libunwind.c:110:11: error: 'EINVAL' undeclared (first use in this function)
    return -EINVAL;
            ^
 util/libunwind/../../arch/x86/util/unwind-libunwind.c:110:11: note: each undeclared identifier is reported only once for each function it appears in
 mv: cannot stat 'util/libunwind/.x86_32.o.tmp': No such file or directory
 make[4]: *** [util/libunwind/x86_32.o] Error 1
 make[3]: *** [util] Error 2
 make[2]: *** [libperf-in.o] Error 2
 make[1]: *** [sub-make] Error 2
 make: *** [all] Error 2

It happens when libunwind-x86 feature is detected.

Signed-off-by: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/r/20171206015040.114574-1-wangnan0@huawei.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/x86/util/unwind-libunwind.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/arch/x86/util/unwind-libunwind.c b/tools/perf/arch/x86/util/unwind-libunwind.c
index 9c917f80c906..05920e3edf7a 100644
--- a/tools/perf/arch/x86/util/unwind-libunwind.c
+++ b/tools/perf/arch/x86/util/unwind-libunwind.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
-#ifndef REMOTE_UNWIND_LIBUNWIND
 #include <errno.h>
+#ifndef REMOTE_UNWIND_LIBUNWIND
 #include <libunwind.h>
 #include "perf_regs.h"
 #include "../../util/unwind.h"
-- 
2.14.3
