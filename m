From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 10/21] perf c2c report: Fix crash for empty browser
Date: Wed,  1 Aug 2018 18:36:37 -0300
Message-ID: <20180801213648.4814-11-acme@kernel.org>
References: <20180801213648.4814-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180801213648.4814-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, David Ahern <dsahern@gmail.com>, Don Zickus <dzickus@redhat.com>, Joe Mario <jmario@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

'perf c2c' scans read/write accesses and tries to find false sharing
cases, so when the events it wants were not asked for or ended up not
taking place, we get no histograms.

So do not try to display entry details if there's not any. Currently
this ends up in crash:

  $ perf c2c report # then press 'd'
  perf: Segmentation fault
  $

Committer testing:

Before:

Record a perf.data file without events of interest to 'perf c2c report',
then call it and press 'd':

  # perf record sleep 1
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.001 MB perf.data (6 samples) ]
  # perf c2c report
  perf: Segmentation fault
  -------- backtrace --------
  perf[0x5b1d2a]
  /lib64/libc.so.6(+0x346df)[0x7fcb566e36df]
  perf[0x46fcae]
  perf[0x4a9f1e]
  perf[0x4aa220]
  perf(main+0x301)[0x42c561]
  /lib64/libc.so.6(__libc_start_main+0xe9)[0x7fcb566cff29]
  perf(_start+0x29)[0x42c999]
  #

After the patch the segfault doesn't take place, a follow up patch to
tell the user why nothing changes when 'd' is pressed would be good.

Reported-by: rodia@autistici.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Don Zickus <dzickus@redhat.com>
Cc: Joe Mario <jmario@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Fixes: f1c5fd4d0bb9 ("perf c2c report: Add TUI cacheline browser")
Link: http://lkml.kernel.org/r/20180724062008.26126-1-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-c2c.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index f2ea85ee573f..f3aa9d02a5ab 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -2349,6 +2349,9 @@ static int perf_c2c__browse_cacheline(struct hist_entry *he)
 	" s             Toggle full length of symbol and source line columns \n"
 	" q             Return back to cacheline list \n";
 
+	if (!he)
+		return 0;
+
 	/* Display compact version first. */
 	c2c.symbol_full = false;
 
-- 
2.14.4
