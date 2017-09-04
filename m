From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 09/13] perf mem: Support physical address
Date: Mon,  4 Sep 2017 11:00:40 -0300
Message-ID: <20170904140044.22912-10-acme@kernel.org>
References: <20170904140044.22912-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170904140044.22912-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Kan Liang <kan.liang@intel.com>, Andi Kleen <ak@linux.intel.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Kan Liang <kan.liang@intel.com>

Add option phys-data in "perf mem" to record/report physical address.
The default mem sort order for physical address is changed accordingly.

Signed-off-by: Kan Liang <kan.liang@intel.com>
Tested-by: Jiri Olsa <jolsa@redhat.com>
Acked-by: Stephane Eranian <eranian@google.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/1504026672-7304-4-git-send-email-kan.liang@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-mem.txt |  4 ++
 tools/perf/builtin-mem.c              | 97 +++++++++++++++++++++++++----------
 2 files changed, 75 insertions(+), 26 deletions(-)

diff --git a/tools/perf/Documentation/perf-mem.txt b/tools/perf/Documentation/perf-mem.txt
index 73496320fca3..4be08a1e3f8d 100644
--- a/tools/perf/Documentation/perf-mem.txt
+++ b/tools/perf/Documentation/perf-mem.txt
@@ -59,6 +59,10 @@ OPTIONS
 --ldload::
 	Specify desired latency for loads event.
 
+-p::
+--phys-data::
+	Record/Report sample physical addresses
+
 SEE ALSO
 --------
 linkperf:perf-record[1], linkperf:perf-report[1]
diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
index e001c0290793..0f15634ef82c 100644
--- a/tools/perf/builtin-mem.c
+++ b/tools/perf/builtin-mem.c
@@ -23,6 +23,7 @@ struct perf_mem {
 	bool			hide_unresolved;
 	bool			dump_raw;
 	bool			force;
+	bool			phys_addr;
 	int			operation;
 	const char		*cpu_list;
 	DECLARE_BITMAP(cpu_bitmap, MAX_NR_CPUS);
@@ -101,6 +102,9 @@ static int __cmd_record(int argc, const char **argv, struct perf_mem *mem)
 
 	rec_argv[i++] = "-d";
 
+	if (mem->phys_addr)
+		rec_argv[i++] = "--phys-data";
+
 	for (j = 0; j < PERF_MEM_EVENTS__MAX; j++) {
 		if (!perf_mem_events[j].record)
 			continue;
@@ -161,30 +165,60 @@ dump_raw_samples(struct perf_tool *tool,
 	if (al.map != NULL)
 		al.map->dso->hit = 1;
 
-	if (symbol_conf.field_sep) {
-		fmt = "%d%s%d%s0x%"PRIx64"%s0x%"PRIx64"%s%"PRIu64
-		      "%s0x%"PRIx64"%s%s:%s\n";
+	if (mem->phys_addr) {
+		if (symbol_conf.field_sep) {
+			fmt = "%d%s%d%s0x%"PRIx64"%s0x%"PRIx64"%s0x%016"PRIx64
+			      "%s%"PRIu64"%s0x%"PRIx64"%s%s:%s\n";
+		} else {
+			fmt = "%5d%s%5d%s0x%016"PRIx64"%s0x016%"PRIx64
+			      "%s0x%016"PRIx64"%s%5"PRIu64"%s0x%06"PRIx64
+			      "%s%s:%s\n";
+			symbol_conf.field_sep = " ";
+		}
+
+		printf(fmt,
+			sample->pid,
+			symbol_conf.field_sep,
+			sample->tid,
+			symbol_conf.field_sep,
+			sample->ip,
+			symbol_conf.field_sep,
+			sample->addr,
+			symbol_conf.field_sep,
+			sample->phys_addr,
+			symbol_conf.field_sep,
+			sample->weight,
+			symbol_conf.field_sep,
+			sample->data_src,
+			symbol_conf.field_sep,
+			al.map ? (al.map->dso ? al.map->dso->long_name : "???") : "???",
+			al.sym ? al.sym->name : "???");
 	} else {
-		fmt = "%5d%s%5d%s0x%016"PRIx64"%s0x016%"PRIx64
-		      "%s%5"PRIu64"%s0x%06"PRIx64"%s%s:%s\n";
-		symbol_conf.field_sep = " ";
-	}
+		if (symbol_conf.field_sep) {
+			fmt = "%d%s%d%s0x%"PRIx64"%s0x%"PRIx64"%s%"PRIu64
+			      "%s0x%"PRIx64"%s%s:%s\n";
+		} else {
+			fmt = "%5d%s%5d%s0x%016"PRIx64"%s0x016%"PRIx64
+			      "%s%5"PRIu64"%s0x%06"PRIx64"%s%s:%s\n";
+			symbol_conf.field_sep = " ";
+		}
 
-	printf(fmt,
-		sample->pid,
-		symbol_conf.field_sep,
-		sample->tid,
-		symbol_conf.field_sep,
-		sample->ip,
-		symbol_conf.field_sep,
-		sample->addr,
-		symbol_conf.field_sep,
-		sample->weight,
-		symbol_conf.field_sep,
-		sample->data_src,
-		symbol_conf.field_sep,
-		al.map ? (al.map->dso ? al.map->dso->long_name : "???") : "???",
-		al.sym ? al.sym->name : "???");
+		printf(fmt,
+			sample->pid,
+			symbol_conf.field_sep,
+			sample->tid,
+			symbol_conf.field_sep,
+			sample->ip,
+			symbol_conf.field_sep,
+			sample->addr,
+			symbol_conf.field_sep,
+			sample->weight,
+			symbol_conf.field_sep,
+			sample->data_src,
+			symbol_conf.field_sep,
+			al.map ? (al.map->dso ? al.map->dso->long_name : "???") : "???",
+			al.sym ? al.sym->name : "???");
+	}
 out_put:
 	addr_location__put(&al);
 	return 0;
@@ -224,7 +258,10 @@ static int report_raw_events(struct perf_mem *mem)
 	if (ret < 0)
 		goto out_delete;
 
-	printf("# PID, TID, IP, ADDR, LOCAL WEIGHT, DSRC, SYMBOL\n");
+	if (mem->phys_addr)
+		printf("# PID, TID, IP, ADDR, PHYS ADDR, LOCAL WEIGHT, DSRC, SYMBOL\n");
+	else
+		printf("# PID, TID, IP, ADDR, LOCAL WEIGHT, DSRC, SYMBOL\n");
 
 	ret = perf_session__process_events(session);
 
@@ -254,9 +291,16 @@ static int report_events(int argc, const char **argv, struct perf_mem *mem)
 	 * there is no weight (cost) associated with stores, so don't print
 	 * the column
 	 */
-	if (!(mem->operation & MEM_OPERATION_LOAD))
-		rep_argv[i++] = "--sort=mem,sym,dso,symbol_daddr,"
-				"dso_daddr,tlb,locked";
+	if (!(mem->operation & MEM_OPERATION_LOAD)) {
+		if (mem->phys_addr)
+			rep_argv[i++] = "--sort=mem,sym,dso,symbol_daddr,"
+					"dso_daddr,tlb,locked,phys_daddr";
+		else
+			rep_argv[i++] = "--sort=mem,sym,dso,symbol_daddr,"
+					"dso_daddr,tlb,locked";
+	} else if (mem->phys_addr)
+		rep_argv[i++] = "--sort=local_weight,mem,sym,dso,symbol_daddr,"
+				"dso_daddr,snoop,tlb,locked,phys_daddr";
 
 	for (j = 1; j < argc; j++, i++)
 		rep_argv[i] = argv[j];
@@ -373,6 +417,7 @@ int cmd_mem(int argc, const char **argv)
 		   "separator for columns, no spaces will be added"
 		   " between columns '.' is reserved."),
 	OPT_BOOLEAN('f', "force", &mem.force, "don't complain, do it"),
+	OPT_BOOLEAN('p', "phys-data", &mem.phys_addr, "Record/Report sample physical addresses"),
 	OPT_END()
 	};
 	const char *const mem_subcommands[] = { "record", "report", NULL };
-- 
2.13.5
