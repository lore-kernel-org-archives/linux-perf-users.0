Received: from mail-oa1-f74.google.com (mail-oa1-f74.google.com [209.85.160.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D8A3126DC
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Sep 2025 22:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758666815; cv=none; b=J7BsyxtSsLcUDF6bNuBz3wTATOnTIh3bfHCV/RC16O0oA3SAmYVTj34Qbj4omU3PuHzL2GFv307KhTlmyXAxOZun4yyAz6IU2XVHE55bp96HeUID+az92m3ifAL0nr/c4vTPM33wLaub2rhXiaoffFDD2bLC5s24DHmP6ojd8JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758666815; c=relaxed/simple;
	bh=9U8Qkaut51IFpJiGPepgidw+gFVSykeXVGEwCAxdADI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=F3XE1lnLs8xrfSBBuJcKbBo3iCA3i5IfzxODi8a2mN/wBxjwsEN+7AEJsaG69KQzI+Omk37h1OW7oV0i0r2SNSjwAKUR2hpTuNkTS3S2vPjYxnLOBN/Z09GM3nEec2bhG16eh1IdtjMCraTYDcSQdzvZ8W6aE52hs1TlPRyIVQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XQWFWEvt; arc=none smtp.client-ip=209.85.160.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XQWFWEvt"
Received: by mail-oa1-f74.google.com with SMTP id 586e51a60fabf-35229d35e82so820070fac.2
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Sep 2025 15:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758666812; x=1759271612; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0ZXMJZTB+guKcD1xbFn0gN7kFBWjFPMzx8qjMl0pf+Q=;
        b=XQWFWEvt8vYRrimDgZO2pkmlBaIAu3aMVtwDCe6j2Aa9kPJXm0Gi6QjajnYLI0dkUx
         UdYRI2KhL/Wl1qT38Oi72gVzHmjKB3YuvDuINKxpWkvxiGopXsgl4WH7vibkx+yKTLVj
         QCRXmfgk1xqnKWuYlGKyW3DkwrSQsne9WPnJj+o01WG+QnyS7KSRFnXMdy+SNuoOs5Cl
         AADk4v0o6kqyDg8Au7tfGDteYQrwWNBAmUyeP0eNHybwGelnGDO0tCf+/LINsjSTjWM3
         vNhUilWahKUxPKlard5B/6X0UVkxp2Nm04tPT2Jf0JqBrQmbO7OddGFBWWgZiiCFmtJ2
         hbuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758666812; x=1759271612;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0ZXMJZTB+guKcD1xbFn0gN7kFBWjFPMzx8qjMl0pf+Q=;
        b=TiGMlbA4EaHLOV2XSmfeS5o9GRQ39IWufLkxIqv6TFJt+lIgu2MIegmpJPdPLv8JS3
         EYWX4/ZSuDo7ViUfBBzh6w5RmR9/AMAuBH80glKxMSek9ABGOxvnJzJr0FMzHt75O8M8
         s0ZY3jxpqiBN3D4hoRLGnY4skyj4RGJn2rXKkQmK4bupSIxkWPJC+qLZgKxJjqrwCOEH
         UQeY5o0inloWBtt0tbRv5kzCXraUiQZk/7CpJuJAiEUS/7Firrq8t64nqfnzCMslfDEP
         Tc6GdJauLpxO6Hb69212wvdhR862yU/TgWdZrfapsUdMxOCHDkkv+ipUY9SKCQzJNDax
         DkHg==
X-Forwarded-Encrypted: i=1; AJvYcCWeApu72vRq3xJevApyD+TFw9lRKaqfCrtEyfoPUxtIf2HD4i8Ab9I0miv2Sd21CfNqNUHZwMbveSIE+F+YW9KJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yz816cCbD2kSzcJD5Tz2l/B0WpxwatscpVuP8zoaaNgi4zCH05E
	sd4C2T6fAhz2rq63BJg8QN/JEtEEXc7GZElREwhzNUqLp5aANnA0VMwGJ6P9TMVpz6I0SatUKgx
	8ir2zH9Opsg==
X-Google-Smtp-Source: AGHT+IHDmPvQP9y72FRag7C6x/ZfQtY3hGADwRqBIolqSG/ttyHpW7j2Y0F1bNlXSvM9Sn7ongVPnNxKUgtW
X-Received: from oabgz15.prod.google.com ([2002:a05:6870:280f:b0:331:10b5:c8d3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6870:d8d:b0:314:b6a6:6862
 with SMTP id 586e51a60fabf-34c88545ce3mr2355145fac.48.1758666812126; Tue, 23
 Sep 2025 15:33:32 -0700 (PDT)
Date: Tue, 23 Sep 2025 15:32:51 -0700
In-Reply-To: <20250923223312.238185-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250923223312.238185-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Message-ID: <20250923223312.238185-8-irogers@google.com>
Subject: [PATCH v6 07/28] perf pmu: Don't eagerly parse event terms
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

When an event/alias is created for a PMU the terms are eagerly parsed
using parse_events_terms. For a command like perf stat or perf record,
the particular event/alias will be found, the terms parsed, the
terms cloned for use in the event parsing, and then the terms used to
configure the perf_event_attr. Events/aliases may be eagerly loaded,
such as from sysfs or in perf list, in which case the aliases terms
will be little or never used. To avoid redundant work, to avoid
cloning, and to reduce memory overhead, hold the terms for an event as
a string until they need handling as a term list. This may introduce
duplicate parsing if an event is repeated in a list, but this
situation is expected to be uncommon.

Measuring the number of instructions before and after with a sysfs
event and perf stat, there is a minor reduction in the number of
instructions executed by 0.3%.

Tested-by: Thomas Richter <tmricht@linux.ibm.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/pmu-events.c  |  24 +------
 tools/perf/util/parse-events.c |   3 +-
 tools/perf/util/parse-events.h |   1 -
 tools/perf/util/pmu.c          | 111 ++++++++++++++++++++-------------
 4 files changed, 70 insertions(+), 69 deletions(-)

diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index 95fd9f671a22..f40a828c9861 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -22,10 +22,6 @@ struct perf_pmu_test_event {
 	/* used for matching against events from generated pmu-events.c */
 	struct pmu_event event;
 
-	/* used for matching against event aliases */
-	/* extra events for aliases */
-	const char *alias_str;
-
 	/*
 	 * Note: For when PublicDescription does not exist in the JSON, we
 	 * will have no long_desc in pmu_event.long_desc, but long_desc may
@@ -52,7 +48,6 @@ static const struct perf_pmu_test_event bp_l1_btb_correct = {
 		.desc = "L1 BTB Correction",
 		.topic = "branch",
 	},
-	.alias_str = "event=0x8a",
 };
 
 static const struct perf_pmu_test_event bp_l2_btb_correct = {
@@ -63,7 +58,6 @@ static const struct perf_pmu_test_event bp_l2_btb_correct = {
 		.desc = "L2 BTB Correction",
 		.topic = "branch",
 	},
-	.alias_str = "event=0x8b",
 };
 
 static const struct perf_pmu_test_event segment_reg_loads_any = {
@@ -74,7 +68,6 @@ static const struct perf_pmu_test_event segment_reg_loads_any = {
 		.desc = "Number of segment register loads",
 		.topic = "other",
 	},
-	.alias_str = "event=0x6,period=0x30d40,umask=0x80",
 };
 
 static const struct perf_pmu_test_event dispatch_blocked_any = {
@@ -85,7 +78,6 @@ static const struct perf_pmu_test_event dispatch_blocked_any = {
 		.desc = "Memory cluster signals to block micro-op dispatch for any reason",
 		.topic = "other",
 	},
-	.alias_str = "event=0x9,period=0x30d40,umask=0x20",
 };
 
 static const struct perf_pmu_test_event eist_trans = {
@@ -96,7 +88,6 @@ static const struct perf_pmu_test_event eist_trans = {
 		.desc = "Number of Enhanced Intel SpeedStep(R) Technology (EIST) transitions",
 		.topic = "other",
 	},
-	.alias_str = "event=0x3a,period=0x30d40",
 };
 
 static const struct perf_pmu_test_event l3_cache_rd = {
@@ -108,7 +99,6 @@ static const struct perf_pmu_test_event l3_cache_rd = {
 		.long_desc = "Attributable Level 3 cache access, read",
 		.topic = "cache",
 	},
-	.alias_str = "event=0x40",
 	.alias_long_desc = "Attributable Level 3 cache access, read",
 };
 
@@ -130,7 +120,6 @@ static const struct perf_pmu_test_event uncore_hisi_ddrc_flux_wcmd = {
 		.topic = "uncore",
 		.pmu = "hisi_sccl,ddrc",
 	},
-	.alias_str = "event=0x2",
 	.matching_pmu = "hisi_sccl1_ddrc2",
 };
 
@@ -142,7 +131,6 @@ static const struct perf_pmu_test_event unc_cbo_xsnp_response_miss_eviction = {
 		.topic = "uncore",
 		.pmu = "uncore_cbox",
 	},
-	.alias_str = "event=0x22,umask=0x81",
 	.matching_pmu = "uncore_cbox_0",
 };
 
@@ -154,7 +142,6 @@ static const struct perf_pmu_test_event uncore_hyphen = {
 		.topic = "uncore",
 		.pmu = "uncore_cbox",
 	},
-	.alias_str = "event=0xe0",
 	.matching_pmu = "uncore_cbox_0",
 };
 
@@ -166,7 +153,6 @@ static const struct perf_pmu_test_event uncore_two_hyph = {
 		.topic = "uncore",
 		.pmu = "uncore_cbox",
 	},
-	.alias_str = "event=0xc0",
 	.matching_pmu = "uncore_cbox_0",
 };
 
@@ -178,7 +164,6 @@ static const struct perf_pmu_test_event uncore_hisi_l3c_rd_hit_cpipe = {
 		.topic = "uncore",
 		.pmu = "hisi_sccl,l3c",
 	},
-	.alias_str = "event=0x7",
 	.matching_pmu = "hisi_sccl3_l3c7",
 };
 
@@ -190,7 +175,6 @@ static const struct perf_pmu_test_event uncore_imc_free_running_cache_miss = {
 		.topic = "uncore",
 		.pmu = "uncore_imc_free_running",
 	},
-	.alias_str = "event=0x12",
 	.matching_pmu = "uncore_imc_free_running_0",
 };
 
@@ -202,7 +186,6 @@ static const struct perf_pmu_test_event uncore_imc_cache_hits = {
 		.topic = "uncore",
 		.pmu = "uncore_imc",
 	},
-	.alias_str = "event=0x34",
 	.matching_pmu = "uncore_imc_0",
 };
 
@@ -226,7 +209,6 @@ static const struct perf_pmu_test_event sys_ddr_pmu_write_cycles = {
 		.pmu = "uncore_sys_ddr_pmu",
 		.compat = "v8",
 	},
-	.alias_str = "event=0x2b",
 	.matching_pmu = "uncore_sys_ddr_pmu0",
 };
 
@@ -239,7 +221,6 @@ static const struct perf_pmu_test_event sys_ccn_pmu_read_cycles = {
 		.pmu = "uncore_sys_ccn_pmu",
 		.compat = "0x01",
 	},
-	.alias_str = "config=0x2c",
 	.matching_pmu = "uncore_sys_ccn_pmu4",
 };
 
@@ -252,7 +233,6 @@ static const struct perf_pmu_test_event sys_cmn_pmu_hnf_cache_miss = {
 		.pmu = "uncore_sys_cmn_pmu",
 		.compat = "(434|436|43c|43a).*",
 	},
-	.alias_str = "eventid=0x1,type=0x5",
 	.matching_pmu = "uncore_sys_cmn_pmu0",
 };
 
@@ -374,9 +354,9 @@ static int compare_alias_to_test_event(struct pmu_event_info *alias,
 		return -1;
 	}
 
-	if (!is_same(alias->str, test_event->alias_str)) {
+	if (!is_same(alias->str, test_event->event.event)) {
 		pr_debug("testing aliases PMU %s: mismatched str, %s vs %s\n",
-			  pmu_name, alias->str, test_event->alias_str);
+			  pmu_name, alias->str, test_event->event.event);
 		return -1;
 	}
 
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index d5675471afc5..9ec1738a5a64 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -40,6 +40,7 @@ static int get_config_terms(const struct parse_events_terms *head_config,
 			    struct list_head *head_terms);
 static int parse_events_terms__copy(const struct parse_events_terms *src,
 				    struct parse_events_terms *dest);
+static int parse_events_terms__to_strbuf(const struct parse_events_terms *terms, struct strbuf *sb);
 
 const struct event_symbol event_symbols_hw[PERF_COUNT_HW_MAX] = {
 	[PERF_COUNT_HW_CPU_CYCLES] = {
@@ -2854,7 +2855,7 @@ void parse_events_terms__delete(struct parse_events_terms *terms)
 	free(terms);
 }
 
-int parse_events_terms__to_strbuf(const struct parse_events_terms *terms, struct strbuf *sb)
+static int parse_events_terms__to_strbuf(const struct parse_events_terms *terms, struct strbuf *sb)
 {
 	struct parse_events_term *term;
 	bool first = true;
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index be8d2ac1e4e4..9c975bb09fe8 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -199,7 +199,6 @@ void parse_events_terms__delete(struct parse_events_terms *terms);
 void parse_events_terms__init(struct parse_events_terms *terms);
 void parse_events_terms__exit(struct parse_events_terms *terms);
 int parse_events_terms(struct parse_events_terms *terms, const char *str, FILE *input);
-int parse_events_terms__to_strbuf(const struct parse_events_terms *terms, struct strbuf *sb);
 
 struct parse_events_modifier {
 	u8 precise;	/* Number of repeated 'p' for precision. */
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 5a291f1380ed..ddcd4918832d 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -67,8 +67,8 @@ struct perf_pmu_alias {
 	 * json events.
 	 */
 	char *topic;
-	/** @terms: Owned list of the original parsed parameters. */
-	struct parse_events_terms terms;
+	/** @terms: Owned copy of the event terms. */
+	char *terms;
 	/**
 	 * @pmu_name: The name copied from the json struct pmu_event. This can
 	 * differ from the PMU name as it won't have suffixes.
@@ -429,7 +429,7 @@ static void perf_pmu_free_alias(struct perf_pmu_alias *alias)
 	zfree(&alias->long_desc);
 	zfree(&alias->topic);
 	zfree(&alias->pmu_name);
-	parse_events_terms__exit(&alias->terms);
+	zfree(&alias->terms);
 	free(alias);
 }
 
@@ -537,8 +537,8 @@ static int update_alias(const struct pmu_event *pe,
 	assign_str(pe->name, "topic", &data->alias->topic, pe->topic);
 	data->alias->per_pkg = pe->perpkg;
 	if (pe->event) {
-		parse_events_terms__exit(&data->alias->terms);
-		ret = parse_events_terms(&data->alias->terms, pe->event, /*input=*/NULL);
+		zfree(&data->alias->terms);
+		data->alias->terms = strdup(pe->event);
 	}
 	if (!ret && pe->unit) {
 		char *unit;
@@ -590,7 +590,6 @@ static int perf_pmu__new_alias(struct perf_pmu *pmu, const char *name,
 	if (!alias)
 		return -ENOMEM;
 
-	parse_events_terms__init(&alias->terms);
 	alias->scale = 1.0;
 	alias->unit[0] = '\0';
 	alias->per_pkg = perpkg;
@@ -615,11 +614,16 @@ static int perf_pmu__new_alias(struct perf_pmu *pmu, const char *name,
 	if (ret)
 		return ret;
 
-	ret = parse_events_terms(&alias->terms, val, val_fd);
-	if (ret) {
-		pr_err("Cannot parse alias %s: %d\n", val, ret);
-		free(alias);
-		return ret;
+	if (!val_fd) {
+		alias->terms = strdup(val);
+	} else {
+		size_t line_len;
+
+		ret = getline(&alias->terms, &line_len, val_fd) < 0 ? -errno : 0;
+		if (ret) {
+			pr_err("Failed to read alias %s\n", name);
+			return ret;
+		}
 	}
 
 	alias->name = strdup(name);
@@ -767,29 +771,21 @@ static int pmu_aliases_parse_eager(struct perf_pmu *pmu, int sysfs_fd)
 	return ret;
 }
 
-static int pmu_alias_terms(struct perf_pmu_alias *alias, int err_loc, struct list_head *terms)
+static int pmu_alias_terms(struct perf_pmu_alias *alias, struct list_head *terms)
 {
-	struct parse_events_term *term, *cloned;
-	struct parse_events_terms clone_terms;
-
-	parse_events_terms__init(&clone_terms);
-	list_for_each_entry(term, &alias->terms.terms, list) {
-		int ret = parse_events_term__clone(&cloned, term);
+	struct parse_events_terms alias_terms;
+	int ret;
 
-		if (ret) {
-			parse_events_terms__exit(&clone_terms);
-			return ret;
-		}
-		/*
-		 * Weak terms don't override command line options,
-		 * which we don't want for implicit terms in aliases.
-		 */
-		cloned->weak = true;
-		cloned->err_term = cloned->err_val = err_loc;
-		list_add_tail(&cloned->list, &clone_terms.terms);
+	parse_events_terms__init(&alias_terms);
+	ret = parse_events_terms(&alias_terms, alias->terms, /*input=*/NULL);
+	if (ret) {
+		pr_err("Cannot parse '%s' terms '%s': %d\n",
+		       alias->name, alias->terms, ret);
+		parse_events_terms__exit(&alias_terms);
+		return ret;
 	}
-	list_splice_init(&clone_terms.terms, terms);
-	parse_events_terms__exit(&clone_terms);
+	list_splice_init(&alias_terms.terms, terms);
+	parse_events_terms__exit(&alias_terms);
 	return 0;
 }
 
@@ -1813,10 +1809,10 @@ int perf_pmu__check_alias(struct perf_pmu *pmu, struct parse_events_terms *head_
 		alias = pmu_find_alias(pmu, term);
 		if (!alias)
 			continue;
-		ret = pmu_alias_terms(alias, term->err_term, &term->list);
+		ret = pmu_alias_terms(alias, &term->list);
 		if (ret) {
 			parse_events_error__handle(err, term->err_term,
-						strdup("Failure to duplicate terms"),
+						strdup("Failed to parse terms"),
 						NULL);
 			return ret;
 		}
@@ -2035,18 +2031,37 @@ static int sub_non_neg(int a, int b)
 static char *format_alias(char *buf, int len, const struct perf_pmu *pmu,
 			  const struct perf_pmu_alias *alias, bool skip_duplicate_pmus)
 {
+	struct parse_events_terms terms;
 	struct parse_events_term *term;
+	int ret, used;
 	size_t pmu_name_len = pmu_deduped_name_len(pmu, pmu->name,
 						   skip_duplicate_pmus);
-	int used = snprintf(buf, len, "%.*s/%s", (int)pmu_name_len, pmu->name, alias->name);
 
-	list_for_each_entry(term, &alias->terms.terms, list) {
+	/* Paramemterized events have the parameters shown. */
+	if (strstr(alias->terms, "=?")) {
+		/* No parameters. */
+		snprintf(buf, len, "%.*s/%s/", (int)pmu_name_len, pmu->name, alias->name);
+		return buf;
+	}
+
+	parse_events_terms__init(&terms);
+	ret = parse_events_terms(&terms, alias->terms, /*input=*/NULL);
+	if (ret) {
+		pr_err("Failure to parse '%s' terms '%s': %d\n",
+			alias->name, alias->terms, ret);
+		parse_events_terms__exit(&terms);
+		snprintf(buf, len, "%.*s/%s/", (int)pmu_name_len, pmu->name, alias->name);
+		return buf;
+	}
+	used = snprintf(buf, len, "%.*s/%s", (int)pmu_name_len, pmu->name, alias->name);
+
+	list_for_each_entry(term, &terms.terms, list) {
 		if (term->type_val == PARSE_EVENTS__TERM_TYPE_STR)
 			used += snprintf(buf + used, sub_non_neg(len, used),
 					",%s=%s", term->config,
 					term->val.str);
 	}
-
+	parse_events_terms__exit(&terms);
 	if (sub_non_neg(len, used) > 0) {
 		buf[used] = '/';
 		used++;
@@ -2069,7 +2084,6 @@ int perf_pmu__for_each_event(struct perf_pmu *pmu, bool skip_duplicate_pmus,
 		.event_type_desc = "Kernel PMU event",
 	};
 	int ret = 0;
-	struct strbuf sb;
 	struct hashmap_entry *entry;
 	size_t bkt;
 
@@ -2080,7 +2094,6 @@ int perf_pmu__for_each_event(struct perf_pmu *pmu, bool skip_duplicate_pmus,
 	if (perf_pmu__is_drm(pmu))
 		return drm_pmu__for_each_event(pmu, state, cb);
 
-	strbuf_init(&sb, /*hint=*/ 0);
 	pmu_aliases_parse(pmu);
 	pmu_add_cpu_aliases(pmu);
 	hashmap__for_each_entry(pmu->aliases, entry, bkt) {
@@ -2115,16 +2128,14 @@ int perf_pmu__for_each_event(struct perf_pmu *pmu, bool skip_duplicate_pmus,
 		info.desc = event->desc;
 		info.long_desc = event->long_desc;
 		info.encoding_desc = buf + buf_used;
-		parse_events_terms__to_strbuf(&event->terms, &sb);
 		buf_used += snprintf(buf + buf_used, sizeof(buf) - buf_used,
-				"%.*s/%s/", (int)pmu_name_len, info.pmu_name, sb.buf) + 1;
+				"%.*s/%s/", (int)pmu_name_len, info.pmu_name, event->terms) + 1;
+		info.str = event->terms;
 		info.topic = event->topic;
-		info.str = sb.buf;
 		info.deprecated = event->deprecated;
 		ret = cb(state, &info);
 		if (ret)
 			goto out;
-		strbuf_setlen(&sb, /*len=*/ 0);
 	}
 	if (pmu->selectable) {
 		info.name = buf;
@@ -2140,7 +2151,6 @@ int perf_pmu__for_each_event(struct perf_pmu *pmu, bool skip_duplicate_pmus,
 		ret = cb(state, &info);
 	}
 out:
-	strbuf_release(&sb);
 	return ret;
 }
 
@@ -2588,10 +2598,21 @@ const char *perf_pmu__name_from_config(struct perf_pmu *pmu, u64 config)
 	hashmap__for_each_entry(pmu->aliases, entry, bkt) {
 		struct perf_pmu_alias *event = entry->pvalue;
 		struct perf_event_attr attr = {.config = 0,};
+		struct parse_events_terms terms;
+		int ret;
 
-		int ret = perf_pmu__config(pmu, &attr, &event->terms, /*apply_hardcoded=*/true,
-					   /*err=*/NULL);
+		parse_events_terms__init(&terms);
+		ret = parse_events_terms(&terms, event->terms, /*input=*/NULL);
+		if (ret) {
+			pr_debug("Failed to parse '%s' terms '%s': %d\n",
+				event->name, event->terms, ret);
+			parse_events_terms__exit(&terms);
+			continue;
+		}
+		ret = perf_pmu__config(pmu, &attr, &terms, /*apply_hardcoded=*/true,
+				       /*err=*/NULL);
 
+		parse_events_terms__exit(&terms);
 		if (ret == 0 && config == attr.config)
 			return event->name;
 	}
-- 
2.51.0.534.gc79095c0ca-goog

