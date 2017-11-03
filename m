From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 15/19] tools include uapi: Grab a copy of linux/kcmp.h
Date: Fri,  3 Nov 2017 10:54:59 -0300
Message-ID: <20171103135503.4921-16-acme@kernel.org>
References: <20171103135503.4921-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171103135503.4921-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Andrey Vagin <avagin@openvz.org>, Cyrill Gorcunov <gorcunov@openvz.org>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

We will use it to generate tables for beautifying kcmp's 'type' arg.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andrey Vagin <avagin@openvz.org>
Cc: Cyrill Gorcunov <gorcunov@openvz.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-r35zr79invmpinfe1zu57cas@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/kcmp.h | 27 +++++++++++++++++++++++++++
 tools/perf/check-headers.sh     |  1 +
 2 files changed, 28 insertions(+)
 create mode 100644 tools/include/uapi/linux/kcmp.h

diff --git a/tools/include/uapi/linux/kcmp.h b/tools/include/uapi/linux/kcmp.h
new file mode 100644
index 000000000000..481e103da78e
--- /dev/null
+++ b/tools/include/uapi/linux/kcmp.h
@@ -0,0 +1,27 @@
+#ifndef _UAPI_LINUX_KCMP_H
+#define _UAPI_LINUX_KCMP_H
+
+#include <linux/types.h>
+
+/* Comparison type */
+enum kcmp_type {
+	KCMP_FILE,
+	KCMP_VM,
+	KCMP_FILES,
+	KCMP_FS,
+	KCMP_SIGHAND,
+	KCMP_IO,
+	KCMP_SYSVSEM,
+	KCMP_EPOLL_TFD,
+
+	KCMP_TYPES,
+};
+
+/* Slot for KCMP_EPOLL_TFD */
+struct kcmp_epoll_slot {
+	__u32 efd;		/* epoll file descriptor */
+	__u32 tfd;		/* target file number */
+	__u32 toff;		/* target offset within same numbered sequence */
+};
+
+#endif /* _UAPI_LINUX_KCMP_H */
diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index 8d8b37198666..a3a041b0d35e 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -4,6 +4,7 @@ HEADERS='
 include/uapi/drm/drm.h
 include/uapi/drm/i915_drm.h
 include/uapi/linux/fcntl.h
+include/uapi/linux/kcmp.h
 include/uapi/linux/kvm.h
 include/uapi/linux/perf_event.h
 include/uapi/linux/prctl.h
-- 
2.13.6
