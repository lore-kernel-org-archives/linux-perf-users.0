Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B800031282B
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Sep 2025 22:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758666816; cv=none; b=o5Lt7NMQnf1WcALYjsxgE6EboUuJrc5uPCY2aJeg5oMFSy7gvyebTyHFMTZmQjr9qh+2/JAd40p/NvEVliky1A5yqb7UvIeIV+U1ozo9Tmh+Q/ZFM+Hh3SAXyhlC/nGTNCIH9lNp3n0XY585ddhqqWbdxF7l9sI/rLeRMAtzF6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758666816; c=relaxed/simple;
	bh=WPp5sf3QDHsYUJNf2dAHXr6uoG+XA9EmqP0/w3J4dIc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=McaOUmonprjE+S9BVzUyvYmcf5fhvvSdzPPVUnYWZQVa75eL5LJi1G0UQILWTpmES5ULSJRWCekws7yifeXLINHFlggRjfSWvukhZXUcq4SGZ/7Ov1NUs8WBtzWe57QHLf511kh3jfzdEmSck6y3LUQGV3rWmOTLoZlnaJo5vTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xyei5kAu; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xyei5kAu"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32eae48beaaso5766753a91.0
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Sep 2025 15:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758666814; x=1759271614; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Nmw42+29yvJvKrw6/kjNexq41QLy8ypEjcJ8nXeA0Rw=;
        b=Xyei5kAuQb3pmLNiHGGRwu7tkWTLudtmmov8ocY6MyAKTIMJTSqQujHefrreg+Nsa3
         s7K+Ape7epzuN1U5EseuaNO0FR/jYqVWVjCrR4SdPX0Fa8SFQuihBot+4+rl51FVs1AQ
         u5lEPHweFfy0Qr6NMC7Vf2vsJFJGabigZdafi13fB0WdkQ+YhrF+pCNsei49+HIYQgo7
         W2RNfCbTLvmLO+FWu654GI1ixsjiY6fVID3y7vcFBYqT7Ud6zLp56bw2fhOxAu1Cy8uL
         5fFayK3XXBtOwRWGxTa2g5ycxFLC9R4YeTIc+iqyOprHlPalOHZabU4WSWgCVin9SauR
         2EoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758666814; x=1759271614;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nmw42+29yvJvKrw6/kjNexq41QLy8ypEjcJ8nXeA0Rw=;
        b=cSgXxQtHfUtRxaZBm9MkjRCJA5nxV5nblnJ24LHpyOP96dYUHEEGXxRuB1Btb6zQ0d
         /VDtcIzG+JTcxO8cwZ7Mjdx5O3lSlnMhyGR+pOJavObS1mwv5fdkoPn7H/OBxq6BDSt/
         b/DrHYsDLiwtSPc0k2y8DdrNowBjb1f9oAuIumu2vR5uQSlJjkHbIp7hDsLDGmrq5ZgN
         J0QMtYOd+Trb9MEfxTxtxS3zO3oeBQOV3pJwc6+J3QXCnIaIR2otgh6o5nClM5pVi5de
         7uMk38BSP8tVxrNjMPV9TdjL1Xa9f2+qpcP2XP+QRRcClnobQAZExjtPaeqgZmrf3I72
         xxeg==
X-Forwarded-Encrypted: i=1; AJvYcCVslYUThJwSZK5G22KG0pj0ppii24cEj5LNpMl0kFUcOhuaZMadoXWIOC2rZ0eTPhRPwd57xmaRBKXTTNEmfFO9@vger.kernel.org
X-Gm-Message-State: AOJu0Yw83i5uWF0gT4F4VM/qxD2o4E9gWALuTNZTS+8dqhO7scwzaAd8
	JfrSNAPykgFVWi7hCqwCmX4RTlVzm1cTPH04DMn1ijbSMs7kWEf2beY7j7AOByTm5gGDqtJdfSc
	41aLThIC4Xw==
X-Google-Smtp-Source: AGHT+IGFi3pC9G2Tpc3i2MbhFFREWoSH2gi0dMuSG3ADsqn+2xdhE6ey8nCRgcQSYKlrYfI+goWo5JJV02jc
X-Received: from pjh11.prod.google.com ([2002:a17:90b:3f8b:b0:32b:65c6:661a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4a8a:b0:327:9e88:7714
 with SMTP id 98e67ed59e1d1-332a97051f7mr4970509a91.37.1758666813760; Tue, 23
 Sep 2025 15:33:33 -0700 (PDT)
Date: Tue, 23 Sep 2025 15:32:52 -0700
In-Reply-To: <20250923223312.238185-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250923223312.238185-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Message-ID: <20250923223312.238185-9-irogers@google.com>
Subject: [PATCH v6 08/28] perf parse-events: Remove unused FILE input argument
 to scanner
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
index bb8004397650..4e55b0d295bd 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -2556,7 +2556,7 @@ static int test_term(const struct terms_test *t)
 
 
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
index 9ec1738a5a64..c3c934da6083 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1962,7 +1962,6 @@ int parse_events__set_default_name(struct list_head *list, char *name)
 }
 
 static int parse_events__scanner(const char *str,
-				 FILE *input,
 				 struct parse_events_state *parse_state)
 {
 	YY_BUFFER_STATE buffer;
@@ -1973,10 +1972,7 @@ static int parse_events__scanner(const char *str,
 	if (ret)
 		return ret;
 
-	if (str)
-		buffer = parse_events__scan_string(str, scanner);
-	else
-	        parse_events_set_in(input, scanner);
+	buffer = parse_events__scan_string(str, scanner);
 
 #ifdef PARSER_DEBUG
 	parse_events_debug = 1;
@@ -1984,10 +1980,8 @@ static int parse_events__scanner(const char *str,
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
@@ -1995,7 +1989,7 @@ static int parse_events__scanner(const char *str,
 /*
  * parse event config string, return a list of event terms.
  */
-int parse_events_terms(struct parse_events_terms *terms, const char *str, FILE *input)
+int parse_events_terms(struct parse_events_terms *terms, const char *str)
 {
 	struct parse_events_state parse_state = {
 		.terms  = NULL,
@@ -2003,7 +1997,7 @@ int parse_events_terms(struct parse_events_terms *terms, const char *str, FILE *
 	};
 	int ret;
 
-	ret = parse_events__scanner(str, input, &parse_state);
+	ret = parse_events__scanner(str, &parse_state);
 	if (!ret)
 		list_splice(&parse_state.terms->terms, &terms->terms);
 
@@ -2307,7 +2301,7 @@ int __parse_events(struct evlist *evlist, const char *str, const char *pmu_filte
 	};
 	int ret, ret2;
 
-	ret = parse_events__scanner(str, /*input=*/ NULL, &parse_state);
+	ret = parse_events__scanner(str, &parse_state);
 
 	if (!ret && list_empty(&parse_state.list)) {
 		WARN_ONCE(true, "WARNING: event parser found nothing\n");
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 9c975bb09fe8..048b38e476f3 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -9,7 +9,6 @@
 #include <stdbool.h>
 #include <linux/types.h>
 #include <linux/perf_event.h>
-#include <stdio.h>
 #include <string.h>
 #include <sys/types.h>
 
@@ -198,7 +197,7 @@ void parse_events_term__delete(struct parse_events_term *term);
 void parse_events_terms__delete(struct parse_events_terms *terms);
 void parse_events_terms__init(struct parse_events_terms *terms);
 void parse_events_terms__exit(struct parse_events_terms *terms);
-int parse_events_terms(struct parse_events_terms *terms, const char *str, FILE *input);
+int parse_events_terms(struct parse_events_terms *terms, const char *str);
 
 struct parse_events_modifier {
 	u8 precise;	/* Number of repeated 'p' for precision. */
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index ddcd4918832d..b44dfe4c73fc 100644
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
@@ -2045,7 +2045,7 @@ static char *format_alias(char *buf, int len, const struct perf_pmu *pmu,
 	}
 
 	parse_events_terms__init(&terms);
-	ret = parse_events_terms(&terms, alias->terms, /*input=*/NULL);
+	ret = parse_events_terms(&terms, alias->terms);
 	if (ret) {
 		pr_err("Failure to parse '%s' terms '%s': %d\n",
 			alias->name, alias->terms, ret);
@@ -2602,7 +2602,7 @@ const char *perf_pmu__name_from_config(struct perf_pmu *pmu, u64 config)
 		int ret;
 
 		parse_events_terms__init(&terms);
-		ret = parse_events_terms(&terms, event->terms, /*input=*/NULL);
+		ret = parse_events_terms(&terms, event->terms);
 		if (ret) {
 			pr_debug("Failed to parse '%s' terms '%s': %d\n",
 				event->name, event->terms, ret);
-- 
2.51.0.534.gc79095c0ca-goog

