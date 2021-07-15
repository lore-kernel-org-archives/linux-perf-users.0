Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54338C07E96
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 06:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D3BF61358
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 06:36:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234475AbhGOGjU (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 15 Jul 2021 02:39:20 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:11311 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbhGOGjU (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 15 Jul 2021 02:39:20 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4GQPfZ33wDz7tch;
        Thu, 15 Jul 2021 14:31:50 +0800 (CST)
Received: from dggpemm000003.china.huawei.com (7.185.36.128) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 15 Jul 2021 14:36:13 +0800
Received: from ubuntu1804.huawei.com (10.67.174.61) by
 dggpemm000003.china.huawei.com (7.185.36.128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 15 Jul 2021 14:36:12 +0800
From:   Yang Jihong <yangjihong1@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>, <mhiramat@kernel.org>,
        <irogers@google.com>, <fche@redhat.com>,
        <ravi.bangoria@linux.ibm.com>, <yao.jin@linux.intel.com>,
        <srikar@linux.vnet.ibm.com>, <Jianlin.Lv@arm.com>,
        <lihuafei1@huawei.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <yangjihong1@huawei.com>
Subject: [PATCH v2] perf probe: Fix add event failed when 32-bit perf running in 64-bit kernel
Date:   Thu, 15 Jul 2021 14:37:23 +0800
Message-ID: <20210715063723.11926-1-yangjihong1@huawei.com>
X-Mailer: git-send-email 2.30.GIT
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.61]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm000003.china.huawei.com (7.185.36.128)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The "address" member  of "struct probe_trace_point" uses long data type.
If kernel is 64-bit and perf program is 32-bit, size of "address" variable is
32 bits. As a result, upper 32 bits of address read from kernel are truncated,
An error occurs during address comparison in kprobe_warn_out_range function.

Before:

  # perf probe -a schedule
  schedule is out of .text, skip it.
    Error: Failed to add events.

Solution:
  Change data type of "address" variable to u64 and change corresponding
address printing and value assignment.

After:

  # perf.new.new probe -a schedule
  Added new event:
    probe:schedule       (on schedule)

  You can now use it in all perf tools, such as:

          perf record -e probe:schedule -aR sleep 1

  # perf probe -l
    probe:schedule       (on schedule@kernel/sched/core.c)
  # perf record -e probe:schedule -aR sleep 1
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.156 MB perf.data (1366 samples) ]
  # perf report --stdio
  # To display the perf.data header info, please use --header/--header-only options.
  #
  #
  # Total Lost Samples: 0
  #
  # Samples: 1K of event 'probe:schedule'
  # Event count (approx.): 1366
  #
  # Overhead  Command          Shared Object      Symbol
  # ........  ...............  .................  ............
  #
       6.22%  migration/0      [kernel.kallsyms]  [k] schedule
       6.22%  migration/1      [kernel.kallsyms]  [k] schedule
       6.22%  migration/2      [kernel.kallsyms]  [k] schedule
       6.22%  migration/3      [kernel.kallsyms]  [k] schedule
       6.15%  migration/10     [kernel.kallsyms]  [k] schedule
       6.15%  migration/11     [kernel.kallsyms]  [k] schedule
       6.15%  migration/12     [kernel.kallsyms]  [k] schedule
       6.15%  migration/13     [kernel.kallsyms]  [k] schedule
       6.15%  migration/14     [kernel.kallsyms]  [k] schedule
       6.15%  migration/15     [kernel.kallsyms]  [k] schedule
       6.15%  migration/4      [kernel.kallsyms]  [k] schedule
       6.15%  migration/5      [kernel.kallsyms]  [k] schedule
       6.15%  migration/6      [kernel.kallsyms]  [k] schedule
       6.15%  migration/7      [kernel.kallsyms]  [k] schedule
       6.15%  migration/8      [kernel.kallsyms]  [k] schedule
       6.15%  migration/9      [kernel.kallsyms]  [k] schedule
       0.22%  rcu_sched        [kernel.kallsyms]  [k] schedule
  ...
  #
  # (Cannot load tips.txt file, please install perf!)
  #

Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
---

Changes since v1:
  - Change the data type of "addr" parameter of the cu_find_lineinfo and
line_range_walk_cb functions to Dwarf_Addr.
  - Update commit msg, perf probe -l shows then filename and line number.

 tools/perf/util/dwarf-aux.c    |  8 +++---
 tools/perf/util/dwarf-aux.h    |  2 +-
 tools/perf/util/probe-event.c  | 49 ++++++++++++++++------------------
 tools/perf/util/probe-event.h  |  4 +--
 tools/perf/util/probe-finder.c | 15 +++++------
 tools/perf/util/probe-finder.h |  2 +-
 6 files changed, 38 insertions(+), 42 deletions(-)

diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index 7d2ba8419b0c..609ca1671501 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -113,14 +113,14 @@ static Dwarf_Line *cu_getsrc_die(Dwarf_Die *cu_die, Dwarf_Addr addr)
  *
  * Find a line number and file name for @addr in @cu_die.
  */
-int cu_find_lineinfo(Dwarf_Die *cu_die, unsigned long addr,
-		    const char **fname, int *lineno)
+int cu_find_lineinfo(Dwarf_Die *cu_die, Dwarf_Addr addr,
+		     const char **fname, int *lineno)
 {
 	Dwarf_Line *line;
 	Dwarf_Die die_mem;
 	Dwarf_Addr faddr;
 
-	if (die_find_realfunc(cu_die, (Dwarf_Addr)addr, &die_mem)
+	if (die_find_realfunc(cu_die, addr, &die_mem)
 	    && die_entrypc(&die_mem, &faddr) == 0 &&
 	    faddr == addr) {
 		*fname = dwarf_decl_file(&die_mem);
@@ -128,7 +128,7 @@ int cu_find_lineinfo(Dwarf_Die *cu_die, unsigned long addr,
 		goto out;
 	}
 
-	line = cu_getsrc_die(cu_die, (Dwarf_Addr)addr);
+	line = cu_getsrc_die(cu_die, addr);
 	if (line && dwarf_lineno(line, lineno) == 0) {
 		*fname = dwarf_linesrc(line, NULL, NULL);
 		if (!*fname)
diff --git a/tools/perf/util/dwarf-aux.h b/tools/perf/util/dwarf-aux.h
index cb99646843a9..7ee0fa19b5c4 100644
--- a/tools/perf/util/dwarf-aux.h
+++ b/tools/perf/util/dwarf-aux.h
@@ -19,7 +19,7 @@ const char *cu_find_realpath(Dwarf_Die *cu_die, const char *fname);
 const char *cu_get_comp_dir(Dwarf_Die *cu_die);
 
 /* Get a line number and file name for given address */
-int cu_find_lineinfo(Dwarf_Die *cudie, unsigned long addr,
+int cu_find_lineinfo(Dwarf_Die *cudie, Dwarf_Addr addr,
 		     const char **fname, int *lineno);
 
 /* Walk on functions at given address */
diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index c14e1d228e56..691b7a0988c6 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -237,8 +237,8 @@ static void clear_probe_trace_events(struct probe_trace_event *tevs, int ntevs)
 		clear_probe_trace_event(tevs + i);
 }
 
-static bool kprobe_blacklist__listed(unsigned long address);
-static bool kprobe_warn_out_range(const char *symbol, unsigned long address)
+static bool kprobe_blacklist__listed(u64 address);
+static bool kprobe_warn_out_range(const char *symbol, u64 address)
 {
 	struct map *map;
 	bool ret = false;
@@ -398,8 +398,7 @@ static int find_alternative_probe_point(struct debuginfo *dinfo,
 	pr_debug("Symbol %s address found : %" PRIx64 "\n",
 			pp->function, address);
 
-	ret = debuginfo__find_probe_point(dinfo, (unsigned long)address,
-					  result);
+	ret = debuginfo__find_probe_point(dinfo, address, result);
 	if (ret <= 0)
 		ret = (!ret) ? -ENOENT : ret;
 	else {
@@ -587,7 +586,7 @@ static void debuginfo_cache__exit(void)
 }
 
 
-static int get_text_start_address(const char *exec, unsigned long *address,
+static int get_text_start_address(const char *exec, u64 *address,
 				  struct nsinfo *nsi)
 {
 	Elf *elf;
@@ -632,7 +631,7 @@ static int find_perf_probe_point_from_dwarf(struct probe_trace_point *tp,
 					    bool is_kprobe)
 {
 	struct debuginfo *dinfo = NULL;
-	unsigned long stext = 0;
+	u64 stext = 0;
 	u64 addr = tp->address;
 	int ret = -ENOENT;
 
@@ -660,8 +659,7 @@ static int find_perf_probe_point_from_dwarf(struct probe_trace_point *tp,
 
 	dinfo = debuginfo_cache__open(tp->module, verbose <= 0);
 	if (dinfo)
-		ret = debuginfo__find_probe_point(dinfo,
-						 (unsigned long)addr, pp);
+		ret = debuginfo__find_probe_point(dinfo, addr, pp);
 	else
 		ret = -ENOENT;
 
@@ -676,7 +674,7 @@ static int find_perf_probe_point_from_dwarf(struct probe_trace_point *tp,
 
 /* Adjust symbol name and address */
 static int post_process_probe_trace_point(struct probe_trace_point *tp,
-					   struct map *map, unsigned long offs)
+					   struct map *map, u64 offs)
 {
 	struct symbol *sym;
 	u64 addr = tp->address - offs;
@@ -719,7 +717,7 @@ post_process_offline_probe_trace_events(struct probe_trace_event *tevs,
 					int ntevs, const char *pathname)
 {
 	struct map *map;
-	unsigned long stext = 0;
+	u64 stext = 0;
 	int i, ret = 0;
 
 	/* Prepare a map for offline binary */
@@ -745,7 +743,7 @@ static int add_exec_to_probe_trace_events(struct probe_trace_event *tevs,
 					  struct nsinfo *nsi)
 {
 	int i, ret = 0;
-	unsigned long stext = 0;
+	u64 stext = 0;
 
 	if (!exec)
 		return 0;
@@ -790,7 +788,7 @@ post_process_module_probe_trace_events(struct probe_trace_event *tevs,
 	mod_name = find_module_name(module);
 	for (i = 0; i < ntevs; i++) {
 		ret = post_process_probe_trace_point(&tevs[i].point,
-						map, (unsigned long)text_offs);
+						map, text_offs);
 		if (ret < 0)
 			break;
 		tevs[i].point.module =
@@ -1534,7 +1532,7 @@ static int parse_perf_probe_point(char *arg, struct perf_probe_event *pev)
 		 * so tmp[1] should always valid (but could be '\0').
 		 */
 		if (tmp && !strncmp(tmp, "0x", 2)) {
-			pp->abs_address = strtoul(pp->function, &tmp, 0);
+			pp->abs_address = strtoull(pp->function, &tmp, 0);
 			if (*tmp != '\0') {
 				semantic_error("Invalid absolute address.\n");
 				return -EINVAL;
@@ -1909,7 +1907,7 @@ int parse_probe_trace_command(const char *cmd, struct probe_trace_event *tev)
 			argv[i] = NULL;
 			argc -= 1;
 		} else
-			tp->address = strtoul(fmt1_str, NULL, 0);
+			tp->address = strtoull(fmt1_str, NULL, 0);
 	} else {
 		/* Only the symbol-based probe has offset */
 		tp->symbol = strdup(fmt1_str);
@@ -2155,7 +2153,7 @@ synthesize_uprobe_trace_def(struct probe_trace_point *tp, struct strbuf *buf)
 		return -EINVAL;
 
 	/* Use the tp->address for uprobes */
-	err = strbuf_addf(buf, "%s:0x%lx", tp->module, tp->address);
+	err = strbuf_addf(buf, "%s:0x%" PRIx64, tp->module, tp->address);
 
 	if (err >= 0 && tp->ref_ctr_offset) {
 		if (!uprobe_ref_ctr_is_supported())
@@ -2170,7 +2168,7 @@ synthesize_kprobe_trace_def(struct probe_trace_point *tp, struct strbuf *buf)
 {
 	if (!strncmp(tp->symbol, "0x", 2)) {
 		/* Absolute address. See try_to_find_absolute_address() */
-		return strbuf_addf(buf, "%s%s0x%lx", tp->module ?: "",
+		return strbuf_addf(buf, "%s%s0x%" PRIx64, tp->module ?: "",
 				  tp->module ? ":" : "", tp->address);
 	} else {
 		return strbuf_addf(buf, "%s%s%s+%lu", tp->module ?: "",
@@ -2269,7 +2267,7 @@ static int convert_to_perf_probe_point(struct probe_trace_point *tp,
 		pp->function = strdup(tp->symbol);
 		pp->offset = tp->offset;
 	} else {
-		ret = e_snprintf(buf, 128, "0x%" PRIx64, (u64)tp->address);
+		ret = e_snprintf(buf, 128, "0x%" PRIx64, tp->address);
 		if (ret < 0)
 			return ret;
 		pp->function = strdup(buf);
@@ -2450,8 +2448,8 @@ void clear_probe_trace_event(struct probe_trace_event *tev)
 
 struct kprobe_blacklist_node {
 	struct list_head list;
-	unsigned long start;
-	unsigned long end;
+	u64 start;
+	u64 end;
 	char *symbol;
 };
 
@@ -2496,7 +2494,7 @@ static int kprobe_blacklist__load(struct list_head *blacklist)
 		}
 		INIT_LIST_HEAD(&node->list);
 		list_add_tail(&node->list, blacklist);
-		if (sscanf(buf, "0x%lx-0x%lx", &node->start, &node->end) != 2) {
+		if (sscanf(buf, "0x%" PRIx64 "-0x%" PRIx64, &node->start, &node->end) != 2) {
 			ret = -EINVAL;
 			break;
 		}
@@ -2512,7 +2510,7 @@ static int kprobe_blacklist__load(struct list_head *blacklist)
 			ret = -ENOMEM;
 			break;
 		}
-		pr_debug2("Blacklist: 0x%lx-0x%lx, %s\n",
+		pr_debug2("Blacklist: 0x%" PRIx64 "-0x%" PRIx64 ", %s\n",
 			  node->start, node->end, node->symbol);
 		ret++;
 	}
@@ -2524,8 +2522,7 @@ static int kprobe_blacklist__load(struct list_head *blacklist)
 }
 
 static struct kprobe_blacklist_node *
-kprobe_blacklist__find_by_address(struct list_head *blacklist,
-				  unsigned long address)
+kprobe_blacklist__find_by_address(struct list_head *blacklist, u64 address)
 {
 	struct kprobe_blacklist_node *node;
 
@@ -2553,7 +2550,7 @@ static void kprobe_blacklist__release(void)
 	kprobe_blacklist__delete(&kprobe_blacklist);
 }
 
-static bool kprobe_blacklist__listed(unsigned long address)
+static bool kprobe_blacklist__listed(u64 address)
 {
 	return !!kprobe_blacklist__find_by_address(&kprobe_blacklist, address);
 }
@@ -3221,7 +3218,7 @@ static int try_to_find_absolute_address(struct perf_probe_event *pev,
 	 * In __add_probe_trace_events, a NULL symbol is interpreted as
 	 * invalid.
 	 */
-	if (asprintf(&tp->symbol, "0x%lx", tp->address) < 0)
+	if (asprintf(&tp->symbol, "0x%" PRIx64, tp->address) < 0)
 		goto errout;
 
 	/* For kprobe, check range */
@@ -3232,7 +3229,7 @@ static int try_to_find_absolute_address(struct perf_probe_event *pev,
 		goto errout;
 	}
 
-	if (asprintf(&tp->realname, "abs_%lx", tp->address) < 0)
+	if (asprintf(&tp->realname, "abs_%" PRIx64, tp->address) < 0)
 		goto errout;
 
 	if (pev->target) {
diff --git a/tools/perf/util/probe-event.h b/tools/perf/util/probe-event.h
index 65769d7949a3..8ad5b1579f1d 100644
--- a/tools/perf/util/probe-event.h
+++ b/tools/perf/util/probe-event.h
@@ -33,7 +33,7 @@ struct probe_trace_point {
 	char		*module;	/* Module name */
 	unsigned long	offset;		/* Offset from symbol */
 	unsigned long	ref_ctr_offset;	/* SDT reference counter offset */
-	unsigned long	address;	/* Actual address of the trace point */
+	u64		address;	/* Actual address of the trace point */
 	bool		retprobe;	/* Return probe flag */
 };
 
@@ -70,7 +70,7 @@ struct perf_probe_point {
 	bool		retprobe;	/* Return probe flag */
 	char		*lazy_line;	/* Lazy matching pattern */
 	unsigned long	offset;		/* Offset from function entry */
-	unsigned long	abs_address;	/* Absolute address of the point */
+	u64		abs_address;	/* Absolute address of the point */
 };
 
 /* Perf probe probing argument field chain */
diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
index 02ef0d78053b..50d861a80f57 100644
--- a/tools/perf/util/probe-finder.c
+++ b/tools/perf/util/probe-finder.c
@@ -668,7 +668,7 @@ static int convert_to_trace_point(Dwarf_Die *sp_die, Dwfl_Module *mod,
 	}
 
 	tp->offset = (unsigned long)(paddr - eaddr);
-	tp->address = (unsigned long)paddr;
+	tp->address = paddr;
 	tp->symbol = strdup(symbol);
 	if (!tp->symbol)
 		return -ENOMEM;
@@ -1707,7 +1707,7 @@ int debuginfo__get_text_offset(struct debuginfo *dbg, Dwarf_Addr *offs,
 }
 
 /* Reverse search */
-int debuginfo__find_probe_point(struct debuginfo *dbg, unsigned long addr,
+int debuginfo__find_probe_point(struct debuginfo *dbg, u64 addr,
 				struct perf_probe_point *ppt)
 {
 	Dwarf_Die cudie, spdie, indie;
@@ -1720,14 +1720,14 @@ int debuginfo__find_probe_point(struct debuginfo *dbg, unsigned long addr,
 		addr += baseaddr;
 	/* Find cu die */
 	if (!dwarf_addrdie(dbg->dbg, (Dwarf_Addr)addr, &cudie)) {
-		pr_warning("Failed to find debug information for address %lx\n",
+		pr_warning("Failed to find debug information for address %" PRIx64 "\n",
 			   addr);
 		ret = -EINVAL;
 		goto end;
 	}
 
 	/* Find a corresponding line (filename and lineno) */
-	cu_find_lineinfo(&cudie, addr, &fname, &lineno);
+	cu_find_lineinfo(&cudie, (Dwarf_Addr)addr, &fname, &lineno);
 	/* Don't care whether it failed or not */
 
 	/* Find a corresponding function (name, baseline and baseaddr) */
@@ -1742,7 +1742,7 @@ int debuginfo__find_probe_point(struct debuginfo *dbg, unsigned long addr,
 		}
 
 		fname = dwarf_decl_file(&spdie);
-		if (addr == (unsigned long)baseaddr) {
+		if (addr == baseaddr) {
 			/* Function entry - Relative line number is 0 */
 			lineno = baseline;
 			goto post;
@@ -1788,7 +1788,7 @@ int debuginfo__find_probe_point(struct debuginfo *dbg, unsigned long addr,
 	if (lineno)
 		ppt->line = lineno - baseline;
 	else if (basefunc) {
-		ppt->offset = addr - (unsigned long)baseaddr;
+		ppt->offset = addr - baseaddr;
 		func = basefunc;
 	}
 
@@ -1828,8 +1828,7 @@ static int line_range_add_line(const char *src, unsigned int lineno,
 }
 
 static int line_range_walk_cb(const char *fname, int lineno,
-			      Dwarf_Addr addr __maybe_unused,
-			      void *data)
+			      Dwarf_Addr addr, void *data)
 {
 	struct line_finder *lf = data;
 	const char *__fname;
diff --git a/tools/perf/util/probe-finder.h b/tools/perf/util/probe-finder.h
index 2febb5875678..8bc1c80d3c1c 100644
--- a/tools/perf/util/probe-finder.h
+++ b/tools/perf/util/probe-finder.h
@@ -46,7 +46,7 @@ int debuginfo__find_trace_events(struct debuginfo *dbg,
 				 struct probe_trace_event **tevs);
 
 /* Find a perf_probe_point from debuginfo */
-int debuginfo__find_probe_point(struct debuginfo *dbg, unsigned long addr,
+int debuginfo__find_probe_point(struct debuginfo *dbg, u64 addr,
 				struct perf_probe_point *ppt);
 
 int debuginfo__get_text_offset(struct debuginfo *dbg, Dwarf_Addr *offs,
-- 
2.30.GIT

