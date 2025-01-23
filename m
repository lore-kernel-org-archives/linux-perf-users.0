Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521D620C03A
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Jan 2025 07:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737618433; cv=none; b=Lh0IINXTxB64+yK86YE7qN6IPbwd8KdZNDqx8UPDfuvv2luwJuuaOjQL+gO7U+IXT9WHaT4b6fHdjejeHdpO2Hh3SNw6DmQhBSMyNCYScUScMb1W1mf3y0UKmXS7wEpo+a8IzdTBmg7KEtNgv9YecykRWwsgbl/tzgquwxOuIIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737618433; c=relaxed/simple;
	bh=ev6gOwSw4jl6V/iZ6caKVvKq7JDregz/9FV23n2B/xQ=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=d1e05I8yuIYTI2i9ErbIjUTS9LbhPfsoWhP9Pu6I9ssrvGrZh2NmA3nSk4yDjRDK09HNbM3oWLCLZy5L+4CJYRMRc9Q+M0v8hpPLo3J+kCxT/MLYyyuffMfqMuTssCG94gCoCaBCMYiotpM6elEwyBUMYo2MVybrYA1OELAdio0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ibg7BCld; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ibg7BCld"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e02fff66a83so1412085276.0
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Jan 2025 23:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737618431; x=1738223231; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DibDykcBruUh/0Lt2YF7KYtu0dPCuDqFOq2uHrXam2E=;
        b=Ibg7BCldAHS2tCAGfd57iKs+XqfgwLnhGPx27Xts+ZQiHgG5h+69/RCRf1yfnGX1zt
         gcTDrFZA313hjYiH/Q+OVegch8TygzzaIDyEN95pvZFs2LRYOgtEpD+R6fwxeAaGaINL
         SMsu8UB4QY/KYnptL0A1uUzKjfDO+sbFePI6/L9fgV6VNq4KOZqkZ2A78ndiRg8MRk8a
         GZSdDYV7vO4USaFD/Dfw5yuv+UKIxef6n8tJPH2Jyv0Y3gxicpVRIo0kT7N6OX+lnW+U
         7WIfW48FlodbpI3f9ATDXQhEzRGgp/4MaJ4t93dWABamn5OTEx5egdOWu6A3saXYzA48
         GLog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737618431; x=1738223231;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DibDykcBruUh/0Lt2YF7KYtu0dPCuDqFOq2uHrXam2E=;
        b=HHzgBaFT8DqWUcwWcPZzxhAeWQdD73YctmKhGoSO/FGGjKTWQP3wl28XINp7ws8vpC
         WTUjgYb5i/PpGOj1dTRQkFWQcUsDL4ALEJL8UXl1Sfxv0MdsxgUwZYgiz8HhtPhtY6AS
         J4ARgaxiX4xM5mVkIZDt7b+7y62J/2rNeGEGQe5OtPkCU8FArwlNdgUcXPuJFRD3lcDv
         vCUrWELnQnOEuleoE5Fd2Dg+JBjsUxq0OPwrkc4qZexXGzQxTxJuT7GFls1WxyqSrNUj
         xWZH/e5HMXpc9cIt6IitvmhDwIRfnGuEnocl4oM6oAhH4PKEQ8j3oJjJZyxWsfVMGOCA
         bVRw==
X-Forwarded-Encrypted: i=1; AJvYcCXDb2AMqOYughJkSlcsHY8qCWrsCEVj4tXfpSezK9yGhHYvqngOWruhAHpV40Mi1qkpRcSv7LnYz4q0VCVLPdAf@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv2MNMfT74ErrzajN/HxdqCp7URfTiiqQUur41gAvFSoBEeMRE
	dwmXnwyOQdW3PijYT7Ipdj0F+6XeFYZMZ8rIt9/DarTy72IHkmjWHg0y2m7gs1Pp4667YfsA8dq
	hptWrzQ==
X-Google-Smtp-Source: AGHT+IE87jbT8I4D3MgQZvsZ2qLI+fhLyD63f8Gc0ijFyB8cgfhVoXEDc1maMbMo27Is6nL5mI8QFidgNe10
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:2fda:d811:ae83:77e0])
 (user=irogers job=sendgmr) by 2002:a05:690c:6307:b0:6ef:7c63:b104 with SMTP
 id 00721157ae682-6f6eb949f2emr577327b3.7.1737618431203; Wed, 22 Jan 2025
 23:47:11 -0800 (PST)
Date: Wed, 22 Jan 2025 23:46:58 -0800
In-Reply-To: <20250123074659.698123-1-irogers@google.com>
Message-Id: <20250123074659.698123-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250123074659.698123-1-irogers@google.com>
X-Mailer: git-send-email 2.48.1.262.g85cc9f2d1e-goog
Subject: [PATCH v2 4/5] perf stat: Don't merge counters purely on name
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Ze Gao <zegao2021@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Junhao He <hejunhao3@huawei.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Counter merging was added in commit 942c5593393d ("perf stat: Add
perf_stat_merge_counters()"), however, it merges events with the same
name on different PMUs regardless of whether the different PMUs are
actually of the same type (ie they differ only in the suffix on the
PMU). For hwmon events there may be a temp1 event on every PMU, but
the PMU names are all unique and don't differ just by a suffix. The
merging is over eager and will merge all the hwmon counters together
meaning an aggregated and very large temp1 value is shown. The same
would be true for say cache events and memory controller events where
the PMUs differ but the event names are the same.

Fix the problem by correctly saying two PMUs alias when they differ
only by suffix.

Note, there is an overlap with evsel's merged_stat with aggregation
and the evsel's metric_leader where aggregation happens for metrics.

Fixes: 942c5593393d ("perf stat: Add perf_stat_merge_counters()")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/stat.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 7c2ccdcc3fdb..1f7abd8754c7 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -535,7 +535,10 @@ static int evsel__merge_aggr_counters(struct evsel *evsel, struct evsel *alias)
 
 	return 0;
 }
-/* events should have the same name, scale, unit, cgroup but on different PMUs */
+/*
+ * Events should have the same name, scale, unit, cgroup but on different core
+ * PMUs or on different but matching uncore PMUs.
+ */
 static bool evsel__is_alias(struct evsel *evsel_a, struct evsel *evsel_b)
 {
 	if (strcmp(evsel__name(evsel_a), evsel__name(evsel_b)))
@@ -553,7 +556,13 @@ static bool evsel__is_alias(struct evsel *evsel_a, struct evsel *evsel_b)
 	if (evsel__is_clock(evsel_a) != evsel__is_clock(evsel_b))
 		return false;
 
-	return evsel_a->pmu != evsel_b->pmu;
+	if (evsel_a->pmu == evsel_b->pmu || evsel_a->pmu == NULL || evsel_b->pmu == NULL)
+		return false;
+
+	if (evsel_a->pmu->is_core)
+		return evsel_b->pmu->is_core;
+
+	return perf_pmu__name_no_suffix_match(evsel_a->pmu, evsel_b->pmu->name);
 }
 
 static void evsel__merge_aliases(struct evsel *evsel)
-- 
2.48.1.262.g85cc9f2d1e-goog

