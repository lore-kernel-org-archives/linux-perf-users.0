Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1C93BFAE8
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 05:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789621657; cv=none; b=n1JblQoDtxI19oU6EMn/P/pSFF0ANP6WGZMM7wS5PN3PbM7Rce5vS9LrkH/T/zrrpzhB1dz/U9LGe1S2y15oNqHaSDSXsHnGWyxtbmqF8aOurxQBJKWMvVXD74r6h5hcnPkePVTNDNq0TS+NpWiKOI0EbJ43rtVv4OkN1UqWX+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789621657; c=relaxed/simple;
	bh=3/ksr6dJ9u+8+78rhBbuNe1Illfjcqctrj4X9hAdg80=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=N+l8TFGfysFjOwBs934V3JVe9Rh8ZF6p2JASPE1kuFM8pzPuNbJyeLw8ca2E406Crv7qjzv6XeRDGDwOkog3tdPbqplAkHeKjXyKGReCVR6EM3NsHwgbBrJ1LPRuqiXVeK3lvXcBO+/etsJAbpTz0iilhrw7uZ/hax0qhcsyjzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=unQ1RfiF; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="unQ1RfiF"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cbe77d6864dso644640a12.2
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 22:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789621655; x=1790226455; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BDO7V9sktC4DN+WfGrw9qWRgLecZHvX85rjze0faLb8=;
        b=unQ1RfiFdWwiktIOmncX7WgGlSpztYurIYPEAJA0WN3EWneRkMRv8DQ+36UnXixQCU
         GrVBOo+HaiZ8bj97k8XC4T5AZxPKwBd5FOCzSNptwJPYslrfJob3f9RKajNAQ/9tdzSq
         On2DMtM5Z7W9lkbXl7RVCzTaUhVMTRj8Mzg/Aml8rpuBo7W9Gf67knGKvSFFqZ3p3hma
         dC+M//25Ixolxbk6iHaH4tOnBDA/BWIHVjzdbfoYBEv3fbzTasBMS0QBZTr0Fwar+sdu
         qvbFfuvATN4wfSvl0+3zVA1wlF/4t0HU4btsexsdLqo4hECl510JNT4sooFXgq416le5
         +/6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789621655; x=1790226455;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BDO7V9sktC4DN+WfGrw9qWRgLecZHvX85rjze0faLb8=;
        b=WO6xo0JGW+5vgtnyRLUkblQIt9SMeaDBRaVS+ajexgCRXEQYslvtAFpGCsOhDesAmd
         pf70580L6ow3Cg/evJAGGauMeHGvcvsvvixvq/7uGnaNt2kIdIX+Y1EcqFCIzC/g5Eeh
         u0E7nnCuWKzCUEITknTYFurgL+2AtEPwSOreg3npahfsdeC9O8OjQLhd2ewlaFkwPzCa
         oBX7snndfUk+1gMYluefMLwvf7XRmkVdrltXmwJte+Q7BhF0TWV1WM7FZ1NbKqqghkyK
         ddptQQ716NuQOzjBQM6CPlwqWSh6gd9H6Z3ygiJEZXLAUhUG7B/dNLDkWy1A2G2qhBYR
         gYJQ==
X-Forwarded-Encrypted: i=1; AKwUvBxpaTh22XOdFedVlORncIdm/SUVshHlRixVrYfkmQPVodsNMrGAJw+lei26nIVfdu+Vs885RKRk6naCPopIa5iJ@vger.kernel.org
X-Gm-Message-State: AFuF++nMpYZE45ibb5EJ5N5R25ks2uvOgaV+gQ+9/k5UpurUMAhhKdx6
	5aGWC05f2TkXXjbQI40zcj3l9tmmrElEqS7FwZRrpVTxTAUMZVTEQOfzMku8Puw1gFjYzP9gHzs
	NWTdlmJWl8A==
X-Received: from dyaw17-n2.prod.google.com ([2002:a05:693c:4151:20b0:339:c3e:449b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:4a81:b0:3da:3492:83d0
 with SMTP id adf61e73a8af0-3dd5f7ad04cmr12424123637.23.1789621655187; Wed, 16
 Sep 2026 22:07:35 -0700 (PDT)
Date: Wed, 16 Sep 2026 22:07:04 -0700
In-Reply-To: <20260917050708.704702-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260916234652.439778-1-irogers@google.com> <20260917050708.704702-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260917050708.704702-6-irogers@google.com>
Subject: [PATCH v4 5/9] perf evlist: Toggle merged_hybrid_group properly in enable/disable
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: ak@kernel.org, ak@linux.intel.com, andi@firstfloor.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Merging makes the merged event the leader of the events of the other
core PMUs so their histograms can be linked, but the result isn't a
real event group. Each event keeps its own file descriptor and has to
be enabled and disabled in its own right.

__evlist__enable(), __evlist__disable() and evlist__is_enabled() skip
anything that isn't a group leader, and the first two then walk the
group members of the events they do act on. For a merged set that is
backwards: the members are skipped by the leader test, so their file
descriptors are never touched, and the walk over the leader's members
only updates the bookkeeping in evsel->disabled.

Treat an evsel with merged_hybrid_group set as a leader so that it is
enabled and disabled in its own right via its own file descriptors.

perf top enables and disables by event name. A merged member carries
the name of its own PMU rather than the name that was asked for, so
also match it against its leader's name, otherwise naming the event
toggles only part of the merged set.

Signed-off-by: Ian Rogers <irogers@google.com>
Assisted-by: Antigravity:gemini-3.1-pro
---
 tools/perf/util/evlist.c | 35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 930efbb66bc8..22eb01116992 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -753,7 +753,9 @@ static bool evlist__is_enabled(struct evlist *evlist)
 	struct evsel *pos;
 
 	evlist__for_each_entry(evlist, pos) {
-		if (!evsel__is_group_leader(pos) || !pos->core.fd)
+		if (!pos->core.fd)
+			continue;
+		if (!evsel__is_group_leader(pos) && !pos->merged_hybrid_group)
 			continue;
 		/* If at least one event is enabled, evlist is enabled. */
 		if (!pos->disabled)
@@ -767,14 +769,19 @@ static void __evlist__disable(struct evlist *evlist, char *evsel_name, bool excl
 	struct evsel *pos, *member;
 	struct evlist_cpu_iterator evlist_cpu_itr;
 	bool has_imm = false;
+	bool match;
 
 	/* Disable 'immediate' events last */
 	for (int imm = 0; imm <= 1; imm++) {
 		evlist__for_each_cpu(evlist_cpu_itr, evlist) {
 			pos = evlist_cpu_itr.evsel;
-			if (evsel__strcmp(pos, evsel_name))
+			match = !evsel__strcmp(pos, evsel_name);
+			if (!match && pos->merged_hybrid_group && evsel__leader(pos))
+				match = !evsel__strcmp(evsel__leader(pos), evsel_name);
+			if (!match)
 				continue;
-			if (pos->disabled || !evsel__is_group_leader(pos) || !pos->core.fd)
+			if (pos->disabled || (!evsel__is_group_leader(pos) &&
+					      !pos->merged_hybrid_group) || !pos->core.fd)
 				continue;
 			if (excl_dummy && evsel__is_dummy_event(pos))
 				continue;
@@ -789,9 +796,12 @@ static void __evlist__disable(struct evlist *evlist, char *evsel_name, bool excl
 	}
 
 	evlist__for_each_entry(evlist, pos) {
-		if (evsel__strcmp(pos, evsel_name))
+		match = !evsel__strcmp(pos, evsel_name);
+		if (!match && pos->merged_hybrid_group && evsel__leader(pos))
+			match = !evsel__strcmp(evsel__leader(pos), evsel_name);
+		if (!match)
 			continue;
-		if (!evsel__is_group_leader(pos) || !pos->core.fd)
+		if ((!evsel__is_group_leader(pos) && !pos->merged_hybrid_group) || !pos->core.fd)
 			continue;
 		if (excl_dummy && evsel__is_dummy_event(pos))
 			continue;
@@ -827,21 +837,28 @@ static void __evlist__enable(struct evlist *evlist, char *evsel_name, bool excl_
 {
 	struct evsel *pos, *member;
 	struct evlist_cpu_iterator evlist_cpu_itr;
+	bool match;
 
 	evlist__for_each_cpu(evlist_cpu_itr, evlist) {
 		pos = evlist_cpu_itr.evsel;
-		if (evsel__strcmp(pos, evsel_name))
+		match = !evsel__strcmp(pos, evsel_name);
+		if (!match && pos->merged_hybrid_group && evsel__leader(pos))
+			match = !evsel__strcmp(evsel__leader(pos), evsel_name);
+		if (!match)
 			continue;
-		if (!evsel__is_group_leader(pos) || !pos->core.fd)
+		if ((!evsel__is_group_leader(pos) && !pos->merged_hybrid_group) || !pos->core.fd)
 			continue;
 		if (excl_dummy && evsel__is_dummy_event(pos))
 			continue;
 		evsel__enable_cpu(pos, evlist_cpu_itr.cpu_map_idx);
 	}
 	evlist__for_each_entry(evlist, pos) {
-		if (evsel__strcmp(pos, evsel_name))
+		match = !evsel__strcmp(pos, evsel_name);
+		if (!match && pos->merged_hybrid_group && evsel__leader(pos))
+			match = !evsel__strcmp(evsel__leader(pos), evsel_name);
+		if (!match)
 			continue;
-		if (!evsel__is_group_leader(pos) || !pos->core.fd)
+		if ((!evsel__is_group_leader(pos) && !pos->merged_hybrid_group) || !pos->core.fd)
 			continue;
 		if (excl_dummy && evsel__is_dummy_event(pos))
 			continue;
-- 
2.55.0.1082.g2b9226bbc0-goog

