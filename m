Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0132153DA;
	Mon,  3 Mar 2025 17:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741023491; cv=none; b=BlACDCZ/SzFYqMzJO3JGkesipR4AG/V76RB/Sd+uMlDNnFdfaJPU+iCXc9e/IFrVHNm710kzpwdyUeFk/zMxB35SXdMF/qcc23rltQm7eIBqfb/9Pus6koZ4Mlo+BhZqedpA1du30ozMKFadXhobYwBaHr4MR1J4WwhiiuPhw3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741023491; c=relaxed/simple;
	bh=IzsVT4D7lKAXXVXm5+ZrHMmiCtYtaaf7NJrpUczKObw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CFekbyio7fHOG1S7Zq1JqbVnaqDYOO+G6TmhWtSc8GMB80Cmim9eECYL070ZxkB0wHze1M5r0mMi1rcHtArqW8N/BC7u8X1Ui0efQKpvxUnYDO/HAu/j/c4AjIZE+4SfeGoBDQE5gnUiY77Sz2vBYlfcEsJMbWoMYtE12nEfblc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=arAZjL8O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="arAZjL8O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 672E1C4CED6;
	Mon,  3 Mar 2025 17:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741023490;
	bh=IzsVT4D7lKAXXVXm5+ZrHMmiCtYtaaf7NJrpUczKObw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=arAZjL8Oj+0MnftXGof345T53okmD8nhVezUbk69sPIxt4C1FEVMYkxTfouSM9XOL
	 ovbq76Fz0Np42Ru7DaJOa6OS92kyqWcVsNODi6ew8BGsMxd6gSW6IddyMDCKLAIoB0
	 WB4GUebHVt86nrRXW0/iH84SDPvdpPKOHfKi+l+i4xa+q1TOwl04DlmIlUNWDypK5j
	 Ps7uKuGNDnrjRitghEeAW05w2+okzoRJY+vSW8KiNYP28TKOFe6tO3yYaUbg9B1bAk
	 35mGKr++PligrKw00VWNmLiufqeL+B/6xyKJIVitYPUIBKb1qvAtb/aC0qkTfrWgHH
	 7kyprtWDZm0tQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Subject: [PATCH 5/7] perf annotate: Factor out __hist_entry__get_data_type()
Date: Mon,  3 Mar 2025 09:38:05 -0800
Message-ID: <20250303173807.1765098-6-namhyung@kernel.org>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
In-Reply-To: <20250303173807.1765098-1-namhyung@kernel.org>
References: <20250303173807.1765098-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

So that it can only handle a single disasm_linme and hopefully make the
code simpler.  This is also a preparation to be called from different
places later.

The NO_TYPE macro was added to distinguish when it failed or needs retry.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate.c | 170 +++++++++++++++++++++----------------
 1 file changed, 95 insertions(+), 75 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 029e47a521caf1af..8a67340a64b94c39 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -87,6 +87,8 @@ struct annotated_data_type canary_type = {
 	},
 };
 
+#define NO_TYPE ((struct annotated_data_type *)-1UL)
+
 /* symbol histogram: key = offset << 16 | evsel->core.idx */
 static size_t sym_hist_hash(long key, void *ctx __maybe_unused)
 {
@@ -2649,6 +2651,92 @@ void debuginfo_cache__delete(void)
 	di_cache.dbg = NULL;
 }
 
+static struct annotated_data_type *
+__hist_entry__get_data_type(struct hist_entry *he, struct arch *arch,
+			    struct debuginfo *dbg, struct disasm_line *dl,
+			    int *type_offset)
+{
+	struct map_symbol *ms = &he->ms;
+	struct annotated_insn_loc loc;
+	struct annotated_op_loc *op_loc;
+	struct annotated_data_type *mem_type;
+	struct annotated_item_stat *istat;
+	int i;
+
+	istat = annotate_data_stat(&ann_insn_stat, dl->ins.name);
+	if (istat == NULL) {
+		ann_data_stat.no_insn++;
+		return NO_TYPE;
+	}
+
+	if (annotate_get_insn_location(arch, dl, &loc) < 0) {
+		ann_data_stat.no_insn_ops++;
+		istat->bad++;
+		return NO_TYPE;
+	}
+
+	if (is_stack_operation(arch, dl)) {
+		istat->good++;
+		*type_offset = 0;
+		return &stackop_type;
+	}
+
+	for_each_insn_op_loc(&loc, i, op_loc) {
+		struct data_loc_info dloc = {
+			.arch = arch,
+			.thread = he->thread,
+			.ms = ms,
+			.ip = ms->sym->start + dl->al.offset,
+			.cpumode = he->cpumode,
+			.op = op_loc,
+			.di = dbg,
+		};
+
+		if (!op_loc->mem_ref && op_loc->segment == INSN_SEG_NONE)
+			continue;
+
+		/* PC-relative addressing */
+		if (op_loc->reg1 == DWARF_REG_PC) {
+			dloc.var_addr = annotate_calc_pcrel(ms, dloc.ip,
+							    op_loc->offset, dl);
+		}
+
+		/* This CPU access in kernel - pretend PC-relative addressing */
+		if (dso__kernel(map__dso(ms->map)) && arch__is(arch, "x86") &&
+		    op_loc->segment == INSN_SEG_X86_GS && op_loc->imm) {
+			dloc.var_addr = op_loc->offset;
+			op_loc->reg1 = DWARF_REG_PC;
+		}
+
+		mem_type = find_data_type(&dloc);
+
+		if (mem_type == NULL && is_stack_canary(arch, op_loc)) {
+			istat->good++;
+			*type_offset = 0;
+			return &canary_type;
+		}
+
+		if (mem_type)
+			istat->good++;
+		else
+			istat->bad++;
+
+		if (symbol_conf.annotate_data_sample) {
+			struct evsel *evsel = hists_to_evsel(he->hists);
+
+			annotated_data_type__update_samples(mem_type, evsel,
+							    dloc.type_offset,
+							    he->stat.nr_events,
+							    he->stat.period);
+		}
+		*type_offset = dloc.type_offset;
+		return mem_type ?: NO_TYPE;
+	}
+
+	/* retry with a fused instruction */
+	return NULL;
+}
+
 /**
  * hist_entry__get_data_type - find data type for given hist entry
  * @he: hist entry
@@ -2664,12 +2752,9 @@ struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he)
 	struct evsel *evsel = hists_to_evsel(he->hists);
 	struct arch *arch;
 	struct disasm_line *dl;
-	struct annotated_insn_loc loc;
-	struct annotated_op_loc *op_loc;
 	struct annotated_data_type *mem_type;
 	struct annotated_item_stat *istat;
 	u64 ip = he->ip;
-	int i;
 
 	ann_data_stat.total++;
 
@@ -2721,77 +2806,10 @@ struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he)
 	}
 
 retry:
-	istat = annotate_data_stat(&ann_insn_stat, dl->ins.name);
-	if (istat == NULL) {
-		ann_data_stat.no_insn++;
-		return NULL;
-	}
-
-	if (annotate_get_insn_location(arch, dl, &loc) < 0) {
-		ann_data_stat.no_insn_ops++;
-		istat->bad++;
-		return NULL;
-	}
-
-	if (is_stack_operation(arch, dl)) {
-		istat->good++;
-		he->mem_type_off = 0;
-		return &stackop_type;
-	}
-
-	for_each_insn_op_loc(&loc, i, op_loc) {
-		struct data_loc_info dloc = {
-			.arch = arch,
-			.thread = he->thread,
-			.ms = ms,
-			/* Recalculate IP for LOCK prefix or insn fusion */
-			.ip = ms->sym->start + dl->al.offset,
-			.cpumode = he->cpumode,
-			.op = op_loc,
-			.di = di_cache.dbg,
-		};
-
-		if (!op_loc->mem_ref && op_loc->segment == INSN_SEG_NONE)
-			continue;
-
-		/* Recalculate IP because of LOCK prefix or insn fusion */
-		ip = ms->sym->start + dl->al.offset;
-
-		/* PC-relative addressing */
-		if (op_loc->reg1 == DWARF_REG_PC) {
-			dloc.var_addr = annotate_calc_pcrel(ms, dloc.ip,
-							    op_loc->offset, dl);
-		}
-
-		/* This CPU access in kernel - pretend PC-relative addressing */
-		if (dso__kernel(map__dso(ms->map)) && arch__is(arch, "x86") &&
-		    op_loc->segment == INSN_SEG_X86_GS && op_loc->imm) {
-			dloc.var_addr = op_loc->offset;
-			op_loc->reg1 = DWARF_REG_PC;
-		}
-
-		mem_type = find_data_type(&dloc);
-
-		if (mem_type == NULL && is_stack_canary(arch, op_loc)) {
-			istat->good++;
-			he->mem_type_off = 0;
-			return &canary_type;
-		}
-
-		if (mem_type)
-			istat->good++;
-		else
-			istat->bad++;
-
-		if (symbol_conf.annotate_data_sample) {
-			annotated_data_type__update_samples(mem_type, evsel,
-							    dloc.type_offset,
-							    he->stat.nr_events,
-							    he->stat.period);
-		}
-		he->mem_type_off = dloc.type_offset;
-		return mem_type;
-	}
+	mem_type = __hist_entry__get_data_type(he, arch, di_cache.dbg, dl,
+					       &he->mem_type_off);
+	if (mem_type)
+		return mem_type == NO_TYPE ? NULL : mem_type;
 
 	/*
 	 * Some instructions can be fused and the actual memory access came
@@ -2811,7 +2829,9 @@ struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he)
 	}
 
 	ann_data_stat.no_mem_ops++;
-	istat->bad++;
+	istat = annotate_data_stat(&ann_insn_stat, dl->ins.name);
+	if (istat)
+		istat->bad++;
 	return NULL;
 }
 
-- 
2.48.1.711.g2feabab25a-goog

