From: Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf tests: Fix test 68 zstd compression for s390
Date: Wed, 29 Jul 2020 15:53:14 +0200
Message-ID: <20200729135314.91281-1-tmricht@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, acme@kernel.org
Cc: svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com, heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

Commit 5aa98879efe7 ("s390/cpum_sf: prohibit callchain data collection")
prohibits call graph sampling for hardware events on s390. The
information recorded is out of context and does not match.

On s390 this commit now breaks test case 68
Zstd perf.data compression/decompression.

Therefore omit call graph sampling on s390 in this test.

Output before:
  [root@t35lp46 perf]# ./perf test -Fv 68
  68: Zstd perf.data compression/decompression              :
  --- start ---
  Collecting compressed record file:
  Error:
  cycles: PMU Hardware doesn't support sampling/overflow-interrupts.
                                Try 'perf stat'
  ---- end ----
  Zstd perf.data compression/decompression: FAILED!
  [root@t35lp46 perf]#

Output after:
[root@t35lp46 perf]# ./perf test -Fv 68
  68: Zstd perf.data compression/decompression              :
  --- start ---
  Collecting compressed record file:
  500+0 records in
  500+0 records out
  256000 bytes (256 kB, 250 KiB) copied, 0.00615638 s, 41.6 MB/s
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.004 MB /tmp/perf.data.X3M,
                        compressed (original 0.002 MB, ratio is 3.609) ]
  Checking compressed events stats:
  # compressed : Zstd, level = 1, ratio = 4
        COMPRESSED events:          1
  2ELIFREPh---- end ----
  Zstd perf.data compression/decompression: Ok
  [root@t35lp46 perf]#

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
---
 tools/perf/tests/shell/record+zstd_comp_decomp.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/record+zstd_comp_decomp.sh b/tools/perf/tests/shell/record+zstd_comp_decomp.sh
index 63a91ec473bb..045723b3d992 100755
--- a/tools/perf/tests/shell/record+zstd_comp_decomp.sh
+++ b/tools/perf/tests/shell/record+zstd_comp_decomp.sh
@@ -12,7 +12,8 @@ skip_if_no_z_record() {
 
 collect_z_record() {
 	echo "Collecting compressed record file:"
-	$perf_tool record -o $trace_file -g -z -F 5000 -- \
+	[[ "$(uname -m)" != s390x ]] && gflag='-g'
+	$perf_tool record -o $trace_file $gflag -z -F 5000 -- \
 		dd count=500 if=/dev/urandom of=/dev/null
 }
 
-- 
2.26.2
