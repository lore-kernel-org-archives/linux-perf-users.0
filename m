Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF0B2877ED
	for <linux-perf-users@vger.kernel.org>; Thu, 28 Aug 2025 06:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756363370; cv=none; b=tTnUsmAo1I2CUwnPuZ9APHpYzX1odEvkYtZiIdY59vuAip5APx5uZ8GbD8CmILYKCTkUmS4/vK1BTv7zyvs7/9fXeL7KBfTRaRwVdiDa9LiJSj2MaUSu2KpimIKP/ribOsrPwL2erM1E1hfnEeiqlTK64u7uDPI1Xm+FM8/XxW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756363370; c=relaxed/simple;
	bh=5koWobhFKzB/i1OAVyIFe0t++WfN/R7tTbQmx48qFnM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=EbOPshKVTEjhfQkYznqzg7CpAfoLEFQAUw/pXI4CvRwUge6RgwbQQmQgHypjO0QAhwPJgdDpccF2aW750CQmthDBlCuzPUWsnJQzqg84jVa4aiQ8+7XC8GrVvaTH6pEAaAa8et1dOqtCy0cUx/cFUfrKtcOtWB2lgbPn/WWGdqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b/ybYm5a; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b/ybYm5a"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-327b00af618so379233a91.1
        for <linux-perf-users@vger.kernel.org>; Wed, 27 Aug 2025 23:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756363368; x=1756968168; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QSMhtCRMX1JJ8a2M6HYUBkzFAQBtsVFer7zAsyKI4O4=;
        b=b/ybYm5aM71jXGL8iGZxxyOW46CEtTBzcTVWCvOSiz88EHQUvZKbkttTnIWoLVxvMI
         0uED7fYObzIdpzrllCaKO2qNILxz7Pd/lWq9FD10NDlAUPol5+ie1/NOmatqcX4Ip+nA
         I/4wftJy9IbsceYuI3D7Wxm+VgR/F+fIx9+hnbR97H0imAcIe9eyJTHsPIQLjJIq7ieJ
         l1WieAerk2rHbvKQHWKbrEGOsv2ZeLdsNAwFW3oHVbrq+wAz/kzCi7uA64wqbuOgEEsb
         hC/L8/e85KWKTEaUxAZJPMIaHdoeNzjhHQUqNmaJoNBQD7SWUjSievZD7LB6FsH18/4U
         sLWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756363368; x=1756968168;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QSMhtCRMX1JJ8a2M6HYUBkzFAQBtsVFer7zAsyKI4O4=;
        b=czL2VPfayOLEn4MbhOStNgNyjlQU+kuCXtZ1vmygMyXtmifFKVj/2YgpltlOmEs8Vj
         BNHaP0JHV9QClLNt+8JlrlCezIG8eVtpC1UJm+wOB+7yA2PSwof9ki//WNNvNe67Sr6r
         Jl4jrkumL9X1kvdxVZy5hEIl0r5Bvy1JTCRGNvwwD9K9XgLGjOOFFWp0hzqPTLZabQma
         2UyJ5UPEtWOm8+hm89qhTYFFRhs6lU9h2KcMOknuZ7p77p2LTRu7J7NU86YyZDzDM0hr
         qfDlx1XrBy2sGTT3MG3vkMwC0qq1aXyU9os1izPiyCe5cFPWsO+LAjNeDfRoAk0bQR2N
         Pviw==
X-Forwarded-Encrypted: i=1; AJvYcCWZk9SCPAIx6TM9k97aYC2qfFzhc859wGGc5V/Fz9Y0fgRE28VI0ieBTUMTGOgCisIbyVUd1tLiBNE4cDYX5JPc@vger.kernel.org
X-Gm-Message-State: AOJu0YxzIkn3s8Yse+cdOuBoHqQjEKVzUB++bztWErl8ij5BoSIqQ4mP
	Un/Y+KVotw2GJRIf2TKyLdnD4OPXbPQlVgBMOFGE5J1dnF0+nAUgL/At4jsJZ3pHkLi6uoSxTbD
	ZVtseC9peAw==
X-Google-Smtp-Source: AGHT+IH8HcjjRK1HgbbucgHYh74YcyS5gY/Fw9YglOPLN7eSqnlPft8E6lWMp2zvZmV4LCuilyL+qsWiUvLz
X-Received: from pjbsv14.prod.google.com ([2002:a17:90b:538e:b0:321:c23e:5e41])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4b4e:b0:327:734a:ae8f
 with SMTP id 98e67ed59e1d1-327734ab092mr6455393a91.12.1756363367923; Wed, 27
 Aug 2025 23:42:47 -0700 (PDT)
Date: Wed, 27 Aug 2025 23:42:24 -0700
In-Reply-To: <20250828064231.1762997-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250828064231.1762997-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.268.g9569e192d0-goog
Message-ID: <20250828064231.1762997-7-irogers@google.com>
Subject: [PATCH v1 06/13] perf pmu: Factor term parsing into a perf_event_attr
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
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, 
	Atish Patra <atishp@rivosinc.com>, Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>
Content-Type: text/plain; charset="UTF-8"

Factor existing functionality in perf_pmu__name_from_config into a
helper that will be used in later patches.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index ddcd4918832d..e590de26a7f5 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1766,6 +1766,24 @@ static int check_info_data(struct perf_pmu *pmu,
 	return 0;
 }
 
+static int perf_pmu__parse_terms_to_attr(struct perf_pmu *pmu, const char *terms_str,
+					 struct perf_event_attr *attr)
+{
+	struct parse_events_terms terms;
+	int ret;
+
+	parse_events_terms__init(&terms);
+	ret = parse_events_terms(&terms, terms_str, /*input=*/NULL);
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
@@ -2598,21 +2616,8 @@ const char *perf_pmu__name_from_config(struct perf_pmu *pmu, u64 config)
 	hashmap__for_each_entry(pmu->aliases, entry, bkt) {
 		struct perf_pmu_alias *event = entry->pvalue;
 		struct perf_event_attr attr = {.config = 0,};
-		struct parse_events_terms terms;
-		int ret;
+		int ret = perf_pmu__parse_terms_to_attr(pmu, event->terms, &attr);
 
-		parse_events_terms__init(&terms);
-		ret = parse_events_terms(&terms, event->terms, /*input=*/NULL);
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
2.51.0.268.g9569e192d0-goog

