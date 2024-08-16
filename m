Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDB014A62A;
	Fri, 16 Aug 2024 23:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723852723; cv=none; b=QTGALBPS0tIL6FhlykyVUy8mskxJXJ/x8AlJnMZKXrRy06Vj5GAEF33lnjGVytMCtSYi9DYvJRyUz37jqLoqw5xkhmi/PB3KFyAgV3oTCix86q9dRqNHvsksw/M3XPI3AIq6O3KbW+rds8ErZBZt/ANpuZwMQ4FCYLCH65t5UTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723852723; c=relaxed/simple;
	bh=C9lHbeYRNAwoTKyMISt6eqSmOtp2+n5T/vIDIWLfjew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oWjhhXp9rabnoMSIKc6aPISxy8hcjHWsDB85scg3KexBZkdAerkbtU38V8Xs/goAyCn+15gz+HiFhzbX7Fyba5e63INL24fp8/zbb7Ayg4o+aWHpIR+IAwJcJHEs8HUyIpufMPQJdLN0gyo/sYKFYsDdktmxj2V3r2S35EytspE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GA/TUmTW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GA/TUmTW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6A6EC32782;
	Fri, 16 Aug 2024 23:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723852723;
	bh=C9lHbeYRNAwoTKyMISt6eqSmOtp2+n5T/vIDIWLfjew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GA/TUmTW7lQ0V9jN5MjwXgBRSLRSOp+4i//wtjAY1V4X3yGflHR9YSCQJEgBpaSUN
	 bfbckY4KBU07sZiXF0nC+nUuiYeA9yMjYP7A5iM3ueCA12MTVl3qc5YbSzz9RbcxY8
	 DaETmjTjozRDFsHmc+w6GA6oxZL4Y0VH6dmv1rKuJT6DPdmPLCs+eENTTgruOBAakm
	 Ny0eScDKgJJJjPMKuFxIW/X20EuXXvCxuyxeNNZOx0VzlLoimqVXBxWomi0sARn/tC
	 lm9zHjx76AqMWvmM82UCP8p9+hrYVyMatsA/WJv2jNcmVyAnxvSjF38heW84C4Kaan
	 lmUWH8b+oCfAQ==
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
Subject: [PATCH 4/9] perf annotate-data: Add variable_state_str()
Date: Fri, 16 Aug 2024 16:58:34 -0700
Message-ID: <20240816235840.2754937-5-namhyung@kernel.org>
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

So that it can show a proper debug message in the right place.  The
check_variable() is used in other places which don't want to print the
message.

  $ perf --debug type-profile annotate --data-type

Before:
  -----------------------------------------------------------
  find data type for 0x140(reg14) at update_blocked_averages+0x2db
  CU for kernel/sched/fair.c (die:0x12dd892)
  frame base: cfa=1 fbreg=7
  no pointer or no type                                         <<<--- removed
  check variable "__mptr" failed (die: 0x13022f1)
   variable location: base=reg14, offset=0x140
   type='void*' size=0x8 (die:0x12dd8f9)

After:
  -----------------------------------------------------------
  find data type for 0x140(reg14) at update_blocked_averages+0x2db
  CU for kernel/sched/fair.c (die:0x12dd892)
  frame base: cfa=1 fbreg=7
  found "__mptr" (die: 0x13022f1) in scope=4/4 (die: 0x13022e8) failed: no/void pointer  <<<--- here
   variable location: base=reg14, offset=0x140
   type='void*' size=0x8 (die:0x12dd8f9)

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate-data.c | 41 +++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 15 deletions(-)

diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index 8e3b422eca22..332254da49be 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -354,6 +354,25 @@ enum type_match_result {
 	PERF_TMR_BAD_OFFSET,
 };
 
+static const char *match_result_str(enum type_match_result tmr)
+{
+	switch (tmr) {
+	case PERF_TMR_OK:
+		return "Good!";
+	case PERF_TMR_NO_TYPE:
+		return "no type information";
+	case PERF_TMR_NO_POINTER:
+		return "no/void pointer";
+	case PERF_TMR_NO_SIZE:
+		return "type size is unknown";
+	case PERF_TMR_BAD_OFFSET:
+		return "offset bigger than size";
+	case PERF_TMR_UNKNOWN:
+	default:
+		return "invalid state";
+	}
+}
+
 /* The type info will be saved in @type_die */
 static enum type_match_result check_variable(struct data_loc_info *dloc,
 					     Dwarf_Die *var_die,
@@ -373,7 +392,6 @@ static enum type_match_result check_variable(struct data_loc_info *dloc,
 
 	/* Get the type of the variable */
 	if (__die_get_real_type(var_die, type_die) == NULL) {
-		pr_debug_dtp("variable has no type\n");
 		ann_data_stat.no_typeinfo++;
 		return PERF_TMR_NO_TYPE;
 	}
@@ -387,7 +405,6 @@ static enum type_match_result check_variable(struct data_loc_info *dloc,
 		if ((dwarf_tag(type_die) != DW_TAG_pointer_type &&
 		     dwarf_tag(type_die) != DW_TAG_array_type) ||
 		    __die_get_real_type(type_die, type_die) == NULL) {
-			pr_debug_dtp("no pointer or no type\n");
 			ann_data_stat.no_typeinfo++;
 			return PERF_TMR_NO_POINTER;
 		}
@@ -400,15 +417,12 @@ static enum type_match_result check_variable(struct data_loc_info *dloc,
 
 	/* Get the size of the actual type */
 	if (dwarf_aggregate_size(&sized_type, &size) < 0) {
-		pr_debug_dtp("type size is unknown\n");
 		ann_data_stat.invalid_size++;
 		return PERF_TMR_NO_SIZE;
 	}
 
 	/* Minimal sanity check */
 	if ((unsigned)offset >= size) {
-		pr_debug_dtp("offset: %d is bigger than size: %"PRIu64"\n",
-			     offset, size);
 		ann_data_stat.bad_offset++;
 		return PERF_TMR_BAD_OFFSET;
 	}
@@ -1310,12 +1324,13 @@ static int find_data_type_die(struct data_loc_info *dloc, Dwarf_Die *type_die)
 				continue;
 		}
 
+		pr_debug_dtp("found \"%s\" (die: %#lx) in scope=%d/%d (die: %#lx) ",
+			     dwarf_diename(&var_die), (long)dwarf_dieoffset(&var_die),
+			     i+1, nr_scopes, (long)dwarf_dieoffset(&scopes[i]));
+
 		/* Found a variable, see if it's correct */
 		result = check_variable(dloc, &var_die, type_die, reg, offset, is_fbreg);
 		if (result == PERF_TMR_OK) {
-			pr_debug_dtp("found \"%s\" in scope=%d/%d (die: %#lx) ",
-				     dwarf_diename(&var_die), i+1, nr_scopes,
-				     (long)dwarf_dieoffset(&scopes[i]));
 			if (reg == DWARF_REG_PC) {
 				pr_debug_dtp("addr=%#"PRIx64" type_offset=%#x\n",
 					     dloc->var_addr, offset);
@@ -1325,17 +1340,13 @@ static int find_data_type_die(struct data_loc_info *dloc, Dwarf_Die *type_die)
 			} else {
 				pr_debug_dtp("type_offset=%#x\n", offset);
 			}
-			pr_debug_location(&var_die, pc, reg);
-			pr_debug_type_name(type_die, TSR_KIND_TYPE);
 			ret = 0;
 		} else {
-			pr_debug_dtp("check variable \"%s\" failed (die: %#lx)\n",
-				     dwarf_diename(&var_die),
-				     (long)dwarf_dieoffset(&var_die));
-			pr_debug_location(&var_die, pc, reg);
-			pr_debug_type_name(type_die, TSR_KIND_TYPE);
+			pr_debug_dtp("failed: %s\n", match_result_str(result));
 			ret = -1;
 		}
+		pr_debug_location(&var_die, pc, reg);
+		pr_debug_type_name(type_die, TSR_KIND_TYPE);
 		dloc->type_offset = offset;
 		goto out;
 	}
-- 
2.46.0.184.g6999bdac58-goog

