Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FB928CF50
	for <linux-perf-users@vger.kernel.org>; Sun,  5 Oct 2025 18:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759688696; cv=none; b=c/eh7lgT4XTEkDhFPb+LZby+QnFobzkdDV5qJ3YQt3UNqu9I8oo1PrQAgxe7wvNKEWukehrvagS/GqgECrP9jr45z/yntTI4fu+8ZlXJ96+7IKcbstKNx8GeZMfWjZ7o9TSVK0+K0lroZGIARhhbyXM3+THUG0Ns6p6/cbh0naM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759688696; c=relaxed/simple;
	bh=6p43zhgfxzOqfth9ihxTy+OAOu1uvEgAxqAGt//52mo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=B4EynEHriqUE480wdELhpoUnofn0XihApHNacZje4r7JKbmt7h1hTme8wzM6Xygb9H6GJsfgXeR/oysZjrB3m57uRuhZ6Udr4iRUw1Qx01WQKeqh7IPNu2jvSupVUmlHnp+Hm505u/Sokx8IATzqqJzFhIBhjNMSesrXVgtR/8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pJ4nOr6j; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pJ4nOr6j"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-27ee214108cso92226355ad.0
        for <linux-perf-users@vger.kernel.org>; Sun, 05 Oct 2025 11:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759688694; x=1760293494; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UK+9vKYDI5SO95JZJfkR0FuzR6EHsxaM13pctEfDrUM=;
        b=pJ4nOr6j6wXa9YC4owfswi3NkR5iDXJ1Kp82bDtTlLatvgr+viLkQ/jjGOP9WuQe6T
         BOF4uZ9D+bR/UnergMQiCRHR3/5HqfuC7OWTz75bVT1mvDuATSti3VgsRO030TbcPk3M
         7R/s/+5COpBFsFaY7pFgAsPMjz/uq/ZI82YzLrO45w6FB74uPy0GzgGbz5mf3YUBdyiZ
         NOL+cPlr82KBfrWi2q36vyEzu9lwvawl3Sy1qT517Bhm1vT6lppPhdon4lWK0DhntqAM
         1MHMRXd2a6OwJnyy0JBAZtpQ+lvHYIWCVNpPUjoT5S2/GUG5fdD76azAUl3vfd6SKyoy
         tZqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759688694; x=1760293494;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UK+9vKYDI5SO95JZJfkR0FuzR6EHsxaM13pctEfDrUM=;
        b=tzehAdPjtrijqlST6931QgSwNCRuwaSxFAUPn5z9nVNTIsxLHi7fA1yTSN3SiNsvSq
         MAdsW0UXtErWkOkdYZNTydxggjRYdEU+A6n964+MySd4QRaSblq5Du0Ow82q8Mm6PVj6
         T6hXMmTqBnqhydRhMsTewVoQt0nbFl42CQ0lkfpwALdNCXI5Z36FkRg8TurDgPm0KXz3
         alope81U8B3zdDfw2/wmyX+64a/wzdYCEKM6xus40AacsIdNiP9BO3HZsUYFQ5N7ERTY
         L67FaUFLSRmKpR5j7e7bqxTZsJ5NMBIbH+u7pl06GsP/MvaAMcmuE3NnfVkG1h/9SfRP
         rHqA==
X-Forwarded-Encrypted: i=1; AJvYcCUN5c+h2ZR/ePL2CMLN2as18ceRZDaHKqqHvKeApsLV9tgz1eQ+pZUdvKr8aoMtXuH1R5YKp6R9RnJ2INYgpqg2@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6VGlaQ2StKSzEYVkE9s4GwQMvv3/RE93KeLQRA/gQVkDgSrsK
	f5pitBmQtKPuK3rSdjCBtfkb1pzH1Ajpm5FXkZf5KvSA0RWqcjWCvos46uoMVaIlbDowV4fwglw
	noDJuRxkxHQ==
X-Google-Smtp-Source: AGHT+IFi+hH2WneunbqqhaE8Ef1ChJUxSeOfMr0ECoCsbafDNVNagVd87dwIdieJ8xXqAMa60zcvqumJrM3I
X-Received: from plsp10.prod.google.com ([2002:a17:902:bd0a:b0:267:a5c9:8a4c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3807:b0:28d:18d3:46ca
 with SMTP id d9443c01a7336-28e9a6be420mr122481015ad.49.1759688694620; Sun, 05
 Oct 2025 11:24:54 -0700 (PDT)
Date: Sun,  5 Oct 2025 11:24:12 -0700
In-Reply-To: <20251005182430.2791371-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251005182430.2791371-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251005182430.2791371-10-irogers@google.com>
Subject: [PATCH v7 09/27] perf pmu: Factor term parsing into a perf_event_attr
 into a helper
From: Ian Rogers <irogers@google.com>
To: James Clark <james.clark@linaro.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Xu Yang <xu.yang_2@nxp.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Atish Patra <atishp@rivosinc.com>, Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>, 
	Vince Weaver <vincent.weaver@maine.edu>
Cc: Ian Rogers <irogers@google.com>, Thomas Richter <tmricht@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

Factor existing functionality in perf_pmu__name_from_config into a
helper that will be used in later patches.

Tested-by: Thomas Richter <tmricht@linux.ibm.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 7992bd923515..2c3e539851c4 100644
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
@@ -2596,21 +2614,8 @@ const char *perf_pmu__name_from_config(struct perf_pmu *pmu, u64 config)
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
2.51.0.618.g983fd99d29-goog

