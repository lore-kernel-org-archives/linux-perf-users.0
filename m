Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2353382E8
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Mar 2026 22:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774565099; cv=none; b=g7RIkFD8895vJVYHCOc+jPBoWmYHQ0G2jfhAOST6cq8aJ+OnuwjBVhme9GqMrHAqh3vBTvfqVNstUZsKaykA9k/K20FagCSe4gz5jBBKGfEQRUiI1KQ0/KYRLAduhVdmR3ic9fCJ3ybZb1CboVZIS8ID3oK93onmRHMHKvL3sPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774565099; c=relaxed/simple;
	bh=CR6+INWhQ/wPb5pyKdSwqC6q9KSJRF0W12JGLakGgaw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=leEedkEFj85aIN5VHtUL03gJ43HvXUmw0zK+M/Qd+eS4J8Wb1/5wRn8nmUNBb1yIo8ShXKgu69fzpKm0MkC+Cl8lYRYAu9lUrVbvPpTKnCJjYDdjG5OoapZqzxrt9mc/SztYN6jl4/BiW+3hBvGZpC2FmLq0aQPfAghtrHURZ4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ki+alzIz; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ki+alzIz"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2c0bddb9196so1004355eec.1
        for <linux-perf-users@vger.kernel.org>; Thu, 26 Mar 2026 15:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774565097; x=1775169897; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+OJlo7iOn/D+yubhqDazKlqKYdB4rVxpLH9bxft1M0A=;
        b=Ki+alzIzZRu6ac30RlBmFQfGbxYyzOdk+ZexJsPHEFLSfYTNoOTTfee7G2qbbGTazh
         /uZdZrTc2Fcg7xG4LaQlyALQZyr1LHPhGUvVv2ilI3L+oyTOTWAF4rsPGcEW6jQO3idI
         lA9G2xJ3+6KOPzDp5KbfVIW4T2EsrTCWqHwtocLO9s4N93aDHRw/kg6n/ei5WR0M4wS6
         l+j9Pzob4AspocIb39LOdONuYJ0dd1oHSk0b3zkaXI7vKSOHe8C4Ho4bUFOkamQMuR7o
         m7VVuVw3ot/m2KPDGMxirTW9VxbkzGRRpao6jNQummjwtfUvpeYxorpXGGhj0Fgzr4xC
         bdlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774565097; x=1775169897;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+OJlo7iOn/D+yubhqDazKlqKYdB4rVxpLH9bxft1M0A=;
        b=KcYbNG8EY6gx4PrRSDshOIhFvVZHTY377LzznH2TOmorGcADJSFYlJL+iuWHQ8k7ZX
         E0rKOj0dsHpZcBDW1aVlSh6CdqmJsbLV6WJGb2bIFclitKGvW50mcaqkYkpeWqM8X5UH
         OB8IJklCa6fdU/gFsvrnSlAB8avIatjylZH5RIH2lK87BeWOYk82v+D7++01bpG3yDkK
         VoajLQbHQ9VuS8B6TRsnT6lRkK0uyKTcw3LsRqvZjAUvjOgfSLAHFfAc620012Iwg75d
         wJ7EASKsl7bjlDsOv551l6qjRxG49dOP4lD+guQdI7Uk4ss2Ht+P7p0EGyY3nkLp/Rou
         GUOw==
X-Forwarded-Encrypted: i=1; AJvYcCXzIDYhkZwgoojKDhC5hKh8/CbYHDDwGH6noLzjWmqV8rxLqxYumNOpvwXtIZWyFQbmXLTMmJAqiI+F6tuVDI9L@vger.kernel.org
X-Gm-Message-State: AOJu0YzG4D0nATYr/RNuLQUm8JH1AoSVuJUKDqjyJ02Zcoxe/nAxPxrL
	Qv0XjfDhUiQc5b33kk9LoA2eiJM0pUVx7eb/xbael8jQu2VdIec7Tz/27zDuY3TiBrGJ0gJmjym
	MJKKpRh1ZIA==
X-Received: from dys12.prod.google.com ([2002:a05:693c:800c:b0:2c0:f534:5cae])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:1010:b0:2c0:e741:9d84
 with SMTP id 5a478bee46e88-2c185fadaf8mr186912eec.35.1774565097263; Thu, 26
 Mar 2026 15:44:57 -0700 (PDT)
Date: Thu, 26 Mar 2026 15:44:54 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Message-ID: <20260326224454.2101190-1-irogers@google.com>
Subject: [PATCH v1] perf metricgroup: Avoid scanning unnecessary PMUs for
 identifier match
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Leo Yan <leo.yan@arm.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Only uncore PMUs can have an identifier, so add an optimized
perf_pmus__scan routine for that case to avoid all PMU types being
created.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/metricgroup.c |  8 ++------
 tools/perf/util/pmus.c        | 18 +++++++++++++++++-
 tools/perf/util/pmus.h        |  1 +
 3 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 7e39d469111b..769b38400832 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -410,13 +410,9 @@ static int metricgroup__sys_event_iter(const struct pmu_metric *pm,
 	if (!pm->metric_expr || !pm->compat)
 		return 0;
 
-	while ((pmu = perf_pmus__scan(pmu))) {
-
-		if (!pmu->id || !pmu_uncore_identifier_match(pm->compat, pmu->id))
-			continue;
-
+	while ((pmu = perf_pmus__scan_for_uncore_id(pmu, pm->compat)))
 		return d->fn(pm, table, d->data);
-	}
+
 	return 0;
 }
 
diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index 98be2eb8f1f0..9859d7056fb7 100644
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
2.53.0.1018.g2bb0e51243-goog

