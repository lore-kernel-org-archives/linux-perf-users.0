From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 29/31] perf kvm: Move kvm-stat header file from conditional inclusion to common include section
Date: Fri, 20 Sep 2019 11:25:40 -0300
Message-ID: <20190920142542.12047-30-acme@kernel.org>
References: <20190920142542.12047-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190920142542.12047-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Peter Zijlstra <peterz@infradead.org>, linuxppc-dev@lists.ozlabs.org, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Anju T Sudhakar <anju@linux.vnet.ibm.com>

Move kvm-stat header file to the common include section, and make the
definitions in the header file under the conditional inclusion `#ifdef
HAVE_KVM_STAT_SUPPORT`.

This helps to define other 'perf kvm' related function prototypes in
kvm-stat header file, which may not need kvm-stat support.

Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
Reviewed-By: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linuxppc-dev@lists.ozlabs.org
Link: http://lore.kernel.org/lkml/20190718181749.30612-1-anju@linux.vnet.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-kvm.c   | 2 +-
 tools/perf/util/kvm-stat.h | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index ac6d6e061dc5..2b822be87673 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -21,6 +21,7 @@
 #include "util/top.h"
 #include "util/data.h"
 #include "util/ordered-events.h"
+#include "util/kvm-stat.h"
 #include "ui/ui.h"
 
 #include <sys/prctl.h>
@@ -59,7 +60,6 @@ static const char *get_filename_for_perf_kvm(void)
 }
 
 #ifdef HAVE_KVM_STAT_SUPPORT
-#include "util/kvm-stat.h"
 
 void exit_event_get_key(struct evsel *evsel,
 			struct perf_sample *sample,
diff --git a/tools/perf/util/kvm-stat.h b/tools/perf/util/kvm-stat.h
index 46913637085b..8fd6ec20662c 100644
--- a/tools/perf/util/kvm-stat.h
+++ b/tools/perf/util/kvm-stat.h
@@ -2,6 +2,8 @@
 #ifndef __PERF_KVM_STAT_H
 #define __PERF_KVM_STAT_H
 
+#ifdef HAVE_KVM_STAT_SUPPORT
+
 #include "tool.h"
 #include "stat.h"
 #include "record.h"
@@ -144,5 +146,6 @@ extern const int decode_str_len;
 extern const char *kvm_exit_reason;
 extern const char *kvm_entry_trace;
 extern const char *kvm_exit_trace;
+#endif /* HAVE_KVM_STAT_SUPPORT */
 
 #endif /* __PERF_KVM_STAT_H */
-- 
2.21.0
