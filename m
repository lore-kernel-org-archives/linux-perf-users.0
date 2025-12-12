Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F7A3191CA
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Dec 2025 15:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765553577; cv=none; b=mDhl0EPynLjkpnWpYRBquVpYmREsNCX4V8bn6Cps5g3kjgiPJoj7aswEKXzMRqNWEWg9RYRkxtsFSZSut+WdmdkxQD895p/HFwcvCuIjH3vPeUQtvSVwUcPRhcoywIB8tlj1Icmd4RJTonjPVEOWGp83J45ofDuc1v6OzycnUQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765553577; c=relaxed/simple;
	bh=8Q916A0+2qqjGTKQxWQQu1Y/Kx5Q3rnxowSKrPOUypo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jKYrGAOIXPnGmLpZ8N7gF71KirHCpEFH76oLDEjxTDg6lXbBfhwg+YEa2KGV9xskNPdGIaWt19ClxuQ0XG8/sZ3+yKgkj3C306F7uoxtUK2UtFppJqokzNaZlh5JDcBxC3s5aRNckmJNZsUHpYYt8y+UnQwTTVtPgqZr3e43ftA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PEt3C44o; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PEt3C44o"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6418738efa0so2645673a12.1
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Dec 2025 07:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765553574; x=1766158374; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3rYOutVV+nlrAeFTj6aX4/QG8Lfx2y/6jkTrJCZiYXg=;
        b=PEt3C44o4bd47o6oRrGUydNfJ0iGKAokMiE0cefIYCqh8OgArdZZiIML+cUh7tlTQv
         McOY73fjg6Byp0BvT7VeOffbP77xyq3gXaJNvZvvVGFjJ6EVK2V303Bn9bdkuT3j0yN7
         jf+N+GPtNHRlhdMizLZMYkzpasxV5HSlrrr5ne8K9E3lgPHe3UUFlsua3+gwns4dXeYQ
         Fci3USAHWyhIWaQt7OadaemX5qwTdbP4CdebZ4Bswru3v1wGJ6UXecNxA5oHL0jGCpPc
         dvBc8YDOzIdSvMHOW6WUCf+410qkOBkQgx0cLQQNyWpZXiAw3a277pYGaoV4C7BbxXmC
         C/kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765553574; x=1766158374;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3rYOutVV+nlrAeFTj6aX4/QG8Lfx2y/6jkTrJCZiYXg=;
        b=nU9XBNTGOt4dOcM+X6HereRnqzREh1SBJ92mOBzAFiHilBcJnu5hojZS1h0xOEsgmR
         +mrb7YBw7RlK6BltglOSCgPQD3fq6Pq/UTKfaTWHi29H7Y7cokb3x9oc46whZk+bQ5SF
         ReCIMdyTFTC6dz2VLw7dohh3FAi8Gx9evmbMDo1Hk15TosqMRtRRlFQzN7tvo+zSF0r8
         TFvfMi+rq3nHxPkV4+kelroYmKc5bCxNpWWhXwxefytQCeHaisxA+sGgPt1gZSfmCPXK
         55wG4wmhazLxTMh27yiBGSjQ2vaKfxeq4rGBgKqlFTSi9CV5bhIxAeoRADuFocmn0jEG
         +x8g==
X-Gm-Message-State: AOJu0Ywf01LCf5BgZk2TonENoZsTY1+Ece6DdqmyayrDa/r2jWjZsrq1
	/93jeH2mnearPoGEuimQYxHbG4zO6AhbRMNnfBbEog6hQqdfMOM3VjxhBzOY38zC6y0=
X-Gm-Gg: AY/fxX4wywysbqtnQpaj6CDKVeTsaBEIVIURDl0HOjsVLLGgAwLANd4tAI+BDaa3qne
	CswseR3OThlktt8GoPUyZ7/U8g11VxZSjKU7Q+PYI3uG8jUlnAiNjSkn/XEqkT4JhQw0K08SAZ2
	m+yA7OIR8tLv9lsPhwNRGtrZCrwMsECVYOmGw4hNnU/Hy5q1M306puPILgs55NQD8a2nrBlYL1Y
	09gqOiX/9Tnv0oMJojmaL1ARILvSfzlCPr5eC0TXpbhpmv+rd4daU0VQWC0qCrMdoGRU2Aklx9j
	G7bb00l3sXfrechL379zFWqcYaAHiNLV43t/uN+J/4J0q23YFUpA8zwoQA4J1sZlPClFNEqZpR8
	2UYsC1WK12PRBE9VJxnS4kRi6pRNoUrLpd0vyYm6tH+9ROndVZVHiDM3TviTGkVuTvBcfYn3nv1
	EeOzcgVT7byem+3YyjosVm
X-Google-Smtp-Source: AGHT+IHuBXF9wDV6j0xVcn3kE6xUIeXTjWm8gIVpYwkhI0QrZi9H7M2hxVZUiLHgfc5qp+HHWr/WGg==
X-Received: by 2002:a05:6402:2114:b0:640:947e:70ce with SMTP id 4fb4d7f45d1cf-6499b12ff90mr2515331a12.5.1765553573963;
        Fri, 12 Dec 2025 07:32:53 -0800 (PST)
Received: from e133063.arm.com ([130.185.218.160])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6498210ed32sm5433234a12.29.2025.12.12.07.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 07:32:53 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Fri, 12 Dec 2025 17:32:23 +0200
Subject: [PATCH v3 06/12] perf parse-events: Always track user config
 changes
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251212-james-perf-config-bits-v3-6-aa36a4846776@linaro.org>
References: <20251212-james-perf-config-bits-v3-0-aa36a4846776@linaro.org>
In-Reply-To: <20251212-james-perf-config-bits-v3-0-aa36a4846776@linaro.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@linaro.org>, John Garry <john.g.garry@oracle.com>, 
 Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.2

Requiring the 'pmu->perf_event_attr_init_default' callback to be set to
track user changes is a bit of a trap to fall in. It's hard to see that
this is required when depending on the user change tracking.

It's possible to want all 0 defaults so not set it, but at the same time
still do some programmatic setting of configs with
evsel__set_config_if_unset(). Also if a PMU reverts to 0 defaults and
deletes its existing callback, it will silently break existing uses of
evsel__set_config_if_unset().

One way to fix this would be to assert in evsel__set_config_if_unset()
if the changes weren't tracked, but that would be a possibly untested
runtime failure. Instead, always track it as it's harmless and
simplifies testing too.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/parse-events.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 7ef63b808d0542999fd1303b9f94cae68e38030f..bee9233437753ff706d6b149503a5e660c3972d8 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1528,12 +1528,8 @@ static int parse_events_add_pmu(struct parse_events_state *parse_state,
 		return -ENOMEM;
 	}
 
-	/*
-	 * When using default config, record which bits of attr->config were
-	 * changed by the user.
-	 */
-	if (pmu->perf_event_attr_init_default &&
-	    get_config_chgs(pmu, &parsed_terms, &config_terms)) {
+	/* Record which bits of attr->config were changed by the user. */
+	if (get_config_chgs(pmu, &parsed_terms, &config_terms)) {
 		parse_events_terms__exit(&parsed_terms);
 		return -ENOMEM;
 	}

-- 
2.34.1

