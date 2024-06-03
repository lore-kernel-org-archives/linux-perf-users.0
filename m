Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68E713CF97;
	Mon,  3 Jun 2024 22:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717454654; cv=none; b=cwypVuqoxaMerZ2ZtHZvPDTbvpSQ4QP6VvbOQjLgSHRcnzGW3EfXMkKpR0mohcYGudbCTc20HEQ++Kt1HzkJ3zI30hVpmTkEYv4rA+DdpVg3vPN0E5c1NLu6APrYNZI1UDHZnJIM8O+NNQUeYkO9SpG6SyWXBqhBr8KopGejfnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717454654; c=relaxed/simple;
	bh=TdJfb4b0EK7Er1ltY544EIHAZOToWommLg0CWKrIXRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pcFJgSAYXTMviru9A/bDagK6glHervOWUt8aR6+TCzUC5VWLxNbuQ1tBrBPG3i4BLE7wulrieMZXvRIwmKhxTp1COPaVm6WkawtlKdmqIFbWouFbRFEkNZCLlbDCnhLMBLXUkudHplS7T6CHY3ogWJryGz9RpcM6Y48ivViLBDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UaUcSg8h; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UaUcSg8h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B475C32782;
	Mon,  3 Jun 2024 22:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717454654;
	bh=TdJfb4b0EK7Er1ltY544EIHAZOToWommLg0CWKrIXRE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UaUcSg8htavfY3pUGIgBMBi7dgY+GqzZOKLr0qz7IQu3MB+ZU9At1vvdEcnvNVj4E
	 tWJopEz+ZRc0xL/JyieuLGFGYCSS33XJCYVIksflKM7BJ77NOFjJGcYcWTdClXJR6X
	 OpWO4sVwIt9YrizsR1ltW5mofhn62XTp1WigrdTXqAGXl5/Q/Pp56XOSnhxQY+G2uq
	 sLt++gPesjV4QZN1QHELdPDyESWpL8Zf6eTwlQk7Q9vSYojYxvSBJ8WnUkgW13jutC
	 hOmzDKYQ7I/tUrZ8a8yoeMfGdzRd/fmkval5+4AUPDE6Bp5KIAqkUTfxl1ufaxLHL0
	 e8L2dtnSj2YKA==
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
Subject: [PATCH 1/4] perf hist: Factor out __hpp__fmt_print()
Date: Mon,  3 Jun 2024 15:44:09 -0700
Message-ID: <20240603224412.1910049-2-namhyung@kernel.org>
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

Split the logic to print the histogram values according to the format
string.  This was used in 3 different places so it's better to move out
the logic into a function.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/ui/hist.c | 83 +++++++++++++++++++-------------------------
 1 file changed, 36 insertions(+), 47 deletions(-)

diff --git a/tools/perf/ui/hist.c b/tools/perf/ui/hist.c
index 685ba2a54fd8..e30fcb1e87e7 100644
--- a/tools/perf/ui/hist.c
+++ b/tools/perf/ui/hist.c
@@ -23,35 +23,42 @@
 	__ret;							\
 })
 
-static int __hpp__fmt(struct perf_hpp *hpp, struct hist_entry *he,
-		      hpp_field_fn get_field, const char *fmt, int len,
-		      hpp_snprint_fn print_fn, enum perf_hpp_fmt_type fmtype)
+static int __hpp__fmt_print(struct perf_hpp *hpp, struct hists *hists, u64 val,
+			    int nr_samples, const char *fmt, int len,
+			    hpp_snprint_fn print_fn, enum perf_hpp_fmt_type fmtype)
 {
-	int ret;
-	struct hists *hists = he->hists;
-	struct evsel *evsel = hists_to_evsel(hists);
-	char *buf = hpp->buf;
-	size_t size = hpp->size;
-
 	if (fmtype == PERF_HPP_FMT_TYPE__PERCENT) {
 		double percent = 0.0;
 		u64 total = hists__total_period(hists);
 
 		if (total)
-			percent = 100.0 * get_field(he) / total;
+			percent = 100.0 * val / total;
 
-		ret = hpp__call_print_fn(hpp, print_fn, fmt, len, percent);
-	} else if (fmtype == PERF_HPP_FMT_TYPE__AVERAGE) {
-		double average = 0;
+		return hpp__call_print_fn(hpp, print_fn, fmt, len, percent);
+	}
 
-		if (he->stat.nr_events)
-			average = 1.0 * get_field(he) / he->stat.nr_events;
+	if (fmtype == PERF_HPP_FMT_TYPE__AVERAGE) {
+		double avg = nr_samples ? (1.0 * val / nr_samples) : 0;
 
-		ret = hpp__call_print_fn(hpp, print_fn, fmt, len, average);
-	} else {
-		ret = hpp__call_print_fn(hpp, print_fn, fmt, len, get_field(he));
+		return hpp__call_print_fn(hpp, print_fn, fmt, len, avg);
 	}
 
+	return hpp__call_print_fn(hpp, print_fn, fmt, len, val);
+}
+
+static int __hpp__fmt(struct perf_hpp *hpp, struct hist_entry *he,
+		      hpp_field_fn get_field, const char *fmt, int len,
+		      hpp_snprint_fn print_fn, enum perf_hpp_fmt_type fmtype)
+{
+	int ret;
+	struct hists *hists = he->hists;
+	struct evsel *evsel = hists_to_evsel(hists);
+	char *buf = hpp->buf;
+	size_t size = hpp->size;
+
+	ret = __hpp__fmt_print(hpp, hists, get_field(he), he->stat.nr_events,
+			       fmt, len, print_fn, fmtype);
+
 	if (evsel__is_group_event(evsel)) {
 		int prev_idx, idx_delta;
 		struct hist_entry *pair;
@@ -72,30 +79,16 @@ static int __hpp__fmt(struct perf_hpp *hpp, struct hist_entry *he,
 
 			while (idx_delta--) {
 				/*
-				 * zero-fill group members in the middle which
-				 * have no sample
+				 * zero-fill group members in the middle which have
+				 * no samples, pair->hists is not correct but it's
+				 * fine since the value is 0.
 				 */
-				if (fmtype != PERF_HPP_FMT_TYPE__RAW) {
-					ret += hpp__call_print_fn(hpp, print_fn,
-								  fmt, len, 0.0);
-				} else {
-					ret += hpp__call_print_fn(hpp, print_fn,
-								  fmt, len, 0ULL);
-				}
+				ret += __hpp__fmt_print(hpp, pair->hists, 0, 0,
+							fmt, len, print_fn, fmtype);
 			}
 
-			if (fmtype == PERF_HPP_FMT_TYPE__PERCENT) {
-				ret += hpp__call_print_fn(hpp, print_fn, fmt, len,
-							  100.0 * period / total);
-			} else if (fmtype == PERF_HPP_FMT_TYPE__AVERAGE) {
-				double avg = nr_samples ? (period / nr_samples) : 0;
-
-				ret += hpp__call_print_fn(hpp, print_fn, fmt,
-							  len, avg);
-			} else {
-				ret += hpp__call_print_fn(hpp, print_fn, fmt,
-							  len, period);
-			}
+			ret += __hpp__fmt_print(hpp, pair->hists, period, nr_samples,
+						fmt, len, print_fn, fmtype);
 
 			prev_idx = evsel__group_idx(evsel);
 		}
@@ -104,15 +97,11 @@ static int __hpp__fmt(struct perf_hpp *hpp, struct hist_entry *he,
 
 		while (idx_delta--) {
 			/*
-			 * zero-fill group members at last which have no sample
+			 * zero-fill group members at last which have no sample.
+			 * the hists is not correct but it's fine like above.
 			 */
-			if (fmtype != PERF_HPP_FMT_TYPE__RAW) {
-				ret += hpp__call_print_fn(hpp, print_fn,
-							  fmt, len, 0.0);
-			} else {
-				ret += hpp__call_print_fn(hpp, print_fn,
-							  fmt, len, 0ULL);
-			}
+			ret += __hpp__fmt_print(hpp, evsel__hists(evsel), 0, 0,
+						fmt, len, print_fn, fmtype);
 		}
 	}
 
-- 
2.45.1.288.g0e0cd299f1-goog

