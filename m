From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 06/10] perf stat: Always separate stalled cycles per insn
Date: Tue, 23 Jul 2019 17:05:26 -0300
Message-ID: <20190723200530.14090-7-acme@kernel.org>
References: <20190723200530.14090-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190723200530.14090-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Cong Wang <xiyou.wangcong@gmail.com>, Andi Kleen <ak@linux.intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Cong Wang <xiyou.wangcong@gmail.com>

The "stalled cycles per insn" is appended to "instructions" when the CPU
has this hardware counter directly. We should always make it a separate
line, which also aligns to the output when we hit the "if (total &&
avg)" branch.

Before:

  $ sudo perf stat --all-cpus --field-separator , --log-fd 1 -einstructions,cycles -- sleep 1
  4565048704,,instructions,64114578096,100.00,1.34,insn per cycle,,
  3396325133,,cycles,64146628546,100.00,,

After:

  $ sudo ./tools/perf/perf stat --all-cpus --field-separator , --log-fd 1 -einstructions,cycles -- sleep 1
  6721924,,instructions,24026790339,100.00,0.22,insn per cycle
  ,,,,,0.00,stalled cycles per insn
  30939953,,cycles,24025512526,100.00,,

Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>
Link: http://lkml.kernel.org/r/20190517221039.8975-1-xiyou.wangcong@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/stat-shadow.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 656065af4971..accb1bf1cfd8 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -819,7 +819,8 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 					"stalled cycles per insn",
 					ratio);
 		} else if (have_frontend_stalled) {
-			print_metric(config, ctxp, NULL, NULL,
+			out->new_line(config, ctxp);
+			print_metric(config, ctxp, NULL, "%7.2f ",
 				     "stalled cycles per insn", 0);
 		}
 	} else if (perf_evsel__match(evsel, HARDWARE, HW_BRANCH_MISSES)) {
-- 
2.21.0
