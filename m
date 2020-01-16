From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 03/12] perf report: Clarify in help that --children is default
Date: Thu, 16 Jan 2020 10:48:05 -0300
Message-ID: <20200116134814.8811-4-acme@kernel.org>
References: <20200116134814.8811-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200116134814.8811-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Refer to --no-children, which is what most people probably want.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
LPU-Reference: 20200103183643.149150-1-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-report.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index de988589d99b..3048c1b95b4c 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1164,7 +1164,8 @@ int cmd_report(int argc, const char **argv)
 			     report_callchain_help, &report_parse_callchain_opt,
 			     callchain_default_opt),
 	OPT_BOOLEAN(0, "children", &symbol_conf.cumulate_callchain,
-		    "Accumulate callchains of children and show total overhead as well"),
+		    "Accumulate callchains of children and show total overhead as well. "
+		    "Enabled by default, use --no-children to disable."),
 	OPT_INTEGER(0, "max-stack", &report.max_stack,
 		    "Set the maximum stack depth when parsing the callchain, "
 		    "anything beyond the specified depth will be ignored. "
-- 
2.21.1
