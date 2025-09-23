Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB49311C2D
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Sep 2025 22:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758666853; cv=none; b=P3yVtT2Sfa7pYmJkj+SZz0+UTXm5Xt4Ozvg9d7C+LM6GAtT+kOw6FbQIbM+vdDImjpiq3ZMnwtjWX5cEqf5IlH/6IUc3YEnpj/85hoCs3sgXjvcn9Gjvt/1Eon4wdHKRaSOG3lBvoLxFVUt7aId9D6W5DcY0iNZpHQTtmeyaPBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758666853; c=relaxed/simple;
	bh=RSqOOOxo2G8WJ3Q6u3A/qEUITI5NAmi34otlxw5uvIM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=MYeuM3lQs9grVk9f0BQAMgaqgIl7O6UTwKTQV3+SC/AGGEs7xHPzoQs8Fb3MW0V4JSlrYAelw0+j2coOGuNdyn6IhQdaedPGMT/NGi8xe+870x/vUN29qy9u9PsylB9Vx+JvqBYnCtq+/TNcqRhH0xab2s/HnLdIfmG2IyPy264=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qMtGx3Yb; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qMtGx3Yb"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32e8c800a79so8232695a91.0
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Sep 2025 15:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758666850; x=1759271650; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d4XZd7WT5Fg2aYG3+qR6VCPykqBFpM9YpU6kt0fn++E=;
        b=qMtGx3Ybez4fdZ0+1O4s5d7wqQhmQnvlRLgu8PBqbxFpyszSv1IVNgoLOwRLHaoFxf
         ZGaTNvYFQtO4Ck5CEPGuDqM6EWtVSfdhKHsaF+OQe+2xiWiY5XhR+fqiSc1m+D9+Nb/C
         cIiyDLl3RcXnnTI/hdhG4MYVhz0l4W83ju4dmVGY8L1l0IziwknaanfyM6UbUZc1RHP2
         F/C6VYRXUucb/KIgQ1DU28m/4XQjba3PU48E2VedvSG98bsAIVKObvtSHcpzWJZxV9Dm
         eN2EXwIeoT8qsssSiLYGh3App4UCXD6iw9j+PIqUq6JagzjpvaxzboLXyqD4th08KUZ1
         868Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758666850; x=1759271650;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d4XZd7WT5Fg2aYG3+qR6VCPykqBFpM9YpU6kt0fn++E=;
        b=UsYYXPWNPaxtuVZ7ebEwN6KP2VN100o43Fc131p0TLwZHIF4jaTlgMv4DVMSUvsozf
         8xZusyEcSFZO6XGrzrw5xt77ax0z5iPcVdt6BeM19LnSvrfi2pxSiAgkhomc92bGyIZW
         nsIs/LHQqFTZq5Si9kIIi6c8+mBNWVXxEIoOMsY/s6zwyriWk4WLk40HOx9bRiN4Uef2
         hDukMQIxnOZxEhxN3HWghVxpRD6nAeS3tao267aRRT6LJrW9org9BAn3OTzeCVLhYGmV
         9CVSp2kud4ou6JGFuYpi+6jTt1QehkZyin0MMj4rZwbD2KjEwz2m0PTHOpie7npID0NZ
         pywA==
X-Forwarded-Encrypted: i=1; AJvYcCU+Pf1zFghxZ8+Zrr6+Y+so0TBKvaoa5UF9Fmbcli4aJhxuOMMqj8R3LlK9Cf+BuLgFuNddDEveyvo8EPH8gqJ3@vger.kernel.org
X-Gm-Message-State: AOJu0YzMDH1KhCKZR7lmq4Tnj+rlTjfvErX5qVKSupHa/gq1zV/GiGnP
	hXKsGBmoiA3ZhxB14kc/ioesNsruhYKyDg1R6hpvbcyp5IZBx/rTmkOBKsvZQ7uo0gRkBHHWh5U
	WS0+zZQZ6GQ==
X-Google-Smtp-Source: AGHT+IFDhvHUbwkezXKQd/e0m8z0HZrc3a67BZWjg/Ff0FEB2Pt+Cegmx02M1hcrrkQ12X3fDWYRN2gH1rYQ
X-Received: from pjg14.prod.google.com ([2002:a17:90b:3f4e:b0:330:8b1f:c4e7])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3fcc:b0:32e:5d79:64f4
 with SMTP id 98e67ed59e1d1-332a96f7a8amr4470422a91.25.1758666850047; Tue, 23
 Sep 2025 15:34:10 -0700 (PDT)
Date: Tue, 23 Sep 2025 15:33:11 -0700
In-Reply-To: <20250923223312.238185-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250923223312.238185-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Message-ID: <20250923223312.238185-28-irogers@google.com>
Subject: [PATCH v6 27/28] perf test parse-events: Add evlist test helper
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
Content-Type: text/plain; charset="UTF-8"

Add TEST_ASSERT_EVLIST to dump the failing evlist in the event of a
failure.

Add the macro to a number of tests not currently checking the evlist
length.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/parse-events.c | 236 ++++++++++++++++++++++----------
 1 file changed, 165 insertions(+), 71 deletions(-)

diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index b48580f43ff3..8950677ead15 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -7,6 +7,7 @@
 #include "debug.h"
 #include "pmu.h"
 #include "pmus.h"
+#include "strbuf.h"
 #include <dirent.h>
 #include <errno.h>
 #include "fncache.h"
@@ -20,6 +21,22 @@
 #define PERF_TP_SAMPLE_TYPE (PERF_SAMPLE_RAW | PERF_SAMPLE_TIME | \
 			     PERF_SAMPLE_CPU | PERF_SAMPLE_PERIOD)
 
+static bool check_evlist(const char *test, int line, bool cond, struct evlist *evlist)
+{
+	struct strbuf sb = STRBUF_INIT;
+
+	if (cond)
+		return true;
+
+	evlist__format_evsels(evlist, &sb, 2048);
+	pr_debug("FAILED %s:%d: %s\nFor evlist: %s\n", __FILE__, line, test, sb.buf);
+	strbuf_release(&sb);
+	return false;
+}
+#define TEST_ASSERT_EVLIST(test, cond, evlist) \
+	if (!check_evlist(test, __LINE__, cond, evlist)) \
+		return TEST_FAIL
+
 static int num_core_entries(struct evlist *evlist)
 {
 	/*
@@ -76,8 +93,8 @@ static int test__checkevent_tracepoint(struct evlist *evlist)
 {
 	struct evsel *evsel = evlist__first(evlist);
 
-	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
-	TEST_ASSERT_VAL("wrong number of groups", 0 == evlist__nr_groups(evlist));
+	TEST_ASSERT_EVLIST("wrong number of entries", 1 == evlist->core.nr_entries, evlist);
+	TEST_ASSERT_EVLIST("wrong number of groups", 0 == evlist__nr_groups(evlist), evlist);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_TRACEPOINT == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong sample_type",
 		PERF_TP_SAMPLE_TYPE == evsel->core.attr.sample_type);
@@ -89,8 +106,8 @@ static int test__checkevent_tracepoint_multi(struct evlist *evlist)
 {
 	struct evsel *evsel;
 
-	TEST_ASSERT_VAL("wrong number of entries", evlist->core.nr_entries > 1);
-	TEST_ASSERT_VAL("wrong number of groups", 0 == evlist__nr_groups(evlist));
+	TEST_ASSERT_EVLIST("wrong number of entries", evlist->core.nr_entries > 1, evlist);
+	TEST_ASSERT_EVLIST("wrong number of groups", 0 == evlist__nr_groups(evlist), evlist);
 
 	evlist__for_each_entry(evlist, evsel) {
 		TEST_ASSERT_VAL("wrong type",
@@ -108,7 +125,7 @@ static int test__checkevent_raw(struct evlist *evlist)
 	struct perf_evsel *evsel;
 	bool raw_type_match = false;
 
-	TEST_ASSERT_VAL("wrong number of entries", 0 != evlist->core.nr_entries);
+	TEST_ASSERT_EVLIST("wrong number of entries", 0 != evlist->core.nr_entries, evlist);
 
 	perf_evlist__for_each_evsel(&evlist->core, evsel) {
 		struct perf_pmu *pmu __maybe_unused = NULL;
@@ -145,7 +162,7 @@ static int test__checkevent_numeric(struct evlist *evlist)
 {
 	struct evsel *evsel = evlist__first(evlist);
 
-	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
+	TEST_ASSERT_EVLIST("wrong number of entries", 1 == evlist->core.nr_entries, evlist);
 	TEST_ASSERT_VAL("wrong type", 1 == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config", 1 == evsel->core.attr.config);
 	return TEST_OK;
@@ -156,7 +173,7 @@ static int test__checkevent_symbolic_name(struct evlist *evlist)
 {
 	struct evsel *evsel;
 
-	TEST_ASSERT_VAL("wrong number of entries", 0 != evlist->core.nr_entries);
+	TEST_ASSERT_EVLIST("wrong number of entries", 0 != evlist->core.nr_entries, evlist);
 
 	evlist__for_each_entry(evlist, evsel)
 		TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_INSTRUCTIONS));
@@ -168,7 +185,7 @@ static int test__checkevent_symbolic_name_config(struct evlist *evlist)
 {
 	struct evsel *evsel;
 
-	TEST_ASSERT_VAL("wrong number of entries", 0 != evlist->core.nr_entries);
+	TEST_ASSERT_EVLIST("wrong number of entries", 0 != evlist->core.nr_entries, evlist);
 
 	evlist__for_each_entry(evlist, evsel) {
 		TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_CPU_CYCLES));
@@ -187,7 +204,7 @@ static int test__checkevent_symbolic_alias(struct evlist *evlist)
 {
 	struct evsel *evsel = evlist__first(evlist);
 
-	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
+	TEST_ASSERT_EVLIST("wrong number of entries", 1 == evlist->core.nr_entries, evlist);
 	TEST_ASSERT_VAL("wrong type/config", evsel__match(evsel, SOFTWARE, SW_PAGE_FAULTS));
 	return TEST_OK;
 }
@@ -196,7 +213,7 @@ static int test__checkevent_genhw(struct evlist *evlist)
 {
 	struct perf_evsel *evsel;
 
-	TEST_ASSERT_VAL("wrong number of entries", 0 != evlist->core.nr_entries);
+	TEST_ASSERT_EVLIST("wrong number of entries", 0 != evlist->core.nr_entries, evlist);
 
 	perf_evlist__for_each_entry(&evlist->core, evsel) {
 		TEST_ASSERT_VAL("wrong type", PERF_TYPE_HW_CACHE == evsel->attr.type);
@@ -209,7 +226,7 @@ static int test__checkevent_breakpoint(struct evlist *evlist)
 {
 	struct evsel *evsel = evlist__first(evlist);
 
-	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
+	TEST_ASSERT_EVLIST("wrong number of entries", 1 == evlist->core.nr_entries, evlist);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_BREAKPOINT == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config", 0 == evsel->core.attr.config);
 	TEST_ASSERT_VAL("wrong bp_type", (HW_BREAKPOINT_R | HW_BREAKPOINT_W) ==
@@ -223,7 +240,7 @@ static int test__checkevent_breakpoint_x(struct evlist *evlist)
 {
 	struct evsel *evsel = evlist__first(evlist);
 
-	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
+	TEST_ASSERT_EVLIST("wrong number of entries", 1 == evlist->core.nr_entries, evlist);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_BREAKPOINT == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config", 0 == evsel->core.attr.config);
 	TEST_ASSERT_VAL("wrong bp_type",
@@ -236,7 +253,7 @@ static int test__checkevent_breakpoint_r(struct evlist *evlist)
 {
 	struct evsel *evsel = evlist__first(evlist);
 
-	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
+	TEST_ASSERT_EVLIST("wrong number of entries", 1 == evlist->core.nr_entries, evlist);
 	TEST_ASSERT_VAL("wrong type",
 			PERF_TYPE_BREAKPOINT == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config", 0 == evsel->core.attr.config);
@@ -251,7 +268,7 @@ static int test__checkevent_breakpoint_w(struct evlist *evlist)
 {
 	struct evsel *evsel = evlist__first(evlist);
 
-	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
+	TEST_ASSERT_EVLIST("wrong number of entries", 1 == evlist->core.nr_entries, evlist);
 	TEST_ASSERT_VAL("wrong type",
 			PERF_TYPE_BREAKPOINT == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config", 0 == evsel->core.attr.config);
@@ -266,7 +283,7 @@ static int test__checkevent_breakpoint_rw(struct evlist *evlist)
 {
 	struct evsel *evsel = evlist__first(evlist);
 
-	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
+	TEST_ASSERT_EVLIST("wrong number of entries", 1 == evlist->core.nr_entries, evlist);
 	TEST_ASSERT_VAL("wrong type",
 			PERF_TYPE_BREAKPOINT == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config", 0 == evsel->core.attr.config);
@@ -281,6 +298,7 @@ static int test__checkevent_tracepoint_modifier(struct evlist *evlist)
 {
 	struct evsel *evsel = evlist__first(evlist);
 
+	TEST_ASSERT_EVLIST("wrong number of entries", 1 == evlist->core.nr_entries, evlist);
 	TEST_ASSERT_VAL("wrong exclude_user", evsel->core.attr.exclude_user);
 	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
 	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
@@ -294,7 +312,7 @@ test__checkevent_tracepoint_multi_modifier(struct evlist *evlist)
 {
 	struct perf_evsel *evsel;
 
-	TEST_ASSERT_VAL("wrong number of entries", evlist->core.nr_entries > 1);
+	TEST_ASSERT_EVLIST("wrong number of entries", evlist->core.nr_entries > 1, evlist);
 
 	perf_evlist__for_each_entry(&evlist->core, evsel) {
 		TEST_ASSERT_VAL("wrong exclude_user", !evsel->attr.exclude_user);
@@ -310,6 +328,8 @@ static int test__checkevent_raw_modifier(struct evlist *evlist)
 {
 	struct perf_evsel *evsel;
 
+	TEST_ASSERT_EVLIST("wrong number of entries", 1 == evlist->core.nr_entries, evlist);
+
 	perf_evlist__for_each_entry(&evlist->core, evsel) {
 		TEST_ASSERT_VAL("wrong exclude_user", evsel->attr.exclude_user);
 		TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->attr.exclude_kernel);
@@ -323,6 +343,8 @@ static int test__checkevent_numeric_modifier(struct evlist *evlist)
 {
 	struct perf_evsel *evsel;
 
+	TEST_ASSERT_EVLIST("wrong number of entries", 1 == evlist->core.nr_entries, evlist);
+
 	perf_evlist__for_each_entry(&evlist->core, evsel) {
 		TEST_ASSERT_VAL("wrong exclude_user", evsel->attr.exclude_user);
 		TEST_ASSERT_VAL("wrong exclude_kernel", evsel->attr.exclude_kernel);
@@ -336,8 +358,9 @@ static int test__checkevent_symbolic_name_modifier(struct evlist *evlist)
 {
 	struct perf_evsel *evsel;
 
-	TEST_ASSERT_VAL("wrong number of entries",
-			evlist->core.nr_entries == num_core_entries(evlist));
+	TEST_ASSERT_EVLIST("wrong number of entries",
+			   evlist->core.nr_entries == num_core_entries(evlist),
+			   evlist);
 
 	perf_evlist__for_each_entry(&evlist->core, evsel) {
 		TEST_ASSERT_VAL("wrong exclude_user", evsel->attr.exclude_user);
@@ -352,6 +375,10 @@ static int test__checkevent_exclude_host_modifier(struct evlist *evlist)
 {
 	struct perf_evsel *evsel;
 
+	TEST_ASSERT_EVLIST("wrong number of entries",
+			   evlist->core.nr_entries == num_core_entries(evlist),
+			   evlist);
+
 	perf_evlist__for_each_entry(&evlist->core, evsel) {
 		TEST_ASSERT_VAL("wrong exclude guest", !evsel->attr.exclude_guest);
 		TEST_ASSERT_VAL("wrong exclude host", evsel->attr.exclude_host);
@@ -363,6 +390,10 @@ static int test__checkevent_exclude_guest_modifier(struct evlist *evlist)
 {
 	struct perf_evsel *evsel;
 
+	TEST_ASSERT_EVLIST("wrong number of entries",
+			   evlist->core.nr_entries == num_core_entries(evlist),
+			   evlist);
+
 	perf_evlist__for_each_entry(&evlist->core, evsel) {
 		TEST_ASSERT_VAL("wrong exclude guest", evsel->attr.exclude_guest);
 		TEST_ASSERT_VAL("wrong exclude host", !evsel->attr.exclude_host);
@@ -374,6 +405,7 @@ static int test__checkevent_symbolic_alias_modifier(struct evlist *evlist)
 {
 	struct evsel *evsel = evlist__first(evlist);
 
+	TEST_ASSERT_EVLIST("wrong number of entries", 1 == evlist->core.nr_entries, evlist);
 	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
 	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
@@ -386,6 +418,10 @@ static int test__checkevent_genhw_modifier(struct evlist *evlist)
 {
 	struct perf_evsel *evsel;
 
+	TEST_ASSERT_EVLIST("wrong number of entries",
+			   evlist->core.nr_entries == num_core_entries(evlist),
+			   evlist);
+
 	perf_evlist__for_each_entry(&evlist->core, evsel) {
 		TEST_ASSERT_VAL("wrong exclude_user", evsel->attr.exclude_user);
 		TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->attr.exclude_kernel);
@@ -399,6 +435,10 @@ static int test__checkevent_exclude_idle_modifier(struct evlist *evlist)
 {
 	struct evsel *evsel = evlist__first(evlist);
 
+	TEST_ASSERT_EVLIST("wrong number of entries",
+			   evlist->core.nr_entries == num_core_entries(evlist),
+			   evlist);
+
 	TEST_ASSERT_VAL("wrong exclude idle", evsel->core.attr.exclude_idle);
 	TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
 	TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
@@ -414,6 +454,10 @@ static int test__checkevent_exclude_idle_modifier_1(struct evlist *evlist)
 {
 	struct evsel *evsel = evlist__first(evlist);
 
+	TEST_ASSERT_EVLIST("wrong number of entries",
+			   evlist->core.nr_entries == num_core_entries(evlist),
+			   evlist);
+
 	TEST_ASSERT_VAL("wrong exclude idle", evsel->core.attr.exclude_idle);
 	TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
 	TEST_ASSERT_VAL("wrong exclude host", evsel->core.attr.exclude_host);
@@ -643,7 +687,7 @@ static int test__checkevent_pmu_name(struct evlist *evlist)
 	char buf[256];
 
 	/* default_core/config=1,name=krava/u */
-	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
+	TEST_ASSERT_EVLIST("wrong number of entries", 2 == evlist->core.nr_entries, evlist);
 	TEST_ASSERT_VAL("wrong type", core_pmu->type == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config", 1 == evsel->core.attr.config);
 	TEST_ASSERT_VAL("wrong name", evsel__name_is(evsel, "krava"));
@@ -665,7 +709,7 @@ static int test__checkevent_pmu_partial_time_callgraph(struct evlist *evlist)
 	struct perf_pmu *core_pmu = perf_pmus__find_core_pmu();
 
 	/* default_core/config=1,call-graph=fp,time,period=100000/ */
-	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
+	TEST_ASSERT_EVLIST("wrong number of entries", 2 == evlist->core.nr_entries, evlist);
 	TEST_ASSERT_VAL("wrong type", core_pmu->type == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config", 1 == evsel->core.attr.config);
 	/*
@@ -696,7 +740,7 @@ static int test__checkevent_pmu_events(struct evlist *evlist)
 	struct evsel *evsel;
 	struct perf_pmu *core_pmu = perf_pmus__find_core_pmu();
 
-	TEST_ASSERT_VAL("wrong number of entries", 1 <= evlist->core.nr_entries);
+	TEST_ASSERT_EVLIST("wrong number of entries", 1 <= evlist->core.nr_entries, evlist);
 
 	evlist__for_each_entry(evlist, evsel) {
 		TEST_ASSERT_VAL("wrong type", core_pmu->type == evsel->core.attr.type ||
@@ -721,7 +765,7 @@ static int test__checkevent_pmu_events_mix(struct evlist *evlist)
 	 * The wild card event will be opened at least once, but it may be
 	 * opened on each core PMU.
 	 */
-	TEST_ASSERT_VAL("wrong number of entries", evlist->core.nr_entries >= 2);
+	TEST_ASSERT_EVLIST("wrong number of entries", evlist->core.nr_entries >= 2, evlist);
 	for (int i = 0; i < evlist->core.nr_entries - 1; i++) {
 		evsel = (i == 0 ? evlist__first(evlist) : evsel__next(evsel));
 		/* pmu-event:u */
@@ -833,10 +877,12 @@ static int test__group1(struct evlist *evlist)
 {
 	struct evsel *evsel = NULL, *leader;
 
-	TEST_ASSERT_VAL("wrong number of entries",
-			evlist->core.nr_entries == (num_core_entries(evlist) * 2));
-	TEST_ASSERT_VAL("wrong number of groups",
-			evlist__nr_groups(evlist) == num_core_entries(evlist));
+	TEST_ASSERT_EVLIST("wrong number of entries",
+			   evlist->core.nr_entries == (num_core_entries(evlist) * 2),
+			   evlist);
+	TEST_ASSERT_EVLIST("wrong number of groups",
+			   evlist__nr_groups(evlist) == num_core_entries(evlist),
+			   evlist);
 
 	for (int i = 0; i < num_core_entries(evlist); i++) {
 		/* instructions:k */
@@ -873,13 +919,14 @@ static int test__group2(struct evlist *evlist)
 {
 	struct evsel *evsel, *leader = NULL;
 
-	TEST_ASSERT_VAL("wrong number of entries",
-			evlist->core.nr_entries == (2 * num_core_entries(evlist) + 1));
+	TEST_ASSERT_EVLIST("wrong number of entries",
+			   evlist->core.nr_entries == (2 * num_core_entries(evlist) + 1),
+			   evlist);
 	/*
 	 * TODO: Currently the software event won't be grouped with the hardware
 	 * event except for 1 PMU.
 	 */
-	TEST_ASSERT_VAL("wrong number of groups", 1 == evlist__nr_groups(evlist));
+	TEST_ASSERT_EVLIST("wrong number of groups", 1 == evlist__nr_groups(evlist), evlist);
 
 	evlist__for_each_entry(evlist, evsel) {
 		if (evsel__match(evsel, SOFTWARE, SW_PAGE_FAULTS)) {
@@ -928,14 +975,15 @@ static int test__group3(struct evlist *evlist __maybe_unused)
 {
 	struct evsel *evsel, *group1_leader = NULL, *group2_leader = NULL;
 
-	TEST_ASSERT_VAL("wrong number of entries",
-			evlist->core.nr_entries == (3 * perf_pmus__num_core_pmus() + 2));
+	TEST_ASSERT_EVLIST("wrong number of entries",
+			   evlist->core.nr_entries == (3 * perf_pmus__num_core_pmus() + 2),
+			   evlist);
 	/*
 	 * Currently the software event won't be grouped with the hardware event
 	 * except for 1 PMU. This means there are always just 2 groups
 	 * regardless of the number of core PMUs.
 	 */
-	TEST_ASSERT_VAL("wrong number of groups", 2 == evlist__nr_groups(evlist));
+	TEST_ASSERT_EVLIST("wrong number of groups", 2 == evlist__nr_groups(evlist), evlist);
 
 	evlist__for_each_entry(evlist, evsel) {
 		if (evsel->core.attr.type == PERF_TYPE_TRACEPOINT) {
@@ -1030,10 +1078,12 @@ static int test__group4(struct evlist *evlist __maybe_unused)
 {
 	struct evsel *evsel = NULL, *leader;
 
-	TEST_ASSERT_VAL("wrong number of entries",
-			evlist->core.nr_entries == (num_core_entries(evlist) * 2));
-	TEST_ASSERT_VAL("wrong number of groups",
-			num_core_entries(evlist) == evlist__nr_groups(evlist));
+	TEST_ASSERT_EVLIST("wrong number of entries",
+			   evlist->core.nr_entries == (num_core_entries(evlist) * 2),
+			   evlist);
+	TEST_ASSERT_EVLIST("wrong number of groups",
+			   num_core_entries(evlist) == evlist__nr_groups(evlist),
+			   evlist);
 
 	for (int i = 0; i < num_core_entries(evlist); i++) {
 		/* cycles:u + p */
@@ -1071,10 +1121,12 @@ static int test__group5(struct evlist *evlist __maybe_unused)
 {
 	struct evsel *evsel = NULL, *leader;
 
-	TEST_ASSERT_VAL("wrong number of entries",
-			evlist->core.nr_entries == (5 * num_core_entries(evlist)));
-	TEST_ASSERT_VAL("wrong number of groups",
-			evlist__nr_groups(evlist) == (2 * num_core_entries(evlist)));
+	TEST_ASSERT_EVLIST("wrong number of entries",
+			   evlist->core.nr_entries == (5 * num_core_entries(evlist)),
+			   evlist);
+	TEST_ASSERT_EVLIST("wrong number of groups",
+			   evlist__nr_groups(evlist) == (2 * num_core_entries(evlist)),
+			   evlist);
 
 	for (int i = 0; i < num_core_entries(evlist); i++) {
 		/* cycles + G */
@@ -1152,10 +1204,12 @@ static int test__group_gh1(struct evlist *evlist)
 {
 	struct evsel *evsel = NULL, *leader;
 
-	TEST_ASSERT_VAL("wrong number of entries",
-			evlist->core.nr_entries == (2 * num_core_entries(evlist)));
-	TEST_ASSERT_VAL("wrong number of groups",
-			evlist__nr_groups(evlist) == num_core_entries(evlist));
+	TEST_ASSERT_EVLIST("wrong number of entries",
+			   evlist->core.nr_entries == (2 * num_core_entries(evlist)),
+			   evlist);
+	TEST_ASSERT_EVLIST("wrong number of groups",
+			   evlist__nr_groups(evlist) == num_core_entries(evlist),
+			   evlist);
 
 	for (int i = 0; i < num_core_entries(evlist); i++) {
 		/* cycles + :H group modifier */
@@ -1191,10 +1245,12 @@ static int test__group_gh2(struct evlist *evlist)
 {
 	struct evsel *evsel = NULL, *leader;
 
-	TEST_ASSERT_VAL("wrong number of entries",
-			evlist->core.nr_entries == (2 * num_core_entries(evlist)));
-	TEST_ASSERT_VAL("wrong number of groups",
-			evlist__nr_groups(evlist) == num_core_entries(evlist));
+	TEST_ASSERT_EVLIST("wrong number of entries",
+			   evlist->core.nr_entries == (2 * num_core_entries(evlist)),
+			   evlist);
+	TEST_ASSERT_EVLIST("wrong number of groups",
+			   evlist__nr_groups(evlist) == num_core_entries(evlist),
+			   evlist);
 
 	for (int i = 0; i < num_core_entries(evlist); i++) {
 		/* cycles + :G group modifier */
@@ -1230,10 +1286,12 @@ static int test__group_gh3(struct evlist *evlist)
 {
 	struct evsel *evsel = NULL, *leader;
 
-	TEST_ASSERT_VAL("wrong number of entries",
-			evlist->core.nr_entries == (2 * num_core_entries(evlist)));
-	TEST_ASSERT_VAL("wrong number of groups",
-			evlist__nr_groups(evlist) == num_core_entries(evlist));
+	TEST_ASSERT_EVLIST("wrong number of entries",
+			   evlist->core.nr_entries == (2 * num_core_entries(evlist)),
+			   evlist);
+	TEST_ASSERT_EVLIST("wrong number of groups",
+			   evlist__nr_groups(evlist) == num_core_entries(evlist),
+			   evlist);
 
 	for (int i = 0; i < num_core_entries(evlist); i++) {
 		/* cycles:G + :u group modifier */
@@ -1269,10 +1327,12 @@ static int test__group_gh4(struct evlist *evlist)
 {
 	struct evsel *evsel = NULL, *leader;
 
-	TEST_ASSERT_VAL("wrong number of entries",
-			evlist->core.nr_entries == (2 * num_core_entries(evlist)));
-	TEST_ASSERT_VAL("wrong number of groups",
-			evlist__nr_groups(evlist) == num_core_entries(evlist));
+	TEST_ASSERT_EVLIST("wrong number of entries",
+			   evlist->core.nr_entries == (2 * num_core_entries(evlist)),
+			   evlist);
+	TEST_ASSERT_EVLIST("wrong number of groups",
+			   evlist__nr_groups(evlist) == num_core_entries(evlist),
+			   evlist);
 
 	for (int i = 0; i < num_core_entries(evlist); i++) {
 		/* cycles:G + :uG group modifier */
@@ -1308,8 +1368,9 @@ static int test__leader_sample1(struct evlist *evlist)
 {
 	struct evsel *evsel = NULL, *leader;
 
-	TEST_ASSERT_VAL("wrong number of entries",
-			evlist->core.nr_entries == (3 * num_core_entries(evlist)));
+	TEST_ASSERT_EVLIST("wrong number of entries",
+			   evlist->core.nr_entries == (3 * num_core_entries(evlist)),
+			   evlist);
 
 	for (int i = 0; i < num_core_entries(evlist); i++) {
 		/* cycles - sampling group leader */
@@ -1358,8 +1419,9 @@ static int test__leader_sample2(struct evlist *evlist __maybe_unused)
 {
 	struct evsel *evsel = NULL, *leader;
 
-	TEST_ASSERT_VAL("wrong number of entries",
-			evlist->core.nr_entries == (2 * num_core_entries(evlist)));
+	TEST_ASSERT_EVLIST("wrong number of entries",
+			   evlist->core.nr_entries == (2 * num_core_entries(evlist)),
+			   evlist);
 
 	for (int i = 0; i < num_core_entries(evlist); i++) {
 		/* instructions - sampling group leader */
@@ -1396,8 +1458,9 @@ static int test__checkevent_pinned_modifier(struct evlist *evlist)
 {
 	struct evsel *evsel = NULL;
 
-	TEST_ASSERT_VAL("wrong number of entries",
-			evlist->core.nr_entries == num_core_entries(evlist));
+	TEST_ASSERT_EVLIST("wrong number of entries",
+			   evlist->core.nr_entries == num_core_entries(evlist),
+			   evlist);
 
 	for (int i = 0; i < num_core_entries(evlist); i++) {
 		evsel = (i == 0 ? evlist__first(evlist) : evsel__next(evsel));
@@ -1414,8 +1477,9 @@ static int test__pinned_group(struct evlist *evlist)
 {
 	struct evsel *evsel = NULL, *leader;
 
-	TEST_ASSERT_VAL("wrong number of entries",
-			evlist->core.nr_entries == (3 * num_core_entries(evlist)));
+	TEST_ASSERT_EVLIST("wrong number of entries",
+			   evlist->core.nr_entries == (3 * num_core_entries(evlist)),
+			   evlist);
 
 	for (int i = 0; i < num_core_entries(evlist); i++) {
 		/* cycles - group leader */
@@ -1445,6 +1509,9 @@ static int test__checkevent_exclusive_modifier(struct evlist *evlist)
 {
 	struct evsel *evsel = evlist__first(evlist);
 
+	TEST_ASSERT_EVLIST("wrong number of entries",
+			   evlist->core.nr_entries == num_core_entries(evlist),
+			   evlist);
 	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
 	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
@@ -1458,8 +1525,9 @@ static int test__exclusive_group(struct evlist *evlist)
 {
 	struct evsel *evsel = NULL, *leader;
 
-	TEST_ASSERT_VAL("wrong number of entries",
-			evlist->core.nr_entries == 3 * num_core_entries(evlist));
+	TEST_ASSERT_EVLIST("wrong number of entries",
+			   evlist->core.nr_entries == 3 * num_core_entries(evlist),
+			   evlist);
 
 	for (int i = 0; i < num_core_entries(evlist); i++) {
 		/* cycles - group leader */
@@ -1488,7 +1556,7 @@ static int test__checkevent_breakpoint_len(struct evlist *evlist)
 {
 	struct evsel *evsel = evlist__first(evlist);
 
-	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
+	TEST_ASSERT_EVLIST("wrong number of entries", 1 == evlist->core.nr_entries, evlist);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_BREAKPOINT == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config", 0 == evsel->core.attr.config);
 	TEST_ASSERT_VAL("wrong bp_type", (HW_BREAKPOINT_R | HW_BREAKPOINT_W) ==
@@ -1503,7 +1571,7 @@ static int test__checkevent_breakpoint_len_w(struct evlist *evlist)
 {
 	struct evsel *evsel = evlist__first(evlist);
 
-	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
+	TEST_ASSERT_EVLIST("wrong number of entries", 1 == evlist->core.nr_entries, evlist);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_BREAKPOINT == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config", 0 == evsel->core.attr.config);
 	TEST_ASSERT_VAL("wrong bp_type", HW_BREAKPOINT_W ==
@@ -1519,6 +1587,7 @@ test__checkevent_breakpoint_len_rw_modifier(struct evlist *evlist)
 {
 	struct evsel *evsel = evlist__first(evlist);
 
+	TEST_ASSERT_EVLIST("wrong number of entries", 1 == evlist->core.nr_entries, evlist);
 	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
 	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
@@ -1531,8 +1600,9 @@ static int test__checkevent_precise_max_modifier(struct evlist *evlist)
 {
 	struct evsel *evsel = evlist__first(evlist);
 
-	TEST_ASSERT_VAL("wrong number of entries",
-			evlist->core.nr_entries == 1 + num_core_entries(evlist));
+	TEST_ASSERT_EVLIST("wrong number of entries",
+			   evlist->core.nr_entries == 1 + num_core_entries(evlist),
+			   evlist);
 	TEST_ASSERT_VAL("wrong type/config", evsel__match(evsel, SOFTWARE, SW_TASK_CLOCK));
 	return TEST_OK;
 }
@@ -1541,6 +1611,9 @@ static int test__checkevent_config_symbol(struct evlist *evlist)
 {
 	struct evsel *evsel = evlist__first(evlist);
 
+	TEST_ASSERT_EVLIST("wrong number of entries",
+			   evlist->core.nr_entries == num_core_entries(evlist),
+			   evlist);
 	TEST_ASSERT_VAL("wrong name setting", evsel__name_is(evsel, "insn"));
 	return TEST_OK;
 }
@@ -1549,6 +1622,7 @@ static int test__checkevent_config_raw(struct evlist *evlist)
 {
 	struct evsel *evsel = evlist__first(evlist);
 
+	TEST_ASSERT_EVLIST("wrong number of entries", 1 == evlist->core.nr_entries, evlist);
 	TEST_ASSERT_VAL("wrong name setting", evsel__name_is(evsel, "rawpmu"));
 	return TEST_OK;
 }
@@ -1557,6 +1631,7 @@ static int test__checkevent_config_num(struct evlist *evlist)
 {
 	struct evsel *evsel = evlist__first(evlist);
 
+	TEST_ASSERT_EVLIST("wrong number of entries", 1 == evlist->core.nr_entries, evlist);
 	TEST_ASSERT_VAL("wrong name setting", evsel__name_is(evsel, "numpmu"));
 	return TEST_OK;
 }
@@ -1565,6 +1640,9 @@ static int test__checkevent_config_cache(struct evlist *evlist)
 {
 	struct evsel *evsel = evlist__first(evlist);
 
+	TEST_ASSERT_EVLIST("wrong number of entries",
+			   evlist->core.nr_entries == num_core_entries(evlist),
+			   evlist);
 	TEST_ASSERT_VAL("wrong name setting", evsel__name_is(evsel, "cachepmu"));
 	return test__checkevent_genhw(evlist);
 }
@@ -1588,6 +1666,7 @@ static int test__intel_pt(struct evlist *evlist)
 {
 	struct evsel *evsel = evlist__first(evlist);
 
+	TEST_ASSERT_EVLIST("wrong number of entries", 1 == evlist->core.nr_entries, evlist);
 	TEST_ASSERT_VAL("wrong name setting", evsel__name_is(evsel, "intel_pt//u"));
 	return TEST_OK;
 }
@@ -1596,6 +1675,9 @@ static int test__checkevent_complex_name(struct evlist *evlist)
 {
 	struct evsel *evsel = evlist__first(evlist);
 
+	TEST_ASSERT_EVLIST("wrong number of entries",
+			   evlist->core.nr_entries == num_core_entries(evlist),
+			   evlist);
 	TEST_ASSERT_VAL("wrong complex name parsing",
 			evsel__name_is(evsel,
 				       "COMPLEX_CYCLES_NAME:orig=cpu-cycles,desc=chip-clock-ticks"));
@@ -1606,7 +1688,7 @@ static int test__checkevent_raw_pmu(struct evlist *evlist)
 {
 	struct evsel *evsel = evlist__first(evlist);
 
-	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
+	TEST_ASSERT_EVLIST("wrong number of entries", 1 == evlist->core.nr_entries, evlist);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_SOFTWARE == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config", 0x1a == evsel->core.attr.config);
 	return TEST_OK;
@@ -1616,6 +1698,9 @@ static int test__sym_event_slash(struct evlist *evlist)
 {
 	struct evsel *evsel = evlist__first(evlist);
 
+	TEST_ASSERT_EVLIST("wrong number of entries",
+			   evlist->core.nr_entries == num_core_entries(evlist),
+			   evlist);
 	TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_CPU_CYCLES));
 	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
 	return TEST_OK;
@@ -1625,6 +1710,9 @@ static int test__sym_event_dc(struct evlist *evlist)
 {
 	struct evsel *evsel = evlist__first(evlist);
 
+	TEST_ASSERT_EVLIST("wrong number of entries",
+			   evlist->core.nr_entries == num_core_entries(evlist),
+			   evlist);
 	TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_CPU_CYCLES));
 	TEST_ASSERT_VAL("wrong exclude_user", evsel->core.attr.exclude_user);
 	return TEST_OK;
@@ -1634,6 +1722,9 @@ static int test__term_equal_term(struct evlist *evlist)
 {
 	struct evsel *evsel = evlist__first(evlist);
 
+	TEST_ASSERT_EVLIST("wrong number of entries",
+			   evlist->core.nr_entries == num_core_entries(evlist),
+			   evlist);
 	TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_CPU_CYCLES));
 	TEST_ASSERT_VAL("wrong name setting", strcmp(evsel->name, "name") == 0);
 	return TEST_OK;
@@ -1643,6 +1734,9 @@ static int test__term_equal_legacy(struct evlist *evlist)
 {
 	struct evsel *evsel = evlist__first(evlist);
 
+	TEST_ASSERT_EVLIST("wrong number of entries",
+			   evlist->core.nr_entries == num_core_entries(evlist),
+			   evlist);
 	TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_CPU_CYCLES));
 	TEST_ASSERT_VAL("wrong name setting", strcmp(evsel->name, "l1d") == 0);
 	return TEST_OK;
-- 
2.51.0.534.gc79095c0ca-goog

