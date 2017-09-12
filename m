From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 13/41] tools include linux: Guard against redefinition of some macros
Date: Tue, 12 Sep 2017 12:10:01 -0300
Message-ID: <20170912151029.6612-14-acme@kernel.org>
References: <20170912151029.6612-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:50916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751672AbdILPLO (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 12 Sep 2017 11:11:14 -0400
In-Reply-To: <20170912151029.6612-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>

From: Arnaldo Carvalho de Melo <acme@redhat.com>

When cross building to android r15c (and older versions) on Fedora 26
we notice these:

/opt/android-ndk-r15c/platforms/android-24/arch-arm/usr/include/sys/cdefs.h:332:0: note: this is the location of the previous definition

For __aligned, __packed and __noreturn, so guard those with ifdefs to
avoid drowning useful warnings in these.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-d7w3fa9c22dtmrwbedos6ie1@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/linux/compiler-gcc.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/include/linux/compiler-gcc.h b/tools/include/linux/compiler-gcc.h
index bd39b2090ad1..3723b9f8f964 100644
--- a/tools/include/linux/compiler-gcc.h
+++ b/tools/include/linux/compiler-gcc.h
@@ -21,11 +21,14 @@
 #define __must_be_array(a)	BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
 
 #define  noinline	__attribute__((noinline))
-
+#ifndef __packed
 #define __packed	__attribute__((packed))
-
+#endif
+#ifndef __noreturn
 #define __noreturn	__attribute__((noreturn))
-
+#endif
+#ifndef __aligned
 #define __aligned(x)	__attribute__((aligned(x)))
+#endif
 #define __printf(a, b)	__attribute__((format(printf, a, b)))
 #define __scanf(a, b)	__attribute__((format(scanf, a, b)))
-- 
2.13.5
