Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8F31CEEBB;
	Mon, 31 Mar 2025 07:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743406644; cv=none; b=fAntnJVdmPN7quTWUoseXt+Wlq7gj0wScewB7dD+6Ah+Y8aNG1oj/7oJOZkwBT89ALaN/dcfzfaplTjsBOlGzjL5y0EC4gybCLLx36MXBChM5vTWVsg71R0xdBJv8r8B6VXbCvYNAQ26qtKnZXnBIzLW5vOtk6LpivqIQXbLEnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743406644; c=relaxed/simple;
	bh=dhoWW6Oi8jAkJCdBJoRBk9QhR4hqUR8fxe78GTR9gmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kFc46yBF9wKaUQ8OiKV/GheLIACm0rJO+f7/3FkRGtseTDoejSclUBzAShCnSJ3pi1d09F3oDJ4MrBW9N5gJbP9UjX8/BKlV8eO5UT3FJNcu0RTQDGYnuYetJHSk/Zx7g6jDbrTudMzNssJoHszJjBtZqUGi9Eu+fIfeylH2lY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WNF+UtIz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WNF+UtIz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63252C4CEED;
	Mon, 31 Mar 2025 07:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743406643;
	bh=dhoWW6Oi8jAkJCdBJoRBk9QhR4hqUR8fxe78GTR9gmM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WNF+UtIz35c6PH6V29HR1kZWttLq9qbLb7UBQE4FtJhHMOIHRKfg7+uzi7aTsEobv
	 fyKyxXT1cC1FIgvjqr/SkjgOOu3p1xI6JO/0/nYbdjrbREq67lSBboXq1B2jswNqg5
	 nIItTO/B+Ud6hG1OeCEgA05IxL6cyBqdTlXgNdQG1UkOwGI4o6LQCCc5ZivZGlLxBo
	 2HQoELXXKDkp2nQPlvwLIKDA3pfMVO2GpGgQr5G2TqDWK+2KnDe9BkwcUe4bLqmyQ1
	 gHwB7ffNByuJO82kjFOSajR1X5owh3JMj3veA8MVFgnBEOq6/tFZSDUikBOtEfGcAS
	 DyUdC0CWXr8wg==
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
Subject: [PATCH 1/4] perf hist: Remove formats in hierarchy when cancel children
Date: Mon, 31 Mar 2025 00:37:19 -0700
Message-ID: <20250331073722.4695-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250331073722.4695-1-namhyung@kernel.org>
References: <20250331073722.4695-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is to support hierarchy options with custom output fields.
Currently perf_hpp__cancel_cumulate() only removes accumulated
overhead and latency fields from the global perf_hpp_list.

This is not used in the hierarchy mode because each evsel's hist
has its own separate hpp_list.  So it needs to remove the fields
from the lists too.  Pass evlist to the function so that it can
iterate the evsels.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-report.c |  2 +-
 tools/perf/builtin-top.c    |  2 +-
 tools/perf/ui/hist.c        | 20 +++++++++++++++++++-
 tools/perf/util/hist.h      |  2 +-
 4 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index b030ce72e13ea8d1..c9138e1379808097 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -413,7 +413,7 @@ static int report__setup_sample_type(struct report *rep)
 		/* Silently ignore if callchain is missing */
 		if (!(sample_type & PERF_SAMPLE_CALLCHAIN)) {
 			symbol_conf.cumulate_callchain = false;
-			perf_hpp__cancel_cumulate();
+			perf_hpp__cancel_cumulate(session->evlist);
 		}
 	}
 
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 1061f4eebc3f6414..f9f31391bddba074 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1790,7 +1790,7 @@ int cmd_top(int argc, const char **argv)
 
 	if (!callchain_param.enabled) {
 		symbol_conf.cumulate_callchain = false;
-		perf_hpp__cancel_cumulate();
+		perf_hpp__cancel_cumulate(top.evlist);
 	}
 
 	if (symbol_conf.cumulate_callchain && !callchain_param.order_set)
diff --git a/tools/perf/ui/hist.c b/tools/perf/ui/hist.c
index ae3b7fe1dadc8f22..1d3f944ed35ed152 100644
--- a/tools/perf/ui/hist.c
+++ b/tools/perf/ui/hist.c
@@ -699,9 +699,10 @@ static void perf_hpp__column_unregister(struct perf_hpp_fmt *format)
 	fmt_free(format);
 }
 
-void perf_hpp__cancel_cumulate(void)
+void perf_hpp__cancel_cumulate(struct evlist *evlist)
 {
 	struct perf_hpp_fmt *fmt, *acc, *ovh, *acc_lat, *tmp;
+	struct evsel *evsel;
 
 	if (is_strict_order(field_order))
 		return;
@@ -719,6 +720,23 @@ void perf_hpp__cancel_cumulate(void)
 		if (fmt_equal(ovh, fmt))
 			fmt->name = "Overhead";
 	}
+
+	evlist__for_each_entry(evlist, evsel) {
+		struct hists *hists = evsel__hists(evsel);
+		struct perf_hpp_list_node *node;
+
+		list_for_each_entry(node, &hists->hpp_formats, list) {
+			perf_hpp_list__for_each_format_safe(&node->hpp, fmt, tmp) {
+				if (fmt_equal(acc, fmt) || fmt_equal(acc_lat, fmt)) {
+					perf_hpp__column_unregister(fmt);
+					continue;
+				}
+
+				if (fmt_equal(ovh, fmt))
+					fmt->name = "Overhead";
+			}
+		}
+	}
 }
 
 void perf_hpp__cancel_latency(void)
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index 317d06cca8b88e3e..8cc94928fcb35a5b 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -581,7 +581,7 @@ enum {
 };
 
 void perf_hpp__init(void);
-void perf_hpp__cancel_cumulate(void);
+void perf_hpp__cancel_cumulate(struct evlist *evlist);
 void perf_hpp__cancel_latency(void);
 void perf_hpp__setup_output_field(struct perf_hpp_list *list);
 void perf_hpp__reset_output_field(struct perf_hpp_list *list);
-- 
2.49.0

