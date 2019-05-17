From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 59/73] perf test zstd: Fixup verbose mode output
Date: Fri, 17 May 2019 16:35:57 -0300
Message-ID: <20190517193611.4974-60-acme@kernel.org>
References: <20190517193611.4974-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190517193611.4974-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Alexey Budankov <alexey.budankov@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The shell tests should not redirect useful output to /dev/null, as that
is done automatically by 'perf test' in non verbose mode, so remove that
from the zstd comp/decomp test, fixing up verbose mode.

Before:

  $ perf test zstd
  68: Zstd perf.data compression/decompression              : Ok
  $ perf test -v zstd
  68: Zstd perf.data compression/decompression              :
  --- start ---
  test child forked, pid 11956
      -z, --compression-level[=<n>]
  Collecting compressed record file:
  Checking compressed events stats:
  test child finished with 0
  ---- end ----
  Zstd perf.data compression/decompression: Ok
  $

Now:

  $ perf test zstd
  68: Zstd perf.data compression/decompression              : Ok
  $ perf test -v zstd
  68: Zstd perf.data compression/decompression              :
  --- start ---
  test child forked, pid 12695
  Collecting compressed record file:
  0+500 records in
  72+1 records out
  37361 bytes (37 kB, 36 KiB) copied, 9.83796 s, 3.8 kB/s
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.001 MB /tmp/perf.data.rzq, compressed (original 0.004 MB, ratio is 3.679) ]
  Checking compressed events stats:
  # compressed : Zstd, level = 1, ratio = 4
        COMPRESSED events:          3
  test child finished with 0
  ---- end ----
  Zstd perf.data compression/decompression: Ok
  $

Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lkml.kernel.org/n/tip-tp96618ds42zic94nlh0msz3@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/shell/record+zstd_comp_decomp.sh | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tools/perf/tests/shell/record+zstd_comp_decomp.sh b/tools/perf/tests/shell/record+zstd_comp_decomp.sh
index 93a26a87b1f2..5dcba800109f 100755
--- a/tools/perf/tests/shell/record+zstd_comp_decomp.sh
+++ b/tools/perf/tests/shell/record+zstd_comp_decomp.sh
@@ -3,29 +3,28 @@
 
 trace_file=$(mktemp /tmp/perf.data.XXX)
 perf_tool=perf
-output=/dev/null
 
 skip_if_no_z_record() {
-	$perf_tool record -h 2>&1 | grep '\-z, \-\-compression\-level'
+	$perf_tool record -h 2>&1 | grep -q '\-z, \-\-compression\-level'
 }
 
 collect_z_record() {
 	echo "Collecting compressed record file:"
 	$perf_tool record -o $trace_file -g -z -F 5000 -- \
-		dd count=500 if=/dev/random of=/dev/null > $output 2>&1
+		dd count=500 if=/dev/random of=/dev/null
 }
 
 check_compressed_stats() {
 	echo "Checking compressed events stats:"
 	$perf_tool report -i $trace_file --header --stats | \
-		grep -E "(# compressed : Zstd,)|(COMPRESSED events:)" > $output 2>&1
+		grep -E "(# compressed : Zstd,)|(COMPRESSED events:)"
 }
 
 check_compressed_output() {
 	$perf_tool inject -i $trace_file -o $trace_file.decomp &&
 	$perf_tool report -i $trace_file --stdio | head -n -3 > $trace_file.comp.output &&
 	$perf_tool report -i $trace_file.decomp --stdio | head -n -3 > $trace_file.decomp.output &&
-	diff $trace_file.comp.output $trace_file.decomp.output > $output 2>&1
+	diff $trace_file.comp.output $trace_file.decomp.output
 }
 
 skip_if_no_z_record || exit 2
-- 
2.20.1
