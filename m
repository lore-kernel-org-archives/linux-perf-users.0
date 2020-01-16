From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 02/12] tools build: Fix test-clang.cpp with Clang 8+
Date: Thu, 16 Jan 2020 10:48:04 -0300
Message-ID: <20200116134814.8811-3-acme@kernel.org>
References: <20200116134814.8811-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200116134814.8811-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Denis Pronin <dannftk@yandex.ru>, Dennis Schridde <devurandom@gmx.net>, Jiri Olsa <jolsa@redhat.com>, Mark Rutland <mark.rutland@arm.com>, Naohiro Aota <naota@elisp.net>, Peter Zijlstra <peterz@infradead.org>, clang-built-linux@googlegroups.com, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>

LLVM rL344140 (included in Clang 8+) moved VFS from Clang to LLVM, so
paths to its include files have changed.

This broke the Clang test in tools/build - let's fix it.

Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Denis Pronin <dannftk@yandex.ru>
Cc: Dennis Schridde <devurandom@gmx.net>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Naohiro Aota <naota@elisp.net>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: clang-built-linux@googlegroups.com
Link: http://lore.kernel.org/lkml/20191228171314.946469-1-mail@maciej.szmigiero.name
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/build/feature/test-clang.cpp | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/build/feature/test-clang.cpp b/tools/build/feature/test-clang.cpp
index a2b3f092d2f0..7d87075cd1c5 100644
--- a/tools/build/feature/test-clang.cpp
+++ b/tools/build/feature/test-clang.cpp
@@ -1,9 +1,15 @@
 // SPDX-License-Identifier: GPL-2.0
+#include "clang/Basic/Version.h"
+#if CLANG_VERSION_MAJOR < 8
 #include "clang/Basic/VirtualFileSystem.h"
+#endif
 #include "clang/Driver/Driver.h"
 #include "clang/Frontend/TextDiagnosticPrinter.h"
 #include "llvm/ADT/IntrusiveRefCntPtr.h"
 #include "llvm/Support/ManagedStatic.h"
+#if CLANG_VERSION_MAJOR >= 8
+#include "llvm/Support/VirtualFileSystem.h"
+#endif
 #include "llvm/Support/raw_ostream.h"
 
 using namespace clang;
-- 
2.21.1
