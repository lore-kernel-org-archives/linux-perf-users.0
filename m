Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A05315380A;
	Fri, 16 Aug 2024 23:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723852725; cv=none; b=oM0UB70+7KH2t/Ay0K+kBLMViE71xNILfmiUvoArVF8A1t3HJn4rb7kayMl/9zT3JH7mXOyChtWg9Nq1j9twcZfvApiOJ1hxUKdYbndbgfQOtEHawW2NPdvBoJwM0mDl+59k0k14CyiBGinb8U60+klolI/HWx6cG3jWi9FeYTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723852725; c=relaxed/simple;
	bh=SwbCiTE6qWd50qP+TjB2e7IR1OYwVHpD2mKCyGVMPx0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uzl+uupSUj9njL2BtAVRL2q0TmjoNTm+T90Yhxbj+nFGEIL+a4P725RFGCx3U/C+gCSWpsynxejBNe8z5Hjh7sY1ep76AHlAqi/tKCV1W6LvtvPKICwMIOKOIGDpBtU78POd3XQOA1ex8lzoJohlHdFFZu5txO7fpfYiPmhJKX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W/GEEUHv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W/GEEUHv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AB92C4AF13;
	Fri, 16 Aug 2024 23:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723852724;
	bh=SwbCiTE6qWd50qP+TjB2e7IR1OYwVHpD2mKCyGVMPx0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W/GEEUHv1dWqijbA/zsrwVRIdjXjHr0GC7E9rtSf21WYfwp/qNNaQ+0vtCUDzxqxU
	 JO2P3H5prk1UaX8iB4F8JQbTlIlsYajK8HouQ+s3zCDPAx3716HPhuMlbKOA3DMe8y
	 QpQ7FAKKYtRZqPhFSYNJDHZw7mKRanUdsdYRHjRLWzvmTOCUH+LX56hJy5uNtq86dZ
	 Llq7NS7lx59dhe3H7C+p5qHS7iIXntPFZa/qkap7BSp2e65aCs6bFfUFb4NlFXw/67
	 TGbYCB9EicU5tgB0AMrQdAF3Idjd8oOEwj2DNuR97Ul/w615oP2v9DWRMlSSR3o8+H
	 zi0iomprAUVog==
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
Subject: [PATCH 7/9] perf annotate-data: Add is_better_type() helper
Date: Fri, 16 Aug 2024 16:58:37 -0700
Message-ID: <20240816235840.2754937-8-namhyung@kernel.org>
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

Sometimes more than one variables are located in the same register or a
stack slot.  Or it can overwrite existing information with others.  I
found this is not helpful in some cases so it needs to update the type
information from the variable only if it's better.

But it's hard to know which one is better, so we needs heuristics. :)

As it deals with memory accesses, the location should have a pointer or
something similar (like array or reference).  So if it had an integer
type and a variable is a pointer, we can take the variable's type to
resolve the target of the access.

If it has a pointer type and a variable with the same location has a
different pointer type, it'll take one with bigger target type.  This
can be useful when the target type embeds a smaller type (like list
header or RB-tree node) at the beginning so their location is same.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate-data.c | 61 +++++++++++++++++++++++++++------
 1 file changed, 51 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index b2414747cdeb..916d26bfb9eb 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -382,6 +382,38 @@ static bool is_pointer_type(Dwarf_Die *type_die)
 	return tag == DW_TAG_pointer_type || tag == DW_TAG_array_type;
 }
 
+/* returns if Type B has better information than Type A */
+static bool is_better_type(Dwarf_Die *type_a, Dwarf_Die *type_b)
+{
+	Dwarf_Word size_a, size_b;
+	Dwarf_Die die_a, die_b;
+
+	/* pointer type is preferred */
+	if (is_pointer_type(type_a) != is_pointer_type(type_b))
+		return is_pointer_type(type_b);
+
+	if (is_pointer_type(type_b)) {
+		/*
+		 * We want to compare the target type, but 'void *' can fail to
+		 * get the target type.
+		 */
+		if (die_get_real_type(type_a, &die_a) == NULL)
+			return true;
+		if (die_get_real_type(type_b, &die_b) == NULL)
+			return false;
+
+		type_a = &die_a;
+		type_b = &die_b;
+	}
+
+	/* bigger type is preferred */
+	if (dwarf_aggregate_size(type_a, &size_a) < 0 ||
+	    dwarf_aggregate_size(type_b, &size_b) < 0)
+		return false;
+
+	return size_a < size_b;
+}
+
 /* The type info will be saved in @type_die */
 static enum type_match_result check_variable(struct data_loc_info *dloc,
 					     Dwarf_Die *var_die,
@@ -741,24 +773,33 @@ static void update_var_state(struct type_state *state, struct data_loc_info *dlo
 		if (!dwarf_offdie(dloc->di->dbg, var->die_off, &mem_die))
 			continue;
 
-		if (var->reg == DWARF_REG_FB) {
-			findnew_stack_state(state, var->offset, TSR_KIND_TYPE,
-					    &mem_die);
+		if (var->reg == DWARF_REG_FB || var->reg == fbreg) {
+			int offset = var->offset;
+			struct type_state_stack *stack;
 
-			pr_debug_dtp("var [%"PRIx64"] -%#x(stack)",
-				     insn_offset, -var->offset);
-			pr_debug_type_name(&mem_die, TSR_KIND_TYPE);
-		} else if (var->reg == fbreg) {
-			findnew_stack_state(state, var->offset - fb_offset,
-					    TSR_KIND_TYPE, &mem_die);
+			if (var->reg != DWARF_REG_FB)
+				offset -= fb_offset;
+
+			stack = find_stack_state(state, offset);
+			if (stack && stack->kind == TSR_KIND_TYPE &&
+			    !is_better_type(&stack->type, &mem_die))
+				continue;
+
+			findnew_stack_state(state, offset, TSR_KIND_TYPE,
+					    &mem_die);
 
 			pr_debug_dtp("var [%"PRIx64"] -%#x(stack)",
-				     insn_offset, -var->offset + fb_offset);
+				     insn_offset, -offset);
 			pr_debug_type_name(&mem_die, TSR_KIND_TYPE);
 		} else if (has_reg_type(state, var->reg) && var->offset == 0) {
 			struct type_state_reg *reg;
 
 			reg = &state->regs[var->reg];
+
+			if (reg->ok && reg->kind == TSR_KIND_TYPE &&
+			    !is_better_type(&reg->type, &mem_die))
+				continue;
+
 			reg->type = mem_die;
 			reg->kind = TSR_KIND_TYPE;
 			reg->ok = true;
-- 
2.46.0.184.g6999bdac58-goog

