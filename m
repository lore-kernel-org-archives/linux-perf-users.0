Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B283C1D7B
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 05:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789621652; cv=none; b=V+QI/Q/OjBOi9aLF1xMGVkjuD5tccywhCt4QGgBuZq+lq5THFMULglLAia5CDhH/nRd05ZYNcybhtTXSMeqOWKCJBXIrhW48FpXGsC93GyKIArIFtvhU049Ax+FhOEPfTkeQlsSwK8psB3El20DC07A7/jmENMmQ2Ce6kAiNWBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789621652; c=relaxed/simple;
	bh=gUr7Teuf5Xrk466VEpBv0l9BCHbmLy0jYFSWMSyOFeQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iCsjZVRSF86VofDBpl26V+QmrfWethmtQFPYhyRMw2ZDL04lq6/UeUeNz8tiFBxL03jjBGy02rZlSuCU8NS2xOtby21URDWoaASsYLPe2D6iVwn2wuGeCBVBwZEQ3x8vE4Ost3azbuutUplLEg3kI06dqkLLH6KQUEmNQGT4wI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Gdqx3tzE; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gdqx3tzE"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2dc7337e2a7so7145775ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 22:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789621650; x=1790226450; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o+3dFnGf7dyBlbMnnfkKa6vSUAPWNKpsZcRpWeiDWNw=;
        b=Gdqx3tzEXe5tl7BEnQxQhUUtmyzs5UyvLvsEGSc/tQrJVLeDaN2siV3n5c4SA/GP5q
         9yGtgovS0MHSGhk42q6AqHR2O3xdcDgcKUt+fUNlc8VWJdYs6/6l6QccQ975idGOxbjj
         tbMATm/MSMebrVj7lAJYaL98wZv5CAXqkMlxiIBbQqnV3Jf2GA1kjOHVUNh5FPtUIzqg
         Pk9jNrRNAcqRDPgr7H3t1zSJOk9UakOcCq1/fgi8Gk+5b99pWbpdrc6BAFBfIn+KRJT0
         AtkkK+U/Ztu0Rlwjjv2cWf0X9N46AMNjpyD9DUkOrFvMXJjzqTscJGMCUA9JzcgoCZ+s
         BlCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789621650; x=1790226450;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o+3dFnGf7dyBlbMnnfkKa6vSUAPWNKpsZcRpWeiDWNw=;
        b=1Hi9zP3jYKG46MT7Bz6dsp/w0FHumoU1jqc3Z+pNNegULIa5PT2/b72Z7SeV/rkvKb
         4NqenLkjlFdqnl00em0N0zommuIQk2uRGstf9fK2Qx2Ycv+jjJ+anvxiI63fBq346/Pp
         oK0NaCF2M0oyMIXtku2jhtPs7c91h4TUOuJYHS5MPqrDqQjiF1qHQwfNmy918hcKM8E8
         rBGi9c1iPoc3kyoz5q8aueO6eZmmdc5iHRbhPxzrR1CIlCnkd+IcP7LWMaquXTteugts
         tuMa9zVDZvo4LT2ycD8MYEc54z6sMCGvwyq46/3FU9bQ8NvXEqjBTy8iRZD2XRz4IGjt
         WqrA==
X-Forwarded-Encrypted: i=1; AKwUvBy+Gtcg6SGCalMcqHbXYfvUOR9Ka2I0+fi8btzupp5m8VoFH8mb80pE6uF3lguld1F9fM2sfevWFDswqzmgQXnv@vger.kernel.org
X-Gm-Message-State: AFuF++kwD7kBzBXW2P6pNt2Mub38yS5A07/WAqLPbAdyLKtcIoc9UgYx
	x6r4I5AB3PvUBWbl5P7BdEOBPVWj/4pCNCuHiNNKkaAArcjX2IAX0+ONZ3oFd9zUntwic0N6a9B
	kPv6HifKaSg==
X-Received: from dybme3.prod.google.com ([2002:a05:7301:1883:b0:333:be45:d677])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d588:b0:2dd:7593:8634
 with SMTP id d9443c01a7336-2dd8e412565mr123222885ad.13.1789621649498; Wed, 16
 Sep 2026 22:07:29 -0700 (PDT)
Date: Wed, 16 Sep 2026 22:07:01 -0700
In-Reply-To: <20260917050708.704702-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260916234652.439778-1-irogers@google.com> <20260917050708.704702-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260917050708.704702-3-irogers@google.com>
Subject: [PATCH v4 2/9] perf ui hist: Add support for aggregated total_period
 and merging entries
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: ak@kernel.org, ak@linux.intel.com, andi@firstfloor.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add the histogram side of hybrid event merging.

When events are merged the entries of the other events are linked to
the leader's entries as pairs, and a row is then displayed as the sum
over an entry and its pairs. Teach the hpp code to work on that sum:

 - The formatting and sorting routines add up the value of an entry and
   of each of its pairs, so a row shows, and is sorted by, the total
   across the core PMUs rather than the leader's value alone.
 - Percentages are taken against the summed total_period of the merged
   hists. Computing each event's share against its own PMU's total
   would leave the column not adding up to 100%.
   hist_entry__get_percent_limit_merged() does the same for
   --percent-limit, which would otherwise compare against the wrong
   total and filter out the wrong entries.
 - A header and column width are reserved for the "Total" the merged
   value is shown under.

evlist__merge_hists_hybrid() links the hists together and resorts the
result so that it is ordered by the merged total.

hists__link() is run once for every event merged into the leader, so an
entry can be offered as a pair more than once. hist_entry__add_pair()
used list_add_tail() unconditionally, which corrupts the list when the
entry is already on one. Return early if the entry is already paired
with this one, and use list_move_tail() so that an entry linked
elsewhere is moved rather than added a second time.

Merging is never combined with --hierarchy, which the merge_entries
tests rely on.

Signed-off-by: Ian Rogers <irogers@google.com>
Assisted-by: Antigravity:gemini-3.1-pro
---
 tools/perf/ui/hist.c   | 246 +++++++++++++++++++++++++++++++++++++++--
 tools/perf/util/hist.h |  14 ++-
 2 files changed, 252 insertions(+), 8 deletions(-)

diff --git a/tools/perf/ui/hist.c b/tools/perf/ui/hist.c
index e58327595d37..09da45c80889 100644
--- a/tools/perf/ui/hist.c
+++ b/tools/perf/ui/hist.c
@@ -57,8 +57,9 @@ struct hpp_fmt_value {
 };
 
 static int __hpp__fmt(struct perf_hpp *hpp, struct hist_entry *he,
-		      hpp_field_fn get_field, const char *fmt, int len,
-		      hpp_snprint_fn print_fn, enum perf_hpp_fmt_type fmtype)
+		      hpp_field_fn get_field, const char *fmtstr, int len,
+		      hpp_snprint_fn print_fn, enum perf_hpp_fmt_type fmtype,
+		      struct perf_hpp_fmt *fmt __maybe_unused)
 {
 	int ret = 0;
 	struct hists *hists = he->hists;
@@ -98,13 +99,50 @@ static int __hpp__fmt(struct perf_hpp *hpp, struct hist_entry *he,
 		}
 	}
 
+	/* Note, merge_entries implies !symbol_conf.report_hierarchy. */
+	if (he->hists->merge_entries) {
+		u64 total_val = 0;
+		u64 total_samples = 0;
+		u64 total_period = 0;
+
+		for (i = 0; i < nr_members; i++) {
+			struct evsel *member_evsel = hists_to_evsel(values[i].hists);
+
+			struct evsel *he_evsel = hists_to_evsel(he->hists);
+
+			if (member_evsel != he_evsel &&
+			    member_evsel->first_wildcard_match != he_evsel)
+				continue;
+
+			total_val += values[i].val;
+			total_samples += values[i].samples;
+			total_period += fmtype == PERF_HPP_FMT_TYPE__PERCENT ?
+					hists__total_period(values[i].hists) :
+					hists__total_latency(values[i].hists);
+		}
+
+		if (fmtype == PERF_HPP_FMT_TYPE__PERCENT || fmtype == PERF_HPP_FMT_TYPE__LATENCY) {
+			double percent = 0.0;
+
+			if (total_period)
+				percent = 100.0 * total_val / total_period;
+			ret += hpp__call_print_fn(hpp, print_fn, fmtstr, len, percent);
+		} else if (fmtype == PERF_HPP_FMT_TYPE__AVERAGE) {
+			double avg = total_samples ? (1.0 * total_val / total_samples) : 0;
+
+			ret += hpp__call_print_fn(hpp, print_fn, fmtstr, len, avg);
+		} else {
+			ret += hpp__call_print_fn(hpp, print_fn, fmtstr, len, total_val);
+		}
+	}
+
 	for (i = 0; i < nr_members; i++) {
 		if (symbol_conf.skip_empty &&
 		    values[i].hists->stats.nr_samples == 0)
 			continue;
 
 		ret += __hpp__fmt_print(hpp, values[i].hists, values[i].val,
-					values[i].samples, fmt, len,
+					values[i].samples, fmtstr, len,
 					print_fn, fmtype);
 	}
 
@@ -129,7 +167,7 @@ int hpp__fmt(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
 
 	if (symbol_conf.field_sep) {
 		return __hpp__fmt(hpp, he, get_field, fmtstr, 1,
-				  print_fn, fmtype);
+				  print_fn, fmtype, fmt);
 	}
 
 	if (fmtype == PERF_HPP_FMT_TYPE__PERCENT || fmtype == PERF_HPP_FMT_TYPE__LATENCY)
@@ -137,7 +175,7 @@ int hpp__fmt(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
 	else
 		len -= 1;
 
-	return  __hpp__fmt(hpp, he, get_field, fmtstr, len, print_fn, fmtype);
+	return  __hpp__fmt(hpp, he, get_field, fmtstr, len, print_fn, fmtype, fmt);
 }
 
 int hpp__fmt_acc(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
@@ -287,6 +325,35 @@ static int __hpp__sort(struct hist_entry *a, struct hist_entry *b,
 		return __hpp__group_sort_idx(a, b, get_field,
 					     symbol_conf.group_sort_idx);
 	}
+	/*
+	 * Relies on merge_entries being only enabled if there are
+	 * only matching events. If that is ever relaxed will need
+	 * more logic here. merge_entries also implies that
+	 * symbol_conf.report_hierarchy is false.
+	 */
+	if (a->hists->merge_entries && b->hists->merge_entries) {
+		u64 val_a = get_field(a), val_b = get_field(b);
+		struct hist_entry *pair;
+		struct evsel *evsel_a = hists_to_evsel(a->hists);
+		struct evsel *evsel_b = hists_to_evsel(b->hists);
+
+		list_for_each_entry(pair, &a->pairs.head, pairs.node) {
+			struct evsel *pair_evsel = hists_to_evsel(pair->hists);
+
+			if (pair_evsel->first_wildcard_match == evsel_a)
+				val_a += get_field(pair);
+		}
+		list_for_each_entry(pair, &b->pairs.head, pairs.node) {
+			struct evsel *pair_evsel = hists_to_evsel(pair->hists);
+
+			if (pair_evsel->first_wildcard_match == evsel_b)
+				val_b += get_field(pair);
+		}
+
+		ret = field_cmp(val_a, val_b);
+		if (ret)
+			return ret;
+	}
 
 	ret = field_cmp(get_field(a), get_field(b));
 	if (ret || !symbol_conf.event_group)
@@ -323,7 +390,29 @@ static int __hpp__sort_acc(struct hist_entry *a, struct hist_entry *b,
 		/*
 		 * Put caller above callee when they have equal period.
 		 */
-		ret = field_cmp(get_field(a), get_field(b));
+		if (a->hists->merge_entries && b->hists->merge_entries) {
+			u64 val_a = get_field(a), val_b = get_field(b);
+			struct hist_entry *pair;
+			struct evsel *evsel_a = hists_to_evsel(a->hists);
+			struct evsel *evsel_b = hists_to_evsel(b->hists);
+
+			list_for_each_entry(pair, &a->pairs.head, pairs.node) {
+				struct evsel *pair_evsel = hists_to_evsel(pair->hists);
+
+				if (pair_evsel->first_wildcard_match == evsel_a)
+					val_a += get_field(pair);
+			}
+			list_for_each_entry(pair, &b->pairs.head, pairs.node) {
+				struct evsel *pair_evsel = hists_to_evsel(pair->hists);
+
+				if (pair_evsel->first_wildcard_match == evsel_b)
+					val_b += get_field(pair);
+			}
+
+			ret = field_cmp(val_a, val_b);
+		} else {
+			ret = field_cmp(get_field(a), get_field(b));
+		}
 		if (ret)
 			return ret;
 
@@ -386,6 +475,8 @@ static int hpp__width_fn(struct perf_hpp_fmt *fmt,
 			    evsel__hists(pos)->stats.nr_samples)
 				nr++;
 		}
+		if (hists->merge_entries)
+			nr++; /* Add 1 extra unit of width generically for the 'Total' */
 
 		len = max(len, nr * fmt->len);
 	}
@@ -403,8 +494,38 @@ static int hpp__header_fn(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
 	int len = hpp__width_fn(fmt, hpp, hists);
 	const char *hdr = "";
 
-	if (line == hists->hpp_list->nr_header_lines - 1)
+	if (line == hists->hpp_list->nr_header_lines - 1) {
 		hdr = fmt->name;
+		if (hists->merge_entries) {
+			int w = 0;
+			int f_len = fmt->user_len ?: fmt->len;
+			struct evsel *pos, *evsel = hists_to_evsel(hists);
+			int string_len = f_len;
+
+			for_each_group_evsel(pos, evsel) {
+				if (symbol_conf.skip_empty &&
+				    evsel__hists(pos)->stats.nr_samples == 0)
+					continue;
+				string_len += f_len;
+			}
+
+			if (len > string_len) {
+				w += scnprintf(hpp->buf + w, hpp->size - w, "%*s",
+					       len - string_len, "");
+			}
+
+			w += scnprintf(hpp->buf + w, hpp->size - w, "%*.*s",
+				       f_len, f_len, fmt->name);
+			for_each_group_evsel(pos, evsel) {
+				if (symbol_conf.skip_empty &&
+				    evsel__hists(pos)->stats.nr_samples == 0)
+					continue;
+				w += scnprintf(hpp->buf + w, hpp->size - w, " %*.*s",
+					       f_len - 1, f_len - 1, evsel__name(pos));
+			}
+			return w;
+		}
+	}
 
 	return scnprintf(hpp->buf, hpp->size, "%*s", len, hdr);
 }
@@ -1271,3 +1392,114 @@ int perf_hpp__alloc_mem_stats(struct perf_hpp_list *list, struct evlist *evlist)
 	}
 	return 0;
 }
+
+float hist_entry__get_percent_limit_merged(struct hist_entry *he)
+{
+	struct hist_entry *pair;
+	u64 period = he->stat.period;
+	u64 total_period = hists__total_period(he->hists);
+	struct evsel *evsel = hists_to_evsel(he->hists);
+	struct evsel *pos;
+
+	/* Accumulate global total_period across all merged hists matching hybrid type */
+	for_each_group_member(pos, evsel) {
+		if (pos->first_wildcard_match == evsel)
+			total_period += hists__total_period(evsel__hists(pos));
+	}
+
+	if (unlikely(total_period == 0))
+		return 0;
+
+	if (symbol_conf.cumulate_callchain) {
+		period = he->stat_acc->period;
+		list_for_each_entry(pair, &he->pairs.head, pairs.node) {
+			struct evsel *pair_evsel = hists_to_evsel(pair->hists);
+
+			if (pair_evsel->first_wildcard_match == evsel)
+				period += pair->stat_acc->period;
+		}
+	} else {
+		/* Accumulate symbol specific period across pairs matching hybrid type */
+		list_for_each_entry(pair, &he->pairs.head, pairs.node) {
+			struct evsel *pair_evsel = hists_to_evsel(pair->hists);
+
+			if (pair_evsel->first_wildcard_match == evsel)
+				period += pair->stat.period;
+		}
+	}
+
+	return period * 100.0 / total_period;
+}
+
+void evlist__merge_hists_hybrid(struct evlist *evlist, bool refresh_hists)
+{
+	struct evsel *pos;
+	struct evsel *member;
+	bool hybrid_group;
+
+	/*
+	 * Merged hists display all the events of a group in a single set of
+	 * entries, which the hierarchy display has no way to render. Keeping
+	 * hists->merge_entries false here means the rest of the display code
+	 * can assume merge_entries implies !symbol_conf.report_hierarchy.
+	 */
+	if (symbol_conf.report_hierarchy)
+		return;
+
+	/* Set merge_entries flag strictly on leaders formulated by hybrid topology */
+	evlist__for_each_entry(evlist, pos) {
+		if (evsel__is_dummy_event(pos))
+			continue;
+
+		if (pos->core.leader == &pos->core && pos->core.nr_members > 1) {
+			hybrid_group = false;
+
+			if (pos->first_wildcard_match || pos->merged_hybrid_group) {
+				hybrid_group = true;
+			} else {
+				for_each_group_member(member, pos) {
+					if (member->first_wildcard_match ||
+					    member->merged_hybrid_group) {
+						hybrid_group = true;
+						break;
+					}
+				}
+			}
+
+			if (hybrid_group) {
+				evsel__hists(pos)->merge_entries = true;
+				symbol_conf.event_group = true;
+				symbol_conf.hybrid_merge = true;
+				if (!pos->group_name) {
+					pos->group_name = strdup("Merged hybrid events");
+					if (!pos->group_name)
+						pr_warning("Failed to allocate hybrid group name\n");
+				}
+			}
+		}
+	}
+
+	if (!refresh_hists)
+		return;
+
+	evlist__for_each_entry(evlist, pos) {
+		/* Match histograms dynamically since parsing happened before group toggling */
+		if (symbol_conf.event_group && !evsel__is_group_leader(pos)) {
+			struct hists *leader_hists = evsel__hists(evsel__leader(pos));
+			struct hists *hists = evsel__hists(pos);
+
+			hists__match(leader_hists, hists);
+			hists__link(leader_hists, hists);
+		}
+	}
+
+	/* Now that links are formed, safely resort the active tree so the UI renders accurately */
+	if (symbol_conf.event_group) {
+		evlist__for_each_entry(evlist, pos) {
+			if (evsel__is_dummy_event(pos) || !evsel__is_group_leader(pos))
+				continue;
+			if (pos->core.nr_members > 1 && evsel__hists(pos)->merge_entries)
+				hists__output_resort(evsel__hists(pos), NULL);
+		}
+	}
+}
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index d0ed43807cf6..0d08011aebce 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -339,7 +339,13 @@ static inline struct hist_entry *hist_entry__next_pair(struct hist_entry *he)
 static inline void hist_entry__add_pair(struct hist_entry *pair,
 					struct hist_entry *he)
 {
-	list_add_tail(&pair->pairs.node, &he->pairs.head);
+	struct list_head *pos;
+
+	list_for_each(pos, &he->pairs.head) {
+		if (pos == &pair->pairs.node)
+			return; /* Already paired */
+	}
+	list_move_tail(&pair->pairs.node, &he->pairs.head);
 }
 
 struct hist_entry *hists__add_entry(struct hists *hists,
@@ -434,11 +440,17 @@ void hists__match(struct hists *leader, struct hists *other);
 int hists__link(struct hists *leader, struct hists *other);
 int hists__unlink(struct hists *hists);
 
+float hist_entry__get_percent_limit_merged(struct hist_entry *he);
+void evlist__merge_hists_hybrid(struct evlist *evlist, bool refresh);
+
 static inline float hist_entry__get_percent_limit(struct hist_entry *he)
 {
 	u64 period = he->stat.period;
 	u64 total_period = hists__total_period(he->hists);
 
+	if (he->hists->merge_entries)
+		return hist_entry__get_percent_limit_merged(he);
+
 	if (unlikely(total_period == 0))
 		return 0;
 
-- 
2.55.0.1082.g2b9226bbc0-goog

