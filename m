Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C515F13D51B;
	Fri, 16 Aug 2024 23:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723852724; cv=none; b=GYE6kRg18YeviLt7bPVjRq/sT8totye/fCJgyneiYBFeR59jWLkP2yzpuUMD2qIfaoaYEwGsBP9gHy2ZB34UgHyz8hXiCuwVBOB0j11jDqYlLxiR/p22KtINbujkwgatUMBZOr9ew440/1rseS/WpEKOHO+Qb+xIMJKRxE5EEEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723852724; c=relaxed/simple;
	bh=OoqgGDfXJTydY97bMo4SdpTXavrvCBBCpnszshPk/mY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MXRYrfye5G8MOKAlb0fOdJVJG+na31k5N0GYJIp94lkvzkfshsZShp6OUcynE1NvCE6gLp1VCaynLDBQAJmeGzYrKvJh0fYogSPOf3ZIfaAhFTovrbFwmUq2oT6m/zn0J8aQIfEZ8+gficlx1mxZALitIoVfIu+qIstIlpRlI8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tNyb2oDB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tNyb2oDB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBBBBC4AF0E;
	Fri, 16 Aug 2024 23:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723852724;
	bh=OoqgGDfXJTydY97bMo4SdpTXavrvCBBCpnszshPk/mY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tNyb2oDB6cdvoIX7Z6OiR2r9BzWRmwtsP2YskSRZQBArirv8yekFZVFlTwubHMTKV
	 HwKwdTPtwovFffaVsp2Z/wcCVBYHUurnh9Fks92qqQJ6fhSD9yCa6APB3JB+z9ZxF+
	 6/bXESQ0zL8lt+nH9PJRvKc1Xp0M33sf4oFK/7aA3XpXATYGmrNlVe38KaIfa/5pLh
	 uMcTGFITXynAmmPPPoks3GJHsKRH9MlTZF1NqomGfjeAbJ4HQbtYF3bvVvHHH8AduM
	 lBtA7Ljem7i1bcXuq9sHiZAC29H5oSY43hVJ3sKyP81pARdFT1AeucEI1nkXiNlpZ0
	 rA0VFFugeWaFA==
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
Subject: [PATCH 6/9] perf annotate-data: Add is_pointer_type() helper
Date: Fri, 16 Aug 2024 16:58:36 -0700
Message-ID: <20240816235840.2754937-7-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
In-Reply-To: <20240816235840.2754937-1-namhyung@kernel.org>
References: <20240816235840.2754937-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It treats pointers and arrays in the same way.  Let's add the helper and
use it when it checks if it needs a pointer.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate-data.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index 5548cd8e84ba..b2414747cdeb 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -375,6 +375,13 @@ static const char *match_result_str(enum type_match_result tmr)
 	}
 }
 
+static bool is_pointer_type(Dwarf_Die *type_die)
+{
+	int tag = dwarf_tag(type_die);
+
+	return tag == DW_TAG_pointer_type || tag == DW_TAG_array_type;
+}
+
 /* The type info will be saved in @type_die */
 static enum type_match_result check_variable(struct data_loc_info *dloc,
 					     Dwarf_Die *var_die,
@@ -382,15 +389,15 @@ static enum type_match_result check_variable(struct data_loc_info *dloc,
 					     int offset, bool is_fbreg)
 {
 	Dwarf_Word size;
-	bool is_pointer = true;
+	bool needs_pointer = true;
 	Dwarf_Die sized_type;
 
 	if (reg == DWARF_REG_PC)
-		is_pointer = false;
+		needs_pointer = false;
 	else if (reg == dloc->fbreg || is_fbreg)
-		is_pointer = false;
+		needs_pointer = false;
 	else if (arch__is(dloc->arch, "x86") && reg == X86_REG_SP)
-		is_pointer = false;
+		needs_pointer = false;
 
 	/* Get the type of the variable */
 	if (__die_get_real_type(var_die, type_die) == NULL) {
@@ -403,9 +410,8 @@ static enum type_match_result check_variable(struct data_loc_info *dloc,
 	 * Convert to a real type it points to.  But global variables
 	 * and local variables are accessed directly without a pointer.
 	 */
-	if (is_pointer) {
-		if ((dwarf_tag(type_die) != DW_TAG_pointer_type &&
-		     dwarf_tag(type_die) != DW_TAG_array_type) ||
+	if (needs_pointer) {
+		if (!is_pointer_type(type_die) ||
 		    __die_get_real_type(type_die, type_die) == NULL) {
 			ann_data_stat.no_typeinfo++;
 			return PERF_TMR_NO_POINTER;
@@ -887,14 +893,13 @@ static enum type_match_result check_matching_type(struct type_state *state,
 		     state->regs[reg].ok, state->regs[reg].kind);
 
 	if (state->regs[reg].ok && state->regs[reg].kind == TSR_KIND_TYPE) {
-		int tag = dwarf_tag(&state->regs[reg].type);
 		Dwarf_Die sized_type;
 
 		/*
 		 * Normal registers should hold a pointer (or array) to
 		 * dereference a memory location.
 		 */
-		if (tag != DW_TAG_pointer_type && tag != DW_TAG_array_type) {
+		if (!is_pointer_type(&state->regs[reg].type)) {
 			if (dloc->op->offset < 0 && reg != state->stack_reg)
 				goto check_kernel;
 
-- 
2.46.0.184.g6999bdac58-goog

