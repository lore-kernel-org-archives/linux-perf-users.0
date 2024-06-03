Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4424113CFAB;
	Mon,  3 Jun 2024 22:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717454655; cv=none; b=CnQv+5a+fk1C1DQzje+jpnUjttNR8F2w+MdHHcTMfMFkiOZAnTn33Uu/cBgRxzyvmYFQt4WB7JejYM7bTRPQmh9nhPeW0mhP3m7S71yc6/AEcPeGkiO3T1BPkO4MMVaRhJXoN3qYl3VTiXSlRoPOI87ZzGaHPB5Y68xl9bc5N2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717454655; c=relaxed/simple;
	bh=Kg6743M4jK2pkp/b4Bbj59j6MAtu4SgkHWIqpEC7BU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lmk5T06TWY0vHdjduXhek6fTUJyeeDfuyWZzKBJdumw1xedhBcboZfCkvo/AkPjnc6+mPm98r2RDpBAFayHSDL6y0KodVQF1oX3HU1KfEPGfoXcqq7GoXdo2hAEqbXqesHsZ1sTtOc3H1L2HitXHF+JWbKY2Kwf6wK7Y+wKoZ3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hKKMTpe5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hKKMTpe5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82DE2C4AF0F;
	Mon,  3 Jun 2024 22:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717454654;
	bh=Kg6743M4jK2pkp/b4Bbj59j6MAtu4SgkHWIqpEC7BU8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hKKMTpe5INUkTRoChzcNztB6VJHSviPAh3CiyC+KpSWvwVEynPJILJ/7YsJOAwdPB
	 yyP1QnTXWAWdwQ+P4WplVNlXIo/iLalPWuc2pem7ZcZA4CUoZeLWzVmEprSEUoFo7l
	 i/hIFfWyCTKaVXvebdKHx1qlLU6iDgR1ZHRrKF5/JF7IKJ2HUDRv3p2+I4ZRHyhScu
	 qSMqkOo9tfi52LTL+BgRVAkHhpVaz6KHkA2Wo8zDDNEEFP/TV0hoYWf6HrTRR5fMsG
	 Rbn4WZP/Gy0VJMBY9T+o1rY5xmby80D0aQI+zy3y9tGwsPrI9uIFH0ZfXfSg6Zc9N+
	 JYke+oYYunE0A==
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
Subject: [PATCH 2/4] perf hist: Simplify __hpp_fmt() using hpp_fmt_data
Date: Mon,  3 Jun 2024 15:44:10 -0700
Message-ID: <20240603224412.1910049-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
In-Reply-To: <20240603224412.1910049-1-namhyung@kernel.org>
References: <20240603224412.1910049-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The struct hpp_fmt_data is to keep the values for each group members so
it doesn't need to check the event index in the group.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/ui/hist.c | 75 +++++++++++++++++++++-----------------------
 1 file changed, 36 insertions(+), 39 deletions(-)

diff --git a/tools/perf/ui/hist.c b/tools/perf/ui/hist.c
index e30fcb1e87e7..539978c95cfd 100644
--- a/tools/perf/ui/hist.c
+++ b/tools/perf/ui/hist.c
@@ -46,65 +46,62 @@ static int __hpp__fmt_print(struct perf_hpp *hpp, struct hists *hists, u64 val,
 	return hpp__call_print_fn(hpp, print_fn, fmt, len, val);
 }
 
+struct hpp_fmt_data {
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
+	struct hpp_fmt_data *data;
+
+	if (evsel__is_group_event(evsel))
+		nr_members = evsel->core.nr_members;
+
+	data = calloc(nr_members, sizeof(*data));
+	if (data == NULL)
+		return 0;
+
+	i = 0;
+	for_each_group_evsel(pos, evsel)
+		data[i++].hists = evsel__hists(pos);
 
-	ret = __hpp__fmt_print(hpp, hists, get_field(he), he->stat.nr_events,
-			       fmt, len, print_fn, fmtype);
+	data[0].val = get_field(he);
+	data[0].samples = he->stat.nr_events;
 
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
+				if (data[i].hists != pair->hists)
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
+				data[i].val = get_field(pair);
+				data[i].samples = pair->stat.nr_events;
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
+		ret += __hpp__fmt_print(hpp, data[i].hists, data[i].val,
+					data[i].samples, fmt, len,
+					print_fn, fmtype);
 	}
 
+	free(data);
+
 	/*
 	 * Restore original buf and size as it's where caller expects
 	 * the result will be saved.
-- 
2.45.1.288.g0e0cd299f1-goog

