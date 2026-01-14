Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACF41509AB
	for <linux-perf-users@vger.kernel.org>; Wed, 14 Jan 2026 15:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768406261; cv=none; b=ewVY/HsvNXChveEKdH12k/xqOupBwqXWsyxxL+1U+jrqQdqaFeDEyVxQFqr4Gc06/CAHIiYTq6ChsFy1KqE5OeRTIW7mOiB5W/259kd74M8vLtjQpSsCyHhlxQLkereCk/oeKpsVyIeB733jAskXZwk5TGaJjj4+YMt9XiwUark=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768406261; c=relaxed/simple;
	bh=PAkf0NbnSlWBogq8yeUp6HixGYaT60O+RjPgTXYfoto=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h3gG5KCYwW7EW4e2QMdp0obNTj3uEIDCXsycAdI6wghFWJlHVi5dbLALROg9pbXC7tZSFJwR1SbOjNGv396s1zXjns0b8UldELk+o24J7C12joXVTxewIX0c9KjqqhRUT2asWqGGaZ81H/Z+WNRGzdYBSzEt7rIGhRiGd28mgcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ju/1RPEN; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ju/1RPEN"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47ee3da7447so5625e9.0
        for <linux-perf-users@vger.kernel.org>; Wed, 14 Jan 2026 07:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768406258; x=1769011058; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dLNSFy2x/hIrhk0Ax93bLHz2woErNJIZ/GG5lWWV+fA=;
        b=Ju/1RPENCdRgOBDcSMdbwSObg44vCqGD9MmUs5H1rSSk3AZcePcYjyeAWCF2nl+ka9
         B4fpEYlGMa1DgElKbEG3K75JmoiZ7c/Ezic3uhdaAR9ynRCoLIZZkKePrUNrHk9oH/ul
         B1FkLMxzTA+ynlGAfBEcMJebnqnK8DbkZ6+CPnnP0sqXmTlsv1WPqAF4NNuYrWkhFqVm
         V+Ad3mImSX25r39Lck7XfmZSkNyYT3PpW+UHxu+0GthJK8asTlm+SD6phCQvi81cr04M
         2RVoVvo8fqQXc5wQWKwWFmixp1pOh/6pRFo0cldHxvvedzB7LDjXPXduulizqg2YAsOe
         O6Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768406258; x=1769011058;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dLNSFy2x/hIrhk0Ax93bLHz2woErNJIZ/GG5lWWV+fA=;
        b=b22vN8jDxYlPfkBzquY++bui3Q55jn1e1rz3mGF0kASD5AJuWtLzPaz4yYFZgnnaOh
         vz12kl+jBhaSYLoKNdm4pneBBmyo6KpJXXF0fSpBlptkcOYeCQZ32/Bc4fPJO8NgBr04
         vHBKJFI2ZoqkAHDT8Dnc6hFoRqo8ucsqgwU/vRcy8oMizcopL1EGEjlpTD5u+pRuxRoi
         fy2bOi3BWkIC7O/xZrZhI6BpKWHTEFA6Hiyt8Y+zA1Oz+WpHBK0oERMVJUlJqwAwVBze
         QSqNycAqAJQL6MtmFQ4zppkCV23G228rtCh/CHlLpq8usijNfAznKOpruqfYTmFKT5ZS
         2Pow==
X-Gm-Message-State: AOJu0Ywl6xw8QHLQHcnQNTkcipOTMwXaJ1En3IFPYD1z3jaCOuHEcE7b
	rHuu+1CuWxOViCpn3sCqL5bIMwhkWc1lzDRzf0Y9B6fPmYchNKPTFkfDvW2V0FG9FKw=
X-Gm-Gg: AY/fxX6VYlHMw59zviXMZkXmc3o2ZoBcpccPnHo34PA6Ul++BQ/ANgttCYaaOTINk5L
	lXnTk8SlDjJxvHSCTq3Km7eD/boN4sIMalkNkkhyeLR/0QS+m57gSqCBa5qdlzaryUhBrVv5YaO
	ryOGA7TJmMFcW4vVeUv6ZCp+Im5pDbrO5Dm1eXO3mpuaRCc9xPHW74WbdcCEnb9AgiMKtRJjPa3
	EM6uooQbEkThoD+A3t34QSubK0cVPWbJRjbGMD2F2y+6o47iMqtCsT7s/+6WTqb0dSlm+tE40Q7
	z4zfiugYpgQ2zKI8d0yXOnQnFMtDO9B+3s9PB/NYFYTWQpdX2XrV6C1+J2zphbAgHwVWRnhZ3Iz
	G4W85E4LX+HZB0B+FJp9VSBEeblAaOlKVEEPMxcFekt2/Yt7fQsY3+ztxTqU+OMLK9ClfCw0Zjr
	qQYmaea4xchxXd3EaM3eXr0BbyJ11LCf4=
X-Received: by 2002:a05:600c:8b58:b0:47e:d943:ec08 with SMTP id 5b1f17b1804b1-47ee483adc2mr28644605e9.28.1768406257990;
        Wed, 14 Jan 2026 07:57:37 -0800 (PST)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47ee85e8807sm7426475e9.16.2026.01.14.07.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 07:57:37 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Wed, 14 Jan 2026 15:57:13 +0000
Subject: [PATCH v5 01/14] perf parse-events: Refactor get_config_terms() to
 remove macros
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260114-james-perf-config-bits-v5-1-0ef97aaf1ac0@linaro.org>
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

The ADD_CONFIG_TERM() macros build the __type argument out of a partial
EVSEL__CONFIG_TERM_x enum name. This means that they can't be called
from a function where __type is a variable and it's also impossible to
grep the codebase to find usages of these enums as they're never typed
in full.

Fix this by removing the macros and replacing them with an
add_config_term() function. It seems the main reason these existed in
the first place was to avoid type punning and to write to a specific
field in the union, but the same thing can be achieved with a single
write to a u64 'val' field.

Running the Perf tests with "-fsanitize=undefined -fno-sanitize-recover"
results in no new issues as a result of this change.

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/evsel_config.h |   1 +
 tools/perf/util/parse-events.c | 146 ++++++++++++++++++++++++-----------------
 2 files changed, 86 insertions(+), 61 deletions(-)

diff --git a/tools/perf/util/evsel_config.h b/tools/perf/util/evsel_config.h
index bcd3a978f0c4..685fd8d5c4a8 100644
--- a/tools/perf/util/evsel_config.h
+++ b/tools/perf/util/evsel_config.h
@@ -50,6 +50,7 @@ struct evsel_config_term {
 		u64	      cfg_chg;
 		char	      *str;
 		int	      cpu;
+		u64	      val;
 	} val;
 	bool weak;
 };
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 17c1c36a7bf9..46422286380f 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1116,105 +1116,107 @@ static int config_attr(struct perf_event_attr *attr,
 	return 0;
 }
 
-static int get_config_terms(const struct parse_events_terms *head_config,
-			    struct list_head *head_terms)
+static struct evsel_config_term *add_config_term(enum evsel_term_type type,
+						 struct list_head *head_terms,
+						 bool weak)
 {
-#define ADD_CONFIG_TERM(__type, __weak)				\
-	struct evsel_config_term *__t;			\
-								\
-	__t = zalloc(sizeof(*__t));				\
-	if (!__t)						\
-		return -ENOMEM;					\
-								\
-	INIT_LIST_HEAD(&__t->list);				\
-	__t->type       = EVSEL__CONFIG_TERM_ ## __type;	\
-	__t->weak	= __weak;				\
-	list_add_tail(&__t->list, head_terms)
-
-#define ADD_CONFIG_TERM_VAL(__type, __name, __val, __weak)	\
-do {								\
-	ADD_CONFIG_TERM(__type, __weak);			\
-	__t->val.__name = __val;				\
-} while (0)
+	struct evsel_config_term *t;
 
-#define ADD_CONFIG_TERM_STR(__type, __val, __weak)		\
-do {								\
-	ADD_CONFIG_TERM(__type, __weak);			\
-	__t->val.str = strdup(__val);				\
-	if (!__t->val.str) {					\
-		zfree(&__t);					\
-		return -ENOMEM;					\
-	}							\
-	__t->free_str = true;					\
-} while (0)
+	t = zalloc(sizeof(*t));
+	if (!t)
+		return NULL;
+
+	INIT_LIST_HEAD(&t->list);
+	t->type = type;
+	t->weak	= weak;
+	list_add_tail(&t->list, head_terms);
 
+	return t;
+}
+
+static int get_config_terms(const struct parse_events_terms *head_config,
+			    struct list_head *head_terms)
+{
 	struct parse_events_term *term;
 
 	list_for_each_entry(term, &head_config->terms, list) {
+		struct evsel_config_term *new_term;
+		enum evsel_term_type new_type;
+		bool str_type = false;
+		u64 val;
+
 		switch (term->type_term) {
 		case PARSE_EVENTS__TERM_TYPE_SAMPLE_PERIOD:
-			ADD_CONFIG_TERM_VAL(PERIOD, period, term->val.num, term->weak);
+			new_type = EVSEL__CONFIG_TERM_PERIOD;
+			val = term->val.num;
 			break;
 		case PARSE_EVENTS__TERM_TYPE_SAMPLE_FREQ:
-			ADD_CONFIG_TERM_VAL(FREQ, freq, term->val.num, term->weak);
+			new_type = EVSEL__CONFIG_TERM_FREQ;
+			val = term->val.num;
 			break;
 		case PARSE_EVENTS__TERM_TYPE_TIME:
-			ADD_CONFIG_TERM_VAL(TIME, time, term->val.num, term->weak);
+			new_type = EVSEL__CONFIG_TERM_TIME;
+			val = term->val.num;
 			break;
 		case PARSE_EVENTS__TERM_TYPE_CALLGRAPH:
-			ADD_CONFIG_TERM_STR(CALLGRAPH, term->val.str, term->weak);
+			new_type = EVSEL__CONFIG_TERM_CALLGRAPH;
+			str_type = true;
 			break;
 		case PARSE_EVENTS__TERM_TYPE_BRANCH_SAMPLE_TYPE:
-			ADD_CONFIG_TERM_STR(BRANCH, term->val.str, term->weak);
+			new_type = EVSEL__CONFIG_TERM_BRANCH;
+			str_type = true;
 			break;
 		case PARSE_EVENTS__TERM_TYPE_STACKSIZE:
-			ADD_CONFIG_TERM_VAL(STACK_USER, stack_user,
-					    term->val.num, term->weak);
+			new_type = EVSEL__CONFIG_TERM_STACK_USER;
+			val = term->val.num;
 			break;
 		case PARSE_EVENTS__TERM_TYPE_INHERIT:
-			ADD_CONFIG_TERM_VAL(INHERIT, inherit,
-					    term->val.num ? 1 : 0, term->weak);
+			new_type = EVSEL__CONFIG_TERM_INHERIT;
+			val = term->val.num ? 1 : 0;
 			break;
 		case PARSE_EVENTS__TERM_TYPE_NOINHERIT:
-			ADD_CONFIG_TERM_VAL(INHERIT, inherit,
-					    term->val.num ? 0 : 1, term->weak);
+			new_type = EVSEL__CONFIG_TERM_INHERIT;
+			val = term->val.num ? 0 : 1;
 			break;
 		case PARSE_EVENTS__TERM_TYPE_MAX_STACK:
-			ADD_CONFIG_TERM_VAL(MAX_STACK, max_stack,
-					    term->val.num, term->weak);
+			new_type = EVSEL__CONFIG_TERM_MAX_STACK;
+			val = term->val.num;
 			break;
 		case PARSE_EVENTS__TERM_TYPE_MAX_EVENTS:
-			ADD_CONFIG_TERM_VAL(MAX_EVENTS, max_events,
-					    term->val.num, term->weak);
+			new_type = EVSEL__CONFIG_TERM_MAX_EVENTS;
+			val = term->val.num;
 			break;
 		case PARSE_EVENTS__TERM_TYPE_OVERWRITE:
-			ADD_CONFIG_TERM_VAL(OVERWRITE, overwrite,
-					    term->val.num ? 1 : 0, term->weak);
+			new_type = EVSEL__CONFIG_TERM_OVERWRITE;
+			val = term->val.num ? 1 : 0;
 			break;
 		case PARSE_EVENTS__TERM_TYPE_NOOVERWRITE:
-			ADD_CONFIG_TERM_VAL(OVERWRITE, overwrite,
-					    term->val.num ? 0 : 1, term->weak);
+			new_type = EVSEL__CONFIG_TERM_OVERWRITE;
+			val = term->val.num ? 0 : 1;
 			break;
 		case PARSE_EVENTS__TERM_TYPE_DRV_CFG:
-			ADD_CONFIG_TERM_STR(DRV_CFG, term->val.str, term->weak);
+			new_type = EVSEL__CONFIG_TERM_DRV_CFG;
+			str_type = true;
 			break;
 		case PARSE_EVENTS__TERM_TYPE_PERCORE:
-			ADD_CONFIG_TERM_VAL(PERCORE, percore,
-					    term->val.num ? true : false, term->weak);
+			new_type = EVSEL__CONFIG_TERM_PERCORE;
+			val = term->val.num ? true : false;
 			break;
 		case PARSE_EVENTS__TERM_TYPE_AUX_OUTPUT:
-			ADD_CONFIG_TERM_VAL(AUX_OUTPUT, aux_output,
-					    term->val.num ? 1 : 0, term->weak);
+			new_type = EVSEL__CONFIG_TERM_AUX_OUTPUT;
+			val = term->val.num ? 1 : 0;
 			break;
 		case PARSE_EVENTS__TERM_TYPE_AUX_ACTION:
-			ADD_CONFIG_TERM_STR(AUX_ACTION, term->val.str, term->weak);
+			new_type = EVSEL__CONFIG_TERM_AUX_ACTION;
+			str_type = true;
 			break;
 		case PARSE_EVENTS__TERM_TYPE_AUX_SAMPLE_SIZE:
-			ADD_CONFIG_TERM_VAL(AUX_SAMPLE_SIZE, aux_sample_size,
-					    term->val.num, term->weak);
+			new_type = EVSEL__CONFIG_TERM_AUX_SAMPLE_SIZE;
+			val = term->val.num;
 			break;
 		case PARSE_EVENTS__TERM_TYPE_RATIO_TO_PREV:
-			ADD_CONFIG_TERM_STR(RATIO_TO_PREV, term->val.str, term->weak);
+			new_type = EVSEL__CONFIG_TERM_RATIO_TO_PREV;
+			str_type = true;
 			break;
 		case PARSE_EVENTS__TERM_TYPE_USER:
 		case PARSE_EVENTS__TERM_TYPE_CONFIG:
@@ -1229,7 +1231,23 @@ do {								\
 		case PARSE_EVENTS__TERM_TYPE_RAW:
 		case PARSE_EVENTS__TERM_TYPE_CPU:
 		default:
-			break;
+			/* Don't add a new term for these ones */
+			continue;
+		}
+
+		new_term = add_config_term(new_type, head_terms, term->weak);
+		if (!new_term)
+			return -ENOMEM;
+
+		if (str_type) {
+			new_term->val.str = strdup(term->val.str);
+			if (!new_term->val.str) {
+				zfree(&new_term);
+				return -ENOMEM;
+			}
+			new_term->free_str = true;
+		} else {
+			new_term->val.val = val;
 		}
 	}
 	return 0;
@@ -1290,10 +1308,16 @@ static int get_config_chgs(struct perf_pmu *pmu, struct parse_events_terms *head
 		}
 	}
 
-	if (bits)
-		ADD_CONFIG_TERM_VAL(CFG_CHG, cfg_chg, bits, false);
+	if (bits) {
+		struct evsel_config_term *new_term;
+
+		new_term = add_config_term(EVSEL__CONFIG_TERM_CFG_CHG,
+					   head_terms, false);
+		if (!new_term)
+			return -ENOMEM;
+		new_term->val.cfg_chg = bits;
+	}
 
-#undef ADD_CONFIG_TERM
 	return 0;
 }
 

-- 
2.34.1

