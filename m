Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6F51598E9;
	Thu,  8 Aug 2024 19:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723145578; cv=none; b=lopeol6j5QGdKUmebwsYqVRu6lEl9yC3+4EEH2A/kqEr+lqKd1v42RqUO5d9khiCX3eI/DYHObL6GrTxO9y385UK371Kkt9HFumpXF+LAIu79Fq+Ne6F9/h8W6060WWXwqoEgR50RNoxH1G3RV4lQ/c8e2klZzPM5W4eKRFzShw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723145578; c=relaxed/simple;
	bh=nGX4/1SsuB3debswjhQV3ylWUPdQhVBu9G3/DW/tklQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iQ+YrkncsF2UIKZZYn+lbt//Qeug+6SraUXz32qyvyiwGzuPeOZKru7NxP12/0ILjr9ELc6vuH7Dj7SYHDI6qsBniIpz5VhEjFb1oYb/jsW19wpOSc92zC3rVvgg0LQOsR5kWQNhcnoh5ExnK7dJQkCzhASHQgdnPhcZqE26FEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lazypx5g; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lazypx5g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723145577; x=1754681577;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nGX4/1SsuB3debswjhQV3ylWUPdQhVBu9G3/DW/tklQ=;
  b=Lazypx5g5fIikQ9Wmjj+2Afk2KLOufUmLFKDTpMEfY9kulHStO1WyB4K
   pZd/iOqHiZWhvm2NNrqf5JlZAvkM/YHKQEhZfrI+Gn4x8YGcbrqkh8yOy
   B7wWKbW1uFvp+feyTkRBnTVOHoUJGs0kXSeST00h0wE2pm0yDHtubEM6Q
   dwy+ZSiVW63hjuAj1Bg/8ikKQY165sL9XyxzrO99r8yU81fljx0467au/
   wwOIROFnJNALNhdLPi7bhLAAbdRyfbH3cIqcqkdj1pnPyzWIT2mXmDyl3
   bXXZPmwPa4tjjP++I60xNpfxvSrCDaFqz3x/FqZy+wLqNtyiL9o65BiHS
   g==;
X-CSE-ConnectionGUID: uRU1MH8mRZGqJwVYFa1R/Q==
X-CSE-MsgGUID: LVAd3nVTSrqBY1KC3edqbQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="25091724"
X-IronPort-AV: E=Sophos;i="6.09,274,1716274800"; 
   d="scan'208";a="25091724"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 12:32:53 -0700
X-CSE-ConnectionGUID: lgt8AILLQhGWKDY95LLL+g==
X-CSE-MsgGUID: mVYljkokR+ihid39DcjJyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,274,1716274800"; 
   d="scan'208";a="57402603"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa010.fm.intel.com with ESMTP; 08 Aug 2024 12:32:53 -0700
From: kan.liang@linux.intel.com
To: acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	peterz@infradead.org,
	mingo@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: adrian.hunter@intel.com,
	ak@linux.intel.com,
	eranian@google.com,
	Kan Liang <kan.liang@linux.intel.com>,
	Tinghao Zhang <tinghao.zhang@intel.com>
Subject: [PATCH V2 8/9] perf script: Add branch counters
Date: Thu,  8 Aug 2024 12:33:23 -0700
Message-Id: <20240808193324.2027665-9-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20240808193324.2027665-1-kan.liang@linux.intel.com>
References: <20240808193324.2027665-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

It's useful to print the branch counter information for each jump in
the brstackinsn when it's available.

Add a new field brcntr to display the branch counter information.

By default, the abbreviation will be used to indicate the branch
counter. In the verbose mode, the real event name is shown.

$perf script -F +brstackinsn,+brcntr

 # Branch counter abbr list:
 # branch-instructions:ppp = A
 # branch-misses = B
 # '-' No event occurs
 # '+' Event occurrences may be lost due to branch counter saturated
     tchain_edit  332203 3366329.405674:      53030 branch-instructions:ppp:            401781 f3+0x2c (home/sdp/test/tchain_edit)
        f3+31:
        0000000000401774        insn: eb 04                     br_cntr: AA     # PRED 5 cycles [5]
        000000000040177a        insn: 81 7d fc 0f 27 00 00
        0000000000401781        insn: 7e e3                     br_cntr: A      # PRED 1 cycles [6] 2.00 IPC
        0000000000401766        insn: 8b 45 fc
        0000000000401769        insn: 83 e0 01
        000000000040176c        insn: 85 c0
        000000000040176e        insn: 74 06                     br_cntr: A      # PRED 1 cycles [7] 4.00 IPC
        0000000000401776        insn: 83 45 fc 01
        000000000040177a        insn: 81 7d fc 0f 27 00 00
        0000000000401781        insn: 7e e3                     br_cntr: A      # PRED 7 cycles [14] 0.43 IPC

$perf script -F +brstackinsn,+brcntr -v

     tchain_edit  332203 3366329.405674:      53030 branch-instructions:ppp:            401781 f3+0x2c (/home/sdp/os.linux.perf.test-suite/kernels/lbr_kernel/tchain_edit)
        f3+31:
        0000000000401774        insn: eb 04                     br_cntr: branch-instructions:ppp 2 branch-misses 0      # PRED 5 cycles [5]
        000000000040177a        insn: 81 7d fc 0f 27 00 00
        0000000000401781        insn: 7e e3                     br_cntr: branch-instructions:ppp 1 branch-misses 0      # PRED 1 cycles [6] 2.00 IPC
        0000000000401766        insn: 8b 45 fc
        0000000000401769        insn: 83 e0 01
        000000000040176c        insn: 85 c0
        000000000040176e        insn: 74 06                     br_cntr: branch-instructions:ppp 1 branch-misses 0      # PRED 1 cycles [7] 4.00 IPC
        0000000000401776        insn: 83 45 fc 01
        000000000040177a        insn: 81 7d fc 0f 27 00 00
        0000000000401781        insn: 7e e3                     br_cntr: branch-instructions:ppp 1 branch-misses 0      # PRED 7 cycles [14] 0.43 IPC

Originally-by: Tinghao Zhang <tinghao.zhang@intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/Documentation/perf-script.txt |  2 +-
 tools/perf/builtin-script.c              | 69 +++++++++++++++++++++---
 2 files changed, 63 insertions(+), 8 deletions(-)

diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
index ff086ef05a0c..be483c904d8d 100644
--- a/tools/perf/Documentation/perf-script.txt
+++ b/tools/perf/Documentation/perf-script.txt
@@ -134,7 +134,7 @@ OPTIONS
         srcline, period, iregs, uregs, brstack, brstacksym, flags, bpf-output,
         brstackinsn, brstackinsnlen, brstackdisasm, brstackoff, callindent, insn, disasm,
         insnlen, synth, phys_addr, metric, misc, srccode, ipc, data_page_size,
-        code_page_size, ins_lat, machine_pid, vcpu, cgroup, retire_lat,
+        code_page_size, ins_lat, machine_pid, vcpu, cgroup, retire_lat, brcntr,
 
         Field list can be prepended with the type, trace, sw or hw,
         to indicate to which event type the field list applies.
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index c16224b1fef3..4d71847196bc 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -62,6 +62,7 @@
 #include "util/record.h"
 #include "util/util.h"
 #include "util/cgroup.h"
+#include "util/annotate.h"
 #include "perf.h"
 
 #include <linux/ctype.h>
@@ -138,6 +139,7 @@ enum perf_output_field {
 	PERF_OUTPUT_DSOFF           = 1ULL << 41,
 	PERF_OUTPUT_DISASM          = 1ULL << 42,
 	PERF_OUTPUT_BRSTACKDISASM   = 1ULL << 43,
+	PERF_OUTPUT_BRCNTR          = 1ULL << 44,
 };
 
 struct perf_script {
@@ -213,6 +215,7 @@ struct output_option {
 	{.str = "cgroup", .field = PERF_OUTPUT_CGROUP},
 	{.str = "retire_lat", .field = PERF_OUTPUT_RETIRE_LAT},
 	{.str = "brstackdisasm", .field = PERF_OUTPUT_BRSTACKDISASM},
+	{.str = "brcntr", .field = PERF_OUTPUT_BRCNTR},
 };
 
 enum {
@@ -520,6 +523,12 @@ static int evsel__check_attr(struct evsel *evsel, struct perf_session *session)
 		       "Hint: run 'perf record -b ...'\n");
 		return -EINVAL;
 	}
+	if (PRINT_FIELD(BRCNTR) &&
+	    !(evlist__combined_branch_type(session->evlist) & PERF_SAMPLE_BRANCH_COUNTERS)) {
+		pr_err("Display of branch counter requested but it's not enabled\n"
+		       "Hint: run 'perf record -j any,counter ...'\n");
+		return -EINVAL;
+	}
 	if ((PRINT_FIELD(PID) || PRINT_FIELD(TID)) &&
 	    evsel__check_stype(evsel, PERF_SAMPLE_TID, "TID", PERF_OUTPUT_TID|PERF_OUTPUT_PID))
 		return -EINVAL;
@@ -789,6 +798,19 @@ static int perf_sample__fprintf_start(struct perf_script *script,
 	int printed = 0;
 	char tstr[128];
 
+	/*
+	 * Print the branch counter's abbreviation list,
+	 * if the branch counter is available.
+	 */
+	if (PRINT_FIELD(BRCNTR) && !verbose) {
+		char *buf;
+
+		if (!annotation_br_cntr_abbr_list(&buf, evsel, true)) {
+			printed += fprintf(stdout, "%s", buf);
+			free(buf);
+		}
+	}
+
 	if (PRINT_FIELD(MACHINE_PID) && sample->machine_pid)
 		printed += fprintf(fp, "VM:%5d ", sample->machine_pid);
 
@@ -1195,7 +1217,9 @@ static int ip__fprintf_jump(uint64_t ip, struct branch_entry *en,
 			    struct perf_insn *x, u8 *inbuf, int len,
 			    int insn, FILE *fp, int *total_cycles,
 			    struct perf_event_attr *attr,
-			    struct thread *thread)
+			    struct thread *thread,
+			    struct evsel *evsel,
+			    u64 br_cntr)
 {
 	int ilen = 0;
 	int printed = fprintf(fp, "\t%016" PRIx64 "\t", ip);
@@ -1216,6 +1240,28 @@ static int ip__fprintf_jump(uint64_t ip, struct branch_entry *en,
 		addr_location__exit(&al);
 	}
 
+	if (PRINT_FIELD(BRCNTR)) {
+		unsigned int width = evsel__env(evsel)->br_cntr_width;
+		unsigned int i = 0, j, num, mask = (1L << width) - 1;
+		struct evsel *pos = evsel__leader(evsel);
+
+		printed += fprintf(fp, "br_cntr: ");
+		evlist__for_each_entry_from(evsel->evlist, pos) {
+			if (!(pos->core.attr.branch_sample_type & PERF_SAMPLE_BRANCH_COUNTERS))
+				continue;
+			if (evsel__leader(pos) != evsel__leader(evsel))
+				break;
+
+			num = (br_cntr >> (i++ * width)) & mask;
+			if (!verbose) {
+				for (j = 0; j < num; j++)
+					printed += fprintf(fp, "%s", pos->abbr_name);
+			} else
+				printed += fprintf(fp, "%s %d ", pos->name, num);
+		}
+		printed += fprintf(fp, "\t");
+	}
+
 	printed += fprintf(fp, "#%s%s%s%s",
 			      en->flags.predicted ? " PRED" : "",
 			      en->flags.mispred ? " MISPRED" : "",
@@ -1272,6 +1318,7 @@ static int ip__fprintf_sym(uint64_t addr, struct thread *thread,
 }
 
 static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
+					    struct evsel *evsel,
 					    struct thread *thread,
 					    struct perf_event_attr *attr,
 					    struct machine *machine, FILE *fp)
@@ -1285,6 +1332,7 @@ static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
 	unsigned off;
 	struct symbol *lastsym = NULL;
 	int total_cycles = 0;
+	u64 br_cntr = 0;
 
 	if (!(br && br->nr))
 		return 0;
@@ -1296,6 +1344,9 @@ static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
 	x.machine = machine;
 	x.cpu = sample->cpu;
 
+	if (PRINT_FIELD(BRCNTR) && sample->branch_stack_cntr)
+		br_cntr = sample->branch_stack_cntr[nr - 1];
+
 	printed += fprintf(fp, "%c", '\n');
 
 	/* Handle first from jump, of which we don't know the entry. */
@@ -1307,7 +1358,7 @@ static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
 					   x.cpumode, x.cpu, &lastsym, attr, fp);
 		printed += ip__fprintf_jump(entries[nr - 1].from, &entries[nr - 1],
 					    &x, buffer, len, 0, fp, &total_cycles,
-					    attr, thread);
+					    attr, thread, evsel, br_cntr);
 		if (PRINT_FIELD(SRCCODE))
 			printed += print_srccode(thread, x.cpumode, entries[nr - 1].from);
 	}
@@ -1337,8 +1388,10 @@ static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
 
 			printed += ip__fprintf_sym(ip, thread, x.cpumode, x.cpu, &lastsym, attr, fp);
 			if (ip == end) {
+				if (PRINT_FIELD(BRCNTR) && sample->branch_stack_cntr)
+					br_cntr = sample->branch_stack_cntr[i];
 				printed += ip__fprintf_jump(ip, &entries[i], &x, buffer + off, len - off, ++insn, fp,
-							    &total_cycles, attr, thread);
+							    &total_cycles, attr, thread, evsel, br_cntr);
 				if (PRINT_FIELD(SRCCODE))
 					printed += print_srccode(thread, x.cpumode, ip);
 				break;
@@ -1547,6 +1600,7 @@ void script_fetch_insn(struct perf_sample *sample, struct thread *thread,
 }
 
 static int perf_sample__fprintf_insn(struct perf_sample *sample,
+				     struct evsel *evsel,
 				     struct perf_event_attr *attr,
 				     struct thread *thread,
 				     struct machine *machine, FILE *fp,
@@ -1567,7 +1621,7 @@ static int perf_sample__fprintf_insn(struct perf_sample *sample,
 		printed += sample__fprintf_insn_asm(sample, thread, machine, fp, al);
 	}
 	if (PRINT_FIELD(BRSTACKINSN) || PRINT_FIELD(BRSTACKINSNLEN) || PRINT_FIELD(BRSTACKDISASM))
-		printed += perf_sample__fprintf_brstackinsn(sample, thread, attr, machine, fp);
+		printed += perf_sample__fprintf_brstackinsn(sample, evsel, thread, attr, machine, fp);
 
 	return printed;
 }
@@ -1639,7 +1693,7 @@ static int perf_sample__fprintf_bts(struct perf_sample *sample,
 	if (print_srcline_last)
 		printed += map__fprintf_srcline(al->map, al->addr, "\n  ", fp);
 
-	printed += perf_sample__fprintf_insn(sample, attr, thread, machine, fp, al);
+	printed += perf_sample__fprintf_insn(sample, evsel, attr, thread, machine, fp, al);
 	printed += fprintf(fp, "\n");
 	if (PRINT_FIELD(SRCCODE)) {
 		int ret = map__fprintf_srccode(al->map, al->addr, stdout,
@@ -2297,7 +2351,7 @@ static void process_event(struct perf_script *script,
 
 	if (evsel__is_bpf_output(evsel) && PRINT_FIELD(BPF_OUTPUT))
 		perf_sample__fprintf_bpf_output(sample, fp);
-	perf_sample__fprintf_insn(sample, attr, thread, machine, fp, al);
+	perf_sample__fprintf_insn(sample, evsel, attr, thread, machine, fp, al);
 
 	if (PRINT_FIELD(PHYS_ADDR))
 		fprintf(fp, "%16" PRIx64, sample->phys_addr);
@@ -3979,7 +4033,8 @@ int cmd_script(int argc, const char **argv)
 		     "brstacksym,flags,data_src,weight,bpf-output,brstackinsn,"
 		     "brstackinsnlen,brstackdisasm,brstackoff,callindent,insn,disasm,insnlen,synth,"
 		     "phys_addr,metric,misc,srccode,ipc,tod,data_page_size,"
-		     "code_page_size,ins_lat,machine_pid,vcpu,cgroup,retire_lat",
+		     "code_page_size,ins_lat,machine_pid,vcpu,cgroup,retire_lat,"
+		     "brcntr",
 		     parse_output_fields),
 	OPT_BOOLEAN('a', "all-cpus", &system_wide,
 		    "system-wide collection from all CPUs"),
-- 
2.38.1

