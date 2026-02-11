Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D29823B604;
	Wed, 11 Feb 2026 01:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770773943; cv=none; b=SHhN/Y27FFOeXG+ApA9kh9zY8utafaB7b8kBNxu5txcK5jsh61f3kD2iUTazVeFOK9pcipHJbmY+b6NjdiyzRuL2nzkkTFDRgrSiWkbjeLbDtDgtPp61yb4TrHM07DuVV3mWV/v82wr/o/8kzHDH/f89JVy2rN9a53TCYm3jEs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770773943; c=relaxed/simple;
	bh=dzk9IYzsKrYIQBDzOw46VcyJzhleWrYnwrFxFJ24tO8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R1OOQ9hckl4DwcXUen44SDY9HONTPSts8eqwkeomqD8vqylaZrm0OZC2YyNF6qmtTmRV8rFTQYAz4n2pOE7KpUkt1rl3azirOU+Fgh2jSQOnK5Q5q64Vq1s2+eUXTx9OU8YKXid7nQsCI5zsc+HiSzKa6ijolFWX9eppcHN+Vc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uO2wcPKg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uO2wcPKg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 540CFC116C6;
	Wed, 11 Feb 2026 01:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770773942;
	bh=dzk9IYzsKrYIQBDzOw46VcyJzhleWrYnwrFxFJ24tO8=;
	h=From:To:Cc:Subject:Date:From;
	b=uO2wcPKg8KWhA5agLbpO6Y/39OS0lYvL15pxEcO4ZW4vKv5HAI34OQ7p9yrOdVoMi
	 hVhiGJWn2lSlWoRgYlnn9+a4O6tuo+dWP/RoCD1+lPk/nrQcHNo4pKvYAIizduOg1f
	 hKwBOvjPI2s49zHbBmeaSMyP7saoL3mcJiZrKTtyk/pRfavpkpTZaeVJGq1zgNWk6K
	 lUruZX5lyaCWn0f0cScDBr/hxD0/Pna1Svz59j0KtSQP24yJV1765aWFnCdl9UoHpu
	 ODZJa5dI3IXrcEXoDxIJpoi6Zivm6IqvjQExcFBXytTyHaIQIKYOOLUiBvgcS3EqVm
	 crH+M0GeC1Jyw==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Frederic Weisbecker <fweisbec@gmail.com>
Subject: [PATCH] perf report: Get rid of unnecessary comm collapsing
Date: Tue, 10 Feb 2026 17:39:00 -0800
Message-ID: <20260211013900.3009454-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.53.0.239.g8d8fc8a987-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The sort_entry->collapse() callback is to merge related hist entries.
It's called in hists__collapse_resort() after processing samples using
the ->cmp() callback first.  The idea was to speed up processing with
lighter-weight operation in ->cmp() and do heavier one in ->collapse().

Note that ->cmp() will be called for every sample, but ->collapse() will
be called for each hist entry which is pre-processed already.  So it's
meaningless to have ->collapse() if it's the same as ->cmp().

The 'comm' sort key used to compare 'tid' in ->cmp() and strcmp() in the
collapse callback.  Then commit fedd63d3cdc9004d ("perf tools: Compare
hists comm by addresses") added comm_str and changed it to compare the
pointer values.  Later, commit 2f15bd8c6c6e80f1 ("perf tools: Fix
"Command" sort_entry's cmp and collapse function") changed to compare
 trings.

Now 'comm' sort key compares the string from the beginning so there's no
point to keep the collapse callback.  This will get rid of unnecessary
processing in hists__collapse_resort().  It'd give a little speedup on
large data files with a lot of threads.  But I didn't see it actually
from my quick testing.

Cc: Frederic Weisbecker <fweisbec@gmail.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/sort.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 42d5cd7ef4e23960..66c45f450e5101e5 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -237,12 +237,6 @@ sort__comm_cmp(struct hist_entry *left, struct hist_entry *right)
 	return strcmp(comm__str(right->comm), comm__str(left->comm));
 }
 
-static int64_t
-sort__comm_collapse(struct hist_entry *left, struct hist_entry *right)
-{
-	return strcmp(comm__str(right->comm), comm__str(left->comm));
-}
-
 static int64_t
 sort__comm_sort(struct hist_entry *left, struct hist_entry *right)
 {
@@ -258,7 +252,6 @@ static int hist_entry__comm_snprintf(struct hist_entry *he, char *bf,
 struct sort_entry sort_comm = {
 	.se_header	= "Command",
 	.se_cmp		= sort__comm_cmp,
-	.se_collapse	= sort__comm_collapse,
 	.se_sort	= sort__comm_sort,
 	.se_snprintf	= hist_entry__comm_snprintf,
 	.se_filter	= hist_entry__thread_filter,
-- 
2.53.0.239.g8d8fc8a987-goog

