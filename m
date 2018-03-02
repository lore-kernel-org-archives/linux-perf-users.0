From: Agustin Vega-Frias <agustinv@codeaurora.org>
Subject: [RFC V2 1/3] perf,
 tools: Support wildcards on pmu name in dynamic pmu events
Date: Fri,  2 Mar 2018 18:41:30 -0500
Message-ID: <1520034092-35275-2-git-send-email-agustinv@codeaurora.org>
References: <1520034092-35275-1-git-send-email-agustinv@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1520034092-35275-1-git-send-email-agustinv@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Andi Kleen <ak@linux.intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>
Cc: timur@codeaurora.org, agustinv@codeaurora.org
List-Id: linux-perf-users.vger.kernel.org

Starting on v4.12 event parsing code for dynamic pmu events already
supports prefix-based matching of multiple pmus when creating dynamic
events. E.g., in a system with the following dynamic pmus:

    mypmu_0
    mypmu_1
    mypmu_2
    mypmu_4

passing mypmu/<config>/ as an event spec will result in the creation
of the event in all of the pmus. This change expands this matching
through the use of fnmatch so glob-like expressions can be used to
create events in multiple pmus. E.g., in the system described above
if a user only wants to create the event in mypmu_0 and mypmu_1,
mypmu_[01]/<config>/ can be passed.

Signed-off-by: Agustin Vega-Frias <agustinv@codeaurora.org>
---
 tools/perf/Documentation/perf-list.txt |  8 +++++++-
 tools/perf/Documentation/perf-stat.txt | 12 ++++++++++++
 tools/perf/util/parse-events.l         |  2 +-
 tools/perf/util/parse-events.y         |  3 ++-
 4 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Documentation/perf-list.txt
index e2a897a..2549c34 100644
--- a/tools/perf/Documentation/perf-list.txt
+++ b/tools/perf/Documentation/perf-list.txt
@@ -141,7 +141,13 @@ on the first memory controller on socket 0 of a Intel Xeon system

 Each memory controller has its own PMU.  Measuring the complete system
 bandwidth would require specifying all imc PMUs (see perf list output),
-and adding the values together.
+and adding the values together. To simplify creation of multiple events,
+prefix and glob matching is supported in the PMU name, and the prefix
+'uncore_' is also ignored when performing the match. So the command above
+can be expanded to all memory controllers by using the syntaxes:
+
+  perf stat -C 0 -a imc/cas_count_read/,imc/cas_count_write/ -I 1000 ...
+  perf stat -C 0 -a *imc*/cas_count_read/,*imc*/cas_count_write/ -I 1000 ...

 This example measures the combined core power every second

diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index 823fce7..49983a7 100644
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -49,6 +49,12 @@ report::
 	  parameters are defined by corresponding entries in
 	  /sys/bus/event_source/devices/<pmu>/format/*

+	Note that the last two syntaxes support prefix and glob matching in
+	the PMU name to simplify creation of events accross multiple instances
+	of the same type of PMU (e.g. memory controller PMU) in large systems.
+	Multiple PMU instances are typical for uncore PMUs, so the prefix
+	'uncore_' is also ignored when performing this match.
+
 -i::
 --no-inherit::
         child tasks do not inherit counters
@@ -246,6 +252,12 @@ taskset.
 --no-merge::
 Do not merge results from same PMUs.

+When multiple events are created from a single event alias, stat will,
+by default, aggregate the event counts and show the result in a single
+row. This option disables that behavior and shows the individual events
+and counts. Aliases are listed immediately after the Kernel PMU events
+by perf list.
+
 --smi-cost::
 Measure SMI cost if msr/aperf/ and msr/smi/ events are supported.

diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
index 655ecff..a1a01b1 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -175,7 +175,7 @@ bpf_source	[^,{}]+\.c[a-zA-Z0-9._]*
 num_dec		[0-9]+
 num_hex		0x[a-fA-F0-9]+
 num_raw_hex	[a-fA-F0-9]+
-name		[a-zA-Z_*?][a-zA-Z0-9_*?.]*
+name		[a-zA-Z_*?\[\]][a-zA-Z0-9_*?.\[\]]*
 name_minus	[a-zA-Z_*?][a-zA-Z0-9\-_*?.:]*
 drv_cfg_term	[a-zA-Z0-9_\.]+(=[a-zA-Z0-9_*?\.:]+)?
 /* If you add a modifier you need to update check_modifier() */
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index e81a20e..c528469 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -8,6 +8,7 @@

 #define YYDEBUG 1

+#include <fnmatch.h>
 #include <linux/compiler.h>
 #include <linux/list.h>
 #include <linux/types.h>
@@ -241,7 +242,7 @@ PE_NAME opt_event_config
 			if (!strncmp(name, "uncore_", 7) &&
 			    strncmp($1, "uncore_", 7))
 				name += 7;
-			if (!strncmp($1, name, strlen($1))) {
+			if (!strncmp($1, name, strlen($1)) || !fnmatch($1, name, 0)) {
 				if (parse_events_copy_term_list(orig_terms, &terms))
 					YYABORT;
 				if (!parse_events_add_pmu(_parse_state, list, pmu->name, terms))
--
Qualcomm Datacenter Technologies, Inc. on behalf of the Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
