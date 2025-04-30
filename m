Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD682D1102;
	Wed, 30 Apr 2025 20:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746046553; cv=none; b=orwyO7/4cCwLRm//o1vIrLSgzU1uskm9/uzP3Rva+hkSvzelpRWeWeFcqP9wHuPoD9Zn+NjOPuETW9x8x+tlJbC4m8U53vRK4NiUBn2WJj1s0HbLinfOILWNn9YC+2ZBfgQpxjXiElruTLA8DkT5Z0kBKKAecxEA1GUbqL0dTuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746046553; c=relaxed/simple;
	bh=Od313OK1KaRM9Dc3kB1+B0iEWriL30mnhLfzK6N9vII=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oxpC1RTacIvGHAZOS7S/sb0ZMhkubbsulmcNKSAXk2TRkUW3dRXj6Otx2ArEGgLrKDcQ3PNE1T1CLifMa4L5Yzb3Or+NB3K2etRtBvXKGJuu2YieYhQXelH2XwEYokSO1Vk1BmaKPYq55njrcTQzcYs1BE5SffnJ+Y/aX6rCglg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fP5u5fPu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fP5u5fPu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51F70C4CEEC;
	Wed, 30 Apr 2025 20:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746046552;
	bh=Od313OK1KaRM9Dc3kB1+B0iEWriL30mnhLfzK6N9vII=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fP5u5fPuoRUawWmxv8/rx3GO0pbZNX0bbxtGLVnBUuQ8itZ3s/yb0xyUHx7EgEkam
	 QfJw1AaeaZR+uSiSVvvnu26u6cp1ExObdUq1D8HyfxFLATDUVYmnHzd+SQ7r1nA/E7
	 TVviNngR9xlN2B/1oe6BAPhr8QzssBjPTr9TJilrgqFDXWP2jry27Z8KW1uYAX+nFh
	 PQ/Z7p5XgXfCGaV2tObPD2p+rtBvGx8src9z8nsSMUdMafxO+LmdUgNlWU5bHaw3E+
	 v8BmE/esYoZoCGX/FMkRKq0IR/IKVqdny8eHsN/18/DU/8Y9O6Fm3YyANFtP2koh53
	 Z9rPMYZJ0tLHw==
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
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Leo Yan <leo.yan@arm.com>
Subject: [PATCH 04/11] perf hist: Add struct he_mem_stat
Date: Wed, 30 Apr 2025 13:55:41 -0700
Message-ID: <20250430205548.789750-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
In-Reply-To: <20250430205548.789750-1-namhyung@kernel.org>
References: <20250430205548.789750-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The struct he_mem_stat is to save detailed information about memory
instruction.  It'll be used to show breakdown of various data from
PERF_SAMPLE_DATA_SRC.  Note that this structure is generic and the
contents will be different depending on actual data it'll use later.

The information about the actual data will be saved in struct hists and
its length is in nr_mem_stats.  This commit just adds ground works and
does nothing since hists->nr_mem_stats is 0 for now.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/hist.c | 74 ++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/hist.h |  9 +++++
 2 files changed, 83 insertions(+)

diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index d65228c1141251fb..fcb9f0db0c92a229 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -336,6 +336,67 @@ static void he_stat__decay(struct he_stat *he_stat)
 	he_stat->latency = (he_stat->latency * 7) / 8;
 }
 
+static int hists__update_mem_stat(struct hists *hists, struct hist_entry *he,
+				  struct mem_info *mi, u64 period)
+{
+	if (hists->nr_mem_stats == 0)
+		return 0;
+
+	if (he->mem_stat == NULL) {
+		he->mem_stat = calloc(hists->nr_mem_stats, sizeof(*he->mem_stat));
+		if (he->mem_stat == NULL)
+			return -1;
+	}
+
+	for (int i = 0; i < hists->nr_mem_stats; i++) {
+		int idx = 0; /* TODO: get correct index from mem info */
+
+		(void)mi;
+		he->mem_stat[i].entries[idx] += period;
+	}
+	return 0;
+}
+
+static void hists__add_mem_stat(struct hists *hists, struct hist_entry *dst,
+				struct hist_entry *src)
+{
+	if (hists->nr_mem_stats == 0)
+		return;
+
+	for (int i = 0; i < hists->nr_mem_stats; i++) {
+		for (int k = 0; k < MEM_STAT_LEN; k++)
+			dst->mem_stat[i].entries[k] += src->mem_stat[i].entries[k];
+	}
+}
+
+static int hists__clone_mem_stat(struct hists *hists, struct hist_entry *dst,
+				  struct hist_entry *src)
+{
+	if (hists->nr_mem_stats == 0)
+		return 0;
+
+	dst->mem_stat = calloc(hists->nr_mem_stats, sizeof(*dst->mem_stat));
+	if (dst->mem_stat == NULL)
+		return -1;
+
+	for (int i = 0; i < hists->nr_mem_stats; i++) {
+		for (int k = 0; k < MEM_STAT_LEN; k++)
+			dst->mem_stat[i].entries[k] = src->mem_stat[i].entries[k];
+	}
+	return 0;
+}
+
+static void hists__decay_mem_stat(struct hists *hists, struct hist_entry *he)
+{
+	if (hists->nr_mem_stats == 0)
+		return;
+
+	for (int i = 0; i < hists->nr_mem_stats; i++) {
+		for (int k = 0; k < MEM_STAT_LEN; k++)
+			he->mem_stat[i].entries[k] = (he->mem_stat[i].entries[k] * 7) / 8;
+	}
+}
+
 static void hists__delete_entry(struct hists *hists, struct hist_entry *he);
 
 static bool hists__decay_entry(struct hists *hists, struct hist_entry *he)
@@ -350,6 +411,7 @@ static bool hists__decay_entry(struct hists *hists, struct hist_entry *he)
 	if (symbol_conf.cumulate_callchain)
 		he_stat__decay(he->stat_acc);
 	decay_callchain(he->callchain);
+	hists__decay_mem_stat(hists, he);
 
 	if (!he->depth) {
 		u64 period_diff = prev_period - he->stat.period;
@@ -693,6 +755,10 @@ static struct hist_entry *hists__findnew_entry(struct hists *hists,
 		he_stat__add_cpumode_period(&he->stat, al->cpumode, period);
 	if (symbol_conf.cumulate_callchain)
 		he_stat__add_cpumode_period(he->stat_acc, al->cpumode, period);
+	if (hists__update_mem_stat(hists, he, entry->mem_info, period) < 0) {
+		hist_entry__delete(he);
+		return NULL;
+	}
 	return he;
 }
 
@@ -1423,6 +1489,7 @@ void hist_entry__delete(struct hist_entry *he)
 	free_callchain(he->callchain);
 	zfree(&he->trace_output);
 	zfree(&he->raw_data);
+	zfree(&he->mem_stat);
 	ops->free(he);
 }
 
@@ -1572,6 +1639,7 @@ static struct hist_entry *hierarchy_insert_entry(struct hists *hists,
 		cmp = hist_entry__collapse_hierarchy(hpp_list, iter, he);
 		if (!cmp) {
 			he_stat__add_stat(&iter->stat, &he->stat);
+			hists__add_mem_stat(hists, iter, he);
 			return iter;
 		}
 
@@ -1613,6 +1681,11 @@ static struct hist_entry *hierarchy_insert_entry(struct hists *hists,
 			new->srcfile = NULL;
 	}
 
+	if (hists__clone_mem_stat(hists, new, he) < 0) {
+		hist_entry__delete(new);
+		return NULL;
+	}
+
 	rb_link_node(&new->rb_node_in, parent, p);
 	rb_insert_color_cached(&new->rb_node_in, root, leftmost);
 	return new;
@@ -1695,6 +1768,7 @@ static int hists__collapse_insert_entry(struct hists *hists,
 			he_stat__add_stat(&iter->stat, &he->stat);
 			if (symbol_conf.cumulate_callchain)
 				he_stat__add_stat(iter->stat_acc, he->stat_acc);
+			hists__add_mem_stat(hists, iter, he);
 
 			if (hist_entry__has_callchains(he) && symbol_conf.use_callchain) {
 				struct callchain_cursor *cursor = get_tls_callchain_cursor();
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index 76efd8952507a561..aba1d84ca074f27b 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -100,6 +100,13 @@ enum hist_column {
 struct thread;
 struct dso;
 
+#define MEM_STAT_LEN  8
+
+struct he_mem_stat {
+	/* meaning of entries depends on enum mem_stat_type */
+	u64			entries[MEM_STAT_LEN];
+};
+
 struct hists {
 	struct rb_root_cached	entries_in_array[2];
 	struct rb_root_cached	*entries_in;
@@ -125,6 +132,7 @@ struct hists {
 	struct perf_hpp_list	*hpp_list;
 	struct list_head	hpp_formats;
 	int			nr_hpp_node;
+	int			nr_mem_stats;
 };
 
 #define hists__has(__h, __f) (__h)->hpp_list->__f
@@ -232,6 +240,7 @@ struct hist_entry {
 	} pairs;
 	struct he_stat		stat;
 	struct he_stat		*stat_acc;
+	struct he_mem_stat	*mem_stat;
 	struct map_symbol	ms;
 	struct thread		*thread;
 	struct comm		*comm;
-- 
2.49.0.906.g1f30a19c02-goog

