From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 17/53] perf kvm stat: Replace kvm-stat.h includes with forward declarations
Date: Wed,  6 Feb 2019 15:48:27 -0300
Message-ID: <20190206184903.24054-18-acme@kernel.org>
References: <20190206184903.24054-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190206184903.24054-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To reduce the include header dependency tree and speed up perf builds.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-dngwaxuhfnhksawgdpo6e74n@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/powerpc/util/kvm-stat.c | 1 +
 tools/perf/arch/s390/util/kvm-stat.c    | 1 +
 tools/perf/arch/x86/util/kvm-stat.c     | 1 +
 tools/perf/util/kvm-stat.h              | 7 ++++---
 4 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/perf/arch/powerpc/util/kvm-stat.c b/tools/perf/arch/powerpc/util/kvm-stat.c
index 596ad6aedaac..86e64c47d8ea 100644
--- a/tools/perf/arch/powerpc/util/kvm-stat.c
+++ b/tools/perf/arch/powerpc/util/kvm-stat.c
@@ -3,6 +3,7 @@
 #include "util/kvm-stat.h"
 #include "util/parse-events.h"
 #include "util/debug.h"
+#include "util/evsel.h"
 
 #include "book3s_hv_exits.h"
 #include "book3s_hcalls.h"
diff --git a/tools/perf/arch/s390/util/kvm-stat.c b/tools/perf/arch/s390/util/kvm-stat.c
index aaabab5e2830..7e3961a4b292 100644
--- a/tools/perf/arch/s390/util/kvm-stat.c
+++ b/tools/perf/arch/s390/util/kvm-stat.c
@@ -11,6 +11,7 @@
 
 #include <errno.h>
 #include "../../util/kvm-stat.h"
+#include "../../util/evsel.h"
 #include <asm/sie.h>
 
 define_exit_reasons_table(sie_exit_reasons, sie_intercept_code);
diff --git a/tools/perf/arch/x86/util/kvm-stat.c b/tools/perf/arch/x86/util/kvm-stat.c
index 081353d7b095..865a9762f22e 100644
--- a/tools/perf/arch/x86/util/kvm-stat.c
+++ b/tools/perf/arch/x86/util/kvm-stat.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <errno.h>
 #include "../../util/kvm-stat.h"
+#include "../../util/evsel.h"
 #include <asm/svm.h>
 #include <asm/vmx.h>
 #include <asm/kvm.h>
diff --git a/tools/perf/util/kvm-stat.h b/tools/perf/util/kvm-stat.h
index 7b1f06567521..1403dec189b4 100644
--- a/tools/perf/util/kvm-stat.h
+++ b/tools/perf/util/kvm-stat.h
@@ -3,12 +3,13 @@
 #define __PERF_KVM_STAT_H
 
 #include "../perf.h"
-#include "evsel.h"
-#include "evlist.h"
-#include "session.h"
 #include "tool.h"
 #include "stat.h"
 
+struct perf_evsel;
+struct perf_evlist;
+struct perf_session;
+
 struct event_key {
 	#define INVALID_KEY     (~0ULL)
 	u64 key;
-- 
2.20.1
