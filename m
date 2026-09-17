Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846D23A9610
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 05:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789621650; cv=none; b=Ddyu+aTNHgJypOUlgJufIfL/AA5KUSxF1Dy8ipFIEKG038SLYlEjJltPU4rAvypNFxwRWOJLxmNfPq8YrI7rUJcqvplAHQmI57CjK0sNJEptRQHxvUPcsFB3c4gNl7LPn4MD7xMksSRu79rEID5Rmd6JGwMTnKlzEwAXOL/ms2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789621650; c=relaxed/simple;
	bh=EoPo5ypiWnepVRbDe39Y+J1lRAlVuS2oMzkmYqfRtcQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mWo7ukxLkrm1ncWVB0LmUuPnSFREwKrpZE4TFGpoYnOEeQHEfju3vO30Ef77c8jXnoAwhVOIvLgptUDmw/pPg0QVSXM5OMMzwC8Dsq522ksYf9HwZVfyjaNgGhHVwCnN/s5Pv75piWieVOqUPrsXvGv2WG+qS1Bg4haRf/8Z5E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ey72k3Bm; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ey72k3Bm"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38e54b6556aso627811a91.2
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 22:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789621648; x=1790226448; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pZ72lov8TCyDVIUq+mzf5it7AyVHEmQS++OUM9G1i7I=;
        b=Ey72k3Bm3jyzNt/90FUa7yefpQIYNcBhTe2FXPlq41uHhqScj57sOjDjYQeJIK6a+G
         ItqoaUunxi8JuTNVEfsTDuVBmr9NYLOG1ZlmvzL9g525QDO2/qQX+zCqOgdZqelOG6Jj
         5zZH3ekymb0FNF/uuxc4wQb8bYEOcof70vQl0unOoCzqxyVQkTch0wpronVti2Tke7Gk
         z5CG/VMm6+2uupvbpgDcf9RRnvpGkGqBe4ap8UrIvWuDrJ0pvABH2nlUolUsQ6yb8FS8
         AflDHyZxmY6aOTGuBhqR1nff5dnIY9UoCToVU2bS83gS5UJn7iG4R4V2/2/qgs3uW08X
         2Pjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789621648; x=1790226448;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pZ72lov8TCyDVIUq+mzf5it7AyVHEmQS++OUM9G1i7I=;
        b=jEPDRx8oHi7qSjrwnwOoCiZXExR0CKiB076T0J2arhvDXmQinbQnhwPJ38LNgTtcR6
         yY/aPa/9wUwnl3Tre05g8jMh3zV4uIeU2uUG2XfzmLftw/NBjxHTPZBQe8qsm234ghjl
         h/6aDXcPM4+K9/UuYj91aWcgCQ9FfFaSaN+TWG5pr4pqtAvKDAgowchkV5GjCXtrnscM
         XM+FY/LuzidZZaeGc4eIDUU/oKetNwHrmT/QqficT7Rjru1XQe3oa8TbRQQdiT55WS29
         mpddZhjvsdPx2clZOJUn0pTjfV5E+ldOiq1O+n0k6zZYsP7UefHwNEW1OlQUzZeBdbt8
         417g==
X-Forwarded-Encrypted: i=1; AKwUvByxHdR5y7wYa3bPO96Oi4YxkhMvjGclj3fluhpHD+eis6jKuc1EaN3fIxEsfisfWIMS4ZYnOuVb70xRTe+rDlKw@vger.kernel.org
X-Gm-Message-State: AFuF++l2jg+LYtO9NAAlDnGIUF5aWdvhtpivJBn+UJ6B5f6ZYHvSzxPI
	QPwfJP317vtZSHXd8h25N9M+xx7ABQ3k5sITRmP2t07kbAzRQ/noI/Bhp0UzGoE2AgZMEn7sujF
	GFJWFgD+W3A==
X-Received: from dloo7-n1.prod.google.com ([2002:a05:7023:a47:10b0:143:7976:20e7])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:48cd:b0:39e:2ea1:e2a9
 with SMTP id 98e67ed59e1d1-39e2ea1e2b7mr7945514a91.8.1789621647474; Wed, 16
 Sep 2026 22:07:27 -0700 (PDT)
Date: Wed, 16 Sep 2026 22:07:00 -0700
In-Reply-To: <20260917050708.704702-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260916234652.439778-1-irogers@google.com> <20260917050708.704702-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260917050708.704702-2-irogers@google.com>
Subject: [PATCH v4 1/9] perf evlist: Implement evlist__can_merge_hybrid using first_wildcard_match
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: ak@kernel.org, ak@linux.intel.com, andi@firstfloor.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add logic to dynamically identify mergeable events spawned from the
same wildcard alias via first_wildcard_match. first_wildcard_match is
populated when events are parsed, in `perf report` the events come
from a file and so the first_wildcard_match is computed by matching
event names.

evlist__can_merge_hybrid only tests whether merging is possible and
doesn't modify the evlist, so that it may be used as a predicate, for
example, to decide whether to display a hint. The linking of all the
matching events is done by evlist__merge_hybrid.

is_pmu_core_len identifies core PMUs using the hybrid topology of the
perf.data file. Should the file lack the topology, the PMUs of this
machine are scanned but only when the file was recorded on the same
architecture, as PMU names like "cpu_core" are architecture specific.

Signed-off-by: Ian Rogers <irogers@google.com>
Assisted-by: Antigravity:gemini-3.1-pro
---
 tools/perf/util/evlist.c       | 183 +++++++++++++++++++++++++++++++++
 tools/perf/util/evlist.h       |   3 +
 tools/perf/util/evsel.h        |   1 +
 tools/perf/util/hist.h         |   1 +
 tools/perf/util/parse-events.c |   4 +-
 tools/perf/util/pmu.c          |  43 +++++++-
 tools/perf/util/pmu.h          |   3 +
 tools/perf/util/symbol_conf.h  |   1 +
 8 files changed, 236 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index c3d784727810..930efbb66bc8 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -7,6 +7,7 @@
  */
 #include "evlist.h"
 
+#include <stdio.h>
 #include <errno.h>
 #include <inttypes.h>
 #include <signal.h>
@@ -53,6 +54,7 @@
 #include "event.h"
 #include "evsel.h"
 #include "evsel_fprintf.h"
+#include "hist.h"
 #include "intel-tpebs.h"
 #include "metricgroup.h"
 #include "mmap.h"
@@ -125,12 +127,24 @@ struct evlist *evlist__new_default(const struct target *target, bool sample_call
 		if (err)
 			goto out_err;
 	} else {
+		struct evsel *leader = NULL;
+
+		/* Fallback for cross-platform file analysis missing the topology header */
 		while ((pmu = perf_pmus__scan_core(pmu)) != NULL) {
 			snprintf(buf, sizeof(buf), "%s/cycles/%s", pmu->name,
 				can_profile_kernel ? "P" : "Pu");
 			err = parse_event(evlist, buf);
 			if (err)
 				goto out_err;
+
+			if (!leader) {
+				leader = evlist__last(evlist);
+			} else {
+				struct evsel *last = evlist__last(evlist);
+
+				if (last != leader)
+					last->first_wildcard_match = leader;
+			}
 		}
 	}
 
@@ -148,6 +162,175 @@ struct evlist *evlist__new_default(const struct target *target, bool sample_call
 	return NULL;
 }
 
+/**
+ * evlist__hybrid_matches - find events that may be merged across core PMUs.
+ * @evlist: The evlist to check.
+ * @env: The perf_env containing the PMU mapping information, NULL for the
+ *       current machine.
+ * @link: Should the matches be recorded in first_wildcard_match?
+ *
+ * perf record, top, etc. set first_wildcard_match in the event parsing. The
+ * perf.data case (e.g. perf report) recomputes the first_wildcard_match using
+ * string matches for core events on hybrid systems.
+ */
+static bool evlist__hybrid_matches(struct evlist *evlist, struct perf_env *env, bool link)
+{
+	struct evsel *pos;
+	unsigned int nr = 0;
+	bool found = false;
+
+	evlist__for_each_entry(evlist, pos) {
+		if (evsel__is_dummy_event(pos))
+			continue;
+
+		if (pos->core.leader != &pos->core || pos->core.nr_members > 1)
+			return false;
+
+		if (pos->first_wildcard_match)
+			found = true;
+		nr++;
+	}
+
+	/* No events found. */
+	if (nr <= 1)
+		return false;
+
+	/* Found wildcard events from parsing. */
+	if (found)
+		return true;
+
+	/* Try to find matching core events and set the first_wildcard_match. */
+	evlist__for_each_entry(evlist, pos) {
+		const char *pos_name;
+		const char *pos_match;
+		struct evsel *peer;
+
+		if (evsel__is_dummy_event(pos) || pos->first_wildcard_match)
+			continue;
+
+		pos_name = evsel__name(pos);
+		pos_match = pos_name ? strchr(pos_name, '/') : NULL;
+
+		if (!pos_match)
+			continue;
+
+		/* If evsel->core.is_pmu_core missing in report, fallback to perf_env */
+		if (!evsel__is_hybrid(pos)) {
+			if (!is_pmu_core_len(env, pos_name, pos_match - pos_name))
+				continue;
+		}
+
+		peer = pos;
+		list_for_each_entry_continue(peer, &evlist__core(evlist)->entries, core.node) {
+			const char *peer_name;
+			const char *peer_match;
+
+			if (evsel__is_dummy_event(peer) || peer->first_wildcard_match)
+				continue;
+
+			peer_name = evsel__name(peer);
+			peer_match = peer_name ? strchr(peer_name, '/') : NULL;
+			if (!peer_match)
+				continue;
+
+			if (!evsel__is_hybrid(peer)) {
+				if (!is_pmu_core_len(env, peer_name,
+						     peer_match - peer_name))
+					continue;
+			}
+
+			if (strcmp(pos_match, peer_match))
+				continue;
+
+			found = true;
+			if (!link) {
+				/* Just a test, don't modify the evlist. */
+				return true;
+			}
+			/*
+			 * Keep looking so that all the events of this name are
+			 * linked, there may be more than 2 core PMUs.
+			 */
+			peer->first_wildcard_match = pos;
+		}
+	}
+	return found;
+}
+
+/**
+ * evlist__can_merge_hybrid - can events in the evlist be merged across core
+ * PMUs? The evlist isn't modified.
+ * @evlist: The evlist to check.
+ * @env: The perf_env containing the PMU mapping information, NULL for the
+ *       current machine.
+ */
+bool evlist__can_merge_hybrid(struct evlist *evlist, struct perf_env *env)
+{
+	return evlist__hybrid_matches(evlist, env, /*link=*/false);
+}
+
+/*
+ * evlist__merge_hybrid - group hybrid events logically together.
+ * @evlist: The evlist containing events to merge.
+ * @env: The perf_env containing the PMU mapping information, NULL for the
+ *       current machine.
+ *
+ * Iterates through the evlist and merges associated hybrid events by assigning
+ * their first_wildcard_match as their core group leader, modifying their
+ * presentation for a single merged histogram view.
+ */
+void evlist__merge_hybrid(struct evlist *evlist, struct perf_env *env)
+{
+	struct list_head new_list;
+	struct evsel *member, *mtmp;
+	struct evsel *pos, *tmp;
+	int idx = 0;
+
+	/* Compute first_wildcard_match for events that lack it, say from a file. */
+	if (!evlist__hybrid_matches(evlist, env, /*link=*/true))
+		return;
+
+	evlist__for_each_entry_safe(evlist, tmp, pos) {
+		struct evsel *leader, *old_leader;
+
+		if (evsel__is_dummy_event(pos))
+			continue;
+
+		if (!pos->first_wildcard_match)
+			continue;
+
+		leader = evsel__leader(pos->first_wildcard_match);
+		old_leader = evsel__leader(pos);
+		if (old_leader == leader)
+			continue;
+
+		if (old_leader != pos)
+			old_leader->core.nr_members--;
+		pos->core.leader = &leader->core;
+		pos->merged_hybrid_group = true;
+		/* Base is 1 to natively represent the leader */
+		if (leader->core.nr_members == 0)
+			leader->core.nr_members = 1;
+		leader->core.nr_members++;
+	}
+
+	INIT_LIST_HEAD(&new_list);
+
+	while (!list_empty(&evlist__core(evlist)->entries)) {
+		pos = list_first_entry(&evlist__core(evlist)->entries, struct evsel, core.node);
+		list_move_tail(&pos->core.node, &new_list);
+
+		list_for_each_entry_safe(member, mtmp, &evlist__core(evlist)->entries, core.node) {
+			if (member->core.leader == &pos->core)
+				list_move_tail(&member->core.node, &new_list);
+		}
+	}
+	list_splice_init(&new_list, &evlist__core(evlist)->entries);
+
+	evlist__for_each_entry(evlist, pos)
+		pos->core.idx = idx++;
+}
+
 struct evlist *evlist__new_dummy(void)
 {
 	struct evlist *evlist = evlist__new();
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 838e263b76f3..0f380421e03d 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -331,6 +331,9 @@ static inline void evlist__set_selected(struct evlist *evlist, struct evsel *evs
 
 struct evlist *evlist__new(void);
 struct evlist *evlist__new_default(const struct target *target, bool sample_callchains);
+struct perf_env;
+bool evlist__can_merge_hybrid(struct evlist *evlist, struct perf_env *env);
+void evlist__merge_hybrid(struct evlist *evlist, struct perf_env *env);
 struct evlist *evlist__new_dummy(void);
 struct evlist *evlist__get(struct evlist *evlist);
 void evlist__put(struct evlist *evlist);
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 6f759b0e86e9..5c5799cee601 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -53,6 +53,7 @@ struct evsel {
 	int			id_pos;
 	int			is_pos;
 	unsigned int		sample_size;
+	bool			merged_hybrid_group;
 
 	/*
 	 * These fields can be set in the parse-events code or similar.
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index b30375a203e7..d0ed43807cf6 100644
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
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index cc7ad331a49f..e40c16cbef01 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1683,7 +1683,7 @@ int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
 			strbuf_release(&sb);
 			ok++;
 		}
-		if (first_wildcard_match == NULL)
+		if (first_wildcard_match == NULL && !list_empty(list))
 			first_wildcard_match = container_of(list->prev, struct evsel, core.node);
 	}
 
@@ -1754,7 +1754,7 @@ int parse_events_multi_pmu_add_or_add_pmu(struct parse_events_state *parse_state
 			ok++;
 			parse_state->wild_card_pmus = true;
 		}
-		if (first_wildcard_match == NULL) {
+		if (first_wildcard_match == NULL && !list_empty(*listp)) {
 			first_wildcard_match =
 				container_of((*listp)->prev, struct evsel, core.node);
 		}
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 744e253e851f..01753d5c69d1 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -2039,7 +2039,7 @@ int perf_pmu__for_each_format(struct perf_pmu *pmu, void *state, pmu_format_call
 }
 
 /**
- * is_pmu_core() - Check if the given PMU name corresponds to a core CPU PMU.
+ * is_pmu_core() - Runtime check if the given PMU name corresponds to a core CPU PMU.
  * @name: The PMU name to check.
  *
  * Core PMUs can be identified by:
@@ -2060,6 +2060,47 @@ bool is_pmu_core(const char *name)
 	       is_sysfs_pmu_core(name);
 }
 
+/**
+ * is_pmu_core_len - Perf env based check if a given string prefix matches a core PMU name.
+ * @env: The perf_env to check within, NULL for the current machine.
+ * @name: The PMU name to check.
+ * @len: The length of the PMU name prefix in the string.
+ */
+bool is_pmu_core_len(struct perf_env *env, const char *name, size_t len)
+{
+	struct perf_pmu *pmu = NULL;
+
+	if (env && env->hybrid_nodes) {
+		for (int i = 0; i < env->nr_hybrid_nodes; i++) {
+			const char *pmu_name = env->hybrid_nodes[i].pmu_name;
+
+			if (strlen(pmu_name) == len && !strncmp(name, pmu_name, len))
+				return true;
+		}
+		return false;
+	}
+
+	/*
+	 * No hybrid topology, either the machine isn't hybrid or the perf.data
+	 * file was written by a perf lacking HEADER_HYBRID_TOPOLOGY. Fall back
+	 * to the PMUs of this machine, which is only meaningful when the data
+	 * was recorded on this architecture. Guessing PMU names from a prefix
+	 * isn't portable, for example, big.LITTLE ARM and Apple core PMUs are
+	 * named after their CPU rather than "cpu_core" and "cpu_atom".
+	 */
+	if (env && strcmp(perf_env__arch(env), perf_env__arch(/*env=*/NULL))) {
+		pr_debug("Can't identify core PMUs of a %s perf.data file recorded without hybrid topology\n",
+			 perf_env__arch(env));
+		return false;
+	}
+
+	while ((pmu = perf_pmus__scan_core(pmu)) != NULL) {
+		if (strlen(pmu->name) == len && !strncmp(name, pmu->name, len))
+			return true;
+	}
+	return false;
+}
+
 bool perf_pmu__supports_legacy_cache(const struct perf_pmu *pmu)
 {
 	return pmu->is_core;
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 0d9f3c57e8e8..2c8916ad073e 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -16,6 +16,7 @@
 struct evsel_config_term;
 struct hashmap;
 struct perf_cpu_map;
+struct perf_env;
 struct print_callbacks;
 
 enum {
@@ -289,6 +290,8 @@ int perf_pmu__for_each_format(struct perf_pmu *pmu, void *state, pmu_format_call
 u64 perf_pmu__format_unpack(unsigned long *format, u64 config_val);
 
 bool is_pmu_core(const char *name);
+bool is_pmu_core_len(struct perf_env *env, const char *name, size_t len);
+
 bool perf_pmu__supports_legacy_cache(const struct perf_pmu *pmu);
 bool perf_pmu__auto_merge_stats(const struct perf_pmu *pmu);
 bool perf_pmu__have_event(struct perf_pmu *pmu, const char *name);
diff --git a/tools/perf/util/symbol_conf.h b/tools/perf/util/symbol_conf.h
index 71f60081a85b..50317bdaf2b6 100644
--- a/tools/perf/util/symbol_conf.h
+++ b/tools/perf/util/symbol_conf.h
@@ -38,6 +38,7 @@ enum symbol__weight_mode {
 	for ((_weight) = WEIGHT_WEIGHT; (_weight) <= WEIGHT_WEIGHT3; (_weight)++)
 
 struct symbol_conf {
+	bool		hybrid_merge;
 	bool		nanosecs;
 	unsigned short	priv_size;
 	bool		try_vmlinux_path,
-- 
2.55.0.1082.g2b9226bbc0-goog

