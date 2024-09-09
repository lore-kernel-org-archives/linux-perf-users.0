Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B60718C90E;
	Mon,  9 Sep 2024 21:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725918173; cv=none; b=GO6HBofG49olgeY+4WlHyCO3QbLMXdi1dXOZKUZdDx3qzt/KYSoPlJtzJ7CcgNykpZrMp+bgu7qqhFjak5G5axF8zEt0brZOQrZOvSzGGvyTNjKXc3uwBskzSqTkeYsnu+m4PyqKoxwjdDv0cowjRbRTT/xRLQxRRnrExsxvjEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725918173; c=relaxed/simple;
	bh=uZ+OSYg5bTrQDtQdjQGUwjTCZ7XxikIsQL3P7hK97xk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rb010mQnuM+DH/wftXYmUr5KOVqq42CxBBItVbVPnuUjnhretDTDouuV5Bk83oe3UUooDbOHwOYhe+J/71pQOs4EitaJrDJkrBouL4hdrADHr+PJcru6W9/YJ11tFNtiZN2N75pdocm16DcOC7V9wnj0AfhgJSsl4XuMrHn8wPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KDJ7I0g6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KDJ7I0g6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B8B9C4CEC6;
	Mon,  9 Sep 2024 21:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725918173;
	bh=uZ+OSYg5bTrQDtQdjQGUwjTCZ7XxikIsQL3P7hK97xk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KDJ7I0g6o3Mw6MywIb/5vdLUvXOHchg/PTdvk2CxOF1Rq5lFAWomDZoINWtgwGZzY
	 2MnJbcceBFbueyAFbS6lAeIag1VaLoT6YS8qqMU0Ke7xDexTbMvGbM21iRtPrWYcDN
	 1N/7rTLRU4DsEeP2ri+Lq9cT0YFrb3/Her68z0rAihRrX3IWAgzU/Tb+C7FEauLrwC
	 WB5WoeqYmX9Oq84vIbb/kmHhfW2+rnrULP5/fns8bTmL3RxNXefJwiAhrzFB37jWzR
	 UDlcWMqDwAReSj6UG3L+Xw6xN2DU/noCOpws6y9ibzM/94JnpDk3AxjpyfmBikBdnt
	 yG6PSEqGBc1Nw==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 2/2] perf annotate-data: Add pr_debug_scope()
Date: Mon,  9 Sep 2024 14:42:51 -0700
Message-ID: <20240909214251.3033827-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
In-Reply-To: <20240909214251.3033827-1-namhyung@kernel.org>
References: <20240909214251.3033827-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The pr_debug_scope() is to print more information about the scope DIE
during the instruction tracking so that it can help finding relevant
debug info and the source code like inlined functions more easily.

  $ perf --debug type-profile annotate --data-type
  ...
  -----------------------------------------------------------
  find data type for 0(reg0, reg12) at set_task_cpu+0xdd
  CU for kernel/sched/core.c (die:0x1268dae)
  frame base: cfa=1 fbreg=7
  scope: [3/3] (die:12b6d28) [inlined] set_task_rq       <<<--- (here)
  bb: [9f - dd]
  var [9f] reg3 type='struct task_struct*' size=0x8 (die:0x126aff0)
  var [9f] reg6 type='unsigned int' size=0x4 (die:0x1268e0d)

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate-data.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index a0ea4e07e57031ff..976abedca09ef547 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -131,6 +131,26 @@ static void pr_debug_location(Dwarf_Die *die, u64 pc, int reg)
 	}
 }
 
+static void pr_debug_scope(Dwarf_Die *scope_die)
+{
+	int tag;
+
+	if (!debug_type_profile && verbose < 3)
+		return;
+
+	pr_info("(die:%lx) ", (long)dwarf_dieoffset(scope_die));
+
+	tag = dwarf_tag(scope_die);
+	if (tag == DW_TAG_subprogram)
+		pr_info("[function] %s\n", dwarf_diename(scope_die));
+	else if (tag == DW_TAG_inlined_subroutine)
+		pr_info("[inlined] %s\n", dwarf_diename(scope_die));
+	else if (tag == DW_TAG_lexical_block)
+		pr_info("[block]\n");
+	else
+		pr_info("[unknown] tag=%x\n", tag);
+}
+
 bool has_reg_type(struct type_state *state, int reg)
 {
 	return (unsigned)reg < ARRAY_SIZE(state->regs);
@@ -1305,8 +1325,9 @@ static enum type_match_result find_data_type_block(struct data_loc_info *dloc,
 		if (dwarf_ranges(&scopes[i], 0, &base, &start, &end) < 0)
 			break;
 
-		pr_debug_dtp("scope: [%d/%d] (die:%lx)\n",
-			     i + 1, nr_scopes, (long)dwarf_dieoffset(&scopes[i]));
+		pr_debug_dtp("scope: [%d/%d] ", i + 1, nr_scopes);
+		pr_debug_scope(&scopes[i]);
+
 		src_ip = map__objdump_2rip(dloc->ms->map, start);
 
 again:
-- 
2.46.0.598.g6f2099f65c-goog

