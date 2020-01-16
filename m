From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 01/12] perf clang: Fix build with Clang 9
Date: Thu, 16 Jan 2020 10:48:03 -0300
Message-ID: <20200116134814.8811-2-acme@kernel.org>
References: <20200116134814.8811-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200116134814.8811-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>, Dennis Schridde <devurandom@gmx.net>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, clang-built-linux@googlegroups.com, Denis Pronin <dannftk@yandex.ru>, Jiri Olsa <jolsa@redhat.com>, Mark Rutland <mark.rutland@arm.com>, Naohiro Aota <naota@elisp.net>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>

LLVM D59377 (included in Clang 9) refactored Clang VFS construction a
bit, which broke perf clang build.  Let's fix it.

Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Reviewed-by: Dennis Schridde <devurandom@gmx.net>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: clang-built-linux@googlegroups.com
Cc: Denis Pronin <dannftk@yandex.ru>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Naohiro Aota <naota@elisp.net>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20191228171314.946469-2-mail@maciej.szmigiero.name
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/c++/clang.cpp | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/util/c++/clang.cpp b/tools/perf/util/c++/clang.cpp
index fc361c3f8570..c8885dfa3667 100644
--- a/tools/perf/util/c++/clang.cpp
+++ b/tools/perf/util/c++/clang.cpp
@@ -71,7 +71,11 @@ getModuleFromSource(llvm::opt::ArgStringList CFlags,
 	CompilerInstance Clang;
 	Clang.createDiagnostics();
 
+#if CLANG_VERSION_MAJOR < 9
 	Clang.setVirtualFileSystem(&*VFS);
+#else
+	Clang.createFileManager(&*VFS);
+#endif
 
 #if CLANG_VERSION_MAJOR < 4
 	IntrusiveRefCntPtr<CompilerInvocation> CI =
-- 
2.21.1
