Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E5F2E718B
	for <linux-perf-users@vger.kernel.org>; Sun, 14 Sep 2025 18:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757873523; cv=none; b=H/oLZ2ttifc6t8Q/CFP/xO/RzQDyirOhSvL5KGnSkoMhy4rRuWGlFI3ht+lrRc2qSDNO7OZwhbfT0N2AvlAzLhR7yvzBq52ZpeI0JhtOIMldW0b9ejOaiJ6qVSc8WZOQCaLH4owWGtA1PNGu+msyHD8mPXFfOmUQSb+zX9gaVNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757873523; c=relaxed/simple;
	bh=h4sXefZhOxCEKIvBSymmqcVW8M/ts7r+91O3C+eEVL0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=NTn3Rjd6WNxEYHWlcgtAt1uV7OLv1atzl6GAkApmP/tjp+4/cybrLaPOwy/J9LBGf5Zul+MU+HNss62NKgpeV+pX4k9gFQ434ZUVw+yKQ78fWheOwgRU9BJKvpNlmZI4RssV5LbG0KQdOlHMlRV5YIomJA7roFCqME8zcH2Rkag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EPEd1TF/; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EPEd1TF/"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32e43b0f038so274141a91.0
        for <linux-perf-users@vger.kernel.org>; Sun, 14 Sep 2025 11:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757873521; x=1758478321; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RjylI1Ng5NnBN9pwU555o9z4A/tVaFnze9kkfZFImEo=;
        b=EPEd1TF/g+sUy8vUx5BrC3+BRQNE5M2b8/f4tYYAQXrzJPfVs1jpnEDjBfkiuEI4ab
         t02kCy2Igs4rm1q7+s/hEBNvqNQZ/hKk3CESncvBjcMccjtU0a7+bZ1EQKLUhNAfzcoH
         tbSiRy2vwoe4g9KU5gIUKAVFiXlpLzWujm7VPEMFkg8ssirvlSPMQGWeTH26I++yfFji
         1Qs8+wtYCdw53/8Nzr1aZQ3ATcB6LhVT4+e1UtYjNkHyTj4Hjy7JW7Uq91f+elEwSiO4
         9mI/WnNF6ya27hs7Sp1bQcSZthAdcznwlzUROj5IWD1ZW1avU2unTlaJqbFd8Jw5Ffg2
         0/nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757873521; x=1758478321;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RjylI1Ng5NnBN9pwU555o9z4A/tVaFnze9kkfZFImEo=;
        b=xHjrwBD83ax3Pky8bC30lN6HV+hI+/9XsoKp6F9nASVLjlidsG0tHEbQNde2dTMGdT
         rzPLhWZZCFwHOevobWojQqFMULTmzPO1cmOy5crKm2mp6+j4mEc+923TguQw3jBO500P
         VqSFjYt1491ho17vfW9rDGoxwP2Q11D7gmo1w3dO0RfmV49ODcaRq18XtsaCehFRK7m2
         kjL8dpQ664TC4lnQQp5j7RkuPOItL5Xm626A3BHaIh/XuflaN+a4FIHabcCxWg1H9s89
         hTAhGgLUxJ8cVUv4WquVuKh9GhPupibD/Zx4+xbSZTvSdCIunrufc+Xmn+bRxKVaiA5s
         wBUg==
X-Forwarded-Encrypted: i=1; AJvYcCWMgBaXXjJTzRvfTtjZLvGKTKoQufSL/aHyDdxvnEHuR2UF1tViaAp7lbvkHQ8U0kPm8vQKn+WvU5M1w36Bh9MG@vger.kernel.org
X-Gm-Message-State: AOJu0YwV2QC1wZxPbuRMRuW7pKPBIL8WfnPAPQkruYF4Hn393Truk/VH
	UBN16yKdZqxwR+noTsUSutCopGVZxF9wzod0EYiD6UXe7/KlKlOM60B7tH9yIaucqLPkk4swRg9
	YR8GB5BFs3A==
X-Google-Smtp-Source: AGHT+IGnn2xJFltc6k0PjS03jSoP/OrGc3R18b/p/EPkWiXKByR1WFESRAYFW+wv288N7SKObI6ml3yvLFPW
X-Received: from plaq13.prod.google.com ([2002:a17:903:204d:b0:25c:8c4a:ec84])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d4c6:b0:25c:4902:7c0
 with SMTP id d9443c01a7336-25d23d1bb3bmr127571745ad.3.1757873520615; Sun, 14
 Sep 2025 11:12:00 -0700 (PDT)
Date: Sun, 14 Sep 2025 11:11:18 -0700
In-Reply-To: <20250914181121.1952748-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250914181121.1952748-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250914181121.1952748-19-irogers@google.com>
Subject: [PATCH v4 18/21] perf evlist: Avoid scanning all PMUs for evlist__new_default
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

Rather than wildcard matching the cycles event specify only the core
PMUs. This avoids potentially loading unnecessary uncore PMUs.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evlist.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 80d8387e6b97..e8217efdda53 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -101,16 +101,24 @@ struct evlist *evlist__new_default(void)
 {
 	struct evlist *evlist = evlist__new();
 	bool can_profile_kernel;
-	int err;
+	struct perf_pmu *pmu = NULL;
 
 	if (!evlist)
 		return NULL;
 
 	can_profile_kernel = perf_event_paranoid_check(1);
-	err = parse_event(evlist, can_profile_kernel ? "cycles:P" : "cycles:Pu");
-	if (err) {
-		evlist__delete(evlist);
-		return NULL;
+
+	while ((pmu = perf_pmus__scan_core(pmu)) != NULL) {
+		char buf[256];
+		int err;
+
+		snprintf(buf, sizeof(buf), "%s/cycles/%s", pmu->name,
+			 can_profile_kernel ? "P" : "Pu");
+		err = parse_event(evlist, buf);
+		if (err) {
+			evlist__delete(evlist);
+			return NULL;
+		}
 	}
 
 	if (evlist->core.nr_entries > 1) {
-- 
2.51.0.384.g4c02a37b29-goog

