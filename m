From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 30/41] perf report: Fix description for --mem-mode
Date: Fri, 16 Feb 2018 16:17:35 -0300
Message-ID: <20180216191746.11095-31-acme@kernel.org>
References: <20180216191746.11095-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180216191746.11095-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

The "mem-loads" event only works when PEBS is enabled, so add the "/p"
("precise") suffix to the examples.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
LPU-Reference: 20180209163909.9240-1-andi@firstfloor.org
Link: https://lkml.kernel.org/n/tip-v0gcd4u9tktrvjjsp6y7ouv4@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-report.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
index a76b871f78a6..cba16d8a970e 100644
--- a/tools/perf/Documentation/perf-report.txt
+++ b/tools/perf/Documentation/perf-report.txt
@@ -368,7 +368,7 @@ OPTIONS
 	Use the data addresses of samples in addition to instruction addresses
 	to build the histograms.  To generate meaningful output, the perf.data
 	file must have been obtained using perf record -d -W and using a
-	special event -e cpu/mem-loads/ or -e cpu/mem-stores/. See
+	special event -e cpu/mem-loads/p or -e cpu/mem-stores/p. See
 	'perf mem' for simpler access.
 
 --percent-limit::
-- 
2.14.3
