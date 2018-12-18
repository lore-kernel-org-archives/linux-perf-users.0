From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 59/63] tools headers uapi: Grab a copy of fadvise.h
Date: Tue, 18 Dec 2018 19:07:29 -0300
Message-ID: <20181218220733.15839-60-acme@kernel.org>
References: <20181218220733.15839-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181218220733.15839-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>, =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= <lclaudio@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Will be used to generate the string table for fadvise64's 'advice'
argument.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-muswpnft8q9krktv052yrgsc@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/fadvise.h | 22 ++++++++++++++++++++++
 tools/perf/check-headers.sh        |  1 +
 2 files changed, 23 insertions(+)
 create mode 100644 tools/include/uapi/linux/fadvise.h

diff --git a/tools/include/uapi/linux/fadvise.h b/tools/include/uapi/linux/fadvise.h
new file mode 100644
index 000000000000..0862b87434c2
--- /dev/null
+++ b/tools/include/uapi/linux/fadvise.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef FADVISE_H_INCLUDED
+#define FADVISE_H_INCLUDED
+
+#define POSIX_FADV_NORMAL	0 /* No further special treatment.  */
+#define POSIX_FADV_RANDOM	1 /* Expect random page references.  */
+#define POSIX_FADV_SEQUENTIAL	2 /* Expect sequential page references.  */
+#define POSIX_FADV_WILLNEED	3 /* Will need these pages.  */
+
+/*
+ * The advise values for POSIX_FADV_DONTNEED and POSIX_ADV_NOREUSE
+ * for s390-64 differ from the values for the rest of the world.
+ */
+#if defined(__s390x__)
+#define POSIX_FADV_DONTNEED	6 /* Don't need these pages.  */
+#define POSIX_FADV_NOREUSE	7 /* Data will be accessed once.  */
+#else
+#define POSIX_FADV_DONTNEED	4 /* Don't need these pages.  */
+#define POSIX_FADV_NOREUSE	5 /* Data will be accessed once.  */
+#endif
+
+#endif	/* FADVISE_H_INCLUDED */
diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index 10d97dc632da..8e811ea0cf85 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -4,6 +4,7 @@
 HEADERS='
 include/uapi/drm/drm.h
 include/uapi/drm/i915_drm.h
+include/uapi/linux/fadvise.h
 include/uapi/linux/fcntl.h
 include/uapi/linux/fs.h
 include/uapi/linux/kcmp.h
-- 
2.19.2
