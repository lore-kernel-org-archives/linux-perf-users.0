Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D6A31B110
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Dec 2025 15:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765553571; cv=none; b=dXxZxZDupdE1ZRAYHxZFNys8X42n1cqcUVXtKy3xOYTeRuCF7FL1VM1CcxwZHLDU3uWdFg1Nx59CM6nWbAqo/D9J0Txmu4Asq0h+a97ryDpFYGhozSERtN3lQiCpe+LRPMzkVCJvSENJ34bdkRLyxGncWoqPXgPeGRvoZTaPAE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765553571; c=relaxed/simple;
	bh=vWZqMcToevyun2DaJzmwXDwT5hN4jpmu6pxtripRP0Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tTyHvq1jDHiHwi0TL4a1jje3vCqApvugXw97sjU/y/hyYZysxv/vTotkiWjI+aNeWQhS5kjFHrBbI12UY980jYCxfRCQZYRpQWaLSGLTyAcLLyfGCBMjthZKp8084Xq1U8m+sReN7Z6bH8ebQEow3i7p2Rdj1WpxsRdKWFjTADA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aSjFq0le; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aSjFq0le"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-63c489f1e6cso2746392a12.1
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Dec 2025 07:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765553567; x=1766158367; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xSulanRhWm+TOJEsIJX6kByj32cTVV8wVNthl+pdTvs=;
        b=aSjFq0ler4sXWOBOeLIgy20ZRgKhLxaS/E4bBC6+GKKhbTWkhLJCQmqtuoqkLibUu5
         Lw6wKnJDuh45R8wybS1DaDAfK7bzuUTm+leX8qH9qL0ASInFQB+0+jVL2RoNoo/ESkKI
         e7ZKSULG7D/eh7Jalew4rhUgC9D48sH8ZZZnSPhpKxIY6XWBgj/6RnXBrae55V0OuBQ2
         ZZpTG43uzOwXOBkcsn2NbW8N6GFVbCZgdRqqh/eHCdPk/5ugnENPZn65SJrtJhmfsJQ7
         bSSaxMVApFoGyXp9VFWAAPdbdJsQHTVsxpu0C+j8KOledF7c7wIZn0CU2icrN9J14xMa
         gI/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765553567; x=1766158367;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xSulanRhWm+TOJEsIJX6kByj32cTVV8wVNthl+pdTvs=;
        b=svdgpBlsnAZJRupp2qkIS7SpfAs11RLY+6JOSO+Tyi+8mi8zKcjF7Q0x/GOYb8rHo0
         UZL1keVGkM1W5FJ1mDGmZngdE0J2Xm/X6HROqnQoWda85DYmkSN7oSZjWunL2nQyF+jB
         vFN+alyzgMfAB96KNyST8wDIwKaEzoDde3oAL1Ymb4r8avs/2f9pdllo17KtSg+rZnVT
         ctoVYeXXmXHeIBh2Itrc33iQ7RRxH9583ASu7EosAIcchf4K9C3Uq5ZhN3WtywTNaQHV
         qa5oFNIflmmxX8y1SIPjxWJdJd9/N3r38CsQ5MP5yMvfHUxwM6tj33bKINcsT4GBSRLf
         Xfeg==
X-Gm-Message-State: AOJu0YwrDWhcATCXdUhkzNIOMxLqusm+OCm6qZKgy1FtqGNKVeX2n6Tg
	q89VpZY0DYJdmXSYgds9H2/z0bQT6iiu1csEBfVv9+9lOG5szlO+kI3d4HpuoumnND4=
X-Gm-Gg: AY/fxX4LqPn4zU86n7RSee1UShZi9GX1lJVHjLT3HwOH61VMUpAG2ADGiOdEV99vdcA
	h6Op5Mx7S/+5sFUDGWX5jvt8xM67qJThq/Ks48M5Va2Xg00kXk6K2jflT92zyOpdHWQ1RC04QGD
	VVo/zE/qY0QHPEx528ZOK3s7IaaUEfecNhMQTxO9C59np9p9BFcek2dWyJFOwKV41iTFfjo7G3C
	qZPGs6KV6VCZF19QnUNY2NilzVfVisidSP1OlYm/7cGq2bpI3x89skqkJXUG3LANHqrFUFuZ1Kf
	H5BHfhYK/FlWVV1Eq3tcIDFoFt6ghzX71CFKafFy/d9Ngu8sa7QFBM4e3IL8uB6PYHCoi8jd9ky
	w37aSMa09rWw+QWniJGqfyfn2qKcRM/o0dxXHtpfH4DOFlQsYxjlfdio8KIjXZncVPU0IitAt/a
	KmMWlJa5A/l8yFfh8jnZg6
X-Google-Smtp-Source: AGHT+IE0jsBzIwoiXf1j1BrrX+hYReRJK59uu92Fpw79dVuN+GXXuARzuNi4SxAAGM0C7gWCzIiRtA==
X-Received: by 2002:aa7:c642:0:b0:640:931e:ccac with SMTP id 4fb4d7f45d1cf-6498745a2a9mr3880322a12.7.1765553567457;
        Fri, 12 Dec 2025 07:32:47 -0800 (PST)
Received: from e133063.arm.com ([130.185.218.160])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6498210ed32sm5433234a12.29.2025.12.12.07.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 07:32:46 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Fri, 12 Dec 2025 17:32:20 +0200
Subject: [PATCH v3 03/12] perf parse-events: Track all user changed config
 bits
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251212-james-perf-config-bits-v3-3-aa36a4846776@linaro.org>
References: <20251212-james-perf-config-bits-v3-0-aa36a4846776@linaro.org>
In-Reply-To: <20251212-james-perf-config-bits-v3-0-aa36a4846776@linaro.org>
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
X-Mailer: b4 0.14.2

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
index 9cd706f6279313c2cc53eba1adbd45f352090f75..dcadf022405d398bf394b3da7f0db5c81a3ec268 100644
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
index 685fd8d5c4a88fb8ae601ded60c1fc36dde73403..7b565d76c0bc4277effbbf950110986b423f571c 100644
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
index 46422286380f33a48087e7079a45bb21beb2d573..7ef63b808d0542999fd1303b9f94cae68e38030f 100644
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
index 2c26c8d76bed920c7b5b43beb867e4d1bcaa2970..e02f74d4020c151082ecc434c29c0ec4c2c9b2c8 100644
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

