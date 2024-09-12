Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627561C0DFA
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Sep 2024 19:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726167837; cv=none; b=IKn0ORV64zU3Y0qf3lOZQAK0yxMJm3k3wevps8Db1hUcIr4uqyAasENUtNWnCNXbNvGYfDA+Xk9ePaj+P3OSJRzfvrvb6uxKYfCKN381dvVIHfmj+BYGFQ+YYSbeKbTVAc2Uiwf6UBJGkOk8MWNy3vpN9pwRFjmCXpWpu7W4a0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726167837; c=relaxed/simple;
	bh=jAbcNv9yqSgarE211GJB5sWazFM4Lu5dS8WW6PuxC5A=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=urXdaHDJ7nTi/DV20CWLSDT6h4GkSSWELhWNsqFzmIGNxRbcYlxNl9mR0S9urO+z07p+tXZut0rsTmFZp6GwX9pVIGp6FsC1S7iIExTMosk4PiZ/a6xRZV4u0k3n6OwwMSzT6e9JX12Got32PKmNusJinUa9L0HCszcepznMsTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qjwc1m7H; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qjwc1m7H"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6d3e062dbeeso20862097b3.0
        for <linux-perf-users@vger.kernel.org>; Thu, 12 Sep 2024 12:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726167834; x=1726772634; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ErJVEWbGWFbXBxm9ftNG9Im8DYNIr0eJ7a1WeskavbY=;
        b=Qjwc1m7HI2+K3sdHGH+pqPI1gN0AIqqdkzMelth5XcKqJwlFVzww9Fff/n1yt10PiR
         C5xmEksRBTn9DtwDnvM5KxaJY7MjaxvDunJLXu8YArm+gkFN/HU1sp9RgSxLhkTHbVWn
         d9wTOHVSs/tpF8WkeQz6NOepd0J5sMX4xtaOYrt4KaOkSEb7yvZXwid+v0vZIOsOpc6l
         d+pLYppym8mClZtgOJE0MVjZRUywjzPa44GUrimMBvzjIpPvWSoqbk/V4YsoSdMvqSST
         BmFFaqsAduSEhCfPu+C1D9FC7RggfmkEI/jtZ+DrVPuIMXYX6jCLnwVzfhmpnbKxn4+0
         IVRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726167834; x=1726772634;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ErJVEWbGWFbXBxm9ftNG9Im8DYNIr0eJ7a1WeskavbY=;
        b=koM6B1sQbjipMKPkLOJNduyhu4+nuqNMq8aZDSaQRzGm3Wp9q1TNw9zm1KXd53AhcL
         aGAtaoS8Q9478R39iF+Gk2oVoiCMohx0wBArGA8KHfJbAnI2dRTl2BzoaTgJd0YSuFwS
         rlYHNlY6yetpYA0Vih+X2oRTtfChZmrf5k1Pn8HSATXRjtIJJ3vr1N2jVP2+MCTIYUrM
         UHuFkjYZRf+r4tii2EdTzAhhClQXw0v/iHiHOWHbRBJmOYvWStblkNmpo6n4UFMLqiAD
         1pto9x8Xy0dPpGbGZl+NAFA4fDS2/QuTSyNLMmMqjEjnkp8RVKKLU3gHL478UXrPV08P
         EeMQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0pinAuqVaDTDBuodX2Hkgo42Z/Q/Fqnz/+bLXfsywSOydrzL996qroUIitPdVsVUUjTSRUJiDjvIuoIKi4lNM@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd7hgvh0RClLLtnSVxab2K4SKawXkSmeG4NL5NiIdGtI89b3b+
	nLYHeeC6cpdMC27r1l0ZtIgFkxJB01nrKLtXm4Kg+dbVu/naSlb0Zcv/p0d8rsWSlS6az4JKg3t
	u9I7f3Q==
X-Google-Smtp-Source: AGHT+IEoVzs1oyyOhvrA5B/BlAJH69uJxOhlzgaDYyg724PtCyJm2X/3yyqctLyUb+O6fIKERxSQj2M4j+R0
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:cf0e:7a99:e672:3862])
 (user=irogers job=sendgmr) by 2002:a81:9f02:0:b0:6be:523:af53 with SMTP id
 00721157ae682-6db95425354mr2564147b3.3.1726167834242; Thu, 12 Sep 2024
 12:03:54 -0700 (PDT)
Date: Thu, 12 Sep 2024 12:03:29 -0700
In-Reply-To: <20240912190341.919229-1-irogers@google.com>
Message-Id: <20240912190341.919229-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240912190341.919229-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.662.g92d0881bb0-goog
Subject: [PATCH v2 02/13] perf pmu: Allow hardcoded terms to be applied to attributes
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
index 9a8be1e46d67..26bbc6f603ab 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1537,7 +1537,9 @@ static int parse_events_add_pmu(struct parse_events_state *parse_state,
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
index 779db2ac06f0..c020fc34b635 100644
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
@@ -2279,7 +2317,9 @@ const char *perf_pmu__name_from_config(struct perf_pmu *pmu, u64 config)
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
2.46.0.662.g92d0881bb0-goog

