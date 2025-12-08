Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A11414A8E
	for <linux-perf-users@vger.kernel.org>; Mon,  8 Dec 2025 14:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765203805; cv=none; b=iAJsRCUq58+2vnPimGrZqknNxV29LCXbukFMvv3PrDrDlsZgRzWpCc4SSFSq2LEiSfp0qOVrc2YJ2weHhMNq4+FS3J1HeC4zZAfm3gv+z5/keal541wkRwksKypTUYcte+93dZLrRIBJiaSCuHp2G6lDJD9Te4PasJf5FhOVgLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765203805; c=relaxed/simple;
	bh=J1wksdIJurkXz2WYT6fWQWG7Ja/E0T/Th8nKVIM+YO4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XVE7Je5U4x3JyjabjZcVTo9c0DlsPMfqexLpoUMoM26UJoChyzgllhtsJncxmMff/wR/T4Ct/4mMfdbs0Xf/3hp0fLNi/bBK4QNIMywipusLM2T6fR1J0OahBd6/0ulj+nKee7c1M914JHnmBNam1klkwdIbkbb+LKRKXZDOY1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=W3Nqm329; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W3Nqm329"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-477563e28a3so32441505e9.1
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Dec 2025 06:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765203799; x=1765808599; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2sW5CVG6fTovVK5pm5F0b9TUqJDd0mR5nCkkwbSDkjc=;
        b=W3Nqm329pQpcHDahFhKI0Yz7Yh0x9xCAK0rCkSaMceiZR6ACIJmGWRJA88bdxYi04E
         mA17WwI0nfYyw7bLb3d99eFPprcIB19ZEUzAkxPG2yZdZJ0za6ywG90Zg1VgjTeDQR8K
         JeO4xyq9Kc7akUixTy1hVIDGDpGLJBijf4jzTpc6ySv1eiphZIsGSvGBEHUAFNc3yNa5
         MiUMN74Lj0nKOhPw33g/rBj2W/VmrnVAjrvwV7eTyCfh+2Ula7E++PbJ5mZTPpYjB2XU
         ZwU1Himq2bErlRd9cSY+T6EpbsK8WR2ZqQ62A9Lxh2oJuQXhBbkZLZgOnD8h6Q2pYgPI
         hXbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765203799; x=1765808599;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2sW5CVG6fTovVK5pm5F0b9TUqJDd0mR5nCkkwbSDkjc=;
        b=N37aH2/ggfYi1Ty8W+0hV0X/k7ydbZ609YqaEMJSQdrRA3exeHggtrR38nA4fa+0MP
         DP/iPv05H7T2RR138DqxXSlSCMktY3xa8jGx2RVUokGT/OQMJvAbM4SuKFUWkwVIv/Ue
         C8HHDrUZE0d9wwvQmrwOxfN7SoeCizdZtjJKoiEmKgv8jSSLaqcAJj98ACkK2IuWQS4y
         DzDmLRZo2zOG+iBjclUAoQAqCT20jNBP38nhYaQnNx8xsNcb/PYNPng29UuVK87XbYaA
         4VBk71Uebi+OC3xy1kdgCmXBR5KQsB168r1Wf6wnSrZ3IReKLvG42mVMqfE4zibIp3YF
         1AYg==
X-Gm-Message-State: AOJu0YzYulYDKLjDDsoN3gi4kowoW5LQHlpL8TUzNxvLHojXJXP7dLrI
	UF7G/O3B+I1Mn/XxJuUJcLzTnpnDfMwRtjiNgOSPV7nfrPsKI7WlhIMCllixy0u5hgc=
X-Gm-Gg: ASbGnctzrlWiJO4u7j1yRaHmKFesuhb050S21PLvsv3PnJkUKTetyWdn1/LKbseFpie
	Fyw/mn0pwAxMLZ5wk2z2OqOOtAvr3s6zVcfbmGqhDXjjAfug9vNtFqae2Tiw3zfN2jqj9kipZ9g
	gLKLfxeVnM2drlhHjWXGF6z6LbPFGGRU4R6kjajR4H3lAoZfI8JUvxuuV2anmV3dsN3wba82kZM
	rdAUvo0ZRR3Kdp9osWippgAQjSwOeAQDZQHIXyoGEpzfFsRN1wjHT3RHZbx9NPX2PtqVeCNJDWR
	48wjsHfhKE3acwlQVWPf0qsrlrA8MXXTFw6OJjzcACguUri3vTe/VsE2RRn2tLo2ulYgvgvWMbC
	s8wtoRkzurxeaI+kSwsDG/VkneHK53UiZMLRMsBcoKr9utyoseH9rsjW0RcfvyKYfNH0TtW09C5
	aRMba3t4F9eeLb/BMBZ9lz0Wlz32Yra2589LZVZdvKyw==
X-Google-Smtp-Source: AGHT+IGYLrvxfRv8u0L6Kyp8fUW21hbwdhdUTTfYsrMxGFHJNMXLnvGBImr+N7bTR/70pUVKkNbYZQ==
X-Received: by 2002:a05:600c:4f11:b0:46e:2815:8568 with SMTP id 5b1f17b1804b1-47939e2371fmr79357865e9.10.1765203798705;
        Mon, 08 Dec 2025 06:23:18 -0800 (PST)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47930920e0dsm248561065e9.2.2025.12.08.06.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 06:23:18 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Mon, 08 Dec 2025 14:22:04 +0000
Subject: [PATCH v2 01/12] perf parse-events: Refactor get_config_terms() to
 remove macros
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251208-james-perf-config-bits-v2-1-4ac0281993b0@linaro.org>
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
index 17c1c36a7bf9..d5b009b4ebab 100644
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
+		char *str = NULL;
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
+			str = term->val.str;
 			break;
 		case PARSE_EVENTS__TERM_TYPE_BRANCH_SAMPLE_TYPE:
-			ADD_CONFIG_TERM_STR(BRANCH, term->val.str, term->weak);
+			new_type = EVSEL__CONFIG_TERM_BRANCH;
+			str = term->val.str;
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
+			str = term->val.str;
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
+			str = term->val.str;
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
+			str = term->val.str;
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
+		if (str) {
+			new_term->val.str = strdup(str);
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

