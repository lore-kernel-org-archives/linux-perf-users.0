Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD57E1D1500
	for <linux-perf-users@vger.kernel.org>; Tue,  5 Nov 2024 10:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730804254; cv=none; b=kCGvBcT9Hza5w0gEUFMXji54oxQfNuttX0r6aL9ZIggPu7t7FKfMW+DAycoEHBHrO27VEVFJu+XxtBYpqEpBUTFnhD5Fz8rKUTvHogV4psVi1dpWqNVtzRLzhceNz0gNPfskG3p2DlyAu/JSVQSSVA+hYY7pOauJgt+1cDknIH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730804254; c=relaxed/simple;
	bh=mzSR0TwCzM/8T+2pVaFCsHhUiSSdgtB+rE1izpwyx/U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TbvTB8T6ALKgjGed7Q6Fi9PvOe3OUTqtos5bXlGmSBiOHxylNMPkib+xRFJCZQs660uVdcxd+IVgWMRp9qQ9p0iwA5dtt4CYjVVAPlcNgHJSJwezA05T7ASjv9lVskAYN93mL63yxUEXXiw0EOY92IVV5H0LKr86G52XshRVJao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XjQH14Plxz1jwYn;
	Tue,  5 Nov 2024 18:55:41 +0800 (CST)
Received: from kwepemd200014.china.huawei.com (unknown [7.221.188.8])
	by mail.maildlp.com (Postfix) with ESMTPS id 37BA11402E2;
	Tue,  5 Nov 2024 18:57:21 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemd200014.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 5 Nov 2024 18:57:20 +0800
From: Yicong Yang <yangyicong@huawei.com>
To: <acme@kernel.org>, <namhyung@kernel.org>, <peterz@infradead.org>,
	<mingo@redhat.com>, <leo.yan@arm.com>, <amadio@gentoo.org>,
	<linux-perf-users@vger.kernel.org>
CC: <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <irogers@google.com>, <linuxarm@huawei.com>,
	<yangyicong@hisilicon.com>
Subject: [PATCH] perf build: Include libtraceevent headers directly indicated by pkg-config
Date: Tue, 5 Nov 2024 18:56:49 +0800
Message-ID: <20241105105649.45399-1-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemd200014.china.huawei.com (7.221.188.8)

From: Yicong Yang <yangyicong@hisilicon.com>

Currently the libtraceevent's found by pkg-config, which give the
include path as:
[root@localhost tmp]# pkg-config --cflags libtraceevent
-I/usr/local/include/traceevent

So we should include the libtraceevent headers directly without
"traceevent/" prefix. Update all the users.

Fixes: 0f0e1f445690 ("perf build: Use pkg-config for feature check for libtrace{event,fs}")
Suggested-by: Namhyung Kim <namhyung@kernel.org>
[https://lore.kernel.org/linux-perf-users/ZyF5_Hf1iL01kldE@google.com/]
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 tools/build/feature/test-libtraceevent.c               | 2 +-
 tools/perf/builtin-kmem.c                              | 2 +-
 tools/perf/builtin-kwork.c                             | 2 +-
 tools/perf/builtin-report.c                            | 2 +-
 tools/perf/builtin-script.c                            | 2 +-
 tools/perf/builtin-timechart.c                         | 2 +-
 tools/perf/builtin-trace.c                             | 2 +-
 tools/perf/tests/evsel-tp-sched.c                      | 2 +-
 tools/perf/util/data-convert-bt.c                      | 2 +-
 tools/perf/util/data-convert-json.c                    | 2 +-
 tools/perf/util/debug.c                                | 2 +-
 tools/perf/util/evsel.c                                | 2 +-
 tools/perf/util/evsel_fprintf.c                        | 2 +-
 tools/perf/util/header.c                               | 2 +-
 tools/perf/util/python.c                               | 2 +-
 tools/perf/util/scripting-engines/trace-event-perl.c   | 2 +-
 tools/perf/util/scripting-engines/trace-event-python.c | 2 +-
 tools/perf/util/sort.c                                 | 2 +-
 tools/perf/util/trace-event-parse.c                    | 2 +-
 tools/perf/util/trace-event-read.c                     | 2 +-
 tools/perf/util/trace-event-scripting.c                | 2 +-
 tools/perf/util/trace-event.c                          | 2 +-
 tools/perf/util/trace-event.h                          | 2 +-
 23 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/tools/build/feature/test-libtraceevent.c b/tools/build/feature/test-libtraceevent.c
index 416b11ffd4b4..804ad80dbbd9 100644
--- a/tools/build/feature/test-libtraceevent.c
+++ b/tools/build/feature/test-libtraceevent.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <traceevent/trace-seq.h>
+#include <trace-seq.h>
 
 int main(void)
 {
diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
index a756147e2eec..4d8d94146f8d 100644
--- a/tools/perf/builtin-kmem.c
+++ b/tools/perf/builtin-kmem.c
@@ -36,7 +36,7 @@
 #include <regex.h>
 
 #include <linux/ctype.h>
-#include <traceevent/event-parse.h>
+#include <event-parse.h>
 
 static int	kmem_slab;
 static int	kmem_page;
diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
index c1daf82c9b92..8234410cba4c 100644
--- a/tools/perf/builtin-kwork.c
+++ b/tools/perf/builtin-kwork.c
@@ -23,7 +23,7 @@
 
 #include <subcmd/pager.h>
 #include <subcmd/parse-options.h>
-#include <traceevent/event-parse.h>
+#include <event-parse.h>
 
 #include <errno.h>
 #include <inttypes.h>
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 5dc17ffee27a..cc354adb07bc 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -70,7 +70,7 @@
 #include <linux/mman.h>
 
 #ifdef HAVE_LIBTRACEEVENT
-#include <traceevent/event-parse.h>
+#include <event-parse.h>
 #endif
 
 struct report {
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index a644787fa9e1..a7917ec630c2 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -67,7 +67,7 @@
 
 #include <linux/ctype.h>
 #ifdef HAVE_LIBTRACEEVENT
-#include <traceevent/event-parse.h>
+#include <event-parse.h>
 #endif
 
 static char const		*script_name;
diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechart.c
index 218c8b44d7be..9b50076449bd 100644
--- a/tools/perf/builtin-timechart.c
+++ b/tools/perf/builtin-timechart.c
@@ -38,7 +38,7 @@
 #include "util/tracepoint.h"
 #include "util/util.h"
 #include <linux/err.h>
-#include <traceevent/event-parse.h>
+#include <event-parse.h>
 
 #ifdef LACKS_OPEN_MEMSTREAM_PROTOTYPE
 FILE *open_memstream(char **ptr, size_t *sizeloc);
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index f6e847529073..ccc6e1d35cd7 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -88,7 +88,7 @@
 #include <perf/mmap.h>
 
 #ifdef HAVE_LIBTRACEEVENT
-#include <traceevent/event-parse.h>
+#include <event-parse.h>
 #endif
 
 #ifndef O_CLOEXEC
diff --git a/tools/perf/tests/evsel-tp-sched.c b/tools/perf/tests/evsel-tp-sched.c
index cf4da3d748c2..2fa6b133af93 100644
--- a/tools/perf/tests/evsel-tp-sched.c
+++ b/tools/perf/tests/evsel-tp-sched.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/err.h>
-#include <traceevent/event-parse.h>
+#include <event-parse.h>
 #include "evsel.h"
 #include "tests.h"
 #include "debug.h"
diff --git a/tools/perf/util/data-convert-bt.c b/tools/perf/util/data-convert-bt.c
index 021e9b1d5cc5..f0599c61fab4 100644
--- a/tools/perf/util/data-convert-bt.c
+++ b/tools/perf/util/data-convert-bt.c
@@ -36,7 +36,7 @@
 #include "util/sample.h"
 
 #ifdef HAVE_LIBTRACEEVENT
-#include <traceevent/event-parse.h>
+#include <event-parse.h>
 #endif
 
 #define pr_N(n, fmt, ...) \
diff --git a/tools/perf/util/data-convert-json.c b/tools/perf/util/data-convert-json.c
index 20bfb0884e9e..8304cd2d4a9c 100644
--- a/tools/perf/util/data-convert-json.c
+++ b/tools/perf/util/data-convert-json.c
@@ -28,7 +28,7 @@
 #include "util/tool.h"
 
 #ifdef HAVE_LIBTRACEEVENT
-#include <traceevent/event-parse.h>
+#include <event-parse.h>
 #endif
 
 struct convert_json {
diff --git a/tools/perf/util/debug.c b/tools/perf/util/debug.c
index d633d15329fa..995f6bb05b5f 100644
--- a/tools/perf/util/debug.c
+++ b/tools/perf/util/debug.c
@@ -27,7 +27,7 @@
 #include <linux/ctype.h>
 
 #ifdef HAVE_LIBTRACEEVENT
-#include <traceevent/event-parse.h>
+#include <event-parse.h>
 #else
 #define LIBTRACEEVENT_VERSION 0
 #endif
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index dbf9c8cee3c5..5d75a78e16fc 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -64,7 +64,7 @@
 #include <linux/ctype.h>
 
 #ifdef HAVE_LIBTRACEEVENT
-#include <traceevent/event-parse.h>
+#include <event-parse.h>
 #endif
 
 struct perf_missing_features perf_missing_features;
diff --git a/tools/perf/util/evsel_fprintf.c b/tools/perf/util/evsel_fprintf.c
index c2c0500d5da9..86b7f46f9e2a 100644
--- a/tools/perf/util/evsel_fprintf.c
+++ b/tools/perf/util/evsel_fprintf.c
@@ -14,7 +14,7 @@
 #include "dso.h"
 
 #ifdef HAVE_LIBTRACEEVENT
-#include <traceevent/event-parse.h>
+#include <event-parse.h>
 #endif
 
 static int comma_fprintf(FILE *fp, bool *first, const char *fmt, ...)
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index a6386d12afd7..fca27b316faf 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -58,7 +58,7 @@
 #include <internal/lib.h>
 
 #ifdef HAVE_LIBTRACEEVENT
-#include <traceevent/event-parse.h>
+#include <event-parse.h>
 #endif
 
 /*
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 31a223eaf8e6..82e0c0382058 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -6,7 +6,7 @@
 #include <linux/err.h>
 #include <perf/cpumap.h>
 #ifdef HAVE_LIBTRACEEVENT
-#include <traceevent/event-parse.h>
+#include <event-parse.h>
 #endif
 #include <perf/mmap.h>
 #include "evlist.h"
diff --git a/tools/perf/util/scripting-engines/trace-event-perl.c b/tools/perf/util/scripting-engines/trace-event-perl.c
index e16257d5ab2c..85b7f188f729 100644
--- a/tools/perf/util/scripting-engines/trace-event-perl.c
+++ b/tools/perf/util/scripting-engines/trace-event-perl.c
@@ -27,7 +27,7 @@
 #include <errno.h>
 #include <linux/bitmap.h>
 #include <linux/time64.h>
-#include <traceevent/event-parse.h>
+#include <event-parse.h>
 
 #include <stdbool.h>
 /* perl needs the following define, right after including stdbool.h */
diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index d7183134b669..0ed0c12cbacd 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -31,7 +31,7 @@
 #include <linux/compiler.h>
 #include <linux/time64.h>
 #ifdef HAVE_LIBTRACEEVENT
-#include <traceevent/event-parse.h>
+#include <event-parse.h>
 #endif
 
 #include "../build-id.h"
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 013020f33ece..27b8ae43769f 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -35,7 +35,7 @@
 #include <linux/string.h>
 
 #ifdef HAVE_LIBTRACEEVENT
-#include <traceevent/event-parse.h>
+#include <event-parse.h>
 #endif
 
 regex_t		parent_regex;
diff --git a/tools/perf/util/trace-event-parse.c b/tools/perf/util/trace-event-parse.c
index f0332bd3a501..9bdad10d00d4 100644
--- a/tools/perf/util/trace-event-parse.c
+++ b/tools/perf/util/trace-event-parse.c
@@ -12,7 +12,7 @@
 
 #include <linux/ctype.h>
 #include <linux/kernel.h>
-#include <traceevent/event-parse.h>
+#include <event-parse.h>
 
 static int get_common_field(struct scripting_context *context,
 			    int *offset, int *size, const char *type)
diff --git a/tools/perf/util/trace-event-read.c b/tools/perf/util/trace-event-read.c
index 1162c49b8082..ecbbb93f0185 100644
--- a/tools/perf/util/trace-event-read.c
+++ b/tools/perf/util/trace-event-read.c
@@ -11,7 +11,7 @@
 #include <sys/stat.h>
 #include <sys/wait.h>
 #include <sys/mman.h>
-#include <traceevent/event-parse.h>
+#include <event-parse.h>
 #include <fcntl.h>
 #include <unistd.h>
 #include <errno.h>
diff --git a/tools/perf/util/trace-event-scripting.c b/tools/perf/util/trace-event-scripting.c
index bd0000300c77..5596fcda2c10 100644
--- a/tools/perf/util/trace-event-scripting.c
+++ b/tools/perf/util/trace-event-scripting.c
@@ -10,7 +10,7 @@
 #include <string.h>
 #include <errno.h>
 #ifdef HAVE_LIBTRACEEVENT
-#include <traceevent/event-parse.h>
+#include <event-parse.h>
 #endif
 
 #include "debug.h"
diff --git a/tools/perf/util/trace-event.c b/tools/perf/util/trace-event.c
index 8ad75b31e09b..6a8c66c64b70 100644
--- a/tools/perf/util/trace-event.c
+++ b/tools/perf/util/trace-event.c
@@ -8,7 +8,7 @@
 #include <fcntl.h>
 #include <linux/kernel.h>
 #include <linux/err.h>
-#include <traceevent/event-parse.h>
+#include <event-parse.h>
 #include <api/fs/tracing_path.h>
 #include <api/fs/fs.h>
 #include "trace-event.h"
diff --git a/tools/perf/util/trace-event.h b/tools/perf/util/trace-event.h
index bbf8b26bc8da..c9fcd4d0b1fc 100644
--- a/tools/perf/util/trace-event.h
+++ b/tools/perf/util/trace-event.h
@@ -150,7 +150,7 @@ int common_lock_depth(struct scripting_context *context);
 int perf_sample__sprintf_flags(u32 flags, char *str, size_t sz);
 
 #if defined(LIBTRACEEVENT_VERSION) &&  LIBTRACEEVENT_VERSION >= MAKE_LIBTRACEEVENT_VERSION(1, 5, 0)
-#include <traceevent/event-parse.h>
+#include <event-parse.h>
 
 static inline bool tep_field_is_relative(unsigned long flags)
 {
-- 
2.24.0

