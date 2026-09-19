Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D8472621;
	Sat, 19 Sep 2026 06:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789799878; cv=none; b=RfUSSVH1ch1SBTcKYb57vzhW0I8ExMrYnqHmcy/xCiAm7FpKerpO7CWIU+QnXi5Vyk4eINYOTHQhPgi9pQP/HEEtzm6CKdkOIO//TGK419bL+Xd5MhTY0POL8sC6EPEnOXi+UE0WqAUw/WHw8l2KFnJrz6r7oTKqExzL3pHwR4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789799878; c=relaxed/simple;
	bh=TQQtXJJjH04u/hnOnUZauq3jKLD5V0udNUkvLQRvtBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dg119G2aZ6zqPbN58Tq2MoZ1MrhmTXaGdfnK9BKCa0zzfo2ZNfT95s6OP7fAzCOA5UYR/Ql9KIXWWMhkjOO82FEeCfI5k9DY+61HwVA7SvE3inqUFWH00WBWcAJG7bF6YwaEypjr/2cSn+Gu1HctJrT7puh2+2gsnRT1FoEvf3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WCd0fNQ/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WCd0fNQ/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3BAC1F00898;
	Sat, 19 Sep 2026 06:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789799874;
	bh=LlAx1lSVoQCyKt9jZ16pnAFFWy81J3aKHgE6uB1i6CA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WCd0fNQ/1mB5wceqRd2xN/SJeIMiiMRMn+QdaPNeH36hU34tAncHFLAS9iyKeilAg
	 uRUMzANQ7MeteDSbQQgig4vf6whoLLbCTdLBiLIVQGJOQBoPXVEPjaMkXPEspPL0vo
	 y5ts1hv9dUT5dVN4bRxjUWuX8wFFL2VVb8hPfOK7NcnXMFTt/WfImFGYGofZUKmnCh
	 KCtK/EZOfkFqrssETFauMdim4uOQdCdNECN1PhNf/Ug+xtK9focQnihQggC4s0f0sq
	 uGhE6tvRiRAt92h/F77bLDB+N3ND3z6rDSb5onJY6Ax02M8q4LRbcPXpZc0LL+O16x
	 izEa3T+bOPzlA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Zecheng Li <zli94@ncsu.edu>,
	Yanbo Zhao <yzhao62@ncsu.edu>,
	Tengda Wu <wutengda@huaweicloud.com>,
	Shuai Xue <xueshuai@linux.alibaba.com>
Subject: [PATCH v5 2/4] perf annotate-data: A small cleanup in __add_member_cb()
Date: Fri, 18 Sep 2026 23:37:43 -0700
Message-ID: <20260919063745.48444-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260919063745.48444-1-namhyung@kernel.org>
References: <20260919063745.48444-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check return value of strbuf_init() and die_get_typename() to make sure
if typename of a member gets never NULL.

Also remove the check for typedef by just using die_get_real_type().
It can get rid of member_type variable as well.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate-data.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index aff60a630fd05b01..845a5d8c2b84b6a6 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -226,7 +226,7 @@ static int __add_member_cb(Dwarf_Die *die, void *arg)
 {
 	struct annotated_member *parent = arg;
 	struct annotated_member *member;
-	Dwarf_Die member_type, die_mem;
+	Dwarf_Die die_mem;
 	Dwarf_Word size, loc, bit_size = 0;
 	Dwarf_Attribute attr;
 	struct strbuf sb;
@@ -239,14 +239,15 @@ static int __add_member_cb(Dwarf_Die *die, void *arg)
 	if (member == NULL)
 		return DIE_FIND_CB_END;
 
-	strbuf_init(&sb, 32);
-	die_get_typename(die, &sb);
+	if (strbuf_init(&sb, 32) < 0) {
+		free(member);
+		return DIE_FIND_CB_END;
+	}
 
-	__die_get_real_type(die, &member_type);
-	if (dwarf_tag(&member_type) == DW_TAG_typedef)
-		die_get_real_type(&member_type, &die_mem);
-	else
-		die_mem = member_type;
+	if (die_get_typename(die, &sb) < 0)
+		strbuf_add(&sb, "(unknown type)", 14);
+
+	die_get_real_type(die, &die_mem);
 
 	if (dwarf_aggregate_size(&die_mem, &size) < 0)
 		size = 0;
-- 
2.55.0

