Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A18167DB7
	for <linux-perf-users@vger.kernel.org>; Wed, 26 Mar 2025 03:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742961070; cv=none; b=ETDA/Yg3h+76DIx+d8p9jCW0WIGhItPJ6k2x4zK5sATvVdVwM0ghFkdfNcfj03uJHmSdVZ1rvqbYc8HEKj8YMYpfgV2yy0JsFD54aqjuRmQQ9CIXjsV3PezRspNUeuB0qvhYdO0yLo4gCM9DSS4yG8SA7n2vZeaDP7pJ/pUHVa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742961070; c=relaxed/simple;
	bh=3jxraLjE69gnQLWEysFoeBUKLHVIso6rk3eWNHc+GA4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NdxkbSj/9ClGpVA5jvnTF2l778xLG7MLqDLkSX/ahcuDy/mV5ekQkD4qfRv+Pz+fQ6RLBXamR0YbgevjIlkAaZif+8goWhRzcsE3HsN8ZZ/YFLYOteNDzVKbDMSEmtyoOPYWTf7CPfqdF0eQcbVRBrajKpmce5PaWlbZZGWtS2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4sCmJBYS; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4sCmJBYS"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-22651aca434so108130515ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 25 Mar 2025 20:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742961068; x=1743565868; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uCVS+DhgJOLHYroH5VuWGGnd2W5CTNd7YHsjO54Adcw=;
        b=4sCmJBYSBM9f8ses29SkX7L/YfCuEuYdJ9qk/wiqtMwQK/+ZGKA8RSKhf1k42btH4U
         pW+lahVBnT1QCi3Q0fHi5l3sUO/a0oF18pkSOp2Ww9VicfoAbH82GQo+7apVDBMueQZU
         tO5v2PupokHp/tdribX6mXMRN4GbZge+kb21yUNdEpBPmzzCaFeqV6Y3zggammponV49
         BigkFNd4ovyRxOsBxBKL35TCW/mHEyo2XNO33hh5/txzk+9ThVlxYgk3k+c4jNjfTatI
         5LxK6SDJLML9Mg1HOmmJWBu3a9NKskSJuNsZU6RTJqOb8pFblb5LwDrHolX7Wi5OHrNW
         iT8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742961068; x=1743565868;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uCVS+DhgJOLHYroH5VuWGGnd2W5CTNd7YHsjO54Adcw=;
        b=PhYc9LM1wFZ6w9SnIqECkh9c9VxmTA01F23cDPi+rk0w/A83SFPiTT01OQRK4ysbY6
         jwhIcX6CD2QboXBOeKhIvlql0Dglbrc5Mk3CPxFkHTCUfXO8YEx4UpfolXStVfBvJc+9
         VdC8ntQnK3rfZmqcvQ76TJFjmw6J6ToddV5mxFic5pZxaFWR96mLE9d1vUvV7u0pclp5
         1wvCV7yoLQr5qiV1xzxeZCIj5U3hLHH6VrmVH/d7LRT5tpchIksbuGDAl+2nAU/lMQXP
         ASNmbcRWQ3D93BxjIR0HDU59UKabOFURi7G+/0mXIkFMC5UTKqm5f837FueTNYaSfpKQ
         Grgw==
X-Forwarded-Encrypted: i=1; AJvYcCUnSvNnnNhr6UJVCJ7LCTl0J5fsIUYtZslw7gk3/9dsB+xRahDIVD1FlbmF1njcKTUaIp4u5IB/MhzxiqGvItJb@vger.kernel.org
X-Gm-Message-State: AOJu0YxVRSNnTaO533pyKT96gABr6OITTmCpM1FBs1KakaPEr69ODsyz
	SfMQ3c5oMDylRQRsBmsG/gdhNgEMlrlGUr++XLKoeaKZhRo+Ef9cDGYnpd2dVYdtxrEypajoTff
	KUnWI1g==
X-Google-Smtp-Source: AGHT+IFVfYoE7t8L3UJr15qQGlHKncIQsy7nPhLY5dK19DZs1BWjoNZ2pWij3AjrrsHCyI9ogBO2Nzy6GO4k
X-Received: from pfiy3.prod.google.com ([2002:a05:6a00:1903:b0:736:8727:67fd])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:80e:b0:736:6279:ca25
 with SMTP id d2e1a72fcca58-73905a27ae5mr34688941b3a.24.1742961067760; Tue, 25
 Mar 2025 20:51:07 -0700 (PDT)
Date: Tue, 25 Mar 2025 20:50:42 -0700
In-Reply-To: <20250326035045.129440-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250326035045.129440-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250326035045.129440-2-irogers@google.com>
Subject: [PATCH v2 1/4] perf parse-events: Avoid scanning PMUs that can't
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
2.49.0.395.g12beb8f557-goog

