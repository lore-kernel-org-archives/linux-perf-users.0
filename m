Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190301553A3;
	Fri, 16 Aug 2024 23:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723852726; cv=none; b=VGuMztvbD2sAz8LTUJVtnpr7VQ0nt8tp5SfcQNts6uMu3RBGovzyjMIqF4FYnQJLh/RYiWhfkrlalXTrPevbIjVeH8OMZcteCj3fnEXCzOEO76mtL0Qy/U8YXxwtPObNsZ0rFHrJ/uAD3ypuoNHOMhwoeEqeFgTye+bR09OLm40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723852726; c=relaxed/simple;
	bh=bVwU8VTS7qfB6LIa6XnvFuKDHO0RzgTfbyXDJAdcTdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OdguynwZ4cmAknOVUNVmuT9telYeEipebsHAZHabQJsxvkOFUoQBLNzR2BZppsE6l/wXebZaXg+VVbuYvEbmRHfGI6tBHSHPKqnGJsPpWrTfKJKdngfrvJ8QKImiSB4ZYFp6oD5knu1OyqTe5ogEudG0kKw9tsFOdydE1YET+Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s9u7P7pq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s9u7P7pq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C51DC4AF09;
	Fri, 16 Aug 2024 23:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723852725;
	bh=bVwU8VTS7qfB6LIa6XnvFuKDHO0RzgTfbyXDJAdcTdY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s9u7P7pqv6Q+nJRJlb2bvCokLoc5eoRXOSePx2m9uV1zikirp9yNiSVuWB6H8y5ws
	 +b3fzRL9wKcCnWU/JvjEDemG0YcSe1jbHdfRmBs2gzBQT2ZhKMl3grd1zzM4IQjELa
	 3Pos8xjRBWBmnHBsbY8Dh02pos0iF3ch13jWpF8+ImN79vRWUO6kUJpO+mcGG4g2/N
	 nKQsi43NpYkuMjsfqr/6ICEWclLLnJdJMQmZkd8Kb7tOB5vYZ7OoqHx4+bzyHhbVnJ
	 b2SZIc2hwdyAQQc8kjMzAa2NWX2gxZ11wrFD9y12fohmwTdJ29HOEqjqW44Z9ubaCw
	 5obW7SXI52L7Q==
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
Subject: [PATCH 9/9] perf annotate-data: Update type stat at the end of find_data_type_die()
Date: Fri, 16 Aug 2024 16:58:39 -0700
Message-ID: <20240816235840.2754937-10-namhyung@kernel.org>
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

after trying all possibilities with DWARF and instruction tracking.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate-data.c | 47 +++++++++++++++++++++------------
 1 file changed, 30 insertions(+), 17 deletions(-)

diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index e86f40fed323..aa330c7d8edd 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -432,10 +432,8 @@ static enum type_match_result check_variable(struct data_loc_info *dloc,
 		needs_pointer = false;
 
 	/* Get the type of the variable */
-	if (__die_get_real_type(var_die, type_die) == NULL) {
-		ann_data_stat.no_typeinfo++;
+	if (__die_get_real_type(var_die, type_die) == NULL)
 		return PERF_TMR_NO_TYPE;
-	}
 
 	/*
 	 * Usually it expects a pointer type for a memory access.
@@ -444,10 +442,8 @@ static enum type_match_result check_variable(struct data_loc_info *dloc,
 	 */
 	if (needs_pointer) {
 		if (!is_pointer_type(type_die) ||
-		    __die_get_real_type(type_die, type_die) == NULL) {
-			ann_data_stat.no_typeinfo++;
+		    __die_get_real_type(type_die, type_die) == NULL)
 			return PERF_TMR_NO_POINTER;
-		}
 	}
 
 	if (dwarf_tag(type_die) == DW_TAG_typedef)
@@ -456,16 +452,12 @@ static enum type_match_result check_variable(struct data_loc_info *dloc,
 		sized_type = *type_die;
 
 	/* Get the size of the actual type */
-	if (dwarf_aggregate_size(&sized_type, &size) < 0) {
-		ann_data_stat.invalid_size++;
+	if (dwarf_aggregate_size(&sized_type, &size) < 0)
 		return PERF_TMR_NO_SIZE;
-	}
 
 	/* Minimal sanity check */
-	if ((unsigned)offset >= size) {
-		ann_data_stat.bad_offset++;
+	if ((unsigned)offset >= size)
 		return PERF_TMR_BAD_OFFSET;
-	}
 
 	return PERF_TMR_OK;
 }
@@ -1275,7 +1267,7 @@ static int find_data_type_die(struct data_loc_info *dloc, Dwarf_Die *type_die)
 	bool found = false;
 	u64 pc;
 	char buf[64];
-	enum type_match_result result;
+	enum type_match_result result = PERF_TMR_UNKNOWN;
 
 	if (dloc->op->multi_regs)
 		snprintf(buf, sizeof(buf), "reg%d, reg%d", dloc->op->reg1, dloc->op->reg2);
@@ -1317,7 +1309,7 @@ static int find_data_type_die(struct data_loc_info *dloc, Dwarf_Die *type_die)
 			pr_debug_dtp("found by addr=%#"PRIx64" type_offset=%#x\n",
 				     dloc->var_addr, offset);
 			pr_debug_type_name(type_die, TSR_KIND_TYPE);
-			ret = 0;
+			found = true;
 			goto out;
 		}
 	}
@@ -1416,16 +1408,37 @@ static int find_data_type_die(struct data_loc_info *dloc, Dwarf_Die *type_die)
 		}
 	}
 
+out:
 	if (found) {
 		pr_debug_dtp("final type:");
 		pr_debug_type_name(type_die, TSR_KIND_TYPE);
 		ret = 0;
 	} else {
-		pr_debug_dtp("no variable found\n");
-		ann_data_stat.no_var++;
+		switch (result) {
+		case PERF_TMR_NO_TYPE:
+		case PERF_TMR_NO_POINTER:
+			pr_debug_dtp("%s\n", match_result_str(result));
+			ann_data_stat.no_typeinfo++;
+			break;
+		case PERF_TMR_NO_SIZE:
+			pr_debug_dtp("%s\n", match_result_str(result));
+			ann_data_stat.invalid_size++;
+			break;
+		case PERF_TMR_BAD_OFFSET:
+			pr_debug_dtp("%s\n", match_result_str(result));
+			ann_data_stat.bad_offset++;
+			break;
+		case PERF_TMR_UNKNOWN:
+		case PERF_TMR_BAIL_OUT:
+		case PERF_TMR_OK:  /* should not reach here */
+		default:
+			pr_debug_dtp("no variable found\n");
+			ann_data_stat.no_var++;
+			break;
+		}
+		ret = -1;
 	}
 
-out:
 	free(scopes);
 	return ret;
 }
-- 
2.46.0.184.g6999bdac58-goog

