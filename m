Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F31B1527A7
	for <linux-perf-users@vger.kernel.org>; Fri, 10 May 2024 05:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715319498; cv=none; b=b0UcKISdM6rZzywrHWHz9D5Uh5Mfx0A/bu0jCDfZpXxWRI9y1CL2OOxrrpnk8Aos5r1sRLDEwTjRrjf7TIFTYGAYB6dv0OhbEFzB6Ef2+3hVkJUgVyIEIYpllZMNgxn79ScJPoaggRw2QKxM+RSn3wQy1JivUFw+krkzH7X60DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715319498; c=relaxed/simple;
	bh=pQ/ykMTJPVdVXsWcWvxI9IBewGKlSl0x/rod7UQD6Fo=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=iEFjE6eW83U/G38jpMq0hlIqdclsNmKII9in2vhBZEVUXvBhlCBnqaIQ4e5qSKgwSRt5dCxUD5XSNZAxiMMcIJ1G9lMFqQy6i6UJ9OWGGc6Lt3LtRb6Am8YMSMpMYzq5WEyMfbhOhHGfwikdDi+5T8qdo1J4SuJ5QqDfgsbYygU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ojo9ixwN; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ojo9ixwN"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b26845cdso2294350276.3
        for <linux-perf-users@vger.kernel.org>; Thu, 09 May 2024 22:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715319495; x=1715924295; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DWRbHF2FL8sVbDNcBMzaCLG3938X5gekbCQ/hc2HZYQ=;
        b=Ojo9ixwNFyBnXHQIT9XIf7XkJuPpTf3Xu3/QOwcEHwIGChjsfGvwrTJN59z+SmspKf
         PgzqxBYd4Y8M0aKJjuLhOV8AucwfTy47Ia48KNFjnhCSSOF7PTljBgeFBD4KwPb4gcDe
         peBKaM+TaHA1Taz6LQi6tbTzIZFmXnvMWYNlzWjh7iMOlh9VUDB7lqG2gcuREsjCx3SJ
         rrwr4k3o+1fTMQye3yxUfupvuwRLdB/BFrXlNNQt1miYd272N4GpjkcT7pLmMwuHXPA8
         zLCgKZDA94xlyCv1LAtMFIwBQf/sX/q/spb6JKUIhDfCSz8EzMMQvkqhl33BO55JzdMW
         FkJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715319495; x=1715924295;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DWRbHF2FL8sVbDNcBMzaCLG3938X5gekbCQ/hc2HZYQ=;
        b=YqzCNmD1Y/D+Lsf2ln1AWC98vu+Uj4Bk6jGg7nH8uWE439sAXc1LDZB1Wu/u8fq3it
         PGTmu7Pb5DWR3+Q6bpi8XqI3iDXp5ZZtRumTP5ImxLWEHh74WSksH5E3Uo11IbQVuf/7
         s84Ut6N9HEN0BJBCVIE3FjdKk06XHZUjJ1CFMTeSXobh6C82sM4Jq3en+AMvXSaBHPO1
         1pHmNVNtJ/BVxqNZwxTPhTxjv1ycS/6bswWbbKJSYmdIab16Wn7ZlblP54OkI6kx1BbP
         AYhD20w5Bi4HTTM6P003t8SKo2lU4HpLmn4votX/MKVvS3fIcaYz1bZ3ZIT15sxC/wJn
         uDxA==
X-Forwarded-Encrypted: i=1; AJvYcCUDnUAjNNgOa5knoOalpWLPpRDapB2y/WXsOAhPQ0nPX3wtTS+oernP7RDPfqGN3cCUJgUVg63bwz919J6VYSEGwR5DlAtJsNKOmt8iwBrXKA==
X-Gm-Message-State: AOJu0YyAndoEcEnyvZIBmpjd9bIhRGN2w2P/6KofK9NJ/gUgFEcbaRdr
	3YG7DJ43DeQ8a25Ufle0+NICvs0ryLmhRxoALFW0M4riQnaM4bDF6u4weCkRE+nOgs46S32dQlc
	ESZYXHg==
X-Google-Smtp-Source: AGHT+IFeUmjBzCgQiTLgDbTRXxGnHHjpPKJPlbHrSS5XJyvbba6JPHgKv0issznoGEKCJQgRGkXbxkPmB+cv
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:79ed:c375:51e3:ed39])
 (user=irogers job=sendgmr) by 2002:a05:6902:728:b0:de5:319b:a226 with SMTP id
 3f1490d57ef6-dee4f2c3b29mr452416276.1.1715319495565; Thu, 09 May 2024
 22:38:15 -0700 (PDT)
Date: Thu,  9 May 2024 22:37:05 -0700
In-Reply-To: <20240510053705.2462258-1-irogers@google.com>
Message-Id: <20240510053705.2462258-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510053705.2462258-1-irogers@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Subject: [PATCH v3 5/5] perf evsel: Remove pmu_name
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	James Clark <james.clark@arm.com>, Yang Jihong <yangjihong@bytedance.com>, 
	Ze Gao <zegao2021@gmail.com>, Leo Yan <leo.yan@linux.dev>, Song Liu <song@kernel.org>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Kaige Ye <ye@kaige.org>, 
	Yicong Yang <yangyicong@hisilicon.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

"evsel->pmu_name" is only ever assigned a strdup of "pmu->name", a
strdup of "evsel->pmu_name" or NULL. As such, prefer to use
"pmu->name" directly and even to directly compare PMUs than PMU
names. For safety, add some additional NULL tests.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/x86/util/evsel.c |  4 ++--
 tools/perf/tests/parse-events.c  |  2 +-
 tools/perf/util/evlist.c         |  3 ++-
 tools/perf/util/evsel.c          |  7 -------
 tools/perf/util/evsel.h          |  3 +--
 tools/perf/util/metricgroup.c    |  4 ++--
 tools/perf/util/parse-events.c   |  1 -
 tools/perf/util/stat-shadow.c    | 10 +++++-----
 tools/perf/util/stat.c           |  2 +-
 9 files changed, 14 insertions(+), 22 deletions(-)

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
index 993e482f094c..c7c0edf3d4ca 100644
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
index de498ba5ac1c..2e3f4f876792 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -2504,7 +2504,8 @@ void evlist__uniquify_name(struct evlist *evlist)
 		else
 			attributes = empty_attributes;
 
-		if (asprintf(&new_name, "%s/%s/%s", pos->pmu_name, pos->name, attributes + 1)) {
+		if (asprintf(&new_name, "%s/%s/%s", pos->pmu ? "" : pos->pmu->name,
+			     pos->name, attributes + 1)) {
 			free(pos->name);
 			pos->name = new_name;
 		} else {
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index dfdb60c7a364..96b545f4d8b0 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -292,7 +292,6 @@ void evsel__init(struct evsel *evsel,
 	evsel->metric_events = NULL;
 	evsel->per_pkg_mask  = NULL;
 	evsel->collect_stat  = false;
-	evsel->pmu_name      = NULL;
 	evsel->group_pmu_name = NULL;
 	evsel->skippable     = false;
 	evsel->alternate_hw_config = PERF_COUNT_HW_MAX;
@@ -390,11 +389,6 @@ struct evsel *evsel__clone(struct evsel *orig)
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
@@ -1481,7 +1475,6 @@ void evsel__exit(struct evsel *evsel)
 	zfree(&evsel->group_name);
 	zfree(&evsel->name);
 	zfree(&evsel->filter);
-	zfree(&evsel->pmu_name);
 	zfree(&evsel->group_pmu_name);
 	zfree(&evsel->unit);
 	zfree(&evsel->metric_id);
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 46e3589314f1..2f99cc8bfa7d 100644
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
@@ -169,7 +168,7 @@ struct evsel {
 	unsigned long		open_flags;
 	int			precise_ip_original;
 
-	/* for missing_features */
+	/* The PMU the event is from. Used for missing_features, PMU name, etc. */
 	struct perf_pmu		*pmu;
 };
 
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 9be406524617..b0700db6e1cc 100644
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
index c72e1722b1fb..01d502d802ee 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -265,7 +265,6 @@ __add_event(struct list_head *list, int *idx,
 	evsel->core.is_pmu_core = pmu ? pmu->is_core : false;
 	evsel->auto_merge_stats = auto_merge_stats;
 	evsel->pmu = pmu;
-	evsel->pmu_name = pmu ? strdup(pmu->name) : NULL;
 	evsel->alternate_hw_config = alternate_hw_config;
 
 	if (name)
diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index ffdd53a07654..7bf39b069c5b 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -566,7 +566,7 @@ static void perf_stat__print_metricgroup_header(struct perf_stat_config *config,
 {
 	bool need_full_name = perf_pmus__num_core_pmus() > 1;
 	static const char *last_name;
-	static const char *last_pmu;
+	static const struct perf_pmu *last_pmu;
 	char full_name[64];
 
 	/*
@@ -577,21 +577,21 @@ static void perf_stat__print_metricgroup_header(struct perf_stat_config *config,
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
2.45.0.118.g7fe29c98d7-goog

