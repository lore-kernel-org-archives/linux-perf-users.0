From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 03/17] tools headers: Grab copy of linux/const.h, needed by linux/bits.h
Date: Tue, 20 Aug 2019 16:27:19 -0300
Message-ID: <20190820192733.19180-4-acme@kernel.org>
References: <20190820192733.19180-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190820192733.19180-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

So that can update the copy of linux/bits.h that now uses macros defined
in const.h and that are not available in older systems.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-c2qfcbl58hxyfb5u5xivp7is@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/linux/const.h      |  9 +++++++++
 tools/include/uapi/linux/const.h | 31 +++++++++++++++++++++++++++++++
 tools/perf/check-headers.sh      |  2 ++
 3 files changed, 42 insertions(+)
 create mode 100644 tools/include/linux/const.h
 create mode 100644 tools/include/uapi/linux/const.h

diff --git a/tools/include/linux/const.h b/tools/include/linux/const.h
new file mode 100644
index 000000000000..7b55a55f5911
--- /dev/null
+++ b/tools/include/linux/const.h
@@ -0,0 +1,9 @@
+#ifndef _LINUX_CONST_H
+#define _LINUX_CONST_H
+
+#include <uapi/linux/const.h>
+
+#define UL(x)		(_UL(x))
+#define ULL(x)		(_ULL(x))
+
+#endif /* _LINUX_CONST_H */
diff --git a/tools/include/uapi/linux/const.h b/tools/include/uapi/linux/const.h
new file mode 100644
index 000000000000..5ed721ad5b19
--- /dev/null
+++ b/tools/include/uapi/linux/const.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/* const.h: Macros for dealing with constants.  */
+
+#ifndef _UAPI_LINUX_CONST_H
+#define _UAPI_LINUX_CONST_H
+
+/* Some constant macros are used in both assembler and
+ * C code.  Therefore we cannot annotate them always with
+ * 'UL' and other type specifiers unilaterally.  We
+ * use the following macros to deal with this.
+ *
+ * Similarly, _AT() will cast an expression with a type in C, but
+ * leave it unchanged in asm.
+ */
+
+#ifdef __ASSEMBLY__
+#define _AC(X,Y)	X
+#define _AT(T,X)	X
+#else
+#define __AC(X,Y)	(X##Y)
+#define _AC(X,Y)	__AC(X,Y)
+#define _AT(T,X)	((T)(X))
+#endif
+
+#define _UL(x)		(_AC(x, UL))
+#define _ULL(x)		(_AC(x, ULL))
+
+#define _BITUL(x)	(_UL(1) << (x))
+#define _BITULL(x)	(_ULL(1) << (x))
+
+#endif /* _UAPI_LINUX_CONST_H */
diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index f211c015cb76..5308b3836278 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -2,6 +2,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 HEADERS='
+include/uapi/linux/const.h
 include/uapi/drm/drm.h
 include/uapi/drm/i915_drm.h
 include/uapi/linux/fadvise.h
@@ -19,6 +20,7 @@ include/uapi/linux/usbdevice_fs.h
 include/uapi/linux/vhost.h
 include/uapi/sound/asound.h
 include/linux/bits.h
+include/linux/const.h
 include/linux/hash.h
 include/uapi/linux/hw_breakpoint.h
 arch/x86/include/asm/disabled-features.h
-- 
2.21.0
