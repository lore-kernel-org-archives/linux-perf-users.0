Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AC514A8B
	for <linux-perf-users@vger.kernel.org>; Wed,  2 Oct 2024 03:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727839229; cv=none; b=TiVanfC7HfFQPw9AYgIJeZ/Kj/smGMNrHHQFa1TatqOR4HDTaYOYhJRlXWEueXfZYOo6vhXkTtaG8llmbNPXLs7s+5Dzl0lYITlspndFCQromcXdr0MoZUC8T/cQeLS87d/1bkIRbCTqKeZ+7scvvrlRnO019PUQJd56GHXabkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727839229; c=relaxed/simple;
	bh=YWlEC9E2v6TPbXto6REFNEMjNj2MpJCCm4sErqLG7r8=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=debFlpHwBtKL5JpT+KSHah0CdGf8GPIbZ86mwSekAvGMnA9zn94yi63Nn8URiyTcSCI6yBxunG8JsA0zVlbqUsD1FatiZPoKKKYCd/oPBMUhvkHki07M01d3+iM+A8Gsh9tRmhKayq2yntouhmadjQL2gKmwUnCRyJ3uGTRg0uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zfoyPads; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zfoyPads"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6d9e31e66eeso112011507b3.1
        for <linux-perf-users@vger.kernel.org>; Tue, 01 Oct 2024 20:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727839227; x=1728444027; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VE9+IE7hHSrPc5kQbTceMm06rK1QDC9BFjLSZ+vA0i8=;
        b=zfoyPadssky7gu41wv9N7Zdc0Ya/AE6E1B5wxM4FknrUJ+QABNa3Tp1ca6Rcm4tb2x
         tNA+E0sLPwhY6OuPNkq98c4M6uslsvWc6KY/D9RQCJmf0YancvO6okLhnz0CRZSMrpFy
         9ARh6gdk8PQsevnpLUSl8HHsE4L/zSTv8bL+pNQuejZ4M00VwwFvG5B8Su2K/2gN+dfx
         ld6WjbEE3G3lHdT6TuixOQieCZnK3HYw4kMIHBQ50m/CbxZmob4nS33p1oZbpBAD50Bv
         DMVlbYFaNN4grbulhE+InMSFYFZ4KylC6utvtw2wjHlk2B430zwKcRadFEl76Ww6eTUD
         9CKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727839227; x=1728444027;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VE9+IE7hHSrPc5kQbTceMm06rK1QDC9BFjLSZ+vA0i8=;
        b=Br8y+nTk3p9yoTFwIDGuU7wYZsMT0rmrlDR5+M05/7m+oj8i1r86riSlu7FI1Qvf4r
         QhsmcCKW/3yYPlxBCap0bRRXQhqWgpmXCRejVWMSRkxlx5NWO9BWERp6epspQPnZQHfD
         bxDVZurYSWH3LjQjA0IZdFseuRSn36c6XdpfkB3bkvcLHSzkzuUvoA/gfIJQrMSZTRqz
         4O9mvf7/nN15J5ekSrspN/U+spfqlhKz1AbvcU33doFDkmDLw53bXQrOSChUuZuvFO10
         mCCHkIY8ZfOE0Xf9mXYdQ9fO++FGzhx4HrFSGK1MX0oOweowkyF5S2cjJozgxXhYkhAc
         8PZg==
X-Forwarded-Encrypted: i=1; AJvYcCWEznnJN3KdDTLIvUG+0RC2Hs26oMWNl1R3u5xUwS2BvtkY1ANzCcRqTWrS8qa5NXq9IJT36SnE4NldylQDk2qr@vger.kernel.org
X-Gm-Message-State: AOJu0YyToGIXYaAAJykXsrfuSA8M0PlVC9eBPZWncpdzbxmPHOBksfpS
	8tmaFNdC0j821fJ9DMCoZsCIdve7Qe7tjI5lsTSCcW2xKQF49RoJL7Ydwx2X13gRJkRpyrS06Sd
	tDGQzaw==
X-Google-Smtp-Source: AGHT+IH/inkFspuhxgcTa9B9c/jF0G4nAk8RuafY1f+rzXiimD8J3ME4ldlsb5wIzWznJRsJHDGFpFXfnKiT
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:ffa1:6d00:2acb:535f])
 (user=irogers job=sendgmr) by 2002:a05:690c:4c13:b0:62f:1f63:ae4f with SMTP
 id 00721157ae682-6e2a2adca3dmr620527b3.1.1727839226771; Tue, 01 Oct 2024
 20:20:26 -0700 (PDT)
Date: Tue,  1 Oct 2024 20:20:05 -0700
In-Reply-To: <20241002032016.333748-1-irogers@google.com>
Message-Id: <20241002032016.333748-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241002032016.333748-1-irogers@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Subject: [PATCH v3 02/13] perf pmu: Allow hardcoded terms to be applied to attributes
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Weilin Wang <weilin.wang@intel.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Sandipan Das <sandipan.das@amd.com>, Xu Yang <xu.yang_2@nxp.com>, 
	Benjamin Gray <bgray@linux.ibm.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Howard Chu <howardchu95@gmail.com>, Veronika Molnarova <vmolnaro@redhat.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Changbin Du <changbin.du@huawei.com>, "Steinar H. Gunderson" <sesse@google.com>, Ze Gao <zegao2021@gmail.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, 
	"=?UTF-8?q?Cl=C3=A9ment=20Le=20Goffic?=" <clement.legoffic@foss.st.com>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	Junhao He <hejunhao3@huawei.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Yicong Yang <yangyicong@hisilicon.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Hard coded terms like "config=10" are skipped by perf_pmu__config
assuming they were already applied to a perf_event_attr by parse
event's config_attr function. When doing a reverse number to name
lookup in perf_pmu__name_from_config, as the hardcoded terms aren't
applied the config value is incorrect leading to misses or false
matches. Fix this by adding a parameter to have perf_pmu__config apply
hardcoded terms too (not just in parse event's config_term_common).

Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/arch/x86/util/intel-pt.c |  3 +-
 tools/perf/tests/pmu.c              |  3 +-
 tools/perf/util/parse-events.c      |  4 ++-
 tools/perf/util/pmu.c               | 56 ++++++++++++++++++++++++-----
 tools/perf/util/pmu.h               |  4 ++-
 5 files changed, 58 insertions(+), 12 deletions(-)

diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
index ea510a7486b1..8f235d8b67b6 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -75,7 +75,8 @@ static int intel_pt_parse_terms_with_default(const struct perf_pmu *pmu,
 		goto out_free;
 
 	attr.config = *config;
-	err = perf_pmu__config_terms(pmu, &attr, &terms, /*zero=*/true, /*err=*/NULL);
+	err = perf_pmu__config_terms(pmu, &attr, &terms, /*zero=*/true, /*apply_hardcoded=*/false,
+				     /*err=*/NULL);
 	if (err)
 		goto out_free;
 
diff --git a/tools/perf/tests/pmu.c b/tools/perf/tests/pmu.c
index be18506f6a24..6a681e3fb552 100644
--- a/tools/perf/tests/pmu.c
+++ b/tools/perf/tests/pmu.c
@@ -176,7 +176,8 @@ static int test__pmu_format(struct test_suite *test __maybe_unused, int subtest
 	}
 
 	memset(&attr, 0, sizeof(attr));
-	ret = perf_pmu__config_terms(pmu, &attr, &terms, /*zero=*/false, /*err=*/NULL);
+	ret = perf_pmu__config_terms(pmu, &attr, &terms, /*zero=*/false,
+				     /*apply_hardcoded=*/false, /*err=*/NULL);
 	if (ret) {
 		pr_err("perf_pmu__config_terms failed");
 		goto err_out;
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index e96cf13dc396..6ae611e70fae 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1546,7 +1546,9 @@ static int parse_events_add_pmu(struct parse_events_state *parse_state,
 		return -ENOMEM;
 	}
 
-	if (perf_pmu__config(pmu, &attr, &parsed_terms, parse_state->error)) {
+	/* Skip configuring hard coded terms that were applied by config_attr. */
+	if (perf_pmu__config(pmu, &attr, &parsed_terms, /*apply_hardcoded=*/false,
+			     parse_state->error)) {
 		free_config_terms(&config_terms);
 		parse_events_terms__exit(&parsed_terms);
 		return -EINVAL;
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index cb2eb2407de5..a1c7e879cb2f 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1366,7 +1366,8 @@ static int pmu_config_term(const struct perf_pmu *pmu,
 			   struct perf_event_attr *attr,
 			   struct parse_events_term *term,
 			   struct parse_events_terms *head_terms,
-			   bool zero, struct parse_events_error *err)
+			   bool zero, bool apply_hardcoded,
+			   struct parse_events_error *err)
 {
 	struct perf_pmu_format *format;
 	__u64 *vp;
@@ -1380,11 +1381,46 @@ static int pmu_config_term(const struct perf_pmu *pmu,
 		return 0;
 
 	/*
-	 * Hardcoded terms should be already in, so nothing
-	 * to be done for them.
+	 * Hardcoded terms are generally handled in event parsing, which
+	 * traditionally have had to handle not having a PMU. An alias may
+	 * have hard coded config values, optionally apply them below.
 	 */
-	if (parse_events__is_hardcoded_term(term))
+	if (parse_events__is_hardcoded_term(term)) {
+		/* Config terms set all bits in the config. */
+		DECLARE_BITMAP(bits, PERF_PMU_FORMAT_BITS);
+
+		if (!apply_hardcoded)
+			return 0;
+
+		bitmap_fill(bits, PERF_PMU_FORMAT_BITS);
+
+		switch (term->type_term) {
+		case PARSE_EVENTS__TERM_TYPE_CONFIG:
+			assert(term->type_val == PARSE_EVENTS__TERM_TYPE_NUM);
+			pmu_format_value(bits, term->val.num, &attr->config, zero);
+			break;
+		case PARSE_EVENTS__TERM_TYPE_CONFIG1:
+			assert(term->type_val == PARSE_EVENTS__TERM_TYPE_NUM);
+			pmu_format_value(bits, term->val.num, &attr->config1, zero);
+			break;
+		case PARSE_EVENTS__TERM_TYPE_CONFIG2:
+			assert(term->type_val == PARSE_EVENTS__TERM_TYPE_NUM);
+			pmu_format_value(bits, term->val.num, &attr->config2, zero);
+			break;
+		case PARSE_EVENTS__TERM_TYPE_CONFIG3:
+			assert(term->type_val == PARSE_EVENTS__TERM_TYPE_NUM);
+			pmu_format_value(bits, term->val.num, &attr->config3, zero);
+			break;
+		case PARSE_EVENTS__TERM_TYPE_USER: /* Not hardcoded. */
+			return -EINVAL;
+		case PARSE_EVENTS__TERM_TYPE_NAME ... PARSE_EVENTS__TERM_TYPE_HARDWARE:
+			/* Skip non-config terms. */
+			break;
+		default:
+			break;
+		}
 		return 0;
+	}
 
 	format = pmu_find_format(&pmu->format, term->config);
 	if (!format) {
@@ -1487,12 +1523,13 @@ static int pmu_config_term(const struct perf_pmu *pmu,
 int perf_pmu__config_terms(const struct perf_pmu *pmu,
 			   struct perf_event_attr *attr,
 			   struct parse_events_terms *terms,
-			   bool zero, struct parse_events_error *err)
+			   bool zero, bool apply_hardcoded,
+			   struct parse_events_error *err)
 {
 	struct parse_events_term *term;
 
 	list_for_each_entry(term, &terms->terms, list) {
-		if (pmu_config_term(pmu, attr, term, terms, zero, err))
+		if (pmu_config_term(pmu, attr, term, terms, zero, apply_hardcoded, err))
 			return -EINVAL;
 	}
 
@@ -1506,6 +1543,7 @@ int perf_pmu__config_terms(const struct perf_pmu *pmu,
  */
 int perf_pmu__config(struct perf_pmu *pmu, struct perf_event_attr *attr,
 		     struct parse_events_terms *head_terms,
+		     bool apply_hardcoded,
 		     struct parse_events_error *err)
 {
 	bool zero = !!pmu->perf_event_attr_init_default;
@@ -1514,7 +1552,7 @@ int perf_pmu__config(struct perf_pmu *pmu, struct perf_event_attr *attr,
 	if (perf_pmu__is_fake(pmu))
 		return 0;
 
-	return perf_pmu__config_terms(pmu, attr, head_terms, zero, err);
+	return perf_pmu__config_terms(pmu, attr, head_terms, zero, apply_hardcoded, err);
 }
 
 static struct perf_pmu_alias *pmu_find_alias(struct perf_pmu *pmu,
@@ -2283,7 +2321,9 @@ const char *perf_pmu__name_from_config(struct perf_pmu *pmu, u64 config)
 	pmu_add_cpu_aliases(pmu);
 	list_for_each_entry(event, &pmu->aliases, list) {
 		struct perf_event_attr attr = {.config = 0,};
-		int ret = perf_pmu__config(pmu, &attr, &event->terms, NULL);
+
+		int ret = perf_pmu__config(pmu, &attr, &event->terms, /*apply_hardcoded=*/true,
+					   /*err=*/NULL);
 
 		if (ret == 0 && config == attr.config)
 			return event->name;
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index d352d53b8d55..c70317d3fb04 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -206,11 +206,13 @@ typedef int (*pmu_format_callback)(void *state, const char *name, int config,
 void pmu_add_sys_aliases(struct perf_pmu *pmu);
 int perf_pmu__config(struct perf_pmu *pmu, struct perf_event_attr *attr,
 		     struct parse_events_terms *head_terms,
+		     bool apply_hardcoded,
 		     struct parse_events_error *error);
 int perf_pmu__config_terms(const struct perf_pmu *pmu,
 			   struct perf_event_attr *attr,
 			   struct parse_events_terms *terms,
-			   bool zero, struct parse_events_error *error);
+			   bool zero, bool apply_hardcoded,
+			   struct parse_events_error *error);
 __u64 perf_pmu__format_bits(struct perf_pmu *pmu, const char *name);
 int perf_pmu__format_type(struct perf_pmu *pmu, const char *name);
 int perf_pmu__check_alias(struct perf_pmu *pmu, struct parse_events_terms *head_terms,
-- 
2.46.1.824.gd892dcdcdd-goog

