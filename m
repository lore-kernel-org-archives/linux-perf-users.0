From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 05/44] perf tools: Add header defining used namespace struct to event.h
Date: Tue,  2 Apr 2019 13:05:10 -0300
Message-ID: <20190402160549.13544-6-acme@kernel.org>
References: <20190402160549.13544-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190402160549.13544-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Hari Bathini <hbathini@linux.vnet.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

When adding the 'struct namespaces_event' to event.h, referencing the
'struct perf_ns_link_info' type, we forgot to add the header where it is
defined, getting that definition only by sheer luck.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Hari Bathini <hbathini@linux.vnet.ibm.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Fixes: f3b3614a284d ("perf tools: Add PERF_RECORD_NAMESPACES to include namespaces related info")
Link: https://lkml.kernel.org/n/tip-qkrld0v7boc9uabjbd8csxux@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/event.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index 36ae7e92dab1..4e908ec1ef64 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -6,6 +6,7 @@
 #include <stdio.h>
 #include <linux/kernel.h>
 #include <linux/bpf.h>
+#include <linux/perf_event.h>
 
 #include "../perf.h"
 #include "build-id.h"
-- 
2.20.1
