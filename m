Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F90C309DB1
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Dec 2025 16:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764607307; cv=none; b=A461I5In9cM1N8G7qJ/+o9PZPwZFDKccO1ZlSy1tChufoHwe83nlRsoGJZOq9Bnf1Sbs5anLQTQM0iql0Dti3inpZC2Tm5GGIK15OhYQOk4j1cSiTDTn45rh4wucSa6sHuKs2JmO5mzClx2PYEf3B/JHjT2IPr87YrBNbnndpzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764607307; c=relaxed/simple;
	bh=dqPYxclE8clNaUE70K6dYoTwOjZL2Yh9P7yQKVdwzAE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SgAjWDkfiC8PeNMhArz5/qEkaBBo4HDjX0Dxzr5GUWQUNcX8YrujkNSE9kyxWCnc333e8jNFofhiSumlFH9KtgsDHq7e6dlp1zwioKiOXC9WksFgMefpohGMS47xjJkpBHQ3RuF7HidatzqZFlw6SzM2Lvbb4vJ9y4ZDAnH4NlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SmF8om9x; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SmF8om9x"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47798ded6fcso25228785e9.1
        for <linux-perf-users@vger.kernel.org>; Mon, 01 Dec 2025 08:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764607304; x=1765212104; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FfR7ElwjGMeri5/LxymMctivyxTyAEttbJyLwb22O4o=;
        b=SmF8om9xPzhsuoehVsAqx/0v95hmWttSapJoBG9x8+ddMm4r6IZdRuZkW9RjxiSphz
         B+uIIejvfAMPAES22b+sTUMsbmS1h9xYlLGJ4Ah9RvAVHhmd7qRutrj6E8x+t5U46cse
         K3ZQ4HNHjnsaeohPSKb1W6i2QFF8Jtr2sN5KvpHd4h2tJUX8LitRaLsCdMNB4XeNBX18
         9UC/nXOgZ3vNpd5c1cMVhl+CQX0VyeZs+ePOMiBnSzbFHYn9ICUJjq04BPFEEBtlEg1w
         mBBljnNmBMvjbUHNe3qj2yfWZ+jz/i7TSXXw38HNn/I88/wrAU1PiU/7/yZy+kTSZ10e
         JLpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764607304; x=1765212104;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FfR7ElwjGMeri5/LxymMctivyxTyAEttbJyLwb22O4o=;
        b=DtnXM7LIy9PVr/j1HMo2msPaDW96qLqjlQeCjCn1+X0JFhmX+ZGIBYbWmiyXsXJ3KW
         Z8DvQIxuuJq2Prl4PR8QAb54owpoOVmFRft6OG2URgB/45vb+LOPa6c0T5mTNpiOk9if
         r5fgVo0WJVk89useXawtkptRaj+Dgj44uq3+BWCkfItcdHOH1ICsyWafsdKghmUnhaXq
         LUx1FplTKyGDd7fsH1aMKDTQThWWAoXv0i65VfTJLioxqIjE3ZKfFHzM4DBUs+CLHmHk
         zFjYLH8dg67KITfbSWWv6e3pCXTD0u5v+eCUg0CQdM+P15R9qcENA+46NpEkuT6KA7tN
         yESg==
X-Gm-Message-State: AOJu0YzOvNZjt0CvFhNZdYNc2ry3tVd5Rcfx7V3aarrua/t1s5FRPEq1
	p6T1fBF33FO7oX9U6E6lOObffoVQm5ZYwqaUhzsJ02EXQKJK/8iw9P6TJjURP8bPLLk=
X-Gm-Gg: ASbGncsIGlHfvCSftWMMYkfMjkC1L4BxpZvtms9ce/WBekD580Sfk+XwLIl2SUf2HCK
	H9op1r1Hv9MyWEHXlT2CpSRA/4GB4Z4ltbZxm1khCfdc3nJaVFl5Rj/jPK4V47gDxJQZrNufZC+
	ZkrVUKSugdBcvIf/59k7rTLC0Z/hY0A+UcU9upgSSOv/Df/EbORgIctP73i2uHS/xiZ+p9Xq+Xx
	QXqBG+bpD7wqXxHrUezrLsNEZA8EnT9c9zFuy5MGY3pdtInLJ4cq/75RNqxPE6slabhCiAq7+DC
	IMDmvF9uR7MOQbk6Hx5ulABeQYKS/mTbMiNl7hGKwIUccY5qyKrVBYfA/VUDWiNTGkKRxByt6QQ
	lgTLIdHUF5lnl9KeUZ0YG2dSk2/B0zHSS/vfiUZIPhXWWpyzzKnqD8gbfuaeBLgbUPH4GHeYOCC
	0GM25328V6BtZY47Ee+iVbp6pbXcgUD3o=
X-Google-Smtp-Source: AGHT+IFs/oaEFLmVc1n33HTh9cmjBtXa2KO56yE2ZPb/iAdAngVrwNGZgh5ta3HeUo0YoAjxOysIHA==
X-Received: by 2002:a05:600c:3511:b0:476:d494:41d2 with SMTP id 5b1f17b1804b1-477c112f7b1mr386734245e9.29.1764607304153;
        Mon, 01 Dec 2025 08:41:44 -0800 (PST)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4791164d4f3sm255901275e9.13.2025.12.01.08.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 08:41:43 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Mon, 01 Dec 2025 16:41:04 +0000
Subject: [PATCH 1/7] perf tools: Track all user changed config bits
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251201-james-perf-config-bits-v1-1-22ecbbf8007c@linaro.org>
References: <20251201-james-perf-config-bits-v1-0-22ecbbf8007c@linaro.org>
In-Reply-To: <20251201-james-perf-config-bits-v1-0-22ecbbf8007c@linaro.org>
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

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/evsel.c        |  6 ++-
 tools/perf/util/evsel_config.h |  6 ++-
 tools/perf/util/parse-events.c | 89 +++++++++++++++++-------------------------
 tools/perf/util/pmu.c          |  2 +-
 4 files changed, 47 insertions(+), 56 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index aee42666e882..40d68f346007 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1238,7 +1238,11 @@ static void evsel__apply_config_terms(struct evsel *evsel,
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
diff --git a/tools/perf/util/evsel_config.h b/tools/perf/util/evsel_config.h
index bcd3a978f0c4..b38190dc5a40 100644
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
index 17c1c36a7bf9..f1cc6e96a371 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1235,63 +1235,46 @@ do {								\
 	return 0;
 }
 
+#define ADD_CONFIG_CHG(format_type, term_type, new_term)		\
+{									\
+	struct parse_events_term *term;					\
+	u64 bits = 0;							\
+	int type;							\
+									\
+	list_for_each_entry(term, &head_config->terms, list) {		\
+		if (term->type_term == PARSE_EVENTS__TERM_TYPE_USER) {  \
+			type = perf_pmu__format_type(pmu, term->config);\
+			if (type != format_type)			\
+				continue;				\
+			bits |= perf_pmu__format_bits(pmu, term->config); \
+		} else if (term->type_term == term_type) {		\
+			bits = ~(u64)0;					\
+		}							\
+	}								\
+									\
+	if (bits)							\
+		ADD_CONFIG_TERM_VAL(new_term, cfg_chg, bits, false);	\
+	return 0;							\
+}
+
 /*
- * Add EVSEL__CONFIG_TERM_CFG_CHG where cfg_chg will have a bit set for
- * each bit of attr->config that the user has changed.
+ * Add EVSEL__CONFIG_TERM_USR_CFG_CONFIGn where cfg_chg will have a bit set for
+ * each bit of attr->configN that the user has changed.
  */
-static int get_config_chgs(struct perf_pmu *pmu, struct parse_events_terms *head_config,
+static int get_config_chgs(struct perf_pmu *pmu,
+			   struct parse_events_terms *head_config,
 			   struct list_head *head_terms)
 {
-	struct parse_events_term *term;
-	u64 bits = 0;
-	int type;
-
-	list_for_each_entry(term, &head_config->terms, list) {
-		switch (term->type_term) {
-		case PARSE_EVENTS__TERM_TYPE_USER:
-			type = perf_pmu__format_type(pmu, term->config);
-			if (type != PERF_PMU_FORMAT_VALUE_CONFIG)
-				continue;
-			bits |= perf_pmu__format_bits(pmu, term->config);
-			break;
-		case PARSE_EVENTS__TERM_TYPE_CONFIG:
-			bits = ~(u64)0;
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
-		}
-	}
-
-	if (bits)
-		ADD_CONFIG_TERM_VAL(CFG_CHG, cfg_chg, bits, false);
+	ADD_CONFIG_CHG(PERF_PMU_FORMAT_VALUE_CONFIG,
+		       PARSE_EVENTS__TERM_TYPE_CONFIG, USR_CHG_CONFIG);
+	ADD_CONFIG_CHG(PERF_PMU_FORMAT_VALUE_CONFIG1,
+		       PARSE_EVENTS__TERM_TYPE_CONFIG1, USR_CHG_CONFIG1);
+	ADD_CONFIG_CHG(PERF_PMU_FORMAT_VALUE_CONFIG2,
+		       PARSE_EVENTS__TERM_TYPE_CONFIG2, USR_CHG_CONFIG2);
+	ADD_CONFIG_CHG(PERF_PMU_FORMAT_VALUE_CONFIG3,
+		       PARSE_EVENTS__TERM_TYPE_CONFIG3, USR_CHG_CONFIG3);
+	ADD_CONFIG_CHG(PERF_PMU_FORMAT_VALUE_CONFIG4,
+		       PARSE_EVENTS__TERM_TYPE_CONFIG4, USR_CHG_CONFIG4);
 
 #undef ADD_CONFIG_TERM
 	return 0;
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 1b7c712d8f99..7a7db31be70d 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1384,7 +1384,7 @@ void evsel__set_config_if_unset(struct perf_pmu *pmu, struct evsel *evsel,
 				const char *config_name, u64 val)
 {
 	u64 user_bits = 0, bits;
-	struct evsel_config_term *term = evsel__get_config_term(evsel, CFG_CHG);
+	struct evsel_config_term *term = evsel__get_config_term(evsel, USR_CHG_CONFIG);
 
 	if (term)
 		user_bits = term->val.cfg_chg;

-- 
2.34.1

