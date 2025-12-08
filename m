Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383EA311952
	for <linux-perf-users@vger.kernel.org>; Mon,  8 Dec 2025 14:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765203805; cv=none; b=ob+d36UDPMjG5noDL0rDNg/VIAgU61uXmC1tBwDfUP2l1MZck1xU1GcptJFxAWHkdx3BuXvOi0YfT0+0eJkgc44ZCW4X4NqCtU57ZeaWK3ssNs/x7iAsf26et7uUGSQ1tqoe1ZJQNUGZHzWpalSYgR/+PFH7Mw1qEKDdcissz9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765203805; c=relaxed/simple;
	bh=05Pbq0Jej4bAMFmDYk0LEbaSQ7hT79En5MlCfiT84iw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OBv+YB/ZMft1uC3jBg72yX/5ObNuTl6KbsxKk2mfUs1eOpV3reOmaHkrlTCQPDUVcxtCeigYml5g4FEjoK/Q5SWhHe8ToP8BLdsZv/6jyDNTozUbxRBdz/YExJrAyZYPg6QF8RgbqceBJ2y+ovU/5qWHMcbXT6L4ADeWqaleuZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eO9TJ4cM; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eO9TJ4cM"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-477aa218f20so28890895e9.0
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Dec 2025 06:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765203801; x=1765808601; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zdr/CpHFQzsUBx8MJgOEiksl8pXlmmWZkFYmwO0fchY=;
        b=eO9TJ4cMdRYKxlxE06p4ZetHT5hSAAUOExKjYi2azbgqZzm8f551KKbYJo4fr25zrO
         jaip3GEkceFFAM4mvmmLbyEV282df2yJZk+zdpLFLQo/4GljQsYAIAj7sqU8oWge/Pfi
         4z6kLuJOEApDISf+McxOOY1L3mvE+VWIgc5Yp4TalMqBn9vt03/IgDOTlpWrhGQc2UWN
         po+2G9RTDnvir9ofKL9AaUkuU0b31KyW14ejqW/2E7iqQHx5nLoZQE9u+oJRZPSySU+4
         qXTn7O8Rh98/HKlivJoFwYJAkkxQeBZr8b6TGU2mCkGbXNiLo917vAilwQBnn11QTeL6
         Q4Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765203801; x=1765808601;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Zdr/CpHFQzsUBx8MJgOEiksl8pXlmmWZkFYmwO0fchY=;
        b=hLxlngp4Z9eUeOjFDWx7p3T5jU8JzuLYWFtQ5VoI6gG8f/vV3HQiqfD+8iTkXujQEl
         aJjXYR9gGoCkUNa0u2MhIyNJT1bFmeXjIND5Flo1O7VjuweyBpmu6l841SMoNnPSp1X0
         SmTO1k7IzL3aOsHJxcMJqjNIoaxk6z9I6JVthSMynIKk5rA6u4UvAK7i/mmQN64b8/YS
         564i86PxVeI1ceEqG3wtsb9iptRPWrGVct3RkrPttCOBPAsFmrEzDWzIZhFyoZnhlZT+
         GpA9dXBocivDnC1j4APiMAomYjhHzJjvdZnfSkMhxy+ns+7xs4xXb4jmHHsBFaviJAnw
         YCwg==
X-Gm-Message-State: AOJu0YxiDHaR0/ZDeG05OTEqITmHyNkkfU8gy5oq22QcX1JCglhZbAos
	5OOKEtAS3LmTFMCCyKgvMitAGhYJRuJkM9BXFAVgCm4p9N2AKyMt2W0QQ1CbLgyS1FA=
X-Gm-Gg: ASbGncvk1pJUv+r1KO8SiSlVU7PyrkhDOEvd1j8Qi7CUqz/Tgoxf3AlEKaLFi5JlKXf
	fLnx2SZJYoU71hVRxuopYfukliQUMqc+kXr/BhNnd2AFvmY0yeXfEG7S/k7M8LaPf/s3cjDP6xq
	oF4IQRPHPwb8bWGSGWcKtcpTaEnULC5zI/AuMqIjV2c7jrP9bsrouMbtBXx/lBQAo8voI7d712G
	jdSGcrvla6dwX5V1XMLhQ0SnfxXzNA+IDnsTCyKdTBH/nYXjhEjiZEKbvgsvM0Qb6hp4RCV598P
	eypzwrU9q5CyXaNh1I/qADyz9l7JgzO2tdKf5d78jH+CFMEzCUnnl6vZ+E7/PAGmnZJ7ST7+ux6
	Mu2+uv872Gl90wOn5HUCHLjC6WbIvhgrPEj/MPLx6ajmwC4aQghiYcCPmfJR5K29RuQsCwdVYo5
	S1cX0jOlzLi7xU83MOigfk
X-Google-Smtp-Source: AGHT+IEu1SotQqoNDjmrD/hhBGtqy2G67QaRn20FmBFDWomVLO0SM2avnkCOuR5GDvM7Zf5p/BZfuw==
X-Received: by 2002:a05:600c:4743:b0:477:afc5:fb02 with SMTP id 5b1f17b1804b1-47939e246e0mr79322745e9.21.1765203801289;
        Mon, 08 Dec 2025 06:23:21 -0800 (PST)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47930920e0dsm248561065e9.2.2025.12.08.06.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 06:23:20 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Mon, 08 Dec 2025 14:22:06 +0000
Subject: [PATCH v2 03/12] perf parse-events: Track all user changed config
 bits
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251208-james-perf-config-bits-v2-3-4ac0281993b0@linaro.org>
References: <20251208-james-perf-config-bits-v2-0-4ac0281993b0@linaro.org>
In-Reply-To: <20251208-james-perf-config-bits-v2-0-4ac0281993b0@linaro.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@linaro.org>, John Garry <john.g.garry@oracle.com>, 
 Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>, leo.yan@arm.com
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
 tools/perf/util/parse-events.c | 98 +++++++++++++++++++++++-------------------
 tools/perf/util/pmu.c          |  2 +-
 4 files changed, 65 insertions(+), 47 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 9cd706f62793..dcadf022405d 100644
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
index d5b009b4ebab..7a3a90377896 100644
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
+static int add_cfg_chg(struct perf_pmu *pmu,
+		       struct parse_events_terms *head_config,
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
+static int get_config_chgs(struct perf_pmu *pmu,
+			   struct parse_events_terms *head_config,
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
index 2c26c8d76bed..e02f74d4020c 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1387,7 +1387,7 @@ void evsel__set_config_if_unset(struct perf_pmu *pmu, struct evsel *evsel,
 				const char *config_name, u64 val)
 {
 	u64 user_bits = 0, bits;
-	struct evsel_config_term *term = evsel__get_config_term(evsel, CFG_CHG);
+	struct evsel_config_term *term = evsel__get_config_term(evsel, USR_CHG_CONFIG);
 
 	if (term)
 		user_bits = term->val.cfg_chg;

-- 
2.34.1

