From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 09/37] perf clang: Delete needless util-cxx.h header
Date: Thu, 29 Aug 2019 11:38:49 -0300
Message-ID: <20190829143917.29745-10-acme@kernel.org>
References: <20190829143917.29745-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190829143917.29745-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, He Kuang <hekuang@huawei.com>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

It was put in place just to make sure the 'new' C++ operator wouldn't
clash with some argument name in util.h, but there is not anymore any
such argument and also the reason stated for util.h to be included there
was to get the __maybe_unused definition, that is in linux/compiler.h,
so use that instead and nuke util-cxx.h.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: He Kuang <hekuang@huawei.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-1r5tvfnwiydjxhukgqs6bi11@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/bpf-loader.c       |  1 +
 tools/perf/util/c++/clang-c.h      |  2 +-
 tools/perf/util/c++/clang-test.cpp |  4 +++-
 tools/perf/util/util-cxx.h         | 27 ---------------------------
 4 files changed, 5 insertions(+), 29 deletions(-)
 delete mode 100644 tools/perf/util/util-cxx.h

diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
index e20d7c5e1925..80a828e75cf6 100644
--- a/tools/perf/util/bpf-loader.c
+++ b/tools/perf/util/bpf-loader.c
@@ -23,6 +23,7 @@
 #include "probe-finder.h" // for MAX_PROBES
 #include "parse-events.h"
 #include "strfilter.h"
+#include "util.h"
 #include "llvm-utils.h"
 #include "c++/clang-c.h"
 
diff --git a/tools/perf/util/c++/clang-c.h b/tools/perf/util/c++/clang-c.h
index e513366f2ee0..2df8a45bd088 100644
--- a/tools/perf/util/c++/clang-c.h
+++ b/tools/perf/util/c++/clang-c.h
@@ -3,7 +3,6 @@
 #define PERF_UTIL_CLANG_C_H
 
 #include <stddef.h>	/* for size_t */
-#include <util-cxx.h>	/* for __maybe_unused */
 
 #ifdef __cplusplus
 extern "C" {
@@ -22,6 +21,7 @@ extern int perf_clang__compile_bpf(const char *filename,
 #else
 
 #include <errno.h>
+#include <linux/compiler.h>	/* for __maybe_unused */
 
 static inline void perf_clang__init(void) { }
 static inline void perf_clang__cleanup(void) { }
diff --git a/tools/perf/util/c++/clang-test.cpp b/tools/perf/util/c++/clang-test.cpp
index 7b042a5ebc68..21b23605f78b 100644
--- a/tools/perf/util/c++/clang-test.cpp
+++ b/tools/perf/util/c++/clang-test.cpp
@@ -1,10 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "clang.h"
 #include "clang-c.h"
+extern "C" {
+#include "../util.h"
+}
 #include "llvm/IR/Function.h"
 #include "llvm/IR/LLVMContext.h"
 
-#include <util-cxx.h>
 #include <tests/llvm.h>
 #include <string>
 
diff --git a/tools/perf/util/util-cxx.h b/tools/perf/util/util-cxx.h
deleted file mode 100644
index 80a99e458d4e..000000000000
--- a/tools/perf/util/util-cxx.h
+++ /dev/null
@@ -1,27 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Support C++ source use utilities defined in util.h
- */
-
-#ifndef PERF_UTIL_UTIL_CXX_H
-#define PERF_UTIL_UTIL_CXX_H
-
-#ifdef __cplusplus
-extern "C" {
-#endif
-
-/*
- * Now 'new' is the only C++ keyword found in util.h:
- * in tools/include/linux/rbtree.h
- *
- * Other keywords, like class and delete, should be
- * redefined if necessary.
- */
-#define new _new
-#include "util.h"
-#undef new
-
-#ifdef __cplusplus
-}
-#endif
-#endif
-- 
2.21.0
