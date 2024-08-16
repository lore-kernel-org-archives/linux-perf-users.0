Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85D915533F;
	Fri, 16 Aug 2024 23:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723852725; cv=none; b=lvvSKvH5svIPqgPqQIVUdd3iqphsoTrvNslF01adnsr7TopfzauirvXr2mswCnEFgoynoEdjvvfBu4sa1Eu2eSv1r9u6+iFLqP7fWvNPXIzjotGVyT7b2xdgKluCSxvvZS7alPN+bbZLJu8VzP+SpgnPwPbQmbH1yUgZlNHGnoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723852725; c=relaxed/simple;
	bh=gz0UmCdJs9jShwr5ENMPky04B9rwbyy9PU/CsFkc5aI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KYN7Vx3PABN7W2HXffkJqlCZDJRDqkyJAIHfDxNXUV5G2YRO/149rmdyd39JTS7/lOuLOwLwfRhe3VR6PGXX3VBSf0vh+oNLQ0+318Ltadd5RWttAaXM/NC+S4fOGfuLg1+moiDIbMVhc4j8QProWzJkpP5xHxSgofhs76pqbI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MQO/8JCp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MQO/8JCp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B055C4AF11;
	Fri, 16 Aug 2024 23:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723852725;
	bh=gz0UmCdJs9jShwr5ENMPky04B9rwbyy9PU/CsFkc5aI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MQO/8JCpt/Db31GLkMRFMbBzVIu1cIe0JNlruvGsta8HKldlmSkKqer32mizjs2AQ
	 3N/pHeFEQ5XJnlJ1DIIXANgNLyjdJBY0ekNNzsswB2LFeVaZqAKKPd75Dv8hp8obBQ
	 TPi7y5k2eTTCkKwihrEdK+FM4e/xyXu9PaMjIk0FL1IdiHtoFbrcNEWeNEKRoUt46M
	 j5WtyujfnEfWoj1SzcBfCNm7LiNaDI8Genjs7Dc/QyuQnx2qwi6kvKlYSIgXcbG3nE
	 LQIac85y17zxEgYG74LMLxqcdPEK1eTw5h7n8g4sN+/mPqngWLWahmYSvAyEn59Q7d
	 7qo3NqamIKRGA==
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
Subject: [PATCH 8/9] perf annotate-data: Check variables in every scope
Date: Fri, 16 Aug 2024 16:58:38 -0700
Message-ID: <20240816235840.2754937-9-namhyung@kernel.org>
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

Sometimes it matches a variable in the inner scope but it fails because
the actual access can be on a different type.  Let's try variables in
every scope and choose the best one using is_better_type().

I have an example with update_blocked_averages(), at first it found a
variable (__mptr) but it's a void pointer.  So it moved on to the upper
scope and found another variable (cfs_rq).

  $ perf --debug type-profile annotate --data-type --stdio
  ...
  -----------------------------------------------------------
  find data type for 0x140(reg14) at update_blocked_averages+0x2db
  CU for kernel/sched/fair.c (die:0x12dd892)
  frame base: cfa=1 fbreg=7
  found "__mptr" (die: 0x13022f1) in scope=4/4 (die: 0x13022e8) failed: no/void pointer
   variable location: base=reg14, offset=0x140
   type='void*' size=0x8 (die:0x12dd8f9)
  found "cfs_rq" (die: 0x1301721) in scope=3/4 (die: 0x130171c) type_offset=0x140
   variable location: reg14
   type='struct cfs_rq' size=0x1c0 (die:0x12e37e5)
  final type: type='struct cfs_rq' size=0x1c0 (die:0x12e37e5)

IIUC the scope is like below:
  1: update_blocked_averages
  2:   __update_blocked_fair
  3:     for_each_leaf_cfs_rq_safe
  4:       list_entry -> (container_of)

The container_of is implemented like:

  #define container_of(ptr, type, member) ({				\
  	void *__mptr = (void *)(ptr);					\
  	static_assert(__same_type(*(ptr), ((type *)0)->member) ||	\
  		      __same_type(*(ptr), void),			\
  		      "pointer type mismatch in container_of()");	\
  	((type *)(__mptr - offsetof(type, member))); })

That's why we see the __mptr variable first but it failed since it has
no type information.

Then for_each_leaf_cfs_rq_safe() is defined as

  #define for_each_leaf_cfs_rq_safe(rq, cfs_rq, pos)			\
  	list_for_each_entry_safe(cfs_rq, pos, &rq->leaf_cfs_rq_list,	\
  				 leaf_cfs_rq_list)

Note that the access was 0x140(r14).  And the cfs_rq has
leaf_cfs_rq_list at the 0x140.  So it converts the list_head pointer to
a pointer to struct cfs_rq here.

  $ pahole --hex -C cfs_rq vmlinux | grep 140
  struct cfs_rq 	struct list_head           leaf_cfs_rq_list;     /* 0x140  0x10 */

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate-data.c | 44 ++++++++++++++++++++-------------
 1 file changed, 27 insertions(+), 17 deletions(-)

diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index 916d26bfb9eb..e86f40fed323 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -1244,7 +1244,6 @@ static enum type_match_result find_data_type_block(struct data_loc_info *dloc,
 
 			pr_debug_dtp("found by insn track: %#x(%s) type-offset=%#x\n",
 				     dloc->op->offset, buf, dloc->type_offset);
-			pr_debug_type_name(type_die, TSR_KIND_TYPE);
 			break;
 		}
 
@@ -1273,6 +1272,7 @@ static int find_data_type_die(struct data_loc_info *dloc, Dwarf_Die *type_die)
 	int fbreg = -1;
 	int fb_offset = 0;
 	bool is_fbreg = false;
+	bool found = false;
 	u64 pc;
 	char buf[64];
 	enum type_match_result result;
@@ -1358,14 +1358,17 @@ static int find_data_type_die(struct data_loc_info *dloc, Dwarf_Die *type_die)
 
 	/* Search from the inner-most scope to the outer */
 	for (i = nr_scopes - 1; i >= 0; i--) {
+		Dwarf_Die mem_die;
+		int type_offset = offset;
+
 		if (reg == DWARF_REG_PC) {
 			if (!die_find_variable_by_addr(&scopes[i], dloc->var_addr,
-						       &var_die, &offset))
+						       &var_die, &type_offset))
 				continue;
 		} else {
 			/* Look up variables/parameters in this scope */
 			if (!die_find_variable_by_reg(&scopes[i], pc, reg,
-						      &offset, is_fbreg, &var_die))
+						      &type_offset, is_fbreg, &var_die))
 				continue;
 		}
 
@@ -1374,43 +1377,50 @@ static int find_data_type_die(struct data_loc_info *dloc, Dwarf_Die *type_die)
 			     i+1, nr_scopes, (long)dwarf_dieoffset(&scopes[i]));
 
 		/* Found a variable, see if it's correct */
-		result = check_variable(dloc, &var_die, type_die, reg, offset, is_fbreg);
+		result = check_variable(dloc, &var_die, &mem_die, reg, type_offset, is_fbreg);
 		if (result == PERF_TMR_OK) {
 			if (reg == DWARF_REG_PC) {
 				pr_debug_dtp("addr=%#"PRIx64" type_offset=%#x\n",
-					     dloc->var_addr, offset);
+					     dloc->var_addr, type_offset);
 			} else if (reg == DWARF_REG_FB || is_fbreg) {
 				pr_debug_dtp("stack_offset=%#x type_offset=%#x\n",
-					     fb_offset, offset);
+					     fb_offset, type_offset);
 			} else {
-				pr_debug_dtp("type_offset=%#x\n", offset);
+				pr_debug_dtp("type_offset=%#x\n", type_offset);
+			}
+
+			if (!found || is_better_type(type_die, &mem_die)) {
+				*type_die = mem_die;
+				dloc->type_offset = type_offset;
+				found = true;
 			}
-			ret = 0;
 		} else {
 			pr_debug_dtp("failed: %s\n", match_result_str(result));
-			ret = -1;
 		}
+
 		pr_debug_location(&var_die, pc, reg);
-		pr_debug_type_name(type_die, TSR_KIND_TYPE);
-		dloc->type_offset = offset;
-		goto out;
+		pr_debug_type_name(&mem_die, TSR_KIND_TYPE);
 	}
 
-	if (loc->multi_regs && reg == loc->reg1 && loc->reg1 != loc->reg2) {
+	if (!found && loc->multi_regs && reg == loc->reg1 && loc->reg1 != loc->reg2) {
 		reg = loc->reg2;
 		goto retry;
 	}
 
-	if (reg != DWARF_REG_PC) {
+	if (!found && reg != DWARF_REG_PC) {
 		result = find_data_type_block(dloc, &cu_die, scopes,
-					   nr_scopes, type_die);
+					      nr_scopes, type_die);
 		if (result == PERF_TMR_OK) {
 			ann_data_stat.insn_track++;
-			ret = 0;
+			found = true;
 		}
 	}
 
-	if (ret < 0) {
+	if (found) {
+		pr_debug_dtp("final type:");
+		pr_debug_type_name(type_die, TSR_KIND_TYPE);
+		ret = 0;
+	} else {
 		pr_debug_dtp("no variable found\n");
 		ann_data_stat.no_var++;
 	}
-- 
2.46.0.184.g6999bdac58-goog

