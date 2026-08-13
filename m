Received: from one.firstfloor.org (one.firstfloor.org [65.21.254.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C8747DF87
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Aug 2026 13:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.254.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786628030; cv=none; b=ulZq+8z4lC6njiTEy1qVuX2o0+ZosqnqSkf2vWlax5NXIVBomBT6l5PWQSt8TXdpuNkfUgSrDAIkJwe69vpZG1Tgd44Dtfooup9rAaVtZOA8cSQRXB5hLsUXeLQ3s/lDlIsoHBQr088TqVrhdggcMxFctc5+9jqCQv1QSRFmlCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786628030; c=relaxed/simple;
	bh=QoB2zShlSbdA87y5qsAf2jDqc+bzDD3S1FqTsTFQ2Hw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BDCkELB385HJwgeSjxxVZAaslRWyT6bTORM3QqqGA4CnNAr1zgb2MKzI8KyLOKlE4C00OYRJH/6Hv7SAIMpprRwjXDHK7gwIlHmmNThuGR6eZlh+xDrKnSGGqEQ32ET17E4DYepz4kniFvIr898aI7thun3HSke2UKPsd4uqDiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=firstfloor.org; spf=pass smtp.mailfrom=firstfloor.org; dkim=pass (1024-bit key) header.d=firstfloor.org header.i=@firstfloor.org header.b=gsbFDowd; arc=none smtp.client-ip=65.21.254.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=firstfloor.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=firstfloor.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=firstfloor.org header.i=@firstfloor.org header.b="gsbFDowd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=firstfloor.org;
	s=mail; t=1786627534;
	bh=QoB2zShlSbdA87y5qsAf2jDqc+bzDD3S1FqTsTFQ2Hw=;
	h=From:To:Cc:Subject:Date:From;
	b=gsbFDowdADkCjahL2aUPnFHDEhW7UnMRDiqfzzd3o04nUf+P/81VszQDwCLeqeGJw
	 Rend2hKvFILbshN4IS5UaTUFXev+qd0f4syW/0NwM1ObpC54Ct23a1VY2avHHUZkmA
	 WPUBai6Tba2yhk9dkjIJ5yJBYeGWMp5vNU9Zw0Cs=
Received: from firstfloor.org (c-73-11-123-161.hsd1.or.comcast.net [73.11.123.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by one.firstfloor.org (Postfix) with ESMTPSA id 0B8295E89D;
	Thu, 13 Aug 2026 15:25:34 +0200 (CEST)
Received: by firstfloor.org (Postfix, from userid 1000)
	id 93554161DE6; Thu, 13 Aug 2026 06:25:30 -0700 (PDT)
From: Andi Kleen <andi@firstfloor.org>
To: namhyung@kernel.org
Cc: acme@kernel.org,
	linux-perf-users@vger.kernel.org,
	Andi Kleen <ak@kernel.org>,
	Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v1] perf top: Merge hybrid common events
Date: Thu, 13 Aug 2026 06:25:19 -0700
Message-ID: <20260813132519.4099508-1-andi@firstfloor.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andi Kleen <ak@kernel.org>

One annoyance with perf top on a hybrid system is that it requires to
chose which hybrid PMU to sample on. Normally I want to sample the whole
system and don't know on which cores my workload ends up.

This patch automatically merges the two PMUs when the event is present
in both PMUs. For now it only handles simple TYPE_HARDWARE cases, like
cycles
(could be later extended for TYPE_RAW too by checking the json name is the same)
The behavior can be disabled with --no-hybrid-merge

Assisted-by: omp:GLM-5.2
Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/Documentation/perf-top.txt |  6 ++++
 tools/perf/builtin-top.c              | 16 ++++++++++
 tools/perf/ui/hist.c                  | 19 ++++++++++++
 tools/perf/util/evlist.c              | 43 +++++++++++++++++++++++++++
 tools/perf/util/evlist.h              |  1 +
 tools/perf/util/hist.h                | 15 +++++++++-
 tools/perf/util/top.c                 |  8 ++++-
 tools/perf/util/top.h                 |  1 +
 8 files changed, 107 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf-top.txt b/tools/perf/Documentation/perf-top.txt
index af3e4230c72f4..e560d6b1634d8 100644
--- a/tools/perf/Documentation/perf-top.txt
+++ b/tools/perf/Documentation/perf-top.txt
@@ -43,6 +43,12 @@ Default is to monitor all CPUS.
 	encoding with the layout of the event control registers as described
 	by entries in /sys/bus/event_source/devices/cpu/format/*.
 
+--hybrid-merge::
+    Merge matching legacy hardware events from all hybrid core PMUs into one
+    display. This is enabled by default when the same event is available on
+    each core PMU. Use `--no-hybrid-merge` to display the existing per-event
+    selection menu instead.
+
 --filter=<filter>::
 	Event filter.  This option should follow an event selector (-e). For
 	syntax see linkperf:perf-record[1].
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 1211401616ee3..19dec094683b3 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1334,6 +1334,19 @@ static int __cmd_top(struct perf_top *top)
 	 */
         if (!target__none(&opts->target))
 		evlist__enable(top->evlist);
+	if (top->hybrid_merge && !symbol_conf.report_hierarchy &&
+	    evlist__can_merge_hybrid(top->evlist)) {
+		struct evsel *leader = evlist__first(top->evlist);
+
+		/*
+		 * Merged events are not true groups, but can use
+		 * the existing group display code to display them
+		 * anyways.
+		 */
+		__perf_evlist__set_leader(&top->evlist->core.entries, &leader->core);
+		evsel__hists(leader)->merge_entries = true;
+		symbol_conf.event_group = true;
+	}
 
 	ret = -1;
 	if (pthread_create(&thread_process, NULL, process_thread, top)) {
@@ -1457,6 +1470,7 @@ int cmd_top(int argc, const char **argv)
 	struct perf_top top = {
 		.count_filter	     = 5,
 		.delay_secs	     = 2,
+		.hybrid_merge	     = true,
 		.record_opts = {
 			.mmap_pages	= UINT_MAX,
 			.user_freq	= UINT_MAX,
@@ -1490,6 +1504,8 @@ int cmd_top(int argc, const char **argv)
 	OPT_CALLBACK('e', "event", &parse_events_option_args, "event",
 		     "event selector. use 'perf list' to list available events",
 		     parse_events_option),
+	OPT_BOOLEAN(0, "hybrid-merge", &top.hybrid_merge,
+		    "merge the same event across hybrid core PMUs"),
 	OPT_CALLBACK(0, "filter", &top.evlist, "filter",
 		     "event filter", parse_filter),
 	OPT_U64('c', "count", &opts->user_interval, "event period to sample"),
diff --git a/tools/perf/ui/hist.c b/tools/perf/ui/hist.c
index e58327595d37d..aee43b33e4e1e 100644
--- a/tools/perf/ui/hist.c
+++ b/tools/perf/ui/hist.c
@@ -287,6 +287,25 @@ static int __hpp__sort(struct hist_entry *a, struct hist_entry *b,
 		return __hpp__group_sort_idx(a, b, get_field,
 					     symbol_conf.group_sort_idx);
 	}
+	/*
+	 * Relies on merge_entries being only enabled if there are
+	 * only matching events. If that is ever relaxed will need
+	 * more logic here.
+	 */
+	if (a->hists->merge_entries && b->hists->merge_entries) {
+		u64 val_a = get_field(a), val_b = get_field(b);
+		struct hist_entry *pair;
+
+		list_for_each_entry(pair, &a->pairs.head, pairs.node)
+			val_a += get_field(pair);
+		list_for_each_entry(pair, &b->pairs.head, pairs.node)
+			val_b += get_field(pair);
+
+		ret = field_cmp(val_a, val_b);
+		if (ret)
+			return ret;
+		/* fall through to per-member tiebreaker */
+	}
 
 	ret = field_cmp(get_field(a), get_field(b));
 	if (ret || !symbol_conf.event_group)
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 1a238b245b3a0..4140f998e8a9b 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -142,6 +142,49 @@ struct evlist *evlist__new_default(const struct target *target, bool sample_call
 	return NULL;
 }
 
+bool evlist__can_merge_hybrid(struct evlist *evlist)
+{
+	struct evsel *pos, *other;
+	u64 config = 0;
+	unsigned int nr = 0;
+	bool first = true;
+	int nr_core_pmus;
+
+	nr_core_pmus = perf_pmus__num_core_pmus();
+	if (nr_core_pmus <= 1)
+		return false;
+
+	evlist__for_each_entry(evlist, pos) {
+		if (evsel__is_dummy_event(pos))
+			continue;
+
+		/* Initial support is for legacy hardware events, such as cycles. */
+		if (!pos->pmu || !pos->pmu->is_core ||
+		    pos->core.attr.type != PERF_TYPE_HARDWARE)
+			return false;
+
+		if (first) {
+			/*
+			 * Filter out the PMU bits. May need something else
+			 * for other types.
+			 */
+			config = pos->core.attr.config & UINT32_MAX;
+			first = false;
+		} else if ((pos->core.attr.config & UINT32_MAX) != config) {
+			return false;
+		}
+
+		evlist__for_each_entry(evlist, other) {
+			if (other != pos && !evsel__is_dummy_event(other) &&
+			    other->pmu == pos->pmu)
+				return false;
+		}
+
+		nr++;
+	}
+	return !first && nr == (unsigned int)nr_core_pmus;
+}
+
 struct evlist *evlist__new_dummy(void)
 {
 	struct evlist *evlist = evlist__new();
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index e507f5f20ef61..ad0e6e7399d2a 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -105,6 +105,7 @@ struct evsel_str_handler {
 
 struct evlist *evlist__new(void);
 struct evlist *evlist__new_default(const struct target *target, bool sample_callchains);
+bool evlist__can_merge_hybrid(struct evlist *evlist);
 struct evlist *evlist__new_dummy(void);
 void evlist__init(struct evlist *evlist, struct perf_cpu_map *cpus,
 		  struct perf_thread_map *threads);
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index b830cbe7f95bf..a9dd423ded5e1 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -130,6 +130,7 @@ struct hists {
 	struct hists_stats	stats;
 	u64			event_stream;
 	u16			col_len[HISTC_NR_COLS];
+	bool			merge_entries;
 	bool			has_callchains;
 	int			socket_filter;
 	struct perf_hpp_list	*hpp_list;
@@ -435,14 +436,26 @@ int hists__unlink(struct hists *hists);
 
 static inline float hist_entry__get_percent_limit(struct hist_entry *he)
 {
+	struct hist_entry *pair;
 	u64 period = he->stat.period;
 	u64 total_period = hists__total_period(he->hists);
 
+	if (he->hists->merge_entries) {
+		list_for_each_entry(pair, &he->pairs.head, pairs.node) {
+			period += pair->stat.period;
+			total_period += hists__total_period(pair->hists);
+		}
+	}
+
 	if (unlikely(total_period == 0))
 		return 0;
 
-	if (symbol_conf.cumulate_callchain)
+	if (symbol_conf.cumulate_callchain) {
 		period = he->stat_acc->period;
+		if (he->hists->merge_entries)
+			list_for_each_entry(pair, &he->pairs.head, pairs.node)
+				period += pair->stat_acc->period;
+	}
 
 	return period * 100.0 / total_period;
 }
diff --git a/tools/perf/util/top.c b/tools/perf/util/top.c
index b06e10a116bb3..b7ae51fbc9541 100644
--- a/tools/perf/util/top.c
+++ b/tools/perf/util/top.c
@@ -78,7 +78,13 @@ size_t perf_top__header_snprintf(struct perf_top *top, char *bf, size_t size)
 				opts->freq ? "Hz" : "");
 	}
 
-	ret += SNPRINTF(bf + ret, size - ret, "%s", evsel__name(top->sym_evsel));
+	if (evsel__is_group_event(top->sym_evsel)) {
+		char buf[256];
+		evsel__group_desc(top->sym_evsel, buf, sizeof(buf));
+		ret += SNPRINTF(bf + ret, size - ret, "%s", buf);
+	} else {
+		ret += SNPRINTF(bf + ret, size - ret, "%s", evsel__name(top->sym_evsel));
+	}
 
 	ret += SNPRINTF(bf + ret, size - ret, "], ");
 
diff --git a/tools/perf/util/top.h b/tools/perf/util/top.h
index 04ff926846be0..b42e23066fc0d 100644
--- a/tools/perf/util/top.h
+++ b/tools/perf/util/top.h
@@ -32,6 +32,7 @@ struct perf_top {
 	u64		   guest_us_samples, guest_kernel_samples;
 	int		   print_entries, count_filter, delay_secs;
 	int		   max_stack;
+	bool		   hybrid_merge;
 	bool		   hide_kernel_symbols, hide_user_symbols, zero;
 #ifdef HAVE_SLANG_SUPPORT
 	bool		   use_tui;
-- 
2.54.0

