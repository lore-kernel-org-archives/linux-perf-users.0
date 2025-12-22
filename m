Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE0B322B93
	for <linux-perf-users@vger.kernel.org>; Mon, 22 Dec 2025 15:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766416496; cv=none; b=Z5nj2vQ7RvOvJp2qoXxiG4U05MRcLL1CTU3OqOBZmNZv/egRZ+c5dyuyvF5wfuThYshRDRHlG/2/1mMUUOrmh3CTH89vmdCRy95SV28UHeV7P9og4nSlwjoHCDZjR1tMv2zHAXi6MkJt5ScR6SX9WVpw6cKYqjTBPe9tWm6hj3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766416496; c=relaxed/simple;
	bh=91WocCuEtGZMcPX4yTHxa5nPnX5Yy14hUt5jFUQrOQA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pfSTo0IQWYAYtVCOdtaRkmeoy5Um+8Fz5NmzBHmd/BQ94X+Pi6o6IgoEVajVhrGQamUQAh3r57n6XIyByzILP3xQ67NoEBFA91xCr22KScIY64PlL1fECLXTzo0I2iXPNjHypQmE+kV/52xrJ4xbarUrH85ULuIoRCPYHV7BKPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nmIuNRgA; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nmIuNRgA"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-42e2ba54a6fso1798757f8f.3
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Dec 2025 07:14:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1766416492; x=1767021292; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LRxhQKZyRKVmSnLrclrpBhqFP+Noob/HLauI0TzjRkA=;
        b=nmIuNRgAkqIviALluRFu1gFKMzs355mEyG8fD2WoYDEzQjygfzM+29HlCIpMwK73x5
         95zVGiNfQ+TGLIflClR2GyMxAOZ506TOD7Q0VJxqQ9ko44qfQBaT+NUmTnOYf+OVCyhQ
         QmKI7Pm/IDgHH7M4h8PmXCucNfcvhbgbCOxf2qFnC5jrMikjCeRE4za4MVdaZQdmZfw3
         C9sHZi/WK7DmEGxYS6xMiccC5xbxOLMnPbH5rCyO93RSX41ptZOX0fj0VoTAdnyocwTH
         PQ+j3elJHiSmLMscLT6bRqpnCMdX+yiUg9QIn/lkLwr6sar86CqjRJM1Eo0RTeSE+wrS
         xu/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766416492; x=1767021292;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LRxhQKZyRKVmSnLrclrpBhqFP+Noob/HLauI0TzjRkA=;
        b=CPYymvVrLHfTb8tAKe+UdShzFokeAakTkajqn9Sh9gOGu8ft7GLe3CJc4zViPb1pjG
         HqeqLlX9+zUZ0nTSZW9fAw5PRnusQ6cPCOuM9Lw6XQLaQWvS/imi7vlUIeQK3A/w3+a5
         G0wyW+ncTdVGNuZyKLFDhbhU/797slj5Qr92/nlchfg/kxLZK5JwQRMvOfwb2hd6bbd2
         Ma2yjUei0LcuTx0aQM8ORaZF3dBnXamUww6LoGV/lB2kyOMMfsPkWpNvCHfWNIK3PSQZ
         +9d7FuLOxYPU5tdjupLmIAAihtXvxzS+C6tP3jVf9zBspGvn0J2471pbz3VjWTc3kE6+
         NbCw==
X-Gm-Message-State: AOJu0Ywm5nvyiIL2e5t0koHzznBCZ9/tkXsXnK/QpB4dQ5dIhpN3N8Yd
	e1VfMbMC67MMprFv2fWmWGQBKDUFj6OU3P3oXkRsXOyK2BSaxKlqegEXl5+mtUtBZig=
X-Gm-Gg: AY/fxX59vBuTo1YIBnxix9QNFrMOhFwK53K1W8B90cWDA4e99cQAiRdO2EQUacjYc6U
	PK/oCh4w9FKJaYB9E1y9Gxi2ni8l0EdGL0qZMGm6WBUXWeJQWkyldrVChOlAWHOri7SYglMIPQw
	vjnWqUZs2k9MANRfcY7gRrbHG79KtPvkmkh6QnPgAEx0NuQpYMjS91wyyh7V/xqZlC56IKW/eL6
	QMgNAkLjqfiFIFfr/k6k1BKS1uVe4q0OWUaC1ahCkDsqDHKgYsOKXMCuvxfcjdub5fGLitN9Xq1
	t6W/g48/KwsB8YMeMYibc6z37KnsVWQS+U1/sF8oQBK4q6IFPAK3dPYR3SIccYT35Up1wng9YUc
	HRMWeuwlIpVzm5i7ySwOt++G/zWouI9HRKbJfGumwS7AG5lS4cnB/dbCvYsNPZwcfx8R/Va3ZsF
	pCMXXNFIbC5Y+/HTGhWAzU
X-Google-Smtp-Source: AGHT+IHwBl/i824ujclP4sQLnrEvoMmybqJO1H8NlqTrzpxaH4/PUebErsbiPsvXrvCvQSiuhI0y+w==
X-Received: by 2002:a05:6000:1acc:b0:431:327:5dc2 with SMTP id ffacd0b85a97d-4324e50a6acmr13487321f8f.51.1766416492214;
        Mon, 22 Dec 2025 07:14:52 -0800 (PST)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea830fesm22750093f8f.20.2025.12.22.07.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 07:14:51 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Mon, 22 Dec 2025 15:14:30 +0000
Subject: [PATCH v4 05/14] perf parse-events: Track all user changed config
 bits
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251222-james-perf-config-bits-v4-5-0608438186fc@linaro.org>
References: <20251222-james-perf-config-bits-v4-0-0608438186fc@linaro.org>
In-Reply-To: <20251222-james-perf-config-bits-v4-0-0608438186fc@linaro.org>
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
index 45ab97beeb34..354e28e94523 100644
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
 	u64 user_bits = 0, bits;
-	struct evsel_config_term *term = evsel__get_config_term(evsel, CFG_CHG);
+	struct evsel_config_term *term = evsel__get_config_term(evsel,
+								USR_CHG_CONFIG);
 
 	if (term)
 		user_bits = term->val.cfg_chg;
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
index 599fdf5e28ba..2fe92b4b6e02 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1374,7 +1374,7 @@ pmu_find_format(const struct list_head *formats, const char *name)
 	return NULL;
 }
 
-__u64 perf_pmu__format_bits(struct perf_pmu *pmu, const char *name)
+__u64 perf_pmu__format_bits(const struct perf_pmu *pmu, const char *name)
 {
 	struct perf_pmu_format *format = pmu_find_format(&pmu->format, name);
 	__u64 bits = 0;
@@ -1389,7 +1389,7 @@ __u64 perf_pmu__format_bits(struct perf_pmu *pmu, const char *name)
 	return bits;
 }
 
-int perf_pmu__format_type(struct perf_pmu *pmu, const char *name)
+int perf_pmu__format_type(const struct perf_pmu *pmu, const char *name)
 {
 	struct perf_pmu_format *format = pmu_find_format(&pmu->format, name);
 
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index e34db47ae5ef..7bf5b23d0ea1 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -247,8 +247,8 @@ int perf_pmu__config_terms(const struct perf_pmu *pmu,
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

