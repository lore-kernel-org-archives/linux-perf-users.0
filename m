Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208F61F30BB
	for <linux-perf-users@vger.kernel.org>; Thu,  3 Apr 2025 20:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743711892; cv=none; b=At/9ZtOex5TFNQYpM2bdITOpPU8pzHw1+gT0dAhbn4NRPGMMgDdiKFr86+9SdfxXQFIHepcTV4WGQa7RMAcAvlm7eZM4yYve94msJ6V9bppYZ6UW6BXmwKDAvm2p84jHRSRUgK5u6VhSUZZCivvFoS4zGsbFWf01ZHfCUzuRKdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743711892; c=relaxed/simple;
	bh=HRxknASP9NJ4vjMn11MtRE7n7ZMTlVait7+eCV8bpfo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KJn+jSXNqMaOgLg1VrtNCVZ3YUjvLgYkJbvqTH/nOKo1ysRLNcWTB1OxSpbQPMPOlvdNAfb3letfkIRfhAsQKqDb9GaMT/ytRFuoVFUdEYO+B0GFnG1+jZSgbbWvnEsYjPNh1UvTt158y72H8ux9lRKjNbK41KB1E2Sb/XL4PrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IXG/B3ao; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IXG/B3ao"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-af8f28f85a7so894019a12.2
        for <linux-perf-users@vger.kernel.org>; Thu, 03 Apr 2025 13:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743711890; x=1744316690; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pil1LeiyQzc9Wfedi7qRLX2THzbN1bSqcXBycZBxx3E=;
        b=IXG/B3ao6mce32Y4EGcUT55zcg6iswx7YV3PtmbRV82sA2SKnawyivwF5U0brDTQv8
         Qeq6AIAQE3u66nCCIyH1j0ZfeX9r8+FrpMQVkjuo3fMcqQILIQhlhZ0xBDV4vvPxTz2r
         XR72pjCmrNXG8prdrwW4yx/Ist6VHkUCYSnHOL0qXySJWTgjRLPc7Irq4RMTmJs9hBgQ
         glUuCjhIpc7Tqv8wHf698j36V12nLFwMcnZQNlO7L0HRYXp8tGqfovN6SyyZ+XAtPYp6
         aBMnbQtijmxSc2lrMBMWOasCI/AMvT59e1DX0hc9sK8dc5IdMb4Jtn4oac+g4iqN8/iS
         ONXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743711890; x=1744316690;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pil1LeiyQzc9Wfedi7qRLX2THzbN1bSqcXBycZBxx3E=;
        b=Cytw3dM/HwxLMP3cO681ZKqzyS5F+aCknd68VjUYT1SiBCEU7MYXO9IZrloVfHncTP
         Cm5EvokKnm1qAJ61bpPoTjP6wp08BrmUwfE+P1KW6I+2FWz9Kn8LldrrectzNWKLQxTi
         eTIx4QwANUVcxFI/NKKIcX2TCXYOwdzMPIwB1fOhfuVLr8axFEI1YqciTmuj2yBG4/27
         SLvEDdZdI74npoRu4DICpJbcwuT0TOJy6Iz1xyHy7vj90jWAZ4ORjY7jNcWRJqpRuNnh
         gY+xoJfkMLLI50Ok/aGWunNDXWo1r/XZZnsstRT7omY+A5dz89HYeZDl8kZ7Q6+Yz7cT
         WtTg==
X-Forwarded-Encrypted: i=1; AJvYcCUzANtzuv8Q+x3ShcyG+xUjmHW7pseNfhxBqk0OyoaZOAP97IzeBWBfKPOkwWQvK0w4Em+J7RuEpWJ+kHBR8axV@vger.kernel.org
X-Gm-Message-State: AOJu0YyIgEtGVussic7IZT11bUWy1C5Pk9Cgw7eSRZhbg0hnnuicZiru
	pLTc2io0isazEB/m2wcLyiA5Pt7GX1hYMxy5ZT1pcu5ErJC4VDmPV85HcITzCklx5M5aSfvz+Qy
	PFYezqg==
X-Google-Smtp-Source: AGHT+IHECJgbaJYB5gyuhkerty/z5QcoT9YXQkYlH1mJyNC2bK+Z2YOQrOHG9csQbYSvdr6YjtqHqs0SwrVx
X-Received: from pjg12.prod.google.com ([2002:a17:90b:3f4c:b0:301:1bf5:2efc])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:51cc:b0:2fa:1e3e:9be5
 with SMTP id 98e67ed59e1d1-306a4757ff7mr1693465a91.0.1743711890504; Thu, 03
 Apr 2025 13:24:50 -0700 (PDT)
Date: Thu,  3 Apr 2025 13:24:36 -0700
In-Reply-To: <20250403202439.57791-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250403202439.57791-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250403202439.57791-2-irogers@google.com>
Subject: [PATCH v3 1/4] perf parse-events: Avoid scanning PMUs that can't
 contain events
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, James Clark <james.clark@linaro.org>, 
	Weilin Wang <weilin.wang@intel.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	Thomas Richter <tmricht@linux.ibm.com>, Junhao He <hejunhao3@huawei.com>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"

Add perf_pmus__scan_for_event that only reads sysfs for pmus that
could contain a given event.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c |  4 ++--
 tools/perf/util/pmus.c         | 35 ++++++++++++++++++++++++++++++++++
 tools/perf/util/pmus.h         |  1 +
 3 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 5152fd5a6ead..d77af1d24985 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -434,7 +434,7 @@ int parse_events_add_cache(struct list_head *list, int *idx, const char *name,
 	const char *config_name = get_config_name(parsed_terms);
 	const char *metric_id = get_config_metric_id(parsed_terms);
 
-	while ((pmu = perf_pmus__scan(pmu)) != NULL) {
+	while ((pmu = perf_pmus__scan_for_event(pmu, name)) != NULL) {
 		LIST_HEAD(config_terms);
 		struct perf_event_attr attr;
 		int ret;
@@ -1585,7 +1585,7 @@ int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
 
 	INIT_LIST_HEAD(list);
 
-	while ((pmu = perf_pmus__scan(pmu)) != NULL) {
+	while ((pmu = perf_pmus__scan_for_event(pmu, event_name)) != NULL) {
 		bool auto_merge_stats;
 
 		if (parse_events__filter_pmu(parse_state, pmu))
diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index b99292de7669..f2706c395509 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -350,6 +350,41 @@ struct perf_pmu *perf_pmus__scan_core(struct perf_pmu *pmu)
 	return NULL;
 }
 
+struct perf_pmu *perf_pmus__scan_for_event(struct perf_pmu *pmu, const char *event)
+{
+	bool use_core_pmus = !pmu || pmu->is_core;
+
+	if (!pmu) {
+		/* Hwmon filename values that aren't used. */
+		enum hwmon_type type;
+		int number;
+		/*
+		 * Core PMUs, other sysfs PMUs and tool PMU can take all event
+		 * types or aren't wother optimizing for.
+		 */
+		unsigned int to_read_pmus =  PERF_TOOL_PMU_TYPE_PE_CORE_MASK |
+			PERF_TOOL_PMU_TYPE_PE_OTHER_MASK |
+			PERF_TOOL_PMU_TYPE_TOOL_MASK;
+
+		/* Could the event be a hwmon event? */
+		if (parse_hwmon_filename(event, &type, &number, /*item=*/NULL, /*alarm=*/NULL))
+			to_read_pmus |= PERF_TOOL_PMU_TYPE_HWMON_MASK;
+
+		pmu_read_sysfs(to_read_pmus);
+		pmu = list_prepare_entry(pmu, &core_pmus, list);
+	}
+	if (use_core_pmus) {
+		list_for_each_entry_continue(pmu, &core_pmus, list)
+			return pmu;
+
+		pmu = NULL;
+		pmu = list_prepare_entry(pmu, &other_pmus, list);
+	}
+	list_for_each_entry_continue(pmu, &other_pmus, list)
+		return pmu;
+	return NULL;
+}
+
 static struct perf_pmu *perf_pmus__scan_skip_duplicates(struct perf_pmu *pmu)
 {
 	bool use_core_pmus = !pmu || pmu->is_core;
diff --git a/tools/perf/util/pmus.h b/tools/perf/util/pmus.h
index 8def20e615ad..213ee65306d6 100644
--- a/tools/perf/util/pmus.h
+++ b/tools/perf/util/pmus.h
@@ -19,6 +19,7 @@ struct perf_pmu *perf_pmus__find_by_type(unsigned int type);
 
 struct perf_pmu *perf_pmus__scan(struct perf_pmu *pmu);
 struct perf_pmu *perf_pmus__scan_core(struct perf_pmu *pmu);
+struct perf_pmu *perf_pmus__scan_for_event(struct perf_pmu *pmu, const char *event);
 
 const struct perf_pmu *perf_pmus__pmu_for_pmu_filter(const char *str);
 
-- 
2.49.0.504.g3bcea36a83-goog

