Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15C92EAB7F
	for <linux-perf-users@vger.kernel.org>; Thu, 21 Aug 2025 22:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755814728; cv=none; b=nn1EB/Zx3okR7E6lZOS69FJFRHqUzKhNk9L5htP+NeYfTGDmg5t0JJdrQV0+k8tHgg1eDIfb328AOwgC1eGoeV3seCF+WqaYX/eQ7BKsRCWkbZSp2hTiNEPXjgiQ3ofYIoMeRjIdsLKNWI05NiU2AkyJNFmy+2yAvztotyZlPJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755814728; c=relaxed/simple;
	bh=fbQi14GqPscWDRXsuaN+KHcS/bYHMtgBEgiE1yKNiWc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=QK6qHMnZlIzTVeBA0f/6oK9JgccQvhYafE9kPhp59dYxFsBpihcceSmzi9qx1eOZvcDGOcVxKqQvlYcz7u61xn4ZdN3k2mSFNKMxWO/wKvU2PPPyhtkEySRhPEE8+hi+MH8efWCo3/2hh4I3p/GjpAYASE/2IdQFxCHWFeyOeTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W2YscNyg; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W2YscNyg"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32326e72dfbso2470897a91.3
        for <linux-perf-users@vger.kernel.org>; Thu, 21 Aug 2025 15:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755814726; x=1756419526; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dTccXPd7+v6/+rANPjgROi6ymWhIsKsDtgiSee4TJ28=;
        b=W2YscNygGieDSHMEeIgrlNztBrJOoV7MZt0jYr/kld0J3grEdETY8Bu8eQizkHEE0H
         TuDwhm+5gnfdVFM9v48kw1ENiY+xEBJoxa+LOB7GUnMotpI+5K9j2m1788Y+fuIYf4+1
         L+TazcblVRMourvTHrREmo6cIddV6JriX2MArksSwH7BrYtLmnfd4BozvsvvnNNtEpOX
         otezFxg51OpgMcqPf1v+R4WsHm0OfRHBZuhI1Sc/txlcXnoI0KtqZ9JIVJxBbhtt5r5K
         XuRk6tYSffTQSYvGCDujuFKv9C+7ljn9WLCR5mWt7XfA6oChME/NEBMns/+YUNF3T4V9
         1vgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755814726; x=1756419526;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dTccXPd7+v6/+rANPjgROi6ymWhIsKsDtgiSee4TJ28=;
        b=Tkx3674H2w3l4boki+rd4vWteTaBePP5/5oyANd5qb1A1EKEpGfZrQz/GlYCPDKiaS
         k1LhKU051acz+pg0gwfT1eCLqy70xNgv0hpkSW/I4XbYhLF1cE6OyIc5Git61c+Wy6rq
         YTEsjZqywA7JgzN7AhBP89OynPb/Onm33YPCNIpx/P4dg6muYB1wqIY3o+DJpRGoaxvH
         Z9QTu+v6KwvKrJj6Q9ZVum6fw6/yUbWnDQJbp5qjfam/dGh8QmZ2zFjDbLqKMxydwHF0
         wW6PsMfRg0DiTEXSu/Xi1DrsbiIMEEtltfwmNQzZR+FCW0izMW86PfL5daOwaRw+IFTY
         aiLg==
X-Forwarded-Encrypted: i=1; AJvYcCXF+Pi8Nl7QVwgIHvDfZeuA3tHT9DiDtBxjpzIdlnDYFhpdjyw1NngN81h+yyEfC7PCQQsGZuFRVswdTkeyR7og@vger.kernel.org
X-Gm-Message-State: AOJu0YzD18cGML9yL96phtqtjr2kDnZhrQY7A4+hcQ08S52e4fCCqjEG
	H3foQST3cuzPIyu4zMhHRnUemS2XsC6QzNobfRMRa79F9qoaT+gO/aVDokmrc0m8zhY0rAc5ihF
	ew6yjnUsyFw==
X-Google-Smtp-Source: AGHT+IHYTLEVbWOFzSCLICihvRMf6bXyZv9JRpV/nHlthIixzEwFOPWfEWnbOTko7BA1kkfGaRewlPLUh7vf
X-Received: from pjbqa5.prod.google.com ([2002:a17:90b:4fc5:b0:321:c2d6:d1c3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3d88:b0:31f:11d6:cea0
 with SMTP id 98e67ed59e1d1-32517d1dd5bmr1283481a91.27.1755814726056; Thu, 21
 Aug 2025 15:18:46 -0700 (PDT)
Date: Thu, 21 Aug 2025 15:18:33 -0700
In-Reply-To: <20250821221834.1312002-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250821221834.1312002-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250821221834.1312002-4-irogers@google.com>
Subject: [PATCH v1 3/4] perf evsel: Fix uniquification when PMU given without suffix
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Chun-Tse Shao <ctshao@google.com>, 
	James Clark <james.clark@linaro.org>, Howard Chu <howardchu95@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The PMU name is appearing twice in:
```
$ perf stat -e uncore_imc_free_running/data_total/ -A true

 Performance counter stats for 'system wide':

CPU0                 1.57 MiB  uncore_imc_free_running_0/uncore_imc_free_running,data_total/
CPU0                 1.58 MiB  uncore_imc_free_running_1/uncore_imc_free_running,data_total/
       0.000892376 seconds time elapsed
```

Use the pmu_name_len_no_suffix to avoid this problem.

Fixes: 7d45f402d311 ("perf evlist: Make uniquifying counter names consistent")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evsel.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index d264c143b592..9a6e2d556d35 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -4048,9 +4048,9 @@ bool evsel__set_needs_uniquify(struct evsel *counter, const struct perf_stat_con
 
 void evsel__uniquify_counter(struct evsel *counter)
 {
-	const char *name, *pmu_name;
-	char *new_name, *config;
-	int ret;
+	const char *name, *pmu_name, *config;
+	char *new_name;
+	int len, ret;
 
 	/* No uniquification necessary. */
 	if (!counter->needs_uniquify)
@@ -4064,15 +4064,23 @@ void evsel__uniquify_counter(struct evsel *counter)
 	counter->uniquified_name = true;
 
 	name = evsel__name(counter);
+	config = strchr(name, '/');
 	pmu_name = counter->pmu->name;
-	/* Already prefixed by the PMU name. */
-	if (!strncmp(name, pmu_name, strlen(pmu_name)))
-		return;
 
-	config = strchr(name, '/');
-	if (config) {
-		int len = config - name;
+	/* Already prefixed by the PMU name? */
+	len = pmu_name_len_no_suffix(pmu_name);
+
+	if (!strncmp(name, pmu_name, len)) {
+		/*
+		 * If the PMU name is there, then there is no sense in not
+		 * having a slash. Do this for robustness.
+		 */
+		if (config == NULL)
+			config = name - 1;
 
+		ret = asprintf(&new_name, "%s/%s", pmu_name, config + 1);
+	} else if (config) {
+		len = config - name;
 		if (config[1] == '/') {
 			/* case: event// */
 			ret = asprintf(&new_name, "%s/%.*s/%s", pmu_name, len, name, config + 2);
@@ -4084,7 +4092,7 @@ void evsel__uniquify_counter(struct evsel *counter)
 		config = strchr(name, ':');
 		if (config) {
 			/* case: event:.. */
-			int len = config - name;
+			len = config - name;
 
 			ret = asprintf(&new_name, "%s/%.*s/%s", pmu_name, len, name, config + 1);
 		} else {
-- 
2.51.0.rc2.233.g662b1ed5c5-goog

