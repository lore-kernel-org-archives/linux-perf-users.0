Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5119E15853B
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Jan 2025 05:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736314490; cv=none; b=YMijAoBOVQhGqB9zYgPlW2n9dJBXOVnrbUaaeu/531epRgZoyhLGZTeuyKZH8aE8iS41m2NAYMbvr9jqHjtMO4IPwzWfTQJjytYCvukg9WX8+/Q77TCLVYxZO+ZnGDA8Gri82/h8/RjriVLs/cPvogDtPcMGZ5ICCzJaVMu362g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736314490; c=relaxed/simple;
	bh=FH6pJMsaJgeqK7UUNBqCQ6T9Rv/2s4i52g3/jbl+dxU=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=gvS4Ncc7rmmck0UXQJB57vpHymM24oln9GNXo6XfqVRnraj6JWANi9SuL24r/XXfX5taDbxsCqQOHzGpH/hL/43rA283/zH4K2lSqQjagEjcLDUBu3sHDBD9wqrsR2mGfutIJUXotqSCMU7LJ9ByWM2dHG5GCyWXzymTwf9go7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aC7P5dJ7; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aC7P5dJ7"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e4a8b40dd40so35027203276.3
        for <linux-perf-users@vger.kernel.org>; Tue, 07 Jan 2025 21:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736314488; x=1736919288; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t23J7xHrW+6du/GAso1cLjFOTcnn40e4CEJt2KBpcE4=;
        b=aC7P5dJ7mQKkVoU4wWK3kuu05K+XaulFPBYq0yMG0mM5jAVgeVJ5QZIwW5Ui3Ii+vc
         5kKIgyVrCfL9ZzEAFnmaREl2Qd6ua8TLCVUBmcER0hTLy79erAmdILAXspzcXMyWVZ6z
         Ce8e+nDYT3swEFr0eCp3UiM0eRI2aXHLL6R5kT+WZZnqVBeAdpoCDO3ikQreIjtC2DBL
         og0aIS27W0ulM9oL4EjwtRkBqXcdIOXtlZl3BYk5PxH6CWpawXuL+Jc9qq6adj4ZATpA
         dPGHhsL4uODF2MIQSeAzdiQRI8E0jXoXyiSeMFWVsC1Wk05FeTKac2BqOiGzDBUVBPa4
         oFKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736314488; x=1736919288;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t23J7xHrW+6du/GAso1cLjFOTcnn40e4CEJt2KBpcE4=;
        b=Ut/Jiazm71cNxcO1sBu2wgiljAlwJB3B1O0ZdocxmoLv2+O2/Z+r595+hJtRtKwjuT
         XB65DLPrrBNGQVPnFdvsMBWR9iG1nv6x7W/RGcSpKJ7htpi/Vl/VdASOnky9wrK9LtcI
         jtpe7jqQLLwsf1cGoSJizSc0/NAhcdpa8eP6AQJXhWN/pX64QnFM+lF/ZoK2w/s35+TG
         zH0h96wbASGuiMA5hgx5lRw9yPHYktGwU0brJwColwwHLK1Yr4q/9QfBfJkAHtQoSDuz
         Hhn+O9gDYJpHwb0mwGawWw8jJbc6QZ2aDRnfJliJDOS/YwStRZIf1LLvAeZjuChIODip
         BMig==
X-Forwarded-Encrypted: i=1; AJvYcCWitsCrhdDN8ArQqipE5LmQvs3BZL3nSBRz+M8ZpSpz07wx85NJ31NleXB1mYTeVfF/0IR7n8fMFC+d+5wSRlNj@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/Ag0oVadAZSHL7KCEZhTOadhZOE35QaNhNYEg4TagJ7dabVw3
	m/80zJIRuddvkecIjbxNeUsQVqCJHF+lBhH6y6SFXAiqrBUKeAznilIS+zO9Ie5Ezvw3wvNY4jH
	+tMWryg==
X-Google-Smtp-Source: AGHT+IGfud90+1PaGtUI5JAJlfl3512z8vfPSPhC61W7tJfmD1UNBvEijqmfYY9XQy9B8gM2/qNunvu08Lxp
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:7ae:a887:5504:e3ca])
 (user=irogers job=sendgmr) by 2002:a25:2b43:0:b0:e2b:d0e9:130f with SMTP id
 3f1490d57ef6-e54efbf428cmr3266276.0.1736314488295; Tue, 07 Jan 2025 21:34:48
 -0800 (PST)
Date: Tue,  7 Jan 2025 21:34:26 -0800
In-Reply-To: <20250108053428.1724490-1-irogers@google.com>
Message-Id: <20250108053428.1724490-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250108053428.1724490-1-irogers@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Subject: [PATCH v4 2/4] perf stat: Use counter cpumask to skip zero values
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Leo Yan <leo.yan@arm.com>, 
	Yoshihiro Furudera <fj5100bi@fujitsu.com>, Weilin Wang <weilin.wang@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Dominique Martinet <asmadeus@codewreck.org>, Yicong Yang <yangyicong@hisilicon.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When a counter is 0 it may or may not be skipped. For uncore counters
it is common they are only valid on 1 logical CPU and all other CPUs
should be skipped. The PMU's cpumask was used for the skip
calculation, but that cpumask may not reflect user
overrides. Similarly a counter on a core PMU may explicitly not
request a CPU be gathered. If the counter on this CPU's value is 0
then the counter should be skipped as it wasn't requested. Switch from
using the PMU cpumask to that associated with the evsel to support
these cases.

Avoid potential crash with --per-thread mode where config->aggr_get_id
is NULL. Add some examples for the tool event 0 counter skipping.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/stat-display.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index ba79f73e1cf5..32badf623267 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -1042,8 +1042,16 @@ static bool should_skip_zero_counter(struct perf_stat_config *config,
 		return true;
 
 	/*
-	 * Many tool events are only gathered on the first index, skip other
-	 * zero values.
+	 * In per-thread mode the aggr_map and aggr_get_id functions may be
+	 * NULL, assume all 0 values should be output in that case.
+	 */
+	if (!config->aggr_map || !config->aggr_get_id)
+		return false;
+
+	/*
+	 * Tool events may be gathered on all logical CPUs, for example
+	 * system_time, but for many the first index is the only one used, for
+	 * example num_cores. Don't skip for the first index.
 	 */
 	if (evsel__is_tool(counter)) {
 		struct aggr_cpu_id own_id =
@@ -1051,15 +1059,12 @@ static bool should_skip_zero_counter(struct perf_stat_config *config,
 
 		return !aggr_cpu_id__equal(id, &own_id);
 	}
-
 	/*
-	 * Skip value 0 when it's an uncore event and the given aggr id
-	 * does not belong to the PMU cpumask.
+	 * Skip value 0 when the counter's cpumask doesn't match the given aggr
+	 * id.
 	 */
-	if (!counter->pmu || !counter->pmu->is_uncore)
-		return false;
 
-	perf_cpu_map__for_each_cpu(cpu, idx, counter->pmu->cpus) {
+	perf_cpu_map__for_each_cpu(cpu, idx, counter->core.cpus) {
 		struct aggr_cpu_id own_id = config->aggr_get_id(config, cpu);
 
 		if (aggr_cpu_id__equal(id, &own_id))
-- 
2.47.1.613.gc27f4b7a9f-goog

