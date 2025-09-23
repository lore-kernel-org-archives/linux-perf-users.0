Received: from mail-oa1-f73.google.com (mail-oa1-f73.google.com [209.85.160.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5ADB3128CD
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Sep 2025 22:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758666820; cv=none; b=ZRQMNIgHnnKUuxwt1nBupUZKvo9jGGhGXCTYOVv1CkLlbAVneT0A5h3O5OsRl1eLhEFjU7ZH2+J0mJc9QWezfoMullp/kt3ovnmRTga2J6fmp8QPDlxaTQ+VOAfkGW+rrhqDNdWfdzmeOo6s+Qx189vO1/WL77ZBghhCpvRN9cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758666820; c=relaxed/simple;
	bh=032C1jzLqg1fZhcoAFb+FaDYwGLmXHO7CCdHxbknGq8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jwBqAh3oZNYr3aHbXZVzUtAY+WRYt+exSK6yIJLYO9xM0Idfh8zJVx7Hp7AQQLFt0U+CBOhSQnY4joStdYm3MFFNtZ92+CUV0gMuYWC0j5wyCh03ZfIwuAzh5Db0pqtvKm4m1095f9nbG1gIedyNKNo1bUom6JJbo82pJ5tUYZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S/EN9Tqp; arc=none smtp.client-ip=209.85.160.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S/EN9Tqp"
Received: by mail-oa1-f73.google.com with SMTP id 586e51a60fabf-3524dfcf121so272782fac.0
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Sep 2025 15:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758666817; x=1759271617; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hwMO8Ta7bp1LibQmtclIAbrG9qBpwQ1+Kt3cBbb/T8s=;
        b=S/EN9TqpjNtYiBW3ORRAL4SD6ouPVWihXFeXt7A6up3s9g0kGTN39/a90ODF23VQRZ
         JBUXxt2611P0r/H7dDd7fZpm2H6KeLECtdm/pNFJtJP+6GP4/KW89/LW6Za7/0/7RmUx
         F3ZDEEFhiRdAsAAgkgHhmVn9TxNXVTRtG8Yd1mQKEXpe6l27qvvi5OaPagu0sqbvjC/e
         UW4lDPe96xXANU5UDu2CcJ/w5ohAcolJ1CuN6Ky+puD72bt0W6tg7HANSZtegdAErH7Y
         x62CLO//cd1tz9zL4hcYdLkncipdRHNPaLxhph+gJZnxN6iHzU3vwptsJjsDrWX+0aeo
         bGLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758666817; x=1759271617;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hwMO8Ta7bp1LibQmtclIAbrG9qBpwQ1+Kt3cBbb/T8s=;
        b=STtjJYMpcbIWx1Zd1m+UJXmmLe2s2xBia/Hluv0wnGfSb131jRBG7OarcJh/6TjuSM
         G5n9AAcl1XU/8Ce4BHXHLnCRyLPVT0j6S5ZrIlWnQwWb3MtuGUuow1Ub+4DA8dQs0kBH
         rxGb0P3i59RqaOmNKPik6b0Slnju5v0d5vzAfeNs4w1+IS7L+ytaEq92YTIm8oFwxpqp
         QFamohG6x1KeYM5ld56CbDQ7XD22L/4/QWP/lNdPpTCFkCC/TU6QMX9oBgNoafvIESz0
         BfM7+tlOZR6psBN4LFNgFpVd9jYzANRz0hmCCmevvwb0Zjx4DeCg2MxcN+X5vyQGXahk
         UlIA==
X-Forwarded-Encrypted: i=1; AJvYcCU7xQnLn2ZWHPiS8EEoTqibE6rDRHiCm0wVT+UYCw7gWSjMRTG9RguNRh11NiXyj0lOmfW46H5Q503220tdxPOH@vger.kernel.org
X-Gm-Message-State: AOJu0YxABwK2UFYGUqbCl9SeTo73gLgVFS7HxxKbibhfxJ+CDYluryli
	H+W8OSbpJhvKwqbVHSrJ5aOE+RDsXwz11hR1M3Y50aManqnzZ+fAA/+laEI2/fcGRX8L4yGYXsH
	C9aWJWaUH/A==
X-Google-Smtp-Source: AGHT+IFUkaxonbuSnKUDxlFH94XNe748/x+8o9XdhcVobBtzaq40h/9LEfVSbzPNzq2DKBRv9BbBiOfpcggf
X-Received: from oabqu3.prod.google.com ([2002:a05:6870:6e83:b0:2ef:de4a:375f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6871:a1e4:b0:331:15b8:802
 with SMTP id 586e51a60fabf-34c8478c793mr2650155fac.27.1758666817629; Tue, 23
 Sep 2025 15:33:37 -0700 (PDT)
Date: Tue, 23 Sep 2025 15:32:54 -0700
In-Reply-To: <20250923223312.238185-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250923223312.238185-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Message-ID: <20250923223312.238185-11-irogers@google.com>
Subject: [PATCH v6 10/28] perf pmu: Factor term parsing into a perf_event_attr
 into a helper
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Atish Patra <atishp@rivosinc.com>, 
	Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>, 
	Vince Weaver <vincent.weaver@maine.edu>
Cc: Thomas Richter <tmricht@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

Factor existing functionality in perf_pmu__name_from_config into a
helper that will be used in later patches.

Tested-by: Thomas Richter <tmricht@linux.ibm.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 818be59db2c6..36b880bf6bbf 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1763,6 +1763,24 @@ static int check_info_data(struct perf_pmu *pmu,
 	return 0;
 }
 
+static int perf_pmu__parse_terms_to_attr(struct perf_pmu *pmu, const char *terms_str,
+					 struct perf_event_attr *attr)
+{
+	struct parse_events_terms terms;
+	int ret;
+
+	parse_events_terms__init(&terms);
+	ret = parse_events_terms(&terms, terms_str);
+	if (ret) {
+		pr_debug("Failed to parse terms '%s': %d\n", terms_str, ret);
+		parse_events_terms__exit(&terms);
+		return ret;
+	}
+	ret = perf_pmu__config(pmu, attr, &terms, /*apply_hardcoded=*/true, /*err=*/NULL);
+	parse_events_terms__exit(&terms);
+	return ret;
+}
+
 /*
  * Find alias in the terms list and replace it with the terms
  * defined for the alias
@@ -2595,21 +2613,8 @@ const char *perf_pmu__name_from_config(struct perf_pmu *pmu, u64 config)
 	hashmap__for_each_entry(pmu->aliases, entry, bkt) {
 		struct perf_pmu_alias *event = entry->pvalue;
 		struct perf_event_attr attr = {.config = 0,};
-		struct parse_events_terms terms;
-		int ret;
+		int ret = perf_pmu__parse_terms_to_attr(pmu, event->terms, &attr);
 
-		parse_events_terms__init(&terms);
-		ret = parse_events_terms(&terms, event->terms);
-		if (ret) {
-			pr_debug("Failed to parse '%s' terms '%s': %d\n",
-				event->name, event->terms, ret);
-			parse_events_terms__exit(&terms);
-			continue;
-		}
-		ret = perf_pmu__config(pmu, &attr, &terms, /*apply_hardcoded=*/true,
-				       /*err=*/NULL);
-
-		parse_events_terms__exit(&terms);
 		if (ret == 0 && config == attr.config)
 			return event->name;
 	}
-- 
2.51.0.534.gc79095c0ca-goog

