Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BE23E5A31
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Aug 2026 06:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787553480; cv=none; b=QsMIsv9QB3jXeW6Uf+CpHcJaae9+WUgin3Fwwbbiz7kICmBywFs+V9Oyk1xEFSYTVeWPZrmbSZPwlopp8qEa2eOLz16c8AlpeLuuCcYUC+HRQVFPGnOcDMW6LDe34F8zNq4AOtKCKrVc80OnX/UDqg31fndx/Cb+JTwUOazWdBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787553480; c=relaxed/simple;
	bh=p6Jja0yrCeaExpX9v/4rfZuPxos1QhVFMsuUEVfTpKU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GhUKPjERdCo/6+ITVQgaA43TeWKsGcEp5dSD8YS8KXVS+a2Smu11JDlCCDsROvz2oJtURSppSagxAJ3HbHopUMmhE9bVRc+JnU4RZm3LC/r2FyF3/KlxjE7PqYTAnqvdUcZKz4udV21U5M+t+IzRp5O8v5bWSr5lERCxzCTaEsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bny1uVkb; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bny1uVkb"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38f283baf1fso4406834a91.3
        for <linux-perf-users@vger.kernel.org>; Sun, 23 Aug 2026 23:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787553478; x=1788158278; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rO5WJKUtfDw4aDMI0RonAumplikkjSeeEuBaBRL9cnU=;
        b=Bny1uVkb7zE1lwq/FqQW7OGdj7Lw56HGfKOscQRf6LD+TC+Ualxf2CbXDnuuqaheAO
         BZOSHUYyh70NLJFvGTIXYMSv77m6Mo7cw0vPgJpVJ9/iBa0C3L0OnBtDuC+l0eV30eVm
         tI7khoHPp/fzLkJksju2gWTzKE0uo/Qd82xWFjIaayHYxgQQ6piXQSddHn7gAN05cFjM
         Et0YADEjsZtE2d9BmuOqruZbTaQ5TEKF1nXeqD/y0Ysig/rDl56c/YfJjrsK3bT6RKsY
         GtD6XsuK6D/WhGEMXbXpI8PeVxmzyl/5HCJTPaaEPCgFJ63wlTM6nACQe9EKHRaXsF3t
         LX9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787553478; x=1788158278;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rO5WJKUtfDw4aDMI0RonAumplikkjSeeEuBaBRL9cnU=;
        b=ZlT7IIq1ABwEuY7frEsGhj3YJOKY5rJa+SQVr8tYLGhYpSjR4LZwpisCiFNu3LesVu
         rUBr8HMDKT2rFL//ouqvsW27hLIpIgm6E5VPEWaz/sANubfufE9CQs7gC159XLsJgLTn
         SwawSs0yJvJzP8tkLmcyut/6xWd0nys4++IWZ4SBJtoV+90eZiP/5g5WCPXY+dJc8W9b
         ZoRNzjx71q0CMPNxX4R5m4Eq8/z+NJMLWinDyvoV3NlCYWpdtH96xS5bKxHFWtF3k6Xj
         O5fb773li15Hmv4kr1XqhTb1+uOu9HV5G2tJ1xNe0ZREsNGmUSv2uj1qF0q0zkpAPp0m
         IecA==
X-Forwarded-Encrypted: i=1; AHgh+RqpzWzuaSQ3Kpw6mBvLrwUpo532OBDwiKUofCd3zzKmyC6Ao5krSoPsKN0sHnpLD490T8dTNLk3ncAJNEbCm4Z7@vger.kernel.org
X-Gm-Message-State: AFuF++kL8ydzsThFi/PakjeRC9Q4GPGXC2xHPu56S34XFGP0hN1rUzOW
	9hWDfHEHKNU9S974+k6z1eYqB3tSg/QQxzBTA2sao5dAVPgmgC60vicx/jfodpXXxHrUZ9cexQl
	qQLm28Ig1tg==
X-Received: from dlbvv10.prod.google.com ([2002:a05:7022:5f0a:b0:139:f590:1d58])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3149:b0:38e:ad9d:1151
 with SMTP id 98e67ed59e1d1-395c33ec565mr41801177a91.4.1787553477312; Sun, 23
 Aug 2026 23:37:57 -0700 (PDT)
Date: Sun, 23 Aug 2026 23:37:38 -0700
In-Reply-To: <20260824063744.1533837-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260813132519.4099508-1-andi@firstfloor.org> <20260824063744.1533837-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.766.g2966f0265a-goog
Message-ID: <20260824063744.1533837-2-irogers@google.com>
Subject: [PATCH v1 1/7] perf evlist: Implement evlist__can_merge_hybrid using first_wildcard_match
From: Ian Rogers <irogers@google.com>
To: andi@firstfloor.org
Cc: acme@kernel.org, ak@kernel.org, ak@linux.intel.com, 
	linux-perf-users@vger.kernel.org, namhyung@kernel.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Add logic to dynamically identify mergeable events spawned from the same
wildcard alias via first_wildcard_match, breaking reliance on hardcoded
PMU metrics or type IDs.

Signed-off-by: Ian Rogers <irogers@google.com>
Assisted-by: Antigravity:gemini-3.1-pro
---
 tools/perf/util/evlist.c      | 208 ++++++++++++++++++++++++++++++++++
 tools/perf/util/evlist.h      |   2 +
 tools/perf/util/evsel.c       |   2 +
 tools/perf/util/hist.h        |   1 +
 tools/perf/util/symbol_conf.h |   1 +
 5 files changed, 214 insertions(+)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index c3d784727810..431759e05e26 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
+#include "util/pmu.h"
 /*
  * Copyright (C) 2011, Red Hat Inc, Arnaldo Carvalho de Melo <acme@redhat.com>
  *
@@ -6,7 +7,9 @@
  * copyright notes.
  */
 #include "evlist.h"
+#include "hist.h"
 
+#include <stdio.h>
 #include <errno.h>
 #include <inttypes.h>
 #include <signal.h>
@@ -125,12 +128,21 @@ struct evlist *evlist__new_default(const struct target *target, bool sample_call
 		if (err)
 			goto out_err;
 	} else {
+		struct evsel *leader = NULL;
 		while ((pmu = perf_pmus__scan_core(pmu)) != NULL) {
 			snprintf(buf, sizeof(buf), "%s/cycles/%s", pmu->name,
 				can_profile_kernel ? "P" : "Pu");
 			err = parse_event(evlist, buf);
 			if (err)
 				goto out_err;
+			if (!leader)
+				leader = evlist__last(evlist);
+			else {
+				struct evsel *last = evlist__last(evlist);
+
+				if (last != leader)
+					last->first_wildcard_match = leader;
+			}
 		}
 	}
 
@@ -148,6 +160,202 @@ struct evlist *evlist__new_default(const struct target *target, bool sample_call
 	return NULL;
 }
 
+
+/**
+ * is_pmu_core_len - Check if a given string prefix matches a core PMU name.
+ * @name: The string to check.
+ * @len: The length of the PMU name prefix in the string.
+ *
+ * This function is used instead of the global `is_pmu_core()` from pmu.h
+ * because it operates natively on substrings without requiring null-termination
+ * (e.g. strndup allocations) when parsing event names like "cpu_core/cycles/".
+ */
+static bool is_pmu_core_len(const char *name, size_t len)
+{
+	struct perf_pmu *pmu = NULL;
+
+	while ((pmu = perf_pmus__scan_core(pmu)) != NULL) {
+		if (!strncmp(name, pmu->name, len) && strlen(pmu->name) == len)
+			return true;
+	}
+	return false;
+}
+
+/*
+ * evlist__can_merge_hybrid - check if hybrid events can be merged.
+ * @evlist: The evlist to check.
+ *
+ * This code is valid for perf record, top, etc. as the event parsing
+ * will set first_wildcard_match. The perf.data case (e.g. perf report)
+ * recomputes the first_wildcard_match in the case there are none by
+ * falling back to string matches only in the case of core events on
+ * hybrid systems.
+ */
+bool evlist__can_merge_hybrid(struct evlist *evlist)
+{
+	struct evsel *pos;
+	unsigned int nr = 0;
+	bool has_wildcard = false;
+
+	evlist__for_each_entry(evlist, pos) {
+		if (evsel__is_dummy_event(pos))
+			continue;
+		if (pos->first_wildcard_match)
+			has_wildcard = true;
+		nr++;
+	}
+
+	if (!has_wildcard) {
+		evlist__for_each_entry(evlist, pos) {
+			const char *pos_name;
+			char *pos_match;
+			struct evsel *peer;
+
+			if (evsel__is_dummy_event(pos) || pos->first_wildcard_match)
+				continue;
+
+			pos_name = evsel__name(pos);
+			pos_match = strchr(pos_name, '/');
+			if (!pos_match)
+				continue;
+
+			/* If evsel->core.is_pmu_core missing in report, fallback to prefix */
+			if (!evsel__is_hybrid(pos)) {
+				if (!is_pmu_core_len(pos_name, pos_match - pos_name) ||
+				    perf_pmus__num_core_pmus() <= 1)
+					continue;
+			}
+
+			peer = pos;
+			list_for_each_entry_continue(peer, &evlist->core.entries, core.node) {
+				const char *peer_name;
+				char *peer_match;
+
+				if (evsel__is_dummy_event(peer) || peer->first_wildcard_match)
+					continue;
+
+				peer_name = evsel__name(peer);
+				peer_match = strchr(peer_name, '/');
+				if (!peer_match)
+					continue;
+
+				if (!evsel__is_hybrid(peer)) {
+					if (!is_pmu_core_len(peer_name, peer_match - peer_name) ||
+					    perf_pmus__num_core_pmus() <= 1)
+						continue;
+				}
+
+				if (!strcmp(pos_match, peer_match)) {
+					peer->first_wildcard_match = pos;
+					has_wildcard = true;
+				}
+			}
+		}
+	}
+
+	return has_wildcard && (nr > 1);
+}
+
+/*
+ * evlist__merge_hybrid - group hybrid events logically together.
+ * @evlist: The evlist containing events to merge.
+ *
+ * Iterates through the evlist and logically merges associated hybrid events
+ * by assigning their first_wildcard_match as their core group leader,
+ * modifying their presentation into a single merged histogram view.
+ */
+void evlist__merge_hybrid(struct evlist *evlist, bool refresh_hists)
+{
+	struct evsel *pos, *tmp;
+	int idx = 0;
+
+	evlist__for_each_entry_safe(evlist, tmp, pos) {
+		if (evsel__is_dummy_event(pos))
+			continue;
+
+		if (pos->first_wildcard_match) {
+			struct evsel *leader = evsel__leader(pos->first_wildcard_match);
+			struct evsel *old_leader = evsel__leader(pos);
+
+			if (old_leader != leader) {
+				struct evsel *member;
+
+				if (old_leader != pos)
+					old_leader->core.nr_members--;
+				pos->core.leader = &leader->core;
+				/* Base is 1 to natively represent the leader */
+				if (leader->core.nr_members == 0)
+					leader->core.nr_members = 1;
+				leader->core.nr_members++;
+
+				/* Assign stranded members to the new leader as well */
+				for_each_group_member(member, pos) {
+					if (!member->first_wildcard_match) {
+						member->core.leader = &leader->core;
+						leader->core.nr_members++;
+					}
+				}
+			}
+		}
+	}
+
+	{
+		struct list_head new_list;
+		struct evsel *member, *mtmp;
+
+		INIT_LIST_HEAD(&new_list);
+
+		while (!list_empty(&evlist->core.entries)) {
+			pos = list_first_entry(&evlist->core.entries, struct evsel, core.node);
+			list_move_tail(&pos->core.node, &new_list);
+
+			list_for_each_entry_safe(member, mtmp, &evlist->core.entries, core.node) {
+				if (member->core.leader == &pos->core)
+					list_move_tail(&member->core.node, &new_list);
+			}
+		}
+		list_splice_init(&new_list, &evlist->core.entries);
+	}
+
+	evlist__for_each_entry(evlist, pos)
+		pos->core.idx = idx++;
+
+	/* Set merge_entries flag on leaders */
+	evlist__for_each_entry(evlist, pos) {
+		if (evsel__is_dummy_event(pos))
+			continue;
+		if (pos->core.leader == &pos->core && pos->core.nr_members > 1) {
+			evsel__hists(pos)->merge_entries = true;
+			symbol_conf.event_group = true;
+			symbol_conf.hybrid_merge = true;
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
+			if (pos->core.nr_members > 1)
+				hists__output_resort(evsel__hists(pos), NULL);
+		}
+	}
+}
+
 struct evlist *evlist__new_dummy(void)
 {
 	struct evlist *evlist = evlist__new();
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 838e263b76f3..12f3fd7dad9b 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -331,6 +331,8 @@ static inline void evlist__set_selected(struct evlist *evlist, struct evsel *evs
 
 struct evlist *evlist__new(void);
 struct evlist *evlist__new_default(const struct target *target, bool sample_callchains);
+bool evlist__can_merge_hybrid(struct evlist *evlist);
+void evlist__merge_hybrid(struct evlist *evlist, bool refresh_hists);
 struct evlist *evlist__new_dummy(void);
 struct evlist *evlist__get(struct evlist *evlist);
 void evlist__put(struct evlist *evlist);
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index d4cb455f4a7d..3f56a0e6f9d6 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2052,6 +2052,8 @@ static void evsel__exit(struct evsel *evsel)
 	evsel__free_config_terms(evsel);
 	cgroup__put(evsel->cgrp);
 	perf_evsel__exit(&evsel->core);
+	if (evsel->first_wildcard_match)
+		evsel->first_wildcard_match = NULL;
 	zfree(&evsel->group_name);
 	zfree(&evsel->name);
 #ifdef HAVE_LIBTRACEEVENT
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index b830cbe7f95b..ea79628bbc6b 100644
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
diff --git a/tools/perf/util/symbol_conf.h b/tools/perf/util/symbol_conf.h
index 0dee5aa6a534..2bdd96fe886f 100644
--- a/tools/perf/util/symbol_conf.h
+++ b/tools/perf/util/symbol_conf.h
@@ -28,6 +28,7 @@ enum a2l_style {
 #define MAX_A2L_STYLE (A2L_STYLE_CMD + 1)
 
 struct symbol_conf {
+	bool		hybrid_merge;
 	bool		nanosecs;
 	unsigned short	priv_size;
 	bool		try_vmlinux_path,
-- 
2.55.0.766.g2966f0265a-goog

