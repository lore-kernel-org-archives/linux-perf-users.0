From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 10/44] perf tools: Add doc about how to build perf with Asan and UBSan
Date: Thu, 21 Mar 2019 15:51:08 -0300
Message-ID: <20190321185142.11441-11-acme@kernel.org>
References: <20190321185142.11441-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190321185142.11441-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Changbin Du <changbin.du@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Changbin Du <changbin.du@gmail.com>

AddressSanitizer (or ASan) and UndefinedBehaviorSanitizer (or UBSan) are
very useful tools to detect program bugs:

 - AddressSanitizer (or ASan) is a GCC feature that detects memory
   corruption bugs such as buffer overflows and memory leaks.

 - UndefinedBehaviorSanitizer (or UBSan) is a fast undefined behavior
   detector supported by GCC. UBSan detects undefined behaviors of programs
   at runtime.

This patch adds a document about how to use them on perf. Later patches will fix
some of the issues disclosed by them.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
Link: http://lkml.kernel.org/r/20190316080556.3075-2-changbin.du@gmail.com
[ Make some changes based on comments made by Jiri Olsa ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/Build.txt | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tools/perf/Documentation/Build.txt b/tools/perf/Documentation/Build.txt
index f6fc6507ba55..3766886c4bca 100644
--- a/tools/perf/Documentation/Build.txt
+++ b/tools/perf/Documentation/Build.txt
@@ -47,3 +47,27 @@ Those objects are then used in final linking:
 
 NOTE this description is omitting other libraries involved, only
      focusing on build framework outcomes
+
+3) Build with ASan or UBSan
+==========================
+  $ cd tools/perf
+  $ make DESTDIR=/usr
+  $ make DESTDIR=/usr install
+
+AddressSanitizer (or ASan) is a GCC feature that detects memory corruption bugs
+such as buffer overflows and memory leaks.
+
+  $ cd tools/perf
+  $ make DEBUG=1 EXTRA_CFLAGS='-fno-omit-frame-pointer -fsanitize=address'
+  $ ASAN_OPTIONS=log_path=asan.log ./perf record -a
+
+ASan outputs all detected issues into a log file named 'asan.log.<pid>'.
+
+UndefinedBehaviorSanitizer (or UBSan) is a fast undefined behavior detector
+supported by GCC. UBSan detects undefined behaviors of programs at runtime.
+
+  $ cd tools/perf
+  $ make DEBUG=1 EXTRA_CFLAGS='-fno-omit-frame-pointer -fsanitize=undefined'
+  $ UBSAN_OPTIONS=print_stacktrace=1 ./perf record -a
+
+If UBSan detects any problem at runtime, it outputs a “runtime error:” message.
-- 
2.20.1
