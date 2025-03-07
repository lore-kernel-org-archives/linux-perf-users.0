Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58549188CD8
	for <linux-perf-users@vger.kernel.org>; Fri,  7 Mar 2025 02:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741315158; cv=none; b=q/PDwJDbVkpYZ+z2Gq1jG8+mA8LgL83Bb5W6gWqLPf7aD4m62qbs0H2aO0361q8Mp11t5G5x16Qm6WSQMFV9d/qwnk0Z7mIen6VwTlF6KhbXv3MtTubMRZExBvkXLq/00YIscPTubwASaOMDYDR2ONhKfQOtRmFhU+lKkYw96RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741315158; c=relaxed/simple;
	bh=F3s3liOiszNRKh+IGM77OFI5rtCSCy0pnnGAdXuo7hE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=eR2WrVe5lwakjdZW9iXwQf/LKuVeSesUCDTDST53C1SyQ3aR4pe7INsklGCt/eiYaxWmOc+SzmHsAbVXu02OvnbzupsqobWJXQtUe20ClPzkga7rDRdC2dd5+erdmEpbwvfvy5DJl4I/yTwhPSBsCH5hw86SlWsjo7y/Fj6B4Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WprpxhQn; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WprpxhQn"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff798e8c3bso1140828a91.2
        for <linux-perf-users@vger.kernel.org>; Thu, 06 Mar 2025 18:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741315155; x=1741919955; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9r1pEzREl2UeUw5kyh9Mo6aZcKi+y0eZFdoOEN6jsvQ=;
        b=WprpxhQnygbpwtiwPAFEvHaSNwvM+J+RabmcuDDLzlejXBEZte1uijziHlqF2DQ41Y
         Tn48XRoG5YB2woGuhvbIX+gZEvowDSERVdAnYpGVrzErKDju18sa25ltVg5iXAUq2qzR
         bIkknTBikUr17pkteaaKwdNnK30BZoYDWs7scGDHKSTYjxz6rOtU4+L6BUPpAI+rhqHG
         rYO0Qvr3vSIkpHBQuqUVsP1aTV+5ddBODZfHRE7QrMk9E7hx5ueA1rpXtGHS0dZXlQjO
         8tYKIaLqAmWH4s8WFXVLP6Zgz5/8VeNnMUhCdw0B0B5NoGYkVe74mXkJcHmmOVFBWehR
         I3Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741315155; x=1741919955;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9r1pEzREl2UeUw5kyh9Mo6aZcKi+y0eZFdoOEN6jsvQ=;
        b=pFTF6Mo5kKlRG8eg1i6gBK/sk1ZeeXfrdd5pppuODh2DNbJGJGNCbzv/2r01q5sdy+
         Affp1p9ttS6tPi/lPHS+TdIwv8JvHv5S60AmWqRwHlISmSFLZEA8ZcEEULDOKdnjopIV
         Vge3f2/mAogGQH/mhbJbR2IjhOEzT0zyTI/QOuYY3mMyN3Ifz5eoGxSGXpoci56cYfE3
         zCeY1ElKOlz1MAIs5IfeI05NS5wSo+MtYgJWmhDxhecm914hs7kHf89DnYQmzb9ejFFb
         XhYRrrt4ERSH2MbvP6C5/qBj15Fr7AQfHpNxgqfsIZqZkQZcmif56l2Jn60xMmlsf3wO
         kAVw==
X-Forwarded-Encrypted: i=1; AJvYcCWq5/Motejttgl57q8kFn32w0OA3Mx5f9Ih6NDKll9bulfi7jg5uCEaozqw3ug+NG2sgctuqjUz6hBXcTXer0g9@vger.kernel.org
X-Gm-Message-State: AOJu0YznuzTDGLaZAvY4CU/HGJPqLMXillhkHDoVBD1kov6k10o1yP8g
	+Ub2v26G46j2sId3xOU7+CXc1uoMpNugUPrUPWVmDvkv8aCrEb085v+fYNKd1K8gs7d7Tfhiaqm
	xoAaA9A==
X-Google-Smtp-Source: AGHT+IFB0Jz96EghCYT9ApTLDpOc/vAwaOVYpvQQQH8OlnfZ6TncP/9f8f1tEe0CjITrBDqQDN3C7rY6NhKW
X-Received: from pjbqx8.prod.google.com ([2002:a17:90b:3e48:b0:2f9:e05f:187f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:38cd:b0:2ee:741c:e9f4
 with SMTP id 98e67ed59e1d1-2ff7ce8e5dfmr2673067a91.11.1741315155485; Thu, 06
 Mar 2025 18:39:15 -0800 (PST)
Date: Thu,  6 Mar 2025 18:39:04 -0800
In-Reply-To: <20250307023906.1135613-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250307023906.1135613-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Message-ID: <20250307023906.1135613-3-irogers@google.com>
Subject: [PATCH v2 3/5] perf parse-events: Corrections to topdown sorting
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Dominique Martinet <asmadeus@codewreck.org>, Andi Kleen <ak@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Falcon <thomas.falcon@intel.com>
Content-Type: text/plain; charset="UTF-8"

In the case of '{instructions,slots},faults,topdown-retiring' the
first event that must be grouped, slots, is ignored causing the
topdown-retiring event not to be adjacent to the group it needs to be
inserted into. Don't ignore the group members when computing the
force_grouped_index.

Make the force_grouped_index be for the leader of the group it is
within and always use it first rather than a group leader index so
that topdown events may be sorted from one group into another.

As the PMU name comparison applies to moving events in the same group
ensure the name ordering is always respected.

Change the group splitting logic to not group if there are no other
topdown events and to fix cases where the force group leader wasn't
being grouped with the other members of its group.

Reported-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Closes: https://lore.kernel.org/lkml/20250224083306.71813-2-dapeng1.mi@linux.intel.com/
Closes: https://lore.kernel.org/lkml/f7e4f7e8-748c-4ec7-9088-0e844392c11a@linux.intel.com/
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/x86/util/evlist.c |  15 ++--
 tools/perf/util/parse-events.c    | 145 ++++++++++++++++++++----------
 2 files changed, 105 insertions(+), 55 deletions(-)

diff --git a/tools/perf/arch/x86/util/evlist.c b/tools/perf/arch/x86/util/evlist.c
index 447a734e591c..ed205d1b207d 100644
--- a/tools/perf/arch/x86/util/evlist.c
+++ b/tools/perf/arch/x86/util/evlist.c
@@ -76,12 +76,15 @@ int arch_evlist__cmp(const struct evsel *lhs, const struct evsel *rhs)
 		 * topdown metrics events are already in same group with slots
 		 * event, do nothing.
 		 */
-		if (arch_is_topdown_metrics(lhs) && !arch_is_topdown_metrics(rhs) &&
-		    lhs->core.leader != rhs->core.leader)
-			return -1;
-		if (!arch_is_topdown_metrics(lhs) && arch_is_topdown_metrics(rhs) &&
-		    lhs->core.leader != rhs->core.leader)
-			return 1;
+		if (lhs->core.leader != rhs->core.leader) {
+			bool lhs_topdown = arch_is_topdown_metrics(lhs);
+			bool rhs_topdown = arch_is_topdown_metrics(rhs);
+
+			if (lhs_topdown && !rhs_topdown)
+				return -1;
+			if (!lhs_topdown && rhs_topdown)
+				return 1;
+		}
 	}
 
 	/* Retire latency event should not be group leader*/
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 35e48fe56dfa..5152fd5a6ead 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1980,48 +1980,55 @@ static int evlist__cmp(void *_fg_idx, const struct list_head *l, const struct li
 	int *force_grouped_idx = _fg_idx;
 	int lhs_sort_idx, rhs_sort_idx, ret;
 	const char *lhs_pmu_name, *rhs_pmu_name;
-	bool lhs_has_group, rhs_has_group;
 
 	/*
-	 * First sort by grouping/leader. Read the leader idx only if the evsel
-	 * is part of a group, by default ungrouped events will be sorted
-	 * relative to grouped events based on where the first ungrouped event
-	 * occurs. If both events don't have a group we want to fall-through to
-	 * the arch specific sorting, that can reorder and fix things like
-	 * Intel's topdown events.
+	 * Get the indexes of the 2 events to sort. If the events are
+	 * in groups then the leader's index is used otherwise the
+	 * event's index is used. An index may be forced for events that
+	 * must be in the same group, namely Intel topdown events.
 	 */
-	if (lhs_core->leader != lhs_core || lhs_core->nr_members > 1) {
-		lhs_has_group = true;
-		lhs_sort_idx = lhs_core->leader->idx;
+	if (*force_grouped_idx != -1 && arch_evsel__must_be_in_group(lhs)) {
+		lhs_sort_idx = *force_grouped_idx;
 	} else {
-		lhs_has_group = false;
-		lhs_sort_idx = *force_grouped_idx != -1 && arch_evsel__must_be_in_group(lhs)
-			? *force_grouped_idx
-			: lhs_core->idx;
-	}
-	if (rhs_core->leader != rhs_core || rhs_core->nr_members > 1) {
-		rhs_has_group = true;
-		rhs_sort_idx = rhs_core->leader->idx;
+		bool lhs_has_group = lhs_core->leader != lhs_core || lhs_core->nr_members > 1;
+
+		lhs_sort_idx = lhs_has_group ? lhs_core->leader->idx : lhs_core->idx;
+	}
+	if (*force_grouped_idx != -1 && arch_evsel__must_be_in_group(rhs)) {
+		rhs_sort_idx = *force_grouped_idx;
 	} else {
-		rhs_has_group = false;
-		rhs_sort_idx = *force_grouped_idx != -1 && arch_evsel__must_be_in_group(rhs)
-			? *force_grouped_idx
-			: rhs_core->idx;
+		bool rhs_has_group = rhs_core->leader != rhs_core || rhs_core->nr_members > 1;
+
+		rhs_sort_idx = rhs_has_group ? rhs_core->leader->idx : rhs_core->idx;
 	}
 
+	/* If the indices differ then respect the insertion order. */
 	if (lhs_sort_idx != rhs_sort_idx)
 		return lhs_sort_idx - rhs_sort_idx;
 
-	/* Group by PMU if there is a group. Groups can't span PMUs. */
-	if (lhs_has_group && rhs_has_group) {
-		lhs_pmu_name = lhs->group_pmu_name;
-		rhs_pmu_name = rhs->group_pmu_name;
-		ret = strcmp(lhs_pmu_name, rhs_pmu_name);
-		if (ret)
-			return ret;
-	}
+	/*
+	 * Ignoring forcing, lhs_sort_idx == rhs_sort_idx so lhs and rhs should
+	 * be in the same group. Events in the same group need to be ordered by
+	 * their grouping PMU name as the group will be broken to ensure only
+	 * events on the same PMU are programmed together.
+	 *
+	 * With forcing the lhs_sort_idx == rhs_sort_idx shows that one or both
+	 * events are being forced to be at force_group_index. If only one event
+	 * is being forced then the other event is the group leader of the group
+	 * we're trying to force the event into. Ensure for the force grouped
+	 * case that the PMU name ordering is also respected.
+	 */
+	lhs_pmu_name = lhs->group_pmu_name;
+	rhs_pmu_name = rhs->group_pmu_name;
+	ret = strcmp(lhs_pmu_name, rhs_pmu_name);
+	if (ret)
+		return ret;
 
-	/* Architecture specific sorting. */
+	/*
+	 * Architecture specific sorting, by default sort events in the same
+	 * group with the same PMU by their insertion index. On Intel topdown
+	 * constraints must be adhered to - slots first, etc.
+	 */
 	return arch_evlist__cmp(lhs, rhs);
 }
 
@@ -2030,9 +2037,11 @@ static int parse_events__sort_events_and_fix_groups(struct list_head *list)
 	int idx = 0, force_grouped_idx = -1;
 	struct evsel *pos, *cur_leader = NULL;
 	struct perf_evsel *cur_leaders_grp = NULL;
-	bool idx_changed = false, cur_leader_force_grouped = false;
+	bool idx_changed = false;
 	int orig_num_leaders = 0, num_leaders = 0;
 	int ret;
+	struct evsel *force_grouped_leader = NULL;
+	bool last_event_was_forced_leader = false;
 
 	/*
 	 * Compute index to insert ungrouped events at. Place them where the
@@ -2055,10 +2064,13 @@ static int parse_events__sort_events_and_fix_groups(struct list_head *list)
 		 */
 		pos->core.idx = idx++;
 
-		/* Remember an index to sort all forced grouped events together to. */
-		if (force_grouped_idx == -1 && pos == pos_leader && pos->core.nr_members < 2 &&
-		    arch_evsel__must_be_in_group(pos))
-			force_grouped_idx = pos->core.idx;
+		/*
+		 * Remember an index to sort all forced grouped events
+		 * together to. Use the group leader as some events
+		 * must appear first within the group.
+		 */
+		if (force_grouped_idx == -1 && arch_evsel__must_be_in_group(pos))
+			force_grouped_idx = pos_leader->core.idx;
 	}
 
 	/* Sort events. */
@@ -2086,31 +2098,66 @@ static int parse_events__sort_events_and_fix_groups(struct list_head *list)
 		 * Set the group leader respecting the given groupings and that
 		 * groups can't span PMUs.
 		 */
-		if (!cur_leader)
+		if (!cur_leader) {
 			cur_leader = pos;
+			cur_leaders_grp = &pos->core;
+			if (pos_force_grouped)
+				force_grouped_leader = pos;
+		}
 
 		cur_leader_pmu_name = cur_leader->group_pmu_name;
-		if ((cur_leaders_grp != pos->core.leader &&
-		     (!pos_force_grouped || !cur_leader_force_grouped)) ||
-		    strcmp(cur_leader_pmu_name, pos_pmu_name)) {
-			/* Event is for a different group/PMU than last. */
+		if (strcmp(cur_leader_pmu_name, pos_pmu_name)) {
+			/* PMU changed so the group/leader must change. */
 			cur_leader = pos;
-			/*
-			 * Remember the leader's group before it is overwritten,
-			 * so that later events match as being in the same
-			 * group.
-			 */
 			cur_leaders_grp = pos->core.leader;
+			if (pos_force_grouped && force_grouped_leader == NULL)
+				force_grouped_leader = pos;
+		} else if (cur_leaders_grp != pos->core.leader) {
+			bool split_even_if_last_leader_was_forced = true;
+
 			/*
-			 * Avoid forcing events into groups with events that
-			 * don't need to be in the group.
+			 * Event is for a different group. If the last event was
+			 * the forced group leader then subsequent group events
+			 * and forced events should be in the same group. If
+			 * there are no other forced group events then the
+			 * forced group leader wasn't really being forced into a
+			 * group, it just set arch_evsel__must_be_in_group, and
+			 * we don't want the group to split here.
 			 */
-			cur_leader_force_grouped = pos_force_grouped;
+			if (force_grouped_idx != -1 && last_event_was_forced_leader) {
+				struct evsel *pos2 = pos;
+				/*
+				 * Search the whole list as the group leaders
+				 * aren't currently valid.
+				 */
+				list_for_each_entry_continue(pos2, list, core.node) {
+					if (pos->core.leader == pos2->core.leader &&
+					    arch_evsel__must_be_in_group(pos2)) {
+						split_even_if_last_leader_was_forced = false;
+						break;
+					}
+				}
+			}
+			if (!last_event_was_forced_leader || split_even_if_last_leader_was_forced) {
+				if (pos_force_grouped) {
+					if (force_grouped_leader) {
+						cur_leader = force_grouped_leader;
+						cur_leaders_grp = force_grouped_leader->core.leader;
+					} else {
+						cur_leader = force_grouped_leader = pos;
+						cur_leaders_grp = &pos->core;
+					}
+				} else {
+					cur_leader = pos;
+					cur_leaders_grp = pos->core.leader;
+				}
+			}
 		}
 		if (pos_leader != cur_leader) {
 			/* The leader changed so update it. */
 			evsel__set_leader(pos, cur_leader);
 		}
+		last_event_was_forced_leader = (force_grouped_leader == pos);
 	}
 	list_for_each_entry(pos, list, core.node) {
 		struct evsel *pos_leader = evsel__leader(pos);
-- 
2.49.0.rc0.332.g42c0ae87b1-goog

