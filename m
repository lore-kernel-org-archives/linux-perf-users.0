From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 04/15] tools headers: Update linux/vdso.h and grab a copy of vdso/const.h
Date: Tue, 14 Apr 2020 13:48:43 -0300
Message-ID: <20200414164854.26026-5-acme@kernel.org>
References: <20200414164854.26026-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200414164854.26026-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To get in line with:

  8165b57bca21 ("linux/const.h: Extract common header for vDSO")

And silence this tools/perf/ build warning:

  Warning: Kernel ABI header at 'tools/include/linux/const.h' differs from latest version at 'include/linux/const.h'
  diff -u tools/include/linux/const.h include/linux/const.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/linux/const.h |  5 +----
 tools/include/vdso/const.h  | 10 ++++++++++
 tools/perf/check-headers.sh |  1 +
 3 files changed, 12 insertions(+), 4 deletions(-)
 create mode 100644 tools/include/vdso/const.h

diff --git a/tools/include/linux/const.h b/tools/include/linux/const.h
index 7b55a55f5911..81b8aae5a855 100644
--- a/tools/include/linux/const.h
+++ b/tools/include/linux/const.h
@@ -1,9 +1,6 @@
 #ifndef _LINUX_CONST_H
 #define _LINUX_CONST_H
 
-#include <uapi/linux/const.h>
-
-#define UL(x)		(_UL(x))
-#define ULL(x)		(_ULL(x))
+#include <vdso/const.h>
 
 #endif /* _LINUX_CONST_H */
diff --git a/tools/include/vdso/const.h b/tools/include/vdso/const.h
new file mode 100644
index 000000000000..94b385ad438d
--- /dev/null
+++ b/tools/include/vdso/const.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __VDSO_CONST_H
+#define __VDSO_CONST_H
+
+#include <uapi/linux/const.h>
+
+#define UL(x)		(_UL(x))
+#define ULL(x)		(_ULL(x))
+
+#endif /* __VDSO_CONST_H */
diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index bfb21d049e6c..c905c683606a 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -23,6 +23,7 @@ include/uapi/linux/vhost.h
 include/uapi/sound/asound.h
 include/linux/bits.h
 include/linux/const.h
+include/vdso/const.h
 include/linux/hash.h
 include/uapi/linux/hw_breakpoint.h
 arch/x86/include/asm/disabled-features.h
-- 
2.21.1
