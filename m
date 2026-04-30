Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2067F2EA732
	for <linux-perf-users@vger.kernel.org>; Thu, 30 Apr 2026 16:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777565852; cv=none; b=jQF8fqHh4v0comqqjwCWiXJljiwc2JilghOlIwdiuyc6ClCSqHI+bqgL8PPyUgj0lBBpHdpcwBG/VqWWZGcTsY+XcS6PBrODhRMFMOobb3Yu4oJF2+ult64Kw393bChmizjQL0rwplkJ8Xtt+CYMFxBrFzS1ayXfkUD6d5foDp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777565852; c=relaxed/simple;
	bh=FECS60I14FzPxzfBio8wxiQhJhKRWX4DQjBg+/uQd/E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=meYMASdCVQT1d+seyTnRBeLH1FoFHfgf2zkNBDmupU1p932k5N3nt8/EX/gdyE5CWrzTPPTcJmdz6/URkK4rhxeC4R3/7wLBft7ZrTeqWsRtHKHHM/dA7r5LYTvVkwrrhsKUxlyUgDSvEI/QZ5Kdpmpb2npjqRSTFIlNL7ziTpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DuuMvOBa; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DuuMvOBa"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2d889997495so4092958eec.0
        for <linux-perf-users@vger.kernel.org>; Thu, 30 Apr 2026 09:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777565850; x=1778170650; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zi8WkznLM4wGdOWXURG1G8s/KXvLgw6m/NoSGKTn09Q=;
        b=DuuMvOBaYqpe75VTzOxlmvrlCQLJyjnHt63DYRgj8VsVGz+Kj+fpS+2+vQbTH+Gg9i
         EPdus5yZ4IsC7iWIqphDVLg6n3PprN1zadXmsnln/kolBXuxCUtpgpSZ1ELkY7M5eZuO
         OOsOxDeBZTJm2RPRO7Mv3OR9FRvTl/xGuNxbrZGX+k5BaK1A59T05vh0/Wgzqb2Ku5th
         RzbYF7dfxUUEnWmdSQMMmQPLAfVs+BiMjZMTOYRbcmjik1VW2jCdDomTQG19IVm7xXXb
         c+QiKaE3U3mSQF8sCvgo3cL/u8QTLZWRoE9SMCJ16uaLHv5GiKyWnaspx24EjmvwAPTt
         9flw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777565850; x=1778170650;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zi8WkznLM4wGdOWXURG1G8s/KXvLgw6m/NoSGKTn09Q=;
        b=Oq6KbEFHpB5Ly1wv/MEnuJ3GbYZrtLF1gLhBHNMOVwiNiCPyBoX6A70IB18+ZB+5Bb
         PyE2ykwOj3LE569YxbOC/mIMgYOt3C1sGRMZBJ9zv0xYf2SQbkuuN/nKN83oO7QDWqqa
         4CUuLSmCd96rCj2iLjFWFIxyPvjCW2Hz9E7lV67bc7PXNJq6CVoNJ9vVtpvQRnbBpi80
         PtKyjc2n5ZniYp3e9U6Sv01fh0Kzut5xNQ+0iCpk7EiIgDKSxyyQ5/1/8HO6R6yGRQF/
         1W9iV6DyEZCQ6qkvz9PvxjgbW0lElMvBET289Cwp3CIJOE1K6vDMw4pjSpg2Uea4ELdh
         jsXg==
X-Forwarded-Encrypted: i=1; AFNElJ8ZGeci1qI7Xof244UEdVVobCYxB4ZrEAvaj1gEplmNLT07YREF4RF3kUp4fkmA7QhRBtv9wmMEDSC1o5RIQhc+@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu//bQe/rMHWfzltZyVLkwrqml7ONyGgAIpc3YqPWTl1cgcVDu
	5ZC5DAnt5ijFu1NrrGT1WrjbZOI1ue8B0HagdDKKDzXuok4kCqpR7jF7qCegd1f/BmS0k1dzazH
	U+h+GposhSA==
X-Received: from dycaq9.prod.google.com ([2002:a05:7301:7e09:b0:2ea:c1bb:3a9c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:fd03:b0:2d2:ff9e:c07d
 with SMTP id 5a478bee46e88-2ed3e4849fcmr1832031eec.24.1777565850066; Thu, 30
 Apr 2026 09:17:30 -0700 (PDT)
Date: Thu, 30 Apr 2026 09:17:25 -0700
In-Reply-To: <acyWR2GAWIY7TKyD@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <acyWR2GAWIY7TKyD@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260430161725.3131665-1-irogers@google.com>
Subject: [PATCH v2] perf metricgroup: Avoid scanning unnecessary PMUs for
 identifier match
From: Ian Rogers <irogers@google.com>
To: namhyung@kernel.org, acme@kernel.org, james.clark@linaro.org
Cc: adrian.hunter@intel.com, irogers@google.com, leo.yan@arm.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, thomas.falcon@intel.com
Content-Type: text/plain; charset="UTF-8"

Only uncore PMUs can have an identifier, so add an optimized
perf_pmus__scan routine for that case to avoid all PMU types being
created.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/metricgroup.c | 11 +++--------
 tools/perf/util/pmus.c        | 18 +++++++++++++++++-
 tools/perf/util/pmus.h        |  1 +
 3 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 4db9578efd81..5a489e97c413 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -415,14 +415,9 @@ static int metricgroup__sys_event_iter(const struct pmu_metric *pm,
 	if (!pm->metric_expr || !pm->compat)
 		return 0;
 
-	while ((pmu = perf_pmus__scan(pmu))) {
-
-		if (!pmu->id || !pmu_uncore_identifier_match(pm->compat, pmu->id))
-			continue;
-
-		return d->fn(pm, table, d->data);
-	}
-	return 0;
+	/* Only process with the iterator if there is a a PMU that matches the ID. */
+	pmu = perf_pmus__scan_for_uncore_id(pmu, pm->compat);
+	return pmu ? d->fn(pm, table, d->data) : 0;
 }
 
 int metricgroup__for_each_metric(const struct pmu_metrics_table *table, pmu_metric_iter_fn fn,
diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index 9a2023ceeefd..5e3f571450fe 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -409,7 +409,7 @@ struct perf_pmu *perf_pmus__scan_matching_wildcard(struct perf_pmu *pmu, const c
 	if (!pmu) {
 		/*
 		 * Core PMUs, other sysfs PMUs and tool PMU can have any name or
-		 * aren't wother optimizing for.
+		 * aren't worth optimizing for.
 		 */
 		unsigned int to_read_pmus =  PERF_TOOL_PMU_TYPE_PE_CORE_MASK |
 			PERF_TOOL_PMU_TYPE_PE_OTHER_MASK |
@@ -486,6 +486,22 @@ static struct perf_pmu *perf_pmus__scan_skip_duplicates(struct perf_pmu *pmu)
 	return NULL;
 }
 
+struct perf_pmu *perf_pmus__scan_for_uncore_id(struct perf_pmu *pmu, const char *compat)
+{
+	if (!pmu) {
+		/* Only uncore PMUs can have identifiers. */
+		unsigned int to_read_pmus = PERF_TOOL_PMU_TYPE_PE_OTHER_MASK;
+
+		pmu_read_sysfs(to_read_pmus);
+		pmu = list_prepare_entry(pmu, &other_pmus, list);
+	}
+	list_for_each_entry_continue(pmu, &other_pmus, list) {
+		if (pmu->id && pmu_uncore_identifier_match(compat, pmu->id))
+			return pmu;
+	}
+	return NULL;
+}
+
 const struct perf_pmu *perf_pmus__pmu_for_pmu_filter(const char *str)
 {
 	struct perf_pmu *pmu = NULL;
diff --git a/tools/perf/util/pmus.h b/tools/perf/util/pmus.h
index 7cb36863711a..0d55edb3f2fc 100644
--- a/tools/perf/util/pmus.h
+++ b/tools/perf/util/pmus.h
@@ -23,6 +23,7 @@ struct perf_pmu *perf_pmus__scan(struct perf_pmu *pmu);
 struct perf_pmu *perf_pmus__scan_core(struct perf_pmu *pmu);
 struct perf_pmu *perf_pmus__scan_for_event(struct perf_pmu *pmu, const char *event);
 struct perf_pmu *perf_pmus__scan_matching_wildcard(struct perf_pmu *pmu, const char *wildcard);
+struct perf_pmu *perf_pmus__scan_for_uncore_id(struct perf_pmu *pmu, const char *compat);
 
 const struct perf_pmu *perf_pmus__pmu_for_pmu_filter(const char *str);
 
-- 
2.54.0.545.g6539524ca2-goog

