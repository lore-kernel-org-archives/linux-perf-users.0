From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 27/35] perf tools: Fix check-headers.sh AND list path of execution
Date: Wed, 15 Aug 2018 12:06:03 -0300
Message-ID: <20180815150611.32080-28-acme@kernel.org>
References: <20180815150611.32080-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180815150611.32080-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Alexander Kapshuk <alexander.kapshuk@gmail.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Alexander Kapshuk <alexander.kapshuk@gmail.com>

The '||' path of execution in the 'test' block of the check_2() function
may also be taken if file2 does not exist, in which case the warning
message about the ABI headers being different would still be printed
where it should not be.  See below.

  % file1=file1; file2=file2
  % cmd="echo diff $file1 $file2"
  % test -f $file2 && \
    eval $cmd || echo "Warning: Kernel ABI header at 'tools/$file1'
                       differs from latest version at '$file2'" >&2
                       Warning: Kernel ABI header at 'tools/file1' differs from latest
                       version at 'file2'

The proposed patch converts the code following the '&&' operator into a
compound list to be executed in the current process environment only if file2
does exist. Should the files being compared differ, a diff command to compare
the files concerned is printed on standard output. E.g.

  $ diff -u tools/arch/x86/lib/memcpy_64.S arch/x86/lib/memcpy_64.S

Committer testing:

Remove a line from that tools/arch/x86/lib/memcpy_64.S file to test
this:

  BUILD:   Doing 'make -j4' parallel build
Warning: Kernel ABI header at 'tools/arch/x86/lib/memcpy_64.S' differs from latest version at 'arch/x86/lib/memcpy_64.S'
diff -u tools/arch/x86/lib/memcpy_64.S arch/x86/lib/memcpy_64.S
  CC       /tmp/build/perf/bench/mem-memcpy-x86-64-asm.o

Signed-off-by: Alexander Kapshuk <alexander.kapshuk@gmail.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180811083915.17471-1-alexander.kapshuk@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/check-headers.sh | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index de28466c0186..ea48aa6f8d19 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -67,8 +67,12 @@ check_2 () {
 
   cmd="diff $* $file1 $file2 > /dev/null"
 
-  test -f $file2 &&
-  eval $cmd || echo "Warning: Kernel ABI header at 'tools/$file' differs from latest version at '$file'" >&2
+  test -f $file2 && {
+    eval $cmd || {
+      echo "Warning: Kernel ABI header at 'tools/$file' differs from latest version at '$file'" >&2
+      echo diff -u tools/$file $file
+    }
+  }
 }
 
 check () {
-- 
2.14.4
