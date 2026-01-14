Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1863A0EA7
	for <linux-perf-users@vger.kernel.org>; Wed, 14 Jan 2026 15:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768406270; cv=none; b=lJrM9RHQk56H0LM8jPXGO+ExyBUyihhLZChigYohnxLJTlJu7Hr1/jhbEcwAxljZnLY9+zYF/tHwA+0zvnitNpq36iaBEK0X+fqeDb1vy79gE19Nc8OwhTuIo1aBZRIjrwZcwD3QE5ux6mewbGwPTPkLrFZL5WE0R2ytcSTZVto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768406270; c=relaxed/simple;
	bh=SA4fI14/Zxyh6ZTCayGh6Qs2N+0qQznRvVAKLljrnBg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CCYR3/W0kC8va2IrE02YphVfPG+vcc6SvBOs4sEhSW3rH5Ctcx7x2gZJoHRDcNMdo+1OEBQVheOEl7oywNkUWAp9RKlqz6TyGkxITFZmTMcjttJ3Wg32VoAutcKROX0C1ofmghrmBtbEufHndh0Sz2YxLb5vVfxSMk5nIU8ZQ10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rn5ROQD+; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rn5ROQD+"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47d63594f7eso8185e9.0
        for <linux-perf-users@vger.kernel.org>; Wed, 14 Jan 2026 07:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768406263; x=1769011063; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=41HNGLiNRNt3A8GGSfSayOntB8acpqhbS5SlmFJ/Hg4=;
        b=rn5ROQD+K5a2YVzkBHQXTYIkjlo0GkamCF/lK0YMfK6+rFgvL4oWh8eQz0wjU5JFS4
         XZN0BDIvJjJLcuxqVTWu+0xvZzS1DqVvpH3LPVhf+DaL/gb8WeVeg6EIl31IQ+3WXsBj
         WcDpQz7OZU5PvXOebtB47XihiJiM8T5GgNOoBYIGVJkbyJlcmwNyzMzG8Y2wyEl1YWCf
         GhG+sY7L1LBet20GZQplvf1x2zK4v56feWaGQ6p8W4se19bMSEwznPrQL+JWUI96RX0w
         38mnLDD/b73OpPEoupyN7eb8/qwQzCYg/NmRqAObYCcH7l/EX63GH2CKcFj+JuSqTYWw
         xCuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768406263; x=1769011063;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=41HNGLiNRNt3A8GGSfSayOntB8acpqhbS5SlmFJ/Hg4=;
        b=jss2YE3uE9YEGHMjbiR6kbOXZ9PuI0IzR83LqS6nF7hlvWmXqSx0nT9zOxzUs1uE5t
         zl2w4lBcgXcZNejo8ndVuXsozDfeNu9qsaHTdcObfNc5syywXxQ98t0KpdhKXZ602zNc
         FAygBwBw1Bor8K4ZoJm0CbXXygc4m6rXnLXioMeSX/irUY1q2hOSGk64Y1T46HH3+dhL
         pw88neucEhod8YyVu6W4doMaHGz29R5zoXje/vqafzM2VFEI8e2Lc/ZKDXMaQuZN4oqv
         lmx6j1FJyhBbQOsnIB05ohna0ZsJgimgIYEHPom8BcsjCIm8lLcfgyrAvrNO5PIm8l1L
         2cug==
X-Gm-Message-State: AOJu0Ywupg8JuGKhnnSZ+mIHznjLLg3Rb05ta747WOReoIarS/KPnDFy
	bOCRqnSO43wD+OoHfsS/To3/2ZD1BkApVH9aIHRkck0k+lV4w6AVCIDDEFdyoA0zz1Y=
X-Gm-Gg: AY/fxX60qFTX8hDkctI4fMP/IbnqKWV9/zVz/asv3D2a9m2v462jATsdnMPdlmYCfS/
	p7WDdvR9mi/ldarRGRjVUcHoLJD0X7Vqgl3uGc/HP0QmmKEoBGDzPDkaHgsfw1BJP5d6cAyKyW3
	WOqyz83vDqMURA9EOGvBA9B1LwWe2dMxbTzGdjwEYxGLCkAqLVYFxiQ4Ig1eRd5b+7EuSV7Pygi
	PLPgYauXZdr8SzUabJwyFLGNUSVyfF+JQqsKOWAh7HGMsz6vRVC5ofQhfL5lUl1XCcAM8L/HtWy
	Zu5xZRlk327OE4TgbNG++eOxp8ES7gG9YHV/3TVFJ7+TkTBlPi2GhayuOErMVZ8k2REd3/y2kYJ
	XnLUx50uu4kiMKA8exm6aly0g8i2JU2SIKBXgMBQ8vxEGYJ9z1BjUTgp8w3dIlDfpkHkxfMWF49
	afq1NlaUSIu3MgK9NCxUQTkBg0Hc07Lmw=
X-Received: by 2002:a05:600c:8b2f:b0:479:3a86:dc1e with SMTP id 5b1f17b1804b1-47ee4840941mr32659375e9.36.1768406263009;
        Wed, 14 Jan 2026 07:57:43 -0800 (PST)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47ee85e8807sm7426475e9.16.2026.01.14.07.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 07:57:42 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Wed, 14 Jan 2026 15:57:17 +0000
Subject: [PATCH v5 05/14] perf parse-events: Track all user changed config
 bits
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260114-james-perf-config-bits-v5-5-0ef97aaf1ac0@linaro.org>
References: <20260114-james-perf-config-bits-v5-0-0ef97aaf1ac0@linaro.org>
In-Reply-To: <20260114-james-perf-config-bits-v5-0-0ef97aaf1ac0@linaro.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@linaro.org>, John Garry <john.g.garry@oracle.com>, 
 Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

Currently we only track which bits were set by the user in attr->config.
But all configN fields should be treated equally as they can all have
default and user overridden values.

Track them all by making get_config_chgs() generic and calling it once
for each config value.

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/evsel.c        |  9 +++-
 tools/perf/util/evsel_config.h |  6 ++-
 tools/perf/util/parse-events.c | 98 +++++++++++++++++++++++-------------------
 tools/perf/util/pmu.c          |  4 +-
 tools/perf/util/pmu.h          |  4 +-
 5 files changed, 70 insertions(+), 51 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 9ef94632106b..27f4b5212dc6 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1242,7 +1242,11 @@ static void evsel__apply_config_terms(struct evsel *evsel,
 		case EVSEL__CONFIG_TERM_AUX_SAMPLE_SIZE:
 			/* Already applied by auxtrace */
 			break;
-		case EVSEL__CONFIG_TERM_CFG_CHG:
+		case EVSEL__CONFIG_TERM_USR_CHG_CONFIG:
+		case EVSEL__CONFIG_TERM_USR_CHG_CONFIG1:
+		case EVSEL__CONFIG_TERM_USR_CHG_CONFIG2:
+		case EVSEL__CONFIG_TERM_USR_CHG_CONFIG3:
+		case EVSEL__CONFIG_TERM_USR_CHG_CONFIG4:
 			break;
 		case EVSEL__CONFIG_TERM_RATIO_TO_PREV:
 			rtp_buf = term->val.str;
@@ -1326,7 +1330,8 @@ void evsel__set_config_if_unset(struct evsel *evsel, const char *config_name,
 				u64 val)
 {
 	u64 user_bits = 0;
-	struct evsel_config_term *term = evsel__get_config_term(evsel, CFG_CHG);
+	struct evsel_config_term *term = evsel__get_config_term(evsel,
+								USR_CHG_CONFIG);
 	struct perf_pmu_format *format = pmu_find_format(&evsel->pmu->format,
 							 config_name);
 	int fbit;
diff --git a/tools/perf/util/evsel_config.h b/tools/perf/util/evsel_config.h
index 685fd8d5c4a8..7b565d76c0bc 100644
--- a/tools/perf/util/evsel_config.h
+++ b/tools/perf/util/evsel_config.h
@@ -27,7 +27,11 @@ enum evsel_term_type {
 	EVSEL__CONFIG_TERM_AUX_OUTPUT,
 	EVSEL__CONFIG_TERM_AUX_ACTION,
 	EVSEL__CONFIG_TERM_AUX_SAMPLE_SIZE,
-	EVSEL__CONFIG_TERM_CFG_CHG,
+	EVSEL__CONFIG_TERM_USR_CHG_CONFIG,
+	EVSEL__CONFIG_TERM_USR_CHG_CONFIG1,
+	EVSEL__CONFIG_TERM_USR_CHG_CONFIG2,
+	EVSEL__CONFIG_TERM_USR_CHG_CONFIG3,
+	EVSEL__CONFIG_TERM_USR_CHG_CONFIG4,
 	EVSEL__CONFIG_TERM_RATIO_TO_PREV,
 };
 
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 46422286380f..1f6e2213326d 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1253,66 +1253,32 @@ static int get_config_terms(const struct parse_events_terms *head_config,
 	return 0;
 }
 
-/*
- * Add EVSEL__CONFIG_TERM_CFG_CHG where cfg_chg will have a bit set for
- * each bit of attr->config that the user has changed.
- */
-static int get_config_chgs(struct perf_pmu *pmu, struct parse_events_terms *head_config,
-			   struct list_head *head_terms)
+static int add_cfg_chg(const struct perf_pmu *pmu,
+		       const struct parse_events_terms *head_config,
+		       struct list_head *head_terms,
+		       int format_type,
+		       enum parse_events__term_type term_type,
+		       enum evsel_term_type new_term_type)
 {
 	struct parse_events_term *term;
 	u64 bits = 0;
 	int type;
 
 	list_for_each_entry(term, &head_config->terms, list) {
-		switch (term->type_term) {
-		case PARSE_EVENTS__TERM_TYPE_USER:
+		if (term->type_term == PARSE_EVENTS__TERM_TYPE_USER) {
 			type = perf_pmu__format_type(pmu, term->config);
-			if (type != PERF_PMU_FORMAT_VALUE_CONFIG)
+			if (type != format_type)
 				continue;
 			bits |= perf_pmu__format_bits(pmu, term->config);
-			break;
-		case PARSE_EVENTS__TERM_TYPE_CONFIG:
+		} else if (term->type_term == term_type) {
 			bits = ~(u64)0;
-			break;
-		case PARSE_EVENTS__TERM_TYPE_CONFIG1:
-		case PARSE_EVENTS__TERM_TYPE_CONFIG2:
-		case PARSE_EVENTS__TERM_TYPE_CONFIG3:
-		case PARSE_EVENTS__TERM_TYPE_CONFIG4:
-		case PARSE_EVENTS__TERM_TYPE_LEGACY_HARDWARE_CONFIG:
-		case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE_CONFIG:
-		case PARSE_EVENTS__TERM_TYPE_NAME:
-		case PARSE_EVENTS__TERM_TYPE_SAMPLE_PERIOD:
-		case PARSE_EVENTS__TERM_TYPE_SAMPLE_FREQ:
-		case PARSE_EVENTS__TERM_TYPE_BRANCH_SAMPLE_TYPE:
-		case PARSE_EVENTS__TERM_TYPE_TIME:
-		case PARSE_EVENTS__TERM_TYPE_CALLGRAPH:
-		case PARSE_EVENTS__TERM_TYPE_STACKSIZE:
-		case PARSE_EVENTS__TERM_TYPE_NOINHERIT:
-		case PARSE_EVENTS__TERM_TYPE_INHERIT:
-		case PARSE_EVENTS__TERM_TYPE_MAX_STACK:
-		case PARSE_EVENTS__TERM_TYPE_MAX_EVENTS:
-		case PARSE_EVENTS__TERM_TYPE_NOOVERWRITE:
-		case PARSE_EVENTS__TERM_TYPE_OVERWRITE:
-		case PARSE_EVENTS__TERM_TYPE_DRV_CFG:
-		case PARSE_EVENTS__TERM_TYPE_PERCORE:
-		case PARSE_EVENTS__TERM_TYPE_AUX_OUTPUT:
-		case PARSE_EVENTS__TERM_TYPE_AUX_ACTION:
-		case PARSE_EVENTS__TERM_TYPE_AUX_SAMPLE_SIZE:
-		case PARSE_EVENTS__TERM_TYPE_METRIC_ID:
-		case PARSE_EVENTS__TERM_TYPE_RAW:
-		case PARSE_EVENTS__TERM_TYPE_CPU:
-		case PARSE_EVENTS__TERM_TYPE_RATIO_TO_PREV:
-		default:
-			break;
 		}
 	}
 
 	if (bits) {
 		struct evsel_config_term *new_term;
 
-		new_term = add_config_term(EVSEL__CONFIG_TERM_CFG_CHG,
-					   head_terms, false);
+		new_term = add_config_term(new_term_type, head_terms, false);
 		if (!new_term)
 			return -ENOMEM;
 		new_term->val.cfg_chg = bits;
@@ -1321,6 +1287,50 @@ static int get_config_chgs(struct perf_pmu *pmu, struct parse_events_terms *head
 	return 0;
 }
 
+/*
+ * Add EVSEL__CONFIG_TERM_USR_CFG_CONFIGn where cfg_chg will have a bit set for
+ * each bit of attr->configN that the user has changed.
+ */
+static int get_config_chgs(const struct perf_pmu *pmu,
+			   const struct parse_events_terms *head_config,
+			   struct list_head *head_terms)
+{
+	int ret;
+
+	ret = add_cfg_chg(pmu, head_config, head_terms,
+			  PERF_PMU_FORMAT_VALUE_CONFIG,
+			  PARSE_EVENTS__TERM_TYPE_CONFIG,
+			  EVSEL__CONFIG_TERM_USR_CHG_CONFIG);
+	if (ret)
+		return ret;
+
+	ret = add_cfg_chg(pmu, head_config, head_terms,
+			  PERF_PMU_FORMAT_VALUE_CONFIG1,
+			  PARSE_EVENTS__TERM_TYPE_CONFIG1,
+			  EVSEL__CONFIG_TERM_USR_CHG_CONFIG1);
+	if (ret)
+		return ret;
+
+	ret = add_cfg_chg(pmu, head_config, head_terms,
+			  PERF_PMU_FORMAT_VALUE_CONFIG2,
+			  PARSE_EVENTS__TERM_TYPE_CONFIG2,
+			  EVSEL__CONFIG_TERM_USR_CHG_CONFIG2);
+	if (ret)
+		return ret;
+
+	ret = add_cfg_chg(pmu, head_config, head_terms,
+			  PERF_PMU_FORMAT_VALUE_CONFIG3,
+			  PARSE_EVENTS__TERM_TYPE_CONFIG3,
+			  EVSEL__CONFIG_TERM_USR_CHG_CONFIG3);
+	if (ret)
+		return ret;
+
+	return add_cfg_chg(pmu, head_config, head_terms,
+			   PERF_PMU_FORMAT_VALUE_CONFIG4,
+			   PARSE_EVENTS__TERM_TYPE_CONFIG4,
+			   EVSEL__CONFIG_TERM_USR_CHG_CONFIG4);
+}
+
 int parse_events_add_tracepoint(struct parse_events_state *parse_state,
 				struct list_head *list,
 				const char *sys, const char *event,
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 7967d9159742..dc5dab69151f 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1349,7 +1349,7 @@ struct perf_pmu_format *pmu_find_format(const struct list_head *formats,
 	return NULL;
 }
 
-__u64 perf_pmu__format_bits(struct perf_pmu *pmu, const char *name)
+__u64 perf_pmu__format_bits(const struct perf_pmu *pmu, const char *name)
 {
 	struct perf_pmu_format *format = pmu_find_format(&pmu->format, name);
 	__u64 bits = 0;
@@ -1364,7 +1364,7 @@ __u64 perf_pmu__format_bits(struct perf_pmu *pmu, const char *name)
 	return bits;
 }
 
-int perf_pmu__format_type(struct perf_pmu *pmu, const char *name)
+int perf_pmu__format_type(const struct perf_pmu *pmu, const char *name)
 {
 	struct perf_pmu_format *format = pmu_find_format(&pmu->format, name);
 
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 3a53e1882cf1..7655d996090a 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -272,8 +272,8 @@ int perf_pmu__config_terms(const struct perf_pmu *pmu,
 			   struct parse_events_terms *terms,
 			   bool zero, bool apply_hardcoded,
 			   struct parse_events_error *error);
-__u64 perf_pmu__format_bits(struct perf_pmu *pmu, const char *name);
-int perf_pmu__format_type(struct perf_pmu *pmu, const char *name);
+__u64 perf_pmu__format_bits(const struct perf_pmu *pmu, const char *name);
+int perf_pmu__format_type(const struct perf_pmu *pmu, const char *name);
 int perf_pmu__check_alias(struct perf_pmu *pmu, struct parse_events_terms *head_terms,
 			  struct perf_pmu_info *info, bool *rewrote_terms,
 			  u64 *alternate_hw_config, struct parse_events_error *err);

-- 
2.34.1

