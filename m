From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 28/35] perf tools: Make check-headers.sh check based on kernel dir
Date: Wed, 15 Aug 2018 12:06:04 -0300
Message-ID: <20180815150611.32080-29-acme@kernel.org>
References: <20180815150611.32080-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180815150611.32080-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Kapshuk <alexander.kapshuk@gmail.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, David Ahern <dsahern@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Changing the logic to compare files with paths relative to kernel source
base dir. This way we can keep the output message for 2 unrelated files,
which is coming in following patch.

Committer testing:

Remove a line from tools/arch/x86/lib/memcpy_64.S to have it detected:

make: Entering directory '/home/acme/git/perf/tools/perf'
  BUILD:   Doing 'make -j4' parallel build
Warning: Kernel ABI header at 'tools/arch/x86/lib/memcpy_64.S' differs from latest version at 'arch/x86/lib/memcpy_64.S'
diff -u tools/arch/x86/lib/memcpy_64.S arch/x86/lib/memcpy_64.S
  INSTALL  GTK UI
  INSTALL  binaries

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Kapshuk <alexander.kapshuk@gmail.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180813111504.3568-1-jolsa@kernel.org
Link: http://lkml.kernel.org/r/20180814072726.GA13931@krava
[ Do not use pushd/popd, its a bashism, reported by Michael Ellerman, fixed by Jiri Olsa ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/check-headers.sh | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index ea48aa6f8d19..b61f8a4dfca3 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -69,8 +69,8 @@ check_2 () {
 
   test -f $file2 && {
     eval $cmd || {
-      echo "Warning: Kernel ABI header at 'tools/$file' differs from latest version at '$file'" >&2
-      echo diff -u tools/$file $file
+      echo "Warning: Kernel ABI header at '$file1' differs from latest version at '$file2'" >&2
+      echo diff -u $file1 $file2
     }
   }
 }
@@ -80,7 +80,7 @@ check () {
 
   shift
 
-  check_2 ../$file ../../$file $*
+  check_2 tools/$file $file $*
 }
 
 # Check if we have the kernel headers (tools/perf/../../include), else
@@ -88,6 +88,8 @@ check () {
 # differences.
 test -d ../../include || exit 0
 
+cd ../..
+
 # simple diff check
 for i in $HEADERS; do
   check $i -B
@@ -98,3 +100,5 @@ check arch/x86/lib/memcpy_64.S        '-I "^EXPORT_SYMBOL" -I "^#include <asm/ex
 check arch/x86/lib/memset_64.S        '-I "^EXPORT_SYMBOL" -I "^#include <asm/export.h>"'
 check include/uapi/asm-generic/mman.h '-I "^#include <\(uapi/\)*asm-generic/mman-common.h>"'
 check include/uapi/linux/mman.h       '-I "^#include <\(uapi/\)*asm/mman.h>"'
+
+cd tools/perf
-- 
2.14.4
