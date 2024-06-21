Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E221667FA;
	Fri, 21 Jun 2024 17:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718989530; cv=none; b=GlqfvJe5Q00wHyxU0H3BGRPR4edwKe8HcwEbnWuvZDgvJZ/U8yrwPA1tYhVvnA5BUJMpYJjoIh8BXJ04I14/H/SMAat/lgvqD30PTwmMGKZLtzqtJrS6+baE0HkAJDEQZ0VUufXOHKBsqmCmxOjJukZPPN7+85mVdUWFBNbqkT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718989530; c=relaxed/simple;
	bh=itpttj0NdgxQo+wKm+pbsZ28jiNm/YdbN+BgrhdkQdE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a9rekXTUpx9nsYOx7Pk34ddT1cvNe35W+f0+bnZoO6z7JzUv390PvrDIOwB4DAGRiaXrCxh4MuKFBqQOPiWtuQc94LPaSjOSwIDDgHXiqQF0R0H41l4ihKSs4P581Pm7RO1F0wsLP9XnAnxbtyhPyVE4diaPDfn6+8saScCgu5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NkakOuf+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NkakOuf+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 606D8C4AF0B;
	Fri, 21 Jun 2024 17:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718989529;
	bh=itpttj0NdgxQo+wKm+pbsZ28jiNm/YdbN+BgrhdkQdE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NkakOuf+ziYIO+6+s9dZAD8bg2DQ+rbA3l0FWUHbCCH1DEzYJfqtchSj0gGmsZ/iJ
	 L8ya7DpjzTGXe7e+PVQbriCdtR+mtTmAHUt/0Xyl5fxowsCFQ6ROt1UOjGbSyn3aXc
	 nJBtEaAAZ0nPlIJpTBufD1Du17utgyhlTfk5MgMBEDRifMOwusezkRLr9cuh4mw6NM
	 +vsyDmM2ihV9y1aHOLtVadt5oqpB/BvY04CnrjqjiBPDWW1SM8hB7gcLUe8eFBgFrf
	 qQf87FpJ0/Qe82dvUxhsNA4EzFT2d0CrZzf2QPbdWjQEPqpCOPfvU2b06OsqOnc5tV
	 0pvDq2e9UyjlA==
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
Subject: [PATCH 1/4] perf report: Fix condition in sort__sym_cmp()
Date: Fri, 21 Jun 2024 10:05:25 -0700
Message-ID: <20240621170528.608772-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
In-Reply-To: <20240621170528.608772-1-namhyung@kernel.org>
References: <20240621170528.608772-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's expected that both hist entries are in the same hists when
comparing two.  But the current code in the function checks one without
dso sort key and other with the key.  This would make the condition true
in any case.

I guess the intention of the original commit was to add '!' for the
right side too.  But as it should be the same, let's just remove it.

Fixes: 69849fc5d2119 ("perf hists: Move sort__has_dso into struct perf_hpp_list")
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/sort.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index cd39ea972193..ab7c7ff35f9b 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -334,7 +334,7 @@ sort__sym_cmp(struct hist_entry *left, struct hist_entry *right)
 	 * comparing symbol address alone is not enough since it's a
 	 * relative address within a dso.
 	 */
-	if (!hists__has(left->hists, dso) || hists__has(right->hists, dso)) {
+	if (!hists__has(left->hists, dso)) {
 		ret = sort__dso_cmp(left, right);
 		if (ret != 0)
 			return ret;
-- 
2.45.2.741.gdbec12cfda-goog

