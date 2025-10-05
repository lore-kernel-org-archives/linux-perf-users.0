Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A177289340
	for <linux-perf-users@vger.kernel.org>; Sun,  5 Oct 2025 18:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759688692; cv=none; b=FLcuzicJNL5FB4bg1csFo4sH7a6k5b8fXmr5Mtlwr0F+i6f1NyoWfBpmnP+1pO4UF8GQvaKK3pVckYbq2oijs9TSyAy/o4Y5254MW5bdt+jNAEbvxBgEUnwlbfPGiB8Utp1LwrC6rscbg6ZNtnsbgj3ncQ1QEQpzxpn8wFL8Jd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759688692; c=relaxed/simple;
	bh=uIZw1elh7PjTq0KwpdLM4JmuXOEqeUa/AKUxoCBBOU0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lIiQaJUemIVgEG4xrgoOhESXtRGMQQyMA1QVShfr8UxiOtUru5gUF8Rs+Lg0XBca7ki1EkUoNTUvuohnY3n9bL9zXcJi4I5+sAt6VX24J+Ce6YLd56EEIeiWTOgMaYIWSP7jFo9K3jvAO0LXmSjuG12Qo4WUHmPXXed9TmjYbyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tuNcGSZi; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tuNcGSZi"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-27ee214108cso92225485ad.0
        for <linux-perf-users@vger.kernel.org>; Sun, 05 Oct 2025 11:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759688690; x=1760293490; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OQl/4S6abgID7MvIffYL9+4E0EwTwc5SSTBB4OKxGpo=;
        b=tuNcGSZiYriQyxeDqh/P/6sjKu63xaJd+hJIcfYb++vcfJ0XTqRmRMTYZokNcuP28U
         2F+nesW2xNOgcM+Exl41HfzQv39LHfDHFnv/0uAfI7+Vdw2gZl8Dip8CDT1adrpy8fgX
         ytg1M24Dl+0n/L+0l/a47Ij+wMWjxoBvzLCdP7jhjd7pqKgZTC8+KQU7fTEcxwYydIQ4
         Rqv3YEnlCYqqaKxWAYWEKDx9wndtp0nlWG3bvWiQsYy6cn3R8T44xRf3oCaaugglz6Bf
         54kEv3aaffVSV5O2pAVpKpBA0wIWi44hksjwyV6ToCj4neKFAuPD03S1kfO6xIRdxVpz
         wplQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759688690; x=1760293490;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OQl/4S6abgID7MvIffYL9+4E0EwTwc5SSTBB4OKxGpo=;
        b=pArBibPLugJ9Pt4cBzN8eN1MG2NK4MksAiodkx0EHgFUYrnPlWvhM8XAvjEvBXHYkY
         hj+DoQqTzSkeseLluEI53nVeDtmMYSa7szzq06zwPHuvpeZqlCNIaKnZm2dcXBg0Asu2
         KDLyuTuK2h25PxGmp3HqyTw17XrXmOwKbr5g3JB/JhC7I0juoXxX/LGTxFs/nUcRsRZU
         Io7rQCQhxyUgJZfsSLOu/JLeYbf9ZQFivebQ5ALkieQ6CKtkZmbbhzc2mW4Abv4hrNGh
         h3qav5g0G1CJXIdqzJg1b8OfvLikxwkaZvocntc4cI6FcP2EZH8ba2HKaX9L/514QHsc
         RFMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQ0pez/WYy/4ciVo6jzact0L/ZvI/4EGem+bh/m8EdPTrO3zQb7vzgFjw8JzXwZkyfDtB8+oPi+saFcTkk7M5s@vger.kernel.org
X-Gm-Message-State: AOJu0YyPGJ9Cxx0+hfgMNXhNPSktzDjPDyRfJMmyR77bnJuRJdhvr9q1
	HC4J+RbpzcT4dluBMKfEaMu1+MTcKZbjeGqkG08QL0debX0Imz4So5GcmxWKWI/m9cWUvI5PzWR
	6vMWhHSR7yw==
X-Google-Smtp-Source: AGHT+IGiYrdueKBf/k6Xe6KV3VvKpZmiinqv9NdWQuIkCnWGMoG9aPHYNg4hp9tYg2FHEx83/9JC2fIMAW2L
X-Received: from pllp13.prod.google.com ([2002:a17:903:478d:b0:25f:48ba:97e1])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3c25:b0:268:db2:b78f
 with SMTP id d9443c01a7336-28e9a6bd375mr128022685ad.44.1759688689944; Sun, 05
 Oct 2025 11:24:49 -0700 (PDT)
Date: Sun,  5 Oct 2025 11:24:10 -0700
In-Reply-To: <20251005182430.2791371-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251005182430.2791371-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251005182430.2791371-8-irogers@google.com>
Subject: [PATCH v7 07/27] perf parse-events: Remove unused FILE input argument
 to scanner
From: Ian Rogers <irogers@google.com>
To: James Clark <james.clark@linaro.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Xu Yang <xu.yang_2@nxp.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Atish Patra <atishp@rivosinc.com>, Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>, 
	Vince Weaver <vincent.weaver@maine.edu>
Cc: Ian Rogers <irogers@google.com>, Thomas Richter <tmricht@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

Now the events file isn't directly parsed from a FILE but stored in a
string prior to parsing, remove the FILE argument to the associated
scanner functions as they only ever pass NULL.

Tested-by: Thomas Richter <tmricht@linux.ibm.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/x86/util/intel-pt.c |  2 +-
 tools/perf/tests/parse-events.c     |  2 +-
 tools/perf/tests/pmu.c              |  3 +--
 tools/perf/util/parse-events.c      | 18 ++++++------------
 tools/perf/util/parse-events.h      |  3 +--
 tools/perf/util/pmu.c               |  6 +++---
 6 files changed, 13 insertions(+), 21 deletions(-)

diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
index add33cb5d1da..2d7c0dec86b0 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -72,7 +72,7 @@ static int intel_pt_parse_terms_with_default(const struct perf_pmu *pmu,
 	int err;
 
 	parse_events_terms__init(&terms);
-	err = parse_events_terms(&terms, str, /*input=*/ NULL);
+	err = parse_events_terms(&terms, str);
 	if (err)
 		goto out_free;
 
diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 67550cc60555..13c1e4c45ea2 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -2610,7 +2610,7 @@ static int test_term(const struct terms_test *t)
 
 
 	parse_events_terms__init(&terms);
-	ret = parse_events_terms(&terms, t->str, /*input=*/ NULL);
+	ret = parse_events_terms(&terms, t->str);
 	if (ret) {
 		pr_debug("failed to parse terms '%s', err %d\n",
 			 t->str , ret);
diff --git a/tools/perf/tests/pmu.c b/tools/perf/tests/pmu.c
index 4a9f8e090cf4..cbded2c6faa4 100644
--- a/tools/perf/tests/pmu.c
+++ b/tools/perf/tests/pmu.c
@@ -169,8 +169,7 @@ static int test__pmu_format(struct test_suite *test __maybe_unused, int subtest
 	parse_events_terms__init(&terms);
 	if (parse_events_terms(&terms,
 				"krava01=15,krava02=170,krava03=1,krava11=27,krava12=1,"
-				"krava13=2,krava21=119,krava22=11,krava23=2",
-				NULL)) {
+				"krava13=2,krava21=119,krava22=11,krava23=2")) {
 		pr_err("Term parsing failed\n");
 		goto err_out;
 	}
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 8f320d08cf1f..e0f18e9c8000 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1984,7 +1984,6 @@ int parse_events__set_default_name(struct list_head *list, char *name)
 }
 
 static int parse_events__scanner(const char *str,
-				 FILE *input,
 				 struct parse_events_state *parse_state)
 {
 	YY_BUFFER_STATE buffer;
@@ -1995,10 +1994,7 @@ static int parse_events__scanner(const char *str,
 	if (ret)
 		return ret;
 
-	if (str)
-		buffer = parse_events__scan_string(str, scanner);
-	else
-	        parse_events_set_in(input, scanner);
+	buffer = parse_events__scan_string(str, scanner);
 
 #ifdef PARSER_DEBUG
 	parse_events_debug = 1;
@@ -2006,10 +2002,8 @@ static int parse_events__scanner(const char *str,
 #endif
 	ret = parse_events_parse(parse_state, scanner);
 
-	if (str) {
-		parse_events__flush_buffer(buffer, scanner);
-		parse_events__delete_buffer(buffer, scanner);
-	}
+	parse_events__flush_buffer(buffer, scanner);
+	parse_events__delete_buffer(buffer, scanner);
 	parse_events_lex_destroy(scanner);
 	return ret;
 }
@@ -2017,7 +2011,7 @@ static int parse_events__scanner(const char *str,
 /*
  * parse event config string, return a list of event terms.
  */
-int parse_events_terms(struct parse_events_terms *terms, const char *str, FILE *input)
+int parse_events_terms(struct parse_events_terms *terms, const char *str)
 {
 	struct parse_events_state parse_state = {
 		.terms  = NULL,
@@ -2025,7 +2019,7 @@ int parse_events_terms(struct parse_events_terms *terms, const char *str, FILE *
 	};
 	int ret;
 
-	ret = parse_events__scanner(str, input, &parse_state);
+	ret = parse_events__scanner(str, &parse_state);
 	if (!ret)
 		list_splice(&parse_state.terms->terms, &terms->terms);
 
@@ -2329,7 +2323,7 @@ int __parse_events(struct evlist *evlist, const char *str, const char *pmu_filte
 	};
 	int ret, ret2;
 
-	ret = parse_events__scanner(str, /*input=*/ NULL, &parse_state);
+	ret = parse_events__scanner(str, &parse_state);
 
 	if (!ret && list_empty(&parse_state.list)) {
 		WARN_ONCE(true, "WARNING: event parser found nothing\n");
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index ed7b73591139..3052a48978f8 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -9,7 +9,6 @@
 #include <stdbool.h>
 #include <linux/types.h>
 #include <linux/perf_event.h>
-#include <stdio.h>
 #include <string.h>
 #include <sys/types.h>
 
@@ -199,7 +198,7 @@ void parse_events_term__delete(struct parse_events_term *term);
 void parse_events_terms__delete(struct parse_events_terms *terms);
 void parse_events_terms__init(struct parse_events_terms *terms);
 void parse_events_terms__exit(struct parse_events_terms *terms);
-int parse_events_terms(struct parse_events_terms *terms, const char *str, FILE *input);
+int parse_events_terms(struct parse_events_terms *terms, const char *str);
 
 struct parse_events_modifier {
 	u8 precise;	/* Number of repeated 'p' for precision. */
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 102fabfbf1d5..876e87708b03 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -777,7 +777,7 @@ static int pmu_alias_terms(struct perf_pmu_alias *alias, struct list_head *terms
 	int ret;
 
 	parse_events_terms__init(&alias_terms);
-	ret = parse_events_terms(&alias_terms, alias->terms, /*input=*/NULL);
+	ret = parse_events_terms(&alias_terms, alias->terms);
 	if (ret) {
 		pr_err("Cannot parse '%s' terms '%s': %d\n",
 		       alias->name, alias->terms, ret);
@@ -2046,7 +2046,7 @@ static char *format_alias(char *buf, int len, const struct perf_pmu *pmu,
 	}
 
 	parse_events_terms__init(&terms);
-	ret = parse_events_terms(&terms, alias->terms, /*input=*/NULL);
+	ret = parse_events_terms(&terms, alias->terms);
 	if (ret) {
 		pr_err("Failure to parse '%s' terms '%s': %d\n",
 			alias->name, alias->terms, ret);
@@ -2603,7 +2603,7 @@ const char *perf_pmu__name_from_config(struct perf_pmu *pmu, u64 config)
 		int ret;
 
 		parse_events_terms__init(&terms);
-		ret = parse_events_terms(&terms, event->terms, /*input=*/NULL);
+		ret = parse_events_terms(&terms, event->terms);
 		if (ret) {
 			pr_debug("Failed to parse '%s' terms '%s': %d\n",
 				event->name, event->terms, ret);
-- 
2.51.0.618.g983fd99d29-goog

