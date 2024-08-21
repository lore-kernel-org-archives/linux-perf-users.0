Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038BA17C9F1;
	Wed, 21 Aug 2024 23:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724282791; cv=none; b=OTrI3rRWpfaV0S69hjbsQRW7eFSfT2PKADoIn1HeFhheIIggf9QluC6rY5AdcTZxouhL23uvqFX4cMMwSKfdNGgay9T1ZBxISw1sWEjD2GgbMexU5QjtU4zAH7CjNdt/KjLewfzI3LCVegw2UQ/sFxmKCwzy1MvOMGAyMz+n3bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724282791; c=relaxed/simple;
	bh=ehGIy2G1PqpxUByasBwgEQIXnGHN6kauN4u3RFWqWQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C+8MhXlJcwoVRaaxyg/tKT58Kbc2YoUKaXXXdUJZpJ1NqzS1VYsBvCQmHnRePs6yy1SOY39nc/SWkrKarBP3T9ounBnvxRyajHR5qu2DXhl+PVkbCBckAdOYb1NktstbWyV61M8DrrePUlYpfKWevSGRXSI8xEKpSmxZ5Riir8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=um48zyWt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="um48zyWt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 483C7C4AF15;
	Wed, 21 Aug 2024 23:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724282790;
	bh=ehGIy2G1PqpxUByasBwgEQIXnGHN6kauN4u3RFWqWQ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=um48zyWt38IoLP+ITAu38D8q7bZ4OxTFBL3wuAlMvemFl4i+L+noOgv/DviAKqcUt
	 Sl/m7q+hRVe47NUhrzkRAyIyYEufrlkPqiuX4LnJLYcpGYZ4kbYwmlboXl0KhcRAdF
	 M1isBBWWimyHLnnIQVsCVBIapOIeaknN6lGgWMEgK4Uy74hcBZmr/MRtGTDF7YN7tp
	 SJewq+tERPR2Ene4Wy/oBd3GQ1LdYVYv952RrdFGKHbsLSwrnpjOhi+BdLBW5bTrWk
	 +KBxd9lCSJ8/bmEAcbjSdZmQ989A+YUXQwIJFla2cPrztNYif3LYStSGbM9bfffffu
	 BPG9LXLBrHObg==
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
Subject: [PATCH 2/4] perf annotate-data: Update debug messages
Date: Wed, 21 Aug 2024 16:26:26 -0700
Message-ID: <20240821232628.353177-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
In-Reply-To: <20240821232628.353177-1-namhyung@kernel.org>
References: <20240821232628.353177-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In check_matching_type(), it'd be easier to display the typename in
question if it's available.

For example, check out the line starts with 'chk'.
  -----------------------------------------------------------
  find data type for 0x10(reg0) at cpuacct_charge+0x13
  CU for kernel/sched/build_utility.c (die:0x137ee0b)
  frame base: cfa=1 fbreg=7
  scope: [3/3] (die:13d9632)
  bb: [c - 13]
  var [c] reg5 type='struct task_struct*' size=0x8 (die:0x1381230)
  mov [c] 0xdf8(reg5) -> reg0 type='struct css_set*' size=0x8 (die:0x1385c56)
  chk [13] reg0 offset=0x10 ok=1 kind=1 (struct css_set*) : Good!         <<<--- here
  found by insn track: 0x10(reg0) type-offset=0x10
  final result:  type='struct css_set' size=0x250 (die:0x1385b0e)

Another example:
  -----------------------------------------------------------
  find data type for 0x8(reg0) at menu_select+0x279
  CU for drivers/cpuidle/governors/menu.c (die:0x7b0fe79)
  frame base: cfa=1 fbreg=7
  scope: [2/2] (die:7b11010)
  bb: [273 - 277]
  bb: [279 - 279]
  chk [279] reg0 offset=0x8 ok=0 kind=0 cfa : no type information
  scope: [1/2] (die:7b10cbc)
  bb: [0 - 64]
  ...
  mov [26a] imm=0xffffffff -> reg15
  bb: [273 - 277]
  bb: [279 - 279]
  chk [279] reg0 offset=0x8 ok=1 kind=1 (long long unsigned int) : no/void pointer    <<<--- here
  final result: no/void pointer

Also change some places to print negative offsets properly.

Before:
  -----------------------------------------------------------
  find data type for 0xffffff40(reg6) at __tcp_transmit_skb+0x58

After:
  -----------------------------------------------------------
  find data type for -0xc0(reg6) at __tcp_transmit_skb+0x58

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate-data.c | 45 +++++++++++++++++++++++++--------
 1 file changed, 35 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index f5eefcb71c4f..cedfe6edcd45 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -960,9 +960,16 @@ static enum type_match_result check_matching_type(struct type_state *state,
 	Dwarf_Word size;
 	u32 insn_offset = dloc->ip - dloc->ms->sym->start;
 	int reg = dloc->op->reg1;
+	int offset = dloc->op->offset;
+	const char *offset_sign = "";
 
-	pr_debug_dtp("chk [%x] reg%d offset=%#x ok=%d kind=%d ",
-		     insn_offset, reg, dloc->op->offset,
+	if (offset < 0) {
+		offset = -offset;
+		offset_sign = "-";
+	}
+
+	pr_debug_dtp("chk [%x] reg%d offset=%s%#x ok=%d kind=%d ",
+		     insn_offset, reg, offset_sign, offset,
 		     state->regs[reg].ok, state->regs[reg].kind);
 
 	if (!state->regs[reg].ok)
@@ -970,6 +977,12 @@ static enum type_match_result check_matching_type(struct type_state *state,
 
 	if (state->regs[reg].kind == TSR_KIND_TYPE) {
 		Dwarf_Die sized_type;
+		struct strbuf sb;
+
+		strbuf_init(&sb, 32);
+		die_get_typename_from_type(&state->regs[reg].type, &sb);
+		pr_debug_dtp("(%s)", sb.buf);
+		strbuf_release(&sb);
 
 		/*
 		 * Normal registers should hold a pointer (or array) to
@@ -1119,7 +1132,6 @@ static enum type_match_result check_matching_type(struct type_state *state,
 check_kernel:
 	if (dso__kernel(map__dso(dloc->ms->map))) {
 		u64 addr;
-		int offset;
 
 		/* Direct this-cpu access like "%gs:0x34740" */
 		if (dloc->op->segment == INSN_SEG_X86_GS && dloc->op->imm &&
@@ -1271,6 +1283,13 @@ static enum type_match_result find_data_type_block(struct data_loc_info *dloc,
 					    cu_die, type_die);
 		if (ret == PERF_TMR_OK) {
 			char buf[64];
+			int offset = dloc->op->offset;
+			const char *offset_sign = "";
+
+			if (offset < 0) {
+				offset = -offset;
+				offset_sign = "-";
+			}
 
 			if (dloc->op->multi_regs)
 				snprintf(buf, sizeof(buf), "reg%d, reg%d",
@@ -1278,8 +1297,8 @@ static enum type_match_result find_data_type_block(struct data_loc_info *dloc,
 			else
 				snprintf(buf, sizeof(buf), "reg%d", dloc->op->reg1);
 
-			pr_debug_dtp("found by insn track: %#x(%s) type-offset=%#x\n",
-				     dloc->op->offset, buf, dloc->type_offset);
+			pr_debug_dtp("found by insn track: %s%#x(%s) type-offset=%#x\n",
+				     offset_sign, offset, buf, dloc->type_offset);
 			break;
 		}
 
@@ -1302,7 +1321,7 @@ static int find_data_type_die(struct data_loc_info *dloc, Dwarf_Die *type_die)
 	struct annotated_op_loc *loc = dloc->op;
 	Dwarf_Die cu_die, var_die;
 	Dwarf_Die *scopes = NULL;
-	int reg, offset;
+	int reg, offset = loc->offset;
 	int ret = -1;
 	int i, nr_scopes;
 	int fbreg = -1;
@@ -1312,6 +1331,7 @@ static int find_data_type_die(struct data_loc_info *dloc, Dwarf_Die *type_die)
 	u64 pc;
 	char buf[64];
 	enum type_match_result result = PERF_TMR_UNKNOWN;
+	const char *offset_sign = "";
 
 	if (dloc->op->multi_regs)
 		snprintf(buf, sizeof(buf), "reg%d, reg%d", dloc->op->reg1, dloc->op->reg2);
@@ -1320,10 +1340,15 @@ static int find_data_type_die(struct data_loc_info *dloc, Dwarf_Die *type_die)
 	else
 		snprintf(buf, sizeof(buf), "reg%d", dloc->op->reg1);
 
+	if (offset < 0) {
+		offset = -offset;
+		offset_sign = "-";
+	}
+
 	pr_debug_dtp("-----------------------------------------------------------\n");
-	pr_debug_dtp("find data type for %#x(%s) at %s+%#"PRIx64"\n",
-		     dloc->op->offset, buf, dloc->ms->sym->name,
-		     dloc->ip - dloc->ms->sym->start);
+	pr_debug_dtp("find data type for %s%#x(%s) at %s+%#"PRIx64"\n",
+		     offset_sign, offset, buf,
+		     dloc->ms->sym->name, dloc->ip - dloc->ms->sym->start);
 
 	/*
 	 * IP is a relative instruction address from the start of the map, as
@@ -1453,8 +1478,8 @@ static int find_data_type_die(struct data_loc_info *dloc, Dwarf_Die *type_die)
 	}
 
 out:
+	pr_debug_dtp("final result: ");
 	if (found) {
-		pr_debug_dtp("final type:");
 		pr_debug_type_name(type_die, TSR_KIND_TYPE);
 		ret = 0;
 	} else {
-- 
2.46.0.184.g6999bdac58-goog

