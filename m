Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DE929D270;
	Sun,  2 Aug 2026 14:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785680604; cv=none; b=UxoamhFF78gn/fo1TeBLzGBg2aXM4u17aLx8kpxXxiOox8q//BTRK6uL5WRaFionWjS+ECH7fn5SPLCxlisIgB1jRhaj+4KSa8ORPSJvIQaevFQFS3BDb8YKdDWGvWpRrgRNlyh05+GmhsBD4NsZ28tzM0Bc9E5wQODgvKS8v3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785680604; c=relaxed/simple;
	bh=IoqYJsdyLrhtQ4Jk74bUjHFI14vzu/T0fHc+ZVtKtY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LitX5JiJeIdKtIPbr8zgIVOg71S5FTLXdHo0h3eBIRRZrViqqDAwfZjqJIU9cVuojKwWCIJ/lFvkgvvBT31phg++MDbspaHsZ1Eo8hzMe1zl/5EXctjualZOHkSom7aE8JeZ0c3T71ls7LPJUL6Dim/VT5e2bkVcg952Z6R+wvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lNf6YYUF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lNf6YYUF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E6241F00A3A;
	Sun,  2 Aug 2026 14:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785680603;
	bh=lDlWRE2o5o/7jvO2n5xt5+TC0ATLFwoubX8hTIOvLTg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lNf6YYUF81RWZ1amF5VleVlDlD/APS8QbFFHCu3kXCF8tHXjN/dR4COqqVMVbahwS
	 m/BmXXpwVKGNLe2jb6IZOXmI8wQSQDDIDlYmvI+Dh7qS0CwUveCkRU4aH2A3GF5AvU
	 kBH75pRdCjqOQ9Sn8tX3Q7+G+CLsLrbExDWb/ETH/KyWWixEpHuRMiVAnPuKl85lPY
	 jDpUyrOf51YmF+5z5FuXzjY5MRSSMe5rLSjTtfU2p/7pGTtUE0zwOt/FMJaH/0xzII
	 NiRBI5D0jMbm3sViXCZ6Tkixg33m8mnD4s0MpInAYWXwMQd1Fk2wq6y8EP4G6+tDGV
	 CqkS8U0CEg6cg==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	sashiko-bot <sashiko-bot@kernel.org>
Subject: [PATCH 1/2] perf c2c: Fix error masking and OOM handling in hpp_list__parse()
Date: Sun,  2 Aug 2026 11:23:12 -0300
Message-ID: <20260802142313.154514-2-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260802142313.154514-1-acme@kernel.org>
References: <20260802142313.154514-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

hpp_list__parse() has two bugs:

1. The PARSE_LIST macro resets ret = 0 at the start of each invocation,
   so an error from output parsing is silently overwritten when the sort
   parsing block runs.  The function returns success with partially
   initialized state.

2. When the caller passes a non-NULL output_ or sort_ string, but
   strdup() returns NULL due to OOM, NULL is passed to PARSE_LIST which
   treats it as empty input (the "if (!_list) break" branch).  No error
   is returned.

Fix by checking strdup() return values before proceeding, and preserving
the first error across PARSE_LIST calls by checking ret and jumping to
the cleanup label.

Fixes: 2d388bd0c9d3 ("perf c2c report: Add stdio output support")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-c2c.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index c9584dbedf77afe8..332d360ca533424b 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -2093,8 +2093,18 @@ static int hpp_list__parse(struct perf_hpp_list *hpp_list,
 	char *sort   = sort_   ? strdup(sort_) : NULL;
 	int ret;
 
+	/* strdup() returns NULL on OOM, don't silently treat as empty */
+	if ((output_ && !output) || (sort_ && !sort)) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
 	PARSE_LIST(output, c2c_hists__init_output);
+	if (ret)
+		goto out;
 	PARSE_LIST(sort,   c2c_hists__init_sort);
+	if (ret)
+		goto out;
 
 	/* copy sort keys to output fields */
 	perf_hpp__setup_output_field(hpp_list);
@@ -2111,6 +2121,7 @@ static int hpp_list__parse(struct perf_hpp_list *hpp_list,
 	perf_hpp__append_sort_keys(&hists->list);
 #endif
 
+out:
 	free(output);
 	free(sort);
 	return ret;
-- 
2.55.0

