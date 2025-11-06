Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B5D2E6CCD
	for <linux-perf-users@vger.kernel.org>; Thu,  6 Nov 2025 23:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762472239; cv=none; b=UQQmUTE+e8xOQcLs2miYSljTqhmvcFRJ+tlqPzo4+TiMXRZA9kyccfxWLDuDyc19nDk8YgE7P+GuGgpqjjGqdcVFgXYPR+M9HT+PxC1ZPs6VUNrwCibvPFRFcwFF2NZL6SKV2DyNcfjcwV1IH0MpZn6EiC4v3u3p4hkOeRJMK8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762472239; c=relaxed/simple;
	bh=xQK/O6IyMvne+q+flAXe2z+7+95wIB4VWqMDqBIwkAY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=D6t0b39bq/Jb6l2mJQbjA5Nft7aGJIZPOT0VEqzeaiPqRWoyACujZPBFGxJvZ+lLokJJAeuYDmJxBQvw1Y6RQEKjP8eZ4B+qPPSQwzjgeZGm9LGoLON1ScekJmZWnZ7rEsy3RjiGX3yuZHtOKvvWfrGhjWUA9EIZfVPSb9n/xig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vGfUVig2; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vGfUVig2"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-297b35951b7so3668415ad.3
        for <linux-perf-users@vger.kernel.org>; Thu, 06 Nov 2025 15:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762472237; x=1763077037; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=53kBEpiSojMAZMNPk8l4f8C1X5BWBrwofuut4eOe+zc=;
        b=vGfUVig2NumjShUY/7zn8lSLh+m1cjBp4w0M0FbA78aAr5qqgJvO9wWJEpCauAsQLT
         PjWB+aEipSLVpMLRE0UebbYrlfO958xVp2ndjMC3zkYolWslFC9ip7U6rKYSl5oq+Kiw
         Uz/QtRPGUVysGvctxtXvn+EqEsrRFMMcWG62Vy7Md1nBp3c4SGxOMmfdCdqxkh37YVUp
         MmeyI0vLiBqYSfXN2Qpjcgc177XqBxOlMjF3gga9CBmWlsw/VKwZBmUOnAylVowmm9mb
         RNpls6XR7wJaQrakWE1QzUmVY+8zDgDOoxr1q44oJkGK51nNat/+PABoW5gYWHE4/J8v
         VoDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762472237; x=1763077037;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=53kBEpiSojMAZMNPk8l4f8C1X5BWBrwofuut4eOe+zc=;
        b=waxz9svGcvgIspB7fPxMU7DVF9aE3upinvUgDTaZTVoBG/t5R6vnPKU1gjbcoZ3j9m
         W1dfCNdJSur+7K1SBmkcUxQXJzTQPTaXXiyR94iZ5t+tLtjxNsiG0Wa1StFRzbOpYgMo
         yuY6TA1sAizXToKMNAgS8l5h71Z5lzZDetaJgQdptpqgHFbABLKBkfwrqLk14llIWX3H
         ZY96KhHevQ9WqNvDy4i2Nm2v9YmvqR8xsTUEMMOsk0cMCXewc+U+f+4YszmPctOxN5al
         hBwNlGC3DpmRZeuiSwHkS8G9gKrxWQ4aiia0dsR7CoWMFHElBtOOx70SgrMqnFw3z90y
         viFg==
X-Forwarded-Encrypted: i=1; AJvYcCUn25mjN/6LS4JJhXPia1ApFtCXsDs+T4ltI+ntPRy5fdRfg4y1dG14XWrNKQBM/Tkn2xOU3W9UDeufYBxR2SBL@vger.kernel.org
X-Gm-Message-State: AOJu0YxiTrfS8Uj4QEUHCRrN2OV12WeauCh18z9eZfKgV72YCFhCFbq/
	SceXpX1b4+ZAXZIOPJhXu+AEvEDdgdlar9RblCiuSbxfgDEpeAKmfTAR9y96ifqkJQnq8egfn4i
	gEFP7UIVr3A==
X-Google-Smtp-Source: AGHT+IEDl6CYdOfelioVOXfTIrSoiUL1OSIs7sE7g9Eq8q6AyGMXsJR8BWNPvmCABvB/SW2ng3GHNlkWh6pC
X-Received: from dlbsj7.prod.google.com ([2002:a05:7022:f907:b0:119:9f33:34a6])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:287:b0:292:dca8:c140
 with SMTP id d9443c01a7336-297c047a762mr14359775ad.44.1762472236927; Thu, 06
 Nov 2025 15:37:16 -0800 (PST)
Date: Thu,  6 Nov 2025 15:37:09 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251106233710.463949-1-irogers@google.com>
Subject: [PATCH v2 1/2] perf pmu: Make pmu_alias_terms weak again
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The terms for a json event should be weak so they don't override
command line options.

Before:
```
$ perf record -vv -c 1000 -e uops_issued.any -o /dev/null true 2>&1
|grep "{ sample_period, sample_freq }"
 { sample_period, sample_freq }   200003
 { sample_period, sample_freq }   2000003
 { sample_period, sample_freq }   1000
```

After:
```
$ perf record -vv -c 1000 -e uops_issued.any -o /dev/null true 2>&1
|grep "{ sample_period, sample_freq }"
 { sample_period, sample_freq }   1000
 { sample_period, sample_freq }   1000
 { sample_period, sample_freq }   1000
```

Fixes: 84bae3af20d0 ("perf pmu: Don't eagerly parse event terms")
Signed-off-by: Ian Rogers <irogers@google.com>
---
v2: Expand the commit message with an example (Namhyung).
---
 tools/perf/util/pmu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index d597263fab4f..f14f2a12d061 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -802,6 +802,7 @@ static int pmu_aliases_parse_eager(struct perf_pmu *pmu, int sysfs_fd)
 static int pmu_alias_terms(struct perf_pmu_alias *alias, struct list_head *terms)
 {
 	struct parse_events_terms alias_terms;
+	struct parse_events_term *term;
 	int ret;
 
 	parse_events_terms__init(&alias_terms);
@@ -812,6 +813,13 @@ static int pmu_alias_terms(struct perf_pmu_alias *alias, struct list_head *terms
 		parse_events_terms__exit(&alias_terms);
 		return ret;
 	}
+	list_for_each_entry(term, &alias_terms.terms, list) {
+		/*
+		 * Weak terms don't override command line options,
+		 * which we don't want for implicit terms in aliases.
+		 */
+		term->weak = true;
+	}
 	list_splice_init(&alias_terms.terms, terms);
 	parse_events_terms__exit(&alias_terms);
 	return 0;
-- 
2.51.2.1041.gc1ab5b90ca-goog

