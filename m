Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E720814F9E6;
	Fri,  7 Jun 2024 20:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717792161; cv=none; b=qdoTv2/WM8f648iC26/bLFidC+8HbQBj+5oHBLbDk9CAxYFeoyGLpoBw20EH8Yuq9VB1Axzwnc9ovuqIIjdDvCGhFXtGdikzCnqe2UbA6nJhIzb3IkL/ClehZxpB6Swtm7W3vry+alh7F+2ykWZooItnKZXNGJ7Za1TOV6cSZ1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717792161; c=relaxed/simple;
	bh=xXti8bLSkXlSV64cAc0cnIOYVS1QeNw8TsTY2C0Saao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uFpgtVlGLvBVPRSRkqffJwjfKCvKiADWdjWSkcCJM9FJczD66cDZEAphN2wzzZg4yyXYz0YHMgP9j5frdNV9kTPkyv66cT6RNZIuIuTo3e3n99/wLVv0/NS4oSwBDE7EY5S1w3g6P2x32nwpsaXZr9zA7wphB/uO+M2KQHz5KKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iVK5dgGy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iVK5dgGy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DC54C32781;
	Fri,  7 Jun 2024 20:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717792160;
	bh=xXti8bLSkXlSV64cAc0cnIOYVS1QeNw8TsTY2C0Saao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iVK5dgGypnZXiwuPVfKv978Ag9qXUdW7nSmBok7TFN0yB+V+ITPvNdr0rOGfXk+3q
	 hmuP8DTb4bg/wVDPg5f66qsYkKwqJkMsdlibswjXrPMUrpOxl02i52+z8+UQa1qJuV
	 G58Wm/oaP2ZpqsVbp067MvU0+cbrZvmv09ThU5Aao27UAcYzhDB2ka2uhU4qQiUQ1s
	 ydrOhU/BeNaUm64zrYgGGC582ccDEU+AQ6//2HuMpL/nKV/3JKavRWFoRt05dLO3ru
	 z+c5BsNiAm+cnRXNGG3MBHXWYp7UF5dgFwKOtqIQDmblJ+GC2Usg7NHp+LHu0vQ2j/
	 VPoC82kDGVKtw==
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
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 2/4] perf hist: Simplify __hpp_fmt() using hpp_fmt_data
Date: Fri,  7 Jun 2024 13:29:16 -0700
Message-ID: <20240607202918.2357459-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
In-Reply-To: <20240607202918.2357459-1-namhyung@kernel.org>
References: <20240607202918.2357459-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The struct hpp_fmt_data is to keep the values for each group members so
it doesn't need to check the event index in the group.

Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/ui/hist.c | 75 +++++++++++++++++++++-----------------------
 1 file changed, 36 insertions(+), 39 deletions(-)

diff --git a/tools/perf/ui/hist.c b/tools/perf/ui/hist.c
index e30fcb1e87e7..7e863cd92781 100644
--- a/tools/perf/ui/hist.c
+++ b/tools/perf/ui/hist.c
@@ -46,65 +46,62 @@ static int __hpp__fmt_print(struct perf_hpp *hpp, struct hists *hists, u64 val,
 	return hpp__call_print_fn(hpp, print_fn, fmt, len, val);
 }
 
+struct hpp_fmt_value {
+	struct hists *hists;
+	u64 val;
+	int samples;
+};
+
 static int __hpp__fmt(struct perf_hpp *hpp, struct hist_entry *he,
 		      hpp_field_fn get_field, const char *fmt, int len,
 		      hpp_snprint_fn print_fn, enum perf_hpp_fmt_type fmtype)
 {
-	int ret;
+	int ret = 0;
 	struct hists *hists = he->hists;
 	struct evsel *evsel = hists_to_evsel(hists);
+	struct evsel *pos;
 	char *buf = hpp->buf;
 	size_t size = hpp->size;
+	int i, nr_members = 1;
+	struct hpp_fmt_value *values;
+
+	if (evsel__is_group_event(evsel))
+		nr_members = evsel->core.nr_members;
+
+	values = calloc(nr_members, sizeof(*values));
+	if (values == NULL)
+		return 0;
+
+	i = 0;
+	for_each_group_evsel(pos, evsel)
+		values[i++].hists = evsel__hists(pos);
 
-	ret = __hpp__fmt_print(hpp, hists, get_field(he), he->stat.nr_events,
-			       fmt, len, print_fn, fmtype);
+	values[0].val = get_field(he);
+	values[0].samples = he->stat.nr_events;
 
 	if (evsel__is_group_event(evsel)) {
-		int prev_idx, idx_delta;
 		struct hist_entry *pair;
-		int nr_members = evsel->core.nr_members;
-
-		prev_idx = evsel__group_idx(evsel);
 
 		list_for_each_entry(pair, &he->pairs.head, pairs.node) {
-			u64 period = get_field(pair);
-			u64 total = hists__total_period(pair->hists);
-			int nr_samples = pair->stat.nr_events;
-
-			if (!total)
-				continue;
+			for (i = 0; i < nr_members; i++) {
+				if (values[i].hists != pair->hists)
+					continue;
 
-			evsel = hists_to_evsel(pair->hists);
-			idx_delta = evsel__group_idx(evsel) - prev_idx - 1;
-
-			while (idx_delta--) {
-				/*
-				 * zero-fill group members in the middle which have
-				 * no samples, pair->hists is not correct but it's
-				 * fine since the value is 0.
-				 */
-				ret += __hpp__fmt_print(hpp, pair->hists, 0, 0,
-							fmt, len, print_fn, fmtype);
+				values[i].val = get_field(pair);
+				values[i].samples = pair->stat.nr_events;
+				break;
 			}
-
-			ret += __hpp__fmt_print(hpp, pair->hists, period, nr_samples,
-						fmt, len, print_fn, fmtype);
-
-			prev_idx = evsel__group_idx(evsel);
 		}
+	}
 
-		idx_delta = nr_members - prev_idx - 1;
-
-		while (idx_delta--) {
-			/*
-			 * zero-fill group members at last which have no sample.
-			 * the hists is not correct but it's fine like above.
-			 */
-			ret += __hpp__fmt_print(hpp, evsel__hists(evsel), 0, 0,
-						fmt, len, print_fn, fmtype);
-		}
+	for (i = 0; i < nr_members; i++) {
+		ret += __hpp__fmt_print(hpp, values[i].hists, values[i].val,
+					values[i].samples, fmt, len,
+					print_fn, fmtype);
 	}
 
+	free(values);
+
 	/*
 	 * Restore original buf and size as it's where caller expects
 	 * the result will be saved.
-- 
2.45.2.505.gda0bf45e8d-goog

