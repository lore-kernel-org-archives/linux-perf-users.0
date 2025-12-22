Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9CF320CD1
	for <linux-perf-users@vger.kernel.org>; Mon, 22 Dec 2025 15:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766416491; cv=none; b=J/98AGA+qul1GOKTo2c/vvcbc2Wh9yVLM1jHWkRdFY36y3LfJEE7m4HJ7XeWMUqhJHc3U55MfZwTqzlDyNhmIkn994DqIU6WwRFUU6p1Y4LeUuD3+nkfcOYBaE7MPo1WAnWwO+fTVZjxjOf0SKDJW9foPXYEEzZRt3rMF6YMlAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766416491; c=relaxed/simple;
	bh=PAkf0NbnSlWBogq8yeUp6HixGYaT60O+RjPgTXYfoto=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oGcVlvfsN7DgKVuYKOy1gkifXAtUH8QzyrGL2hLa4o7jc9VJwn2GJaYPxOKTLAAUrEu6zHvukzYWsoPm0Y6zksS43XExsHtyRL1G4Db1JbWMZgbcSF8Yd4YQj9SvuHZ/Xhd+KT32y+DrgTm+/VeubH3ueRWH7Z/UK+3GnaKdrjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WiKGUH5O; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WiKGUH5O"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47796a837c7so28138105e9.0
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Dec 2025 07:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1766416488; x=1767021288; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dLNSFy2x/hIrhk0Ax93bLHz2woErNJIZ/GG5lWWV+fA=;
        b=WiKGUH5OPeDsf6FwpN1nrlmyeQUOr/WFK5KyIZflalgvq0CPQHPZUPNgmvKvdlEvZn
         QZ7/fCDxy7Azg5fAtSQ0aSSAIEnyhF/ZJDROs27335JTw4ECHRYGLjDpHTngyu0Ua3BA
         aaMtVxoOgNCXdhGs93ccvunz2QSUqngXavU1ADdBn0grrttQuO8m9JMxzvdZ/1q4cb5R
         g8R46GrIofkkZf2cQ7qLfBsqKyOaFhF38xxrXf3wJwjTD6UD6D8cp0bvRsG4mV3c005y
         0+RqZ+azJZVyozb7kiMMbHEnBGkjMBFhK34gxynI8OW+ywKchUtukvmjDntRNGZPe0/X
         Ksig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766416488; x=1767021288;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dLNSFy2x/hIrhk0Ax93bLHz2woErNJIZ/GG5lWWV+fA=;
        b=rPVFMhCuzDIP2PUSRG22mDK1izVRnA84oSiSoskfjdef1rPPAWPmuPzArybJ/eWHFx
         1R4Cz/tKjWvqZS5sxtb0S6WJPq5qhT0y8+Yz1LchNMSRYi70i1PWD6Xs9GAXJNmuh1Rc
         iv6EehQAk5y04+tZ8gs461s+wrVUSo6sfcM0+IMR4ePJ8jMOXZBN8T023AEH1KnAi3+e
         g3+EG6o8cUmyODp08wVPDJK0WtQuDtMOQSaz2lfCwNExptnGiy/kbq4VMMRMXSmiWLgU
         Xd1/f0agUyJWUb6YsoT5C6W58bsSS0VnC53AspFLxKgMBBJEg74yzQ2aMHOAAL2XdoYC
         TlaA==
X-Gm-Message-State: AOJu0YzzpjfDQ88iWo4bIGb6nwwLAtkEByZ+jJAgTnLKoqmo3P25VDa9
	QyW9KsdbStQr2vtLgOyR/qBfKR81BtwkzkwTyUHB3rTxxUqCWMBzoaQgXekzSj2kdq8=
X-Gm-Gg: AY/fxX5Nd3wOvCzpc2knnL4uIR5JVvI89CoyN+UMKg4IYuuknoS1VjaonWhBxlWyQNt
	LPFlL07hpdq5FI9YsRy1HnWWk236CjEfvUKunSRzFDEaNnH663M2S34fi0PO7y+2Awmyl1Jc7zm
	j0YMFFvmu9dgSEo34O2TVs6qxF5yG3TOUYyxwHTQJlE1bjvm/byEJIsl64kREYhBZPoys4TUO6C
	qA5WpaqgmPMxWS0arVDhKgiG+034+vPlAyJAi17jFYHmGXtvtBndftZSJAQj0MACxwPBxwsm49I
	UbZRaQ6y80zGam6fAUvFFCOASNrm1UqYnZ6FzYbaLW4XoSVLyYilEkYLfuW5JDx9yJQBrIc+utH
	AFFaeFXx3deH4CvjRgVOqRCaV5Qec5haUUGOew9Ne2ISZJSSrjhCfXq6KgsL5N0+2RUt8q3XuGl
	41pLnMCPa1qvjpD7HCnM+k
X-Google-Smtp-Source: AGHT+IEahEYGJ7vFS+t3GrATAlFobA+R67jco9VafW8F5oa5ErNeavGgswhI/pyV13bcbNTE7NBvDA==
X-Received: by 2002:a05:600c:350b:b0:471:1774:3003 with SMTP id 5b1f17b1804b1-47d1958ef07mr103027745e9.29.1766416487713;
        Mon, 22 Dec 2025 07:14:47 -0800 (PST)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea830fesm22750093f8f.20.2025.12.22.07.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 07:14:47 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Mon, 22 Dec 2025 15:14:26 +0000
Subject: [PATCH v4 01/14] perf parse-events: Refactor get_config_terms() to
 remove macros
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251222-james-perf-config-bits-v4-1-0608438186fc@linaro.org>
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

