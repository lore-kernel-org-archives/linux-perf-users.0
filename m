From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 5/5] perf tools: Fix the build on the alpine:edge distro
Date: Mon, 30 Jul 2018 17:50:31 -0300
Message-ID: <20180730205031.12853-6-acme@kernel.org>
References: <20180730205031.12853-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180730205031.12853-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The UAPI file byteorder/little_endian.h uses the __always_inline define
without including the header where it is defined, linux/stddef.h, this
ends up working in all the other distros because that file gets included
seemingly by luck from one of the files included from little_endian.h.

But not on Alpine:edge, that fails for all files where perf_event.h is
included but linux/stddef.h isn't include before that.

Adding the missing linux/stddef.h file where it breaks on Alpine:edge to
fix that, in all other distros, that is just a very small header anyway.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-9r1pifftxvuxms8l7ir73p5l@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/x86/util/pmu.c | 1 +
 tools/perf/arch/x86/util/tsc.c | 1 +
 tools/perf/perf.h              | 1 +
 tools/perf/util/header.h       | 1 +
 tools/perf/util/namespaces.h   | 1 +
 5 files changed, 5 insertions(+)

diff --git a/tools/perf/arch/x86/util/pmu.c b/tools/perf/arch/x86/util/pmu.c
index 63a74c32ddc5..e33ef5bc31c5 100644
--- a/tools/perf/arch/x86/util/pmu.c
+++ b/tools/perf/arch/x86/util/pmu.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <string.h>
 
+#include <linux/stddef.h>
 #include <linux/perf_event.h>
 
 #include "../../util/intel-pt.h"
diff --git a/tools/perf/arch/x86/util/tsc.c b/tools/perf/arch/x86/util/tsc.c
index 06bae7023a51..950539f9a4f7 100644
--- a/tools/perf/arch/x86/util/tsc.c
+++ b/tools/perf/arch/x86/util/tsc.c
@@ -2,6 +2,7 @@
 #include <stdbool.h>
 #include <errno.h>
 
+#include <linux/stddef.h>
 #include <linux/perf_event.h>
 
 #include "../../perf.h"
diff --git a/tools/perf/perf.h b/tools/perf/perf.h
index a1a97956136f..d215714f48df 100644
--- a/tools/perf/perf.h
+++ b/tools/perf/perf.h
@@ -5,6 +5,7 @@
 #include <time.h>
 #include <stdbool.h>
 #include <linux/types.h>
+#include <linux/stddef.h>
 #include <linux/perf_event.h>
 
 extern bool test_attr__enabled;
diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
index 90d4577a92dc..6d7fe44aadc0 100644
--- a/tools/perf/util/header.h
+++ b/tools/perf/util/header.h
@@ -2,6 +2,7 @@
 #ifndef __PERF_HEADER_H
 #define __PERF_HEADER_H
 
+#include <linux/stddef.h>
 #include <linux/perf_event.h>
 #include <sys/types.h>
 #include <stdbool.h>
diff --git a/tools/perf/util/namespaces.h b/tools/perf/util/namespaces.h
index 760558dcfd18..cae1a9a39722 100644
--- a/tools/perf/util/namespaces.h
+++ b/tools/perf/util/namespaces.h
@@ -10,6 +10,7 @@
 #define __PERF_NAMESPACES_H
 
 #include <sys/types.h>
+#include <linux/stddef.h>
 #include <linux/perf_event.h>
 #include <linux/refcount.h>
 #include <linux/types.h>
-- 
2.14.4
