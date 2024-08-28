Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0FC18786F
	for <linux-perf-users@vger.kernel.org>; Wed, 28 Aug 2024 14:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724854162; cv=none; b=abTurlmc8vT31khMCpI0w60GQfDwpTkGJzxY9FqjwuBWGSc+ariSOZIUtg75P2mHsvrixauwLxG/OKgOnJ4X5GR2f9JD2nChjSoUIHEL1c3G6pDTkoIWHq+Jy23wYqAFI3S6W9Y8vu0JVVGM9rGolRFKHaL8VW1BqOm73Ik9x9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724854162; c=relaxed/simple;
	bh=svDylw00YDrOwEUlgnNGbWMFv5+C8tkXtzLrWQTqGS8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tkwxuOds9uykq8nWC6n53VJNnb1A71wgd+T0j+/f0Uka8kx+04CFoVf4NUV3fFOfJMDjkzxAkeowSMY7CEMVP/pEwOLFGKdnX8GoE2V2jL5kuNGKWHRs/KyVW/XNax7n4XSuBmQxKJppzrRxE09oRqXrf818CS8OBUaTpu9j3sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=edASUSrd; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="edASUSrd"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5befd2f35bfso7343523a12.2
        for <linux-perf-users@vger.kernel.org>; Wed, 28 Aug 2024 07:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724854159; x=1725458959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jt6m2cvFLahBiVh7r4fU/dK5iwEboYmsnljQ5bVAR6o=;
        b=edASUSrd4cK9z7RjRa53kv4XsNfhyubuKycpdzSDT1idwoy547PmkfET+xom/G/lkn
         gHfCIjuTLEBjH5jgrJpm5OE9YindjxdBGiYLJLBNE/QqqsesswzQgWZiKKiwnRlOwgv1
         A6IdbC4aivL/HrGgFfE5nwQFAkMwy0weWzkC4rvRJiO6v0+gxzz8gXH2G60sBvZZooLU
         mMK8PZrUIj+D3rIkw27O/fay6FC/NUeeO9d34zD9BTP08HUbAyJlF2sStuW5bwgcu8Tk
         fmfrKlFIXsn8a9A+zi7Fn4cMkCPUqMiyDwrh0BbwW1wK+M71SIMOfErXZzlKqIn5Wq+V
         pS0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724854159; x=1725458959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jt6m2cvFLahBiVh7r4fU/dK5iwEboYmsnljQ5bVAR6o=;
        b=r7S1Kh32Atv0sLML7YWbGJTrW/kopxMeah+ouKMF1oU76hqR3fYfyZ7Wa7cLP3SlDP
         2KbB0beop9XovJ/GB7CxlS3HOSy2DvxxvJrS0BG7gszBsCCdYNYrlAutsxEfRAej5Ou/
         3wkUJVdvKJi0zatjh/sP79LYDLq+ahavEoLF51KepHglnB7fkCq1bw2Hbz4d4kY2eC0A
         Qd4Zc7UKWzjl07Npz7kq8nhUVFLEOMhC3el3TzY/2VBeqpSBbSQ/nwpo9HGuoKlLm9SK
         pML24gkfYTrEXUuX9g6N9QpApgd+Qk5ZOT1y5f+W6IzEZqyKtbeFDEvljpXNAQy66wOy
         5Npw==
X-Forwarded-Encrypted: i=1; AJvYcCX5D7QDe0sNZdHLO/AmyazjA2eQXt1auafdoXriuMOBcHrnSx3GvjyATbIscklx9pRdCsD8kLT76duAv5TVI42S@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+qfUKJJLnerv//4OzRtzmojheOjUpvSUaRcnygFI/6h0OtXlQ
	dxJKp1g+V2/tRqryOMNEOC1NH5whByflIBSvMfuAWkzZ/mKn8O7tJUSgA3m1oRs=
X-Google-Smtp-Source: AGHT+IEDIEQ2Rb6mMuhZRhKlOmgcL5qvZ0lVR3CiSqYPIS/pHPTSXlf0WK3OQbxqv7ZdpffIHJZv0w==
X-Received: by 2002:a17:907:e283:b0:a86:9776:ef40 with SMTP id a640c23a62f3a-a86a52c160fmr1200932366b.36.1724854158564;
        Wed, 28 Aug 2024 07:09:18 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e5832855sm251302666b.130.2024.08.28.07.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 07:09:17 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
To: irogers@google.com,
	linux-perf-users@vger.kernel.org,
	kan.liang@linux.intel.com,
	ak@linux.intel.com
Cc: James Clark <james.clark@linaro.org>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@linaro.org>,
	Leo Yan <leo.yan@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Yang Jihong <yangjihong@bytedance.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Ze Gao <zegao2021@gmail.com>,
	Sun Haiyong <sunhaiyong@loongson.cn>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 5/7] perf evsel: Remove pmu_name
Date: Wed, 28 Aug 2024 15:07:19 +0100
Message-Id: <20240828140736.156703-6-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240828140736.156703-1-james.clark@linaro.org>
References: <20240828140736.156703-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ian Rogers <irogers@google.com>

"evsel->pmu_name" is only ever assigned a strdup of "pmu->name", a
strdup of "evsel->pmu_name" or NULL. As such, prefer to use
"pmu->name" directly and even to directly compare PMUs than PMU
names. For safety, add some additional NULL tests.

Signed-off-by: Ian Rogers <irogers@google.com>
[ Fix arm-spe.c usage of pmu_name ]
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/arch/arm64/util/arm-spe.c |  4 ++--
 tools/perf/arch/x86/util/evsel.c     |  4 ++--
 tools/perf/tests/parse-events.c      |  2 +-
 tools/perf/util/evlist.c             |  3 ++-
 tools/perf/util/evsel.c              |  7 -------
 tools/perf/util/evsel.h              |  3 +--
 tools/perf/util/metricgroup.c        |  4 ++--
 tools/perf/util/parse-events.c       |  1 -
 tools/perf/util/stat-shadow.c        | 10 +++++-----
 tools/perf/util/stat.c               |  2 +-
 10 files changed, 16 insertions(+), 24 deletions(-)

diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
index d59f6ca499f2..81dcfeccdaf8 100644
--- a/tools/perf/arch/arm64/util/arm-spe.c
+++ b/tools/perf/arch/arm64/util/arm-spe.c
@@ -188,9 +188,9 @@ static int arm_spe_recording_options(struct auxtrace_record *itr,
 
 	evlist__for_each_entry(evlist, evsel) {
 		if (evsel__is_aux_event(evsel)) {
-			if (!strstarts(evsel->pmu_name, ARM_SPE_PMU_NAME)) {
+			if (!strstarts(evsel->pmu->name, ARM_SPE_PMU_NAME)) {
 				pr_err("Found unexpected auxtrace event: %s\n",
-				       evsel->pmu_name);
+				       evsel->pmu->name);
 				return -EINVAL;
 			}
 			opts->full_auxtrace = true;
diff --git a/tools/perf/arch/x86/util/evsel.c b/tools/perf/arch/x86/util/evsel.c
index 1eaae8819c5e..fe8a817d2061 100644
--- a/tools/perf/arch/x86/util/evsel.c
+++ b/tools/perf/arch/x86/util/evsel.c
@@ -84,7 +84,7 @@ int arch_evsel__hw_name(struct evsel *evsel, char *bf, size_t size)
 		return  scnprintf(bf, size, "%s", event_name);
 
 	return scnprintf(bf, size, "%s/%s/",
-			 evsel->pmu_name ? evsel->pmu_name : "cpu",
+			 evsel->pmu ? evsel->pmu->name : "cpu",
 			 event_name);
 }
 
@@ -129,7 +129,7 @@ int arch_evsel__open_strerror(struct evsel *evsel, char *msg, size_t size)
 		return 0;
 
 	if (!evsel->core.attr.precise_ip &&
-	    !(evsel->pmu_name && !strncmp(evsel->pmu_name, "ibs", 3)))
+	    !(evsel->pmu && !strncmp(evsel->pmu->name, "ibs", 3)))
 		return 0;
 
 	/* More verbose IBS errors. */
diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index edc2adcf1bae..c38fa4e16670 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -730,7 +730,7 @@ static int test__checkevent_pmu_events(struct evlist *evlist)
 
 	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type ||
-				      strcmp(evsel->pmu_name, "cpu"));
+				      strcmp(evsel->pmu->name, "cpu"));
 	TEST_ASSERT_VAL("wrong exclude_user",
 			!evsel->core.attr.exclude_user);
 	TEST_ASSERT_VAL("wrong exclude_kernel",
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index a941f46c958d..fff7fd4ae785 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -2576,7 +2576,8 @@ void evlist__uniquify_name(struct evlist *evlist)
 		else
 			attributes = empty_attributes;
 
-		if (asprintf(&new_name, "%s/%s/%s", pos->pmu_name, pos->name, attributes + 1)) {
+		if (asprintf(&new_name, "%s/%s/%s", pos->pmu ? "" : pos->pmu->name,
+			     pos->name, attributes + 1)) {
 			free(pos->name);
 			pos->name = new_name;
 		} else {
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 2928c1f76dad..082159fb2091 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -296,7 +296,6 @@ void evsel__init(struct evsel *evsel,
 	evsel->metric_events = NULL;
 	evsel->per_pkg_mask  = NULL;
 	evsel->collect_stat  = false;
-	evsel->pmu_name      = NULL;
 	evsel->group_pmu_name = NULL;
 	evsel->skippable     = false;
 	evsel->alternate_hw_config = PERF_COUNT_HW_MAX;
@@ -394,11 +393,6 @@ struct evsel *evsel__clone(struct evsel *orig)
 		if (evsel->group_name == NULL)
 			goto out_err;
 	}
-	if (orig->pmu_name) {
-		evsel->pmu_name = strdup(orig->pmu_name);
-		if (evsel->pmu_name == NULL)
-			goto out_err;
-	}
 	if (orig->group_pmu_name) {
 		evsel->group_pmu_name = strdup(orig->group_pmu_name);
 		if (evsel->group_pmu_name == NULL)
@@ -1497,7 +1491,6 @@ void evsel__exit(struct evsel *evsel)
 	zfree(&evsel->group_name);
 	zfree(&evsel->name);
 	zfree(&evsel->filter);
-	zfree(&evsel->pmu_name);
 	zfree(&evsel->group_pmu_name);
 	zfree(&evsel->unit);
 	zfree(&evsel->metric_id);
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 430441fdfbbc..936aafb046b6 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -72,7 +72,6 @@ struct evsel {
 	struct {
 		char			*name;
 		char			*group_name;
-		const char		*pmu_name;
 		const char		*group_pmu_name;
 #ifdef HAVE_LIBTRACEEVENT
 		struct tep_event	*tp_format;
@@ -184,7 +183,7 @@ struct evsel {
 	unsigned long		open_flags;
 	int			precise_ip_original;
 
-	/* for missing_features */
+	/* The PMU the event is from. Used for missing_features, PMU name, etc. */
 	struct perf_pmu		*pmu;
 
 	/* For tool events */
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 69f6a46402c3..bbbb2e7eb8db 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -297,8 +297,8 @@ static int setup_metric_events(const char *pmu, struct hashmap *ids,
 		struct expr_id_data *val_ptr;
 
 		/* Don't match events for the wrong hybrid PMU. */
-		if (!all_pmus && ev->pmu_name && evsel__is_hybrid(ev) &&
-		    strcmp(ev->pmu_name, pmu))
+		if (!all_pmus && ev->pmu && evsel__is_hybrid(ev) &&
+		    strcmp(ev->pmu->name, pmu))
 			continue;
 		/*
 		 * Check for duplicate events with the same name. For
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index d1355e492df3..fa37567e0323 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -262,7 +262,6 @@ __add_event(struct list_head *list, int *idx,
 	evsel->core.is_pmu_core = pmu ? pmu->is_core : false;
 	evsel->auto_merge_stats = auto_merge_stats;
 	evsel->pmu = pmu;
-	evsel->pmu_name = pmu ? strdup(pmu->name) : NULL;
 	evsel->alternate_hw_config = alternate_hw_config;
 
 	if (name)
diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 5548f751e56e..72275806e6e2 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -573,7 +573,7 @@ static void perf_stat__print_metricgroup_header(struct perf_stat_config *config,
 {
 	bool need_full_name = perf_pmus__num_core_pmus() > 1;
 	static const char *last_name;
-	static const char *last_pmu;
+	static const struct perf_pmu *last_pmu;
 	char full_name[64];
 
 	/*
@@ -584,21 +584,21 @@ static void perf_stat__print_metricgroup_header(struct perf_stat_config *config,
 	 * different metric events.
 	 */
 	if (last_name && !strcmp(last_name, name)) {
-		if (!need_full_name || !strcmp(last_pmu, evsel->pmu_name)) {
+		if (!need_full_name || last_pmu != evsel->pmu) {
 			out->print_metricgroup_header(config, ctxp, NULL);
 			return;
 		}
 	}
 
-	if (need_full_name)
-		scnprintf(full_name, sizeof(full_name), "%s (%s)", name, evsel->pmu_name);
+	if (need_full_name && evsel->pmu)
+		scnprintf(full_name, sizeof(full_name), "%s (%s)", name, evsel->pmu->name);
 	else
 		scnprintf(full_name, sizeof(full_name), "%s", name);
 
 	out->print_metricgroup_header(config, ctxp, full_name);
 
 	last_name = name;
-	last_pmu = evsel->pmu_name;
+	last_pmu = evsel->pmu;
 }
 
 /**
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 0bd5467389e4..7c2ccdcc3fdb 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -553,7 +553,7 @@ static bool evsel__is_alias(struct evsel *evsel_a, struct evsel *evsel_b)
 	if (evsel__is_clock(evsel_a) != evsel__is_clock(evsel_b))
 		return false;
 
-	return !!strcmp(evsel_a->pmu_name, evsel_b->pmu_name);
+	return evsel_a->pmu != evsel_b->pmu;
 }
 
 static void evsel__merge_aliases(struct evsel *evsel)
-- 
2.34.1

