From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 08/13] perf sort: Add sort option for physical address
Date: Mon,  4 Sep 2017 11:00:39 -0300
Message-ID: <20170904140044.22912-9-acme@kernel.org>
References: <20170904140044.22912-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170904140044.22912-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Kan Liang <kan.liang@intel.com>, Andi Kleen <ak@linux.intel.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Kan Liang <kan.liang@intel.com>

Add a new sort option "phys_daddr" for --mem-mode sort.  With this
option applied, perf can sort and report by sample's physical address.

Signed-off-by: Kan Liang <kan.liang@intel.com>
Tested-by: Jiri Olsa <jolsa@redhat.com>
Acked-by: Stephane Eranian <eranian@google.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/1504026672-7304-3-git-send-email-kan.liang@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-report.txt |  1 +
 tools/perf/util/hist.c                   |  4 +++
 tools/perf/util/hist.h                   |  1 +
 tools/perf/util/machine.c                |  8 ++++--
 tools/perf/util/session.c                |  3 +++
 tools/perf/util/sort.c                   | 42 ++++++++++++++++++++++++++++++++
 tools/perf/util/sort.h                   |  1 +
 tools/perf/util/symbol.h                 |  1 +
 8 files changed, 59 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
index 9fa84617181e..383a98d992ed 100644
--- a/tools/perf/Documentation/perf-report.txt
+++ b/tools/perf/Documentation/perf-report.txt
@@ -137,6 +137,7 @@ OPTIONS
 	- mem: type of memory access for the data at the time of the sample
 	- snoop: type of snoop (if any) for the data at the time of the sample
 	- dcacheline: the cacheline the data address is on at the time of the sample
+	- phys_daddr: physical address of data being executed on at the time of sample
 
 	And the default sort keys are changed to local_weight, mem, sym, dso,
 	symbol_daddr, dso_daddr, snoop, tlb, locked, see '--mem-mode'.
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 9453b2e27015..e60d8d8ea4c2 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -167,6 +167,10 @@ void hists__calc_col_len(struct hists *hists, struct hist_entry *h)
 			symlen = unresolved_col_width + 4 + 2;
 			hists__set_unres_dso_col_len(hists, HISTC_MEM_DADDR_DSO);
 		}
+
+		hists__new_col_len(hists, HISTC_MEM_PHYS_DADDR,
+				   unresolved_col_width + 4 + 2);
+
 	} else {
 		symlen = unresolved_col_width + 4 + 2;
 		hists__new_col_len(hists, HISTC_MEM_DADDR_SYMBOL, symlen);
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index ee3670a388df..e60dda26a920 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -47,6 +47,7 @@ enum hist_column {
 	HISTC_GLOBAL_WEIGHT,
 	HISTC_MEM_DADDR_SYMBOL,
 	HISTC_MEM_DADDR_DSO,
+	HISTC_MEM_PHYS_DADDR,
 	HISTC_MEM_LOCKED,
 	HISTC_MEM_TLB,
 	HISTC_MEM_LVL,
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 9eaa95302c86..df709363ef69 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1635,10 +1635,12 @@ static void ip__resolve_ams(struct thread *thread,
 	ams->al_addr = al.addr;
 	ams->sym = al.sym;
 	ams->map = al.map;
+	ams->phys_addr = 0;
 }
 
 static void ip__resolve_data(struct thread *thread,
-			     u8 m, struct addr_map_symbol *ams, u64 addr)
+			     u8 m, struct addr_map_symbol *ams,
+			     u64 addr, u64 phys_addr)
 {
 	struct addr_location al;
 
@@ -1658,6 +1660,7 @@ static void ip__resolve_data(struct thread *thread,
 	ams->al_addr = al.addr;
 	ams->sym = al.sym;
 	ams->map = al.map;
+	ams->phys_addr = phys_addr;
 }
 
 struct mem_info *sample__resolve_mem(struct perf_sample *sample,
@@ -1669,7 +1672,8 @@ struct mem_info *sample__resolve_mem(struct perf_sample *sample,
 		return NULL;
 
 	ip__resolve_ams(al->thread, &mi->iaddr, sample->ip);
-	ip__resolve_data(al->thread, al->cpumode, &mi->daddr, sample->addr);
+	ip__resolve_data(al->thread, al->cpumode, &mi->daddr,
+			 sample->addr, sample->phys_addr);
 	mi->data_src.val = sample->data_src;
 
 	return mi;
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index ac863691605f..a7ebd9fe8e40 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1120,6 +1120,9 @@ static void dump_sample(struct perf_evsel *evsel, union perf_event *event,
 	if (sample_type & PERF_SAMPLE_DATA_SRC)
 		printf(" . data_src: 0x%"PRIx64"\n", sample->data_src);
 
+	if (sample_type & PERF_SAMPLE_PHYS_ADDR)
+		printf(" .. phys_addr: 0x%"PRIx64"\n", sample->phys_addr);
+
 	if (sample_type & PERF_SAMPLE_TRANSACTION)
 		printf("... transaction: %" PRIx64 "\n", sample->transaction);
 
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 12359bd986db..eb3ab902a1c0 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -1316,6 +1316,47 @@ struct sort_entry sort_mem_dcacheline = {
 };
 
 static int64_t
+sort__phys_daddr_cmp(struct hist_entry *left, struct hist_entry *right)
+{
+	uint64_t l = 0, r = 0;
+
+	if (left->mem_info)
+		l = left->mem_info->daddr.phys_addr;
+	if (right->mem_info)
+		r = right->mem_info->daddr.phys_addr;
+
+	return (int64_t)(r - l);
+}
+
+static int hist_entry__phys_daddr_snprintf(struct hist_entry *he, char *bf,
+					   size_t size, unsigned int width)
+{
+	uint64_t addr = 0;
+	size_t ret = 0;
+	size_t len = BITS_PER_LONG / 4;
+
+	addr = he->mem_info->daddr.phys_addr;
+
+	ret += repsep_snprintf(bf + ret, size - ret, "[%c] ", he->level);
+
+	ret += repsep_snprintf(bf + ret, size - ret, "%-#.*llx", len, addr);
+
+	ret += repsep_snprintf(bf + ret, size - ret, "%-*s", width - ret, "");
+
+	if (ret > width)
+		bf[width] = '\0';
+
+	return width;
+}
+
+struct sort_entry sort_mem_phys_daddr = {
+	.se_header	= "Data Physical Address",
+	.se_cmp		= sort__phys_daddr_cmp,
+	.se_snprintf	= hist_entry__phys_daddr_snprintf,
+	.se_width_idx	= HISTC_MEM_PHYS_DADDR,
+};
+
+static int64_t
 sort__abort_cmp(struct hist_entry *left, struct hist_entry *right)
 {
 	if (!left->branch_info || !right->branch_info)
@@ -1547,6 +1588,7 @@ static struct sort_dimension memory_sort_dimensions[] = {
 	DIM(SORT_MEM_LVL, "mem", sort_mem_lvl),
 	DIM(SORT_MEM_SNOOP, "snoop", sort_mem_snoop),
 	DIM(SORT_MEM_DCACHELINE, "dcacheline", sort_mem_dcacheline),
+	DIM(SORT_MEM_PHYS_DADDR, "phys_daddr", sort_mem_phys_daddr),
 };
 
 #undef DIM
diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
index b7c75597e18f..f36dc4980a6c 100644
--- a/tools/perf/util/sort.h
+++ b/tools/perf/util/sort.h
@@ -245,6 +245,7 @@ enum sort_type {
 	SORT_MEM_SNOOP,
 	SORT_MEM_DCACHELINE,
 	SORT_MEM_IADDR_SYMBOL,
+	SORT_MEM_PHYS_DADDR,
 };
 
 /*
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index d00a012cfdfb..2bd6a1f01a1c 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -186,6 +186,7 @@ struct addr_map_symbol {
 	struct symbol *sym;
 	u64	      addr;
 	u64	      al_addr;
+	u64	      phys_addr;
 };
 
 struct branch_info {
-- 
2.13.5
