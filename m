Received: from mail-yx1-f73.google.com (mail-yx1-f73.google.com [74.125.224.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820302DF142
	for <linux-perf-users@vger.kernel.org>; Sun, 14 Sep 2025 18:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757873525; cv=none; b=auBzxEArVAGwyPduxRIBrHAQXwcxS8P1hwSs6EaKPFrCYtzgiPARv9XoDUMNg9yT0CMKDkSZ/M4Wnvw4r8ao8AqzSqEbWgDtlihSQIBrFUQXGngHQXXUDexOJvvuhsTxtsD6bq08QwoMDoxsROJ/pniIW8alH6Ro1e1wx5Dox8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757873525; c=relaxed/simple;
	bh=3USz/8cgiAXodD9rWKo1mVu9mCYIiQGOe68nUSdOSeQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=KLk77g6YiW/SmtkZLjurm/pgMkHc4Um8d8UnmGKvqMRKCaNW9KYe3hTiYeftwW8B/y2HjnI0E38xP/gQMp+sVE7U1h8jeAPv5rZy5K5D/wUQxy9+h0oOSZyBsY+vG9Z+h1LlHobXsg67ZjOGrDH2ugL5SfVmg1Oi3mno6OFwVBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XwCjcqY5; arc=none smtp.client-ip=74.125.224.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XwCjcqY5"
Received: by mail-yx1-f73.google.com with SMTP id 956f58d0204a3-60f47bc0cdbso1671771d50.2
        for <linux-perf-users@vger.kernel.org>; Sun, 14 Sep 2025 11:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757873522; x=1758478322; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NcSuLxjViMVn1AH06++WwbZcfBvTqoDTZlptnzuTMdI=;
        b=XwCjcqY5Q6xqK4ukhdHaw2NboJUhnS0GAJlmcr1WbKl7XjUuKOzWWXuW80zHOPmYVD
         Tlq0qgCoQ6X0E2898iOQfQrtBJw++3ZPFh5OpTRI1YK+dRj6IFCA76aAUlujcwaeanxW
         Fx2xKOAkpP6qPHMUdjqfVdfqh8rUsNcT0uTlFjgbqmyWjGQEubjWJMvFT4pkN4tDh0Pw
         fGxGyet/oVOvwHdiX+6eVn/z7KDep4X2OTsXrahGi6yy6rGDk34qb3WrrR6sKXZ3b6Zm
         X+HJTyxQtWvaLi8M33TVQvqDJG17N0vCHgeYl8KsB56+MUHZk4Y7tJpPiZTGsmQ4ruws
         EFNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757873522; x=1758478322;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NcSuLxjViMVn1AH06++WwbZcfBvTqoDTZlptnzuTMdI=;
        b=phwIGwsAuVQ25X8KYNuOtWQppvJhFPiK5DOvkDafJgxLWzOh4+BkLVinH05EedpidB
         p50nPgA0RRLLceT4P6rbJbIcqhP/gyeRddsLQpb8GRaEScDIVwIDK/NzrS4kzU2rqm0g
         isYf9v6gQb4J0ChhY4d6yY3ZHVQoDESXWLYSY8E3FwDAMzDy8dhLuhQpoZzt3aISfjOJ
         O+UQnEeF0LF42GzJ8E+/lWhMix0EHzPeRznZesxttX5+XlauPFWZg7MwUoC4NSQFIDF/
         juekBATslkjaCKiUxE9oCjKWm0qIFjkLSi6rqeRtxrtCl2GD6iaEoShm757la934g5Hj
         oTdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIi+6MhY442Z9bEnET9yBMYyrSL87O/hP+IgLWcqGpd4TFUuE4rGDPLEeqH5R4stz4N0n/1SgedoOAjLZGUunH@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9+lCApz3USLWxlVElfWivMzAG/rvISoeoasdS9rUXYNn7TCs2
	rq2KMk8RdATrwRAtc+EmwDw3F2OVe/a6jFsUbj4dWOz9YKNqlp7+W0+AauULPI5R8wsV6YmDJT5
	UTpCXYyWcrQ==
X-Google-Smtp-Source: AGHT+IEaP9E+vKfkNkdjktEC7RJRDoEjErIeyDQdhLvHEpnOMn+A9azJ8eDsAc2xfisfAwUjBe3+hWwPZorX
X-Received: from ybaj123.prod.google.com ([2002:a25:3c81:0:b0:ea3:f3ae:c816])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:690e:1612:b0:62b:5a42:5d76
 with SMTP id 956f58d0204a3-62b5a425fc3mr2865601d50.36.1757873522223; Sun, 14
 Sep 2025 11:12:02 -0700 (PDT)
Date: Sun, 14 Sep 2025 11:11:19 -0700
In-Reply-To: <20250914181121.1952748-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250914181121.1952748-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250914181121.1952748-20-irogers@google.com>
Subject: [PATCH v4 19/21] perf evsel: Improvements to __evsel__match
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, 
	Atish Patra <atishp@rivosinc.com>, Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>, 
	Vince Weaver <vincent.weaver@maine.edu>
Content-Type: text/plain; charset="UTF-8"

Ensure both the perf_event_attr and alternate_hw_config are checked in
the match. Don't mask the config if the perf_event_attr isn't a
HARDWARE or HW_CACHE event. Add common early exit cases.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evsel.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 9c086d743d34..477cddf08c5c 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1863,16 +1863,19 @@ bool __evsel__match(const struct evsel *evsel, u32 type, u64 config)
 	u32 e_type = evsel->core.attr.type;
 	u64 e_config = evsel->core.attr.config;
 
-	if (e_type != type) {
-		return type == PERF_TYPE_HARDWARE && evsel->pmu && evsel->pmu->is_core &&
-			evsel->alternate_hw_config == config;
-	}
-
-	if ((type == PERF_TYPE_HARDWARE || type == PERF_TYPE_HW_CACHE) &&
-	    perf_pmus__supports_extended_type())
+	if (e_type == type && e_config == config)
+		return true;
+        if (type != PERF_TYPE_HARDWARE && type != PERF_TYPE_HW_CACHE)
+		return false;
+        if ((e_type == PERF_TYPE_HARDWARE || e_type == PERF_TYPE_HW_CACHE) &&
+		perf_pmus__supports_extended_type())
 		e_config &= PERF_HW_EVENT_MASK;
-
-	return e_config == config;
+        if (e_type == type && e_config == config)
+		return true;
+        if (type == PERF_TYPE_HARDWARE && evsel->pmu && evsel->pmu->is_core &&
+	    evsel->alternate_hw_config == config)
+		return true;
+        return false;
 }
 
 int evsel__read_counter(struct evsel *evsel, int cpu_map_idx, int thread)
-- 
2.51.0.384.g4c02a37b29-goog

