Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46EB149C4F
	for <linux-perf-users@vger.kernel.org>; Sat,  7 Sep 2024 05:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725685734; cv=none; b=hPcp31yGEVLOdkzbmzVv6pc+FD9vOiOWd4yiIndWTGPhKNRYm/hqzFIZzDKQVj1PPtJNRqvKHuxmqhBXANGEUKT3fSASzUR98esv3PDLfpkNEJ21BH8oQcxeo8TWIgNXURdRTPjH2I7lq8fJIO7YJ3zOUNbwk3aRz9qyIFACGrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725685734; c=relaxed/simple;
	bh=m1WPfgl7SP89GnaSfdxl2RxnyAm/9Kd02ncuz7JYQHo=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=gFHBMZjK3P73m0gxLBiInTe9hdw1OrlRRDjwmx8McXF5810WDveYi1c0XrAqnDHbIOjjlS+RWDISoNPwgajPNLms8XHdtL/+bToziL6CTwGJ283O2E2X5kzMVJVYzUvsWOCcPHOLA55LyczGbcWO+1XWw6Hiy602bgI8DL14TRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eu+tf5Ot; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eu+tf5Ot"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e1a892d8438so6602117276.3
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Sep 2024 22:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725685732; x=1726290532; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a5r49TcDCPH7T31bKkTHHjqs94+2zUrOQeYr8a1P3XQ=;
        b=eu+tf5OtcY8ZUj7bSQo+d4FUhai6KwJ2zVOpRC30qTMddor3kjkHsjDcbiVAOYnabU
         YBtWXZ8vb9SpOMR9mZEQKp5l81bOHrk1qfHTNO5yY3y8pD0pSi2u9ew43X+7WheS9AQo
         AfCINMeO4eIOiMBBmRepv9pNfxehK4tgU+qCjWA6ijz0AlNIXUf5OFVkJVe9wuQmJ0PF
         fx+WrNQ/yi44uJ0DQjIlOrGghpnkRIfcb9kdBaaPw6embus62JMrKbEwLP+6ZsgANW8Z
         KBH1uGZpUOaezFS1zj2USODzlXORnU/hHGKwRFTKHixcO44Fo+mF0ylzVdA06/+ggHdW
         opvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725685732; x=1726290532;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a5r49TcDCPH7T31bKkTHHjqs94+2zUrOQeYr8a1P3XQ=;
        b=woUY8rnviLjApnBiYigs8RCUBSSNcY7YIlQUbQPzzrAbYAbfcP29DcSExRH2/gUwIL
         sztzpRteNhFQk91vLDvAgf0bm0QWzSF6Ai5P547ng+eXZP3Y3lPlCFdYoNrYw71vYfy/
         gjMkVyrqoE2brtN5D8yOXLktdvYt3yAFqE2dIeTWF2Kx4khRpfyzOqK9w4ZNqSXj5az7
         7Wb62zonB6fz+/z11SgPsWGbFB7/Sv7kFOo43fx/PxNOcRN09vjYA2RCi3Qwfsh9pRHl
         qEk0V+7VjfhTrE42Zsi6HLZBhDtHxXpKBsCuVPr1ErLofxTlPB6BlTCorZcLqxvy22Ql
         8hFg==
X-Forwarded-Encrypted: i=1; AJvYcCWJNphQHibarS/k9yIGXsi3+T1Tli1ieK8pIw0oGiGwrV0WIh6ZgewcvloUdsQfr4vRCGm1JI1filATTflWdWCD@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9mNHzvOXs+RZ32/vCuBrbS6flezb0qGIRXVAYru+i3lTH8hJy
	hofisdqt8apwSQKhr3/SuOeTQ7ZJ2k9Aj1XrtN9RoQQUsNPSKEJpUDaKBiUxDPH7GWdVhK2LEGW
	lAYDJ5Q==
X-Google-Smtp-Source: AGHT+IE0EKaeMy7eJuhDT92fQLJKrgy/uZcZe5uCVRdZiDDQ3ing5jXBYBWu0n5fxCO0bKSAum8dkVGrPuL8
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:90e5:a813:c3d3:daed])
 (user=irogers job=sendgmr) by 2002:a05:6902:4d1:b0:e0b:cce3:45c7 with SMTP id
 3f1490d57ef6-e1d349e38d5mr7954276.9.1725685731891; Fri, 06 Sep 2024 22:08:51
 -0700 (PDT)
Date: Fri,  6 Sep 2024 22:08:20 -0700
In-Reply-To: <20240907050830.6752-1-irogers@google.com>
Message-Id: <20240907050830.6752-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240907050830.6752-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Subject: [PATCH v1 05/15] perf pmu: Allow hardcoded terms to be applied to attributes
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Weilin Wang <weilin.wang@intel.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Xu Yang <xu.yang_2@nxp.com>, 
	Sandipan Das <sandipan.das@amd.com>, Benjamin Gray <bgray@linux.ibm.com>, 
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>, Howard Chu <howardchu95@gmail.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Yang Jihong <yangjihong@bytedance.com>, 
	Colin Ian King <colin.i.king@gmail.com>, Veronika Molnarova <vmolnaro@redhat.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Changbin Du <changbin.du@huawei.com>, Ze Gao <zegao2021@gmail.com>, 
	Andi Kleen <ak@linux.intel.com>, 
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
---
 tools/perf/arch/x86/util/intel-pt.c |  3 +-
 tools/perf/tests/pmu.c              |  3 +-
 tools/perf/util/parse-events.c      |  4 ++-
 tools/perf/util/pmu.c               | 54 ++++++++++++++++++++++++-----
 tools/perf/util/pmu.h               |  4 ++-
 5 files changed, 56 insertions(+), 12 deletions(-)

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
index 081ceff467f2..30b78fe8d704 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1515,7 +1515,9 @@ static int parse_events_add_pmu(struct parse_events_state *parse_state,
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
index 72bfc321e4b3..29bd0fa9f88c 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1367,7 +1367,8 @@ static int pmu_config_term(const struct perf_pmu *pmu,
 			   struct perf_event_attr *attr,
 			   struct parse_events_term *term,
 			   struct parse_events_terms *head_terms,
-			   bool zero, struct parse_events_error *err)
+			   bool zero, bool apply_hardcoded,
+			   struct parse_events_error *err)
 {
 	struct perf_pmu_format *format;
 	__u64 *vp;
@@ -1381,11 +1382,44 @@ static int pmu_config_term(const struct perf_pmu *pmu,
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
+		}
 		return 0;
+	}
 
 	format = pmu_find_format(&pmu->format, term->config);
 	if (!format) {
@@ -1489,12 +1523,13 @@ static int pmu_config_term(const struct perf_pmu *pmu,
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
 
@@ -1508,6 +1543,7 @@ int perf_pmu__config_terms(const struct perf_pmu *pmu,
  */
 int perf_pmu__config(struct perf_pmu *pmu, struct perf_event_attr *attr,
 		     struct parse_events_terms *head_terms,
+		     bool apply_hardcoded,
 		     struct parse_events_error *err)
 {
 	bool zero = !!pmu->perf_event_attr_init_default;
@@ -1516,7 +1552,7 @@ int perf_pmu__config(struct perf_pmu *pmu, struct perf_event_attr *attr,
 	if (perf_pmu__is_fake(pmu))
 		return 0;
 
-	return perf_pmu__config_terms(pmu, attr, head_terms, zero, err);
+	return perf_pmu__config_terms(pmu, attr, head_terms, zero, apply_hardcoded, err);
 }
 
 static struct perf_pmu_alias *pmu_find_alias(struct perf_pmu *pmu,
@@ -2281,7 +2317,9 @@ const char *perf_pmu__name_from_config(struct perf_pmu *pmu, u64 config)
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
index 4397c48ad569..af7532ca7fb1 100644
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
2.46.0.469.g59c65b2a67-goog

