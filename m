Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2390C42058;
	Wed,  7 Aug 2024 06:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723011435; cv=none; b=V/3FpWc026aSbldfqmzq/TbNYlN2YluVJFrWXa15XeEPWjEZo+HZc1BZdi4Iq1pmCLeSp8Kwl845+M4Vx0MIOu2YO+qi3cOLZ8vvg1FXCiIYeD8KofTxSWjQDRtUB/Ot7n/MEPQvnTR9mRy4+5lSvUeuMuRnrJ/o9SiUiOqDn78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723011435; c=relaxed/simple;
	bh=0NZ/E7RDLgfDPnY+Jnfm2aTXMAqExctiZQfzwx2T4zQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gBmuigwMVlweh7m3t22q2iAJ89wvEEYTJzyHL9qwZe05Ix1xcMjvmt0SZqZ68ko65jQ9vg7MLqwkNQthvlibpIXJfaCdHaimTbY8y3ysVWf03L9Ha0sFhCMPDoo4WyF86PPJOXv5aP2gspcmjoMa3g1VZ57dX0a319uK9uu7Hes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GbYWEZ/n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GbYWEZ/n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94690C4AF10;
	Wed,  7 Aug 2024 06:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723011434;
	bh=0NZ/E7RDLgfDPnY+Jnfm2aTXMAqExctiZQfzwx2T4zQ=;
	h=From:To:Cc:Subject:Date:From;
	b=GbYWEZ/nf55qi9ItKS7XnJmc2vJX75ZwVBFtXi/T7hUtDSY3mm+RxUkXYMwk1ZsFb
	 rZP9bdhZuLaYDiNu+gkEZOgw2MZoTb5ooZoHNSGTfZ8T3/bwbmRRyL8NBU77VGxasU
	 aDGk6m9uUJOxyOPsASBS7HNFZuQ4jtCd3K9ZN8z79n4x5tM/PzL/U7SD7dECnmxclX
	 apzbqvFBB1hEpuiC5pDDx7vvOYGL9IIHl9H31pfhq7tt5pqMYPwu6q4ZoOi/L6KW+A
	 Wma3mvdbft+U+e6LSmBwCSzRa6EuZwlsL+2/MymHQRhtyOF0z8ulwnGEAMEKKp+U/+
	 qW9PnqJf9cwgA==
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
Subject: [PATCH] perf annotate-data: Support --skip-empty option
Date: Tue,  6 Aug 2024 23:17:13 -0700
Message-ID: <20240807061713.1642924-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The --skip-empty option is to hide dummy events in a group.  Like other
output mode like perf report and perf annotate, the data-type profiling
output should support the option.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/ui/browsers/annotate-data.c | 30 ++++++++++++++----
 tools/perf/util/annotate-data.c        | 44 +++++++++++++-------------
 2 files changed, 45 insertions(+), 29 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate-data.c b/tools/perf/ui/browsers/annotate-data.c
index 8d6bf08d371d..c3db80a7589a 100644
--- a/tools/perf/ui/browsers/annotate-data.c
+++ b/tools/perf/ui/browsers/annotate-data.c
@@ -46,15 +46,18 @@ static int get_member_overhead(struct annotated_data_type *adt,
 	struct annotated_member *member = entry->data;
 	int i, k;
 
-	for (i = 0; i < member->size; i++) {
+	for (i = 0, k = 0; i < member->size; i++) {
 		struct type_hist *h;
 		struct evsel *evsel;
 		int offset = member->offset + i;
 
 		for_each_group_evsel(evsel, leader) {
+			if (symbol_conf.skip_empty &&
+			    evsel__hists(evsel)->stats.nr_samples == 0)
+				continue;
+
 			h = adt->histograms[evsel->core.idx];
-			k = evsel__group_idx(evsel);
-			update_hist_entry(&entry->hists[k], &h->addr[offset]);
+			update_hist_entry(&entry->hists[k++], &h->addr[offset]);
 		}
 	}
 	return 0;
@@ -203,6 +206,7 @@ static void browser__write(struct ui_browser *uib, void *entry, int row)
 	struct annotated_data_type *adt = he->mem_type;
 	struct evsel *leader = hists_to_evsel(he->hists);
 	struct evsel *evsel;
+	int idx = 0;
 
 	if (member == NULL) {
 		bool current = ui_browser__is_current_entry(uib, row);
@@ -219,9 +223,12 @@ static void browser__write(struct ui_browser *uib, void *entry, int row)
 	/* print the number */
 	for_each_group_evsel(evsel, leader) {
 		struct type_hist *h = adt->histograms[evsel->core.idx];
-		int idx = evsel__group_idx(evsel);
 
-		browser__write_overhead(uib, h, &be->hists[idx], row);
+		if (symbol_conf.skip_empty &&
+		    evsel__hists(evsel)->stats.nr_samples == 0)
+			continue;
+
+		browser__write_overhead(uib, h, &be->hists[idx++], row);
 	}
 
 	/* print type info */
@@ -300,8 +307,17 @@ int hist_entry__annotate_data_tui(struct hist_entry *he, struct evsel *evsel,
 
 	ui_helpline__push("Press ESC to exit");
 
-	if (evsel__is_group_event(evsel))
-		browser.nr_events = evsel->core.nr_members;
+	if (evsel__is_group_event(evsel)) {
+		struct evsel *pos;
+		int nr = 0;
+
+		for_each_group_evsel(pos, evsel) {
+			if (!symbol_conf.skip_empty ||
+			    evsel__hists(pos)->stats.nr_samples)
+				nr++;
+		}
+		browser.nr_events = nr;
+	}
 
 	ret = annotated_data_browser__collect_entries(&browser);
 	if (ret == 0)
diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index 734acdd8c4b7..be3b84a82271 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -1492,10 +1492,15 @@ static void print_annotated_data_header(struct hist_entry *he, struct evsel *evs
 		struct evsel *pos;
 		int i = 0;
 
-		for_each_group_evsel(pos, evsel)
-			printf(" event[%d] = %s\n", i++, pos->name);
+		nr_members = 0;
+		for_each_group_evsel(pos, evsel) {
+			if (symbol_conf.skip_empty &&
+			    evsel__hists(pos)->stats.nr_samples == 0)
+				continue;
 
-		nr_members = evsel->core.nr_members;
+			printf(" event[%d] = %s\n", i++, pos->name);
+			nr_members++;
+		}
 	}
 
 	if (symbol_conf.show_total_period) {
@@ -1530,31 +1535,26 @@ static void print_annotated_data_type(struct annotated_data_type *mem_type,
 {
 	struct annotated_member *child;
 	struct type_hist *h = mem_type->histograms[evsel->core.idx];
-	int i, nr_events = 1, samples = 0;
+	int i, nr_events = 0, samples = 0;
 	u64 period = 0;
 	int width = symbol_conf.show_total_period ? 11 : 7;
+	struct evsel *pos;
 
-	for (i = 0; i < member->size; i++) {
-		samples += h->addr[member->offset + i].nr_samples;
-		period += h->addr[member->offset + i].period;
-	}
-	print_annotated_data_value(h, period, samples);
-
-	if (evsel__is_group_event(evsel)) {
-		struct evsel *pos;
+	for_each_group_evsel(pos, evsel) {
+		h = mem_type->histograms[pos->core.idx];
 
-		for_each_group_member(pos, evsel) {
-			h = mem_type->histograms[pos->core.idx];
+		if (symbol_conf.skip_empty &&
+		    evsel__hists(pos)->stats.nr_samples == 0)
+			continue;
 
-			samples = 0;
-			period = 0;
-			for (i = 0; i < member->size; i++) {
-				samples += h->addr[member->offset + i].nr_samples;
-				period += h->addr[member->offset + i].period;
-			}
-			print_annotated_data_value(h, period, samples);
+		samples = 0;
+		period = 0;
+		for (i = 0; i < member->size; i++) {
+			samples += h->addr[member->offset + i].nr_samples;
+			period += h->addr[member->offset + i].period;
 		}
-		nr_events = evsel->core.nr_members;
+		print_annotated_data_value(h, period, samples);
+		nr_events++;
 	}
 
 	printf(" %10d %10d  %*s%s\t%s",
-- 
2.46.0.rc2.264.g509ed76dc8-goog

