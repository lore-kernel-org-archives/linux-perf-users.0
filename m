Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454972BE622
	for <linux-perf-users@vger.kernel.org>; Sun,  5 Oct 2025 18:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759688735; cv=none; b=DsaSvUK1VPddTsC5CfwSkZAAXMKN8HwHCGhs1OnetIu+d3iJRFJ1UzRH5MgvJ5glDtQaPR7RzBo7zzyY1dzt2i/g/DdH+IvsFUZEHsm8gtI12zWUgd5VN+WjkOMUP8x9m9HIiNtBEqGzz7o4hSGh6T5hSwCZXf8lZRVmcf26ntc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759688735; c=relaxed/simple;
	bh=Ld+7A/xHZ/69wov/MDVLHj4rjQYhra0pmx/Kcw0gSNY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kaGeEs3i6YGCbca5ZZSqJdQbcys29EKEhROezAnIsXgXgVvmw3sN+XYbESAc7ntPz/sm8ydVlXtexgUxMhV5UDYY03eU4V04gN8v6DoQkLAvrQEx9bU0Dw61+jTlRQVAIuU/xUL5gD5fogC43TbJvHXh3R18ukkAoWrbBoyXLhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jBYrsIBB; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jBYrsIBB"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-28a5b8b12bbso86903115ad.2
        for <linux-perf-users@vger.kernel.org>; Sun, 05 Oct 2025 11:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759688732; x=1760293532; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pN+zeYAvwPFoU/4E+aa8wDV681uLv8GE9sACvTmZy9A=;
        b=jBYrsIBBS9ePXuepH4CaWA+vSs3kYvb7OgWTRWS0Y/iE7iExY0m+a7Ri+jvTnJ/llD
         A6I5EeBs6cpIB/oar2MF9clns1qWEM+JB1SFkVlfwQSxOQaG7jt2oIELyPN16onRm4mX
         w+lCqGBbsJ0pt2wsXncOW7Hkxa27qtNOEmc7FYCz494gKn67Xai+2I0kdNyqKhgESiYB
         +nqAGr+XI0qLOsp0H5WJqmqtXxy/SJRSIP5hRjtT6lvchADLOd6QY6ZxnrVag2TkptaE
         PDf740oxbe2OEoEl7ECkWjOItvaft91Sr6GNvqLOk8rdkRySWCvgEijv87oAlSnqa7Wz
         +d1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759688732; x=1760293532;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pN+zeYAvwPFoU/4E+aa8wDV681uLv8GE9sACvTmZy9A=;
        b=hkUsVk55R2+FQ+Ejh1HxNiv5AGvEXIoulZ/rjfo5aFM21PjCmkqDbngfxi5LbLW/3w
         FETDYTpZSufXYOcy1+JIkM/92pPDssHiBnZzkz7flEpsL3JKJhR3kVO4CUIZLRUEYYCa
         RfYIUIBifIkRonsEdhONIHLqSl4nsGTCKsO6v+rb49DIWUW3KUwR/YGvAzaUNhEIUg1s
         75FXm+ShVFXA27gfT/nHlvOrPcYQQvAEQpeHOKHRL1Frsha734AKrrh4oaidUgcQMWx+
         IdLbDCc6pM4GqTek+bZmUlBGfBVY2zRtOMDA08ovDUHS1cLinceGeGHoXwlaZZb55oDt
         /1oQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUgY9kAF1prsVhepNx+svUzShvcJtpxj9GzlVx0apMRCwOdPkZyx/dyXYyZIZqoCtUKbUi2fzyrKzwK/qvKBsy@vger.kernel.org
X-Gm-Message-State: AOJu0YyzD0cXN2PA+i96vIir/LtUTKhAFtxOM86RBMMmnz/RPco8BEJl
	CjvsyfHD8hO3Vm0wXPFlX7YvktCBPPvYDLUaHmw08oNDxpWzh8wOZIL2Ko0sIHjGQvf/GX5UDl9
	gsV0FLRoKqQ==
X-Google-Smtp-Source: AGHT+IF9R8TtqR2gVOtF96iguHfZ+R5pUZBX5q5/2/kJ7StiNzbvhtlPWWH8fAjjq2C8BGNcAn7ckuRxEcfj
X-Received: from plbbh8.prod.google.com ([2002:a17:902:a988:b0:269:7867:579f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1aa5:b0:28a:2e51:9272
 with SMTP id d9443c01a7336-28e9a67bf43mr98130345ad.48.1759688731784; Sun, 05
 Oct 2025 11:25:31 -0700 (PDT)
Date: Sun,  5 Oct 2025 11:24:29 -0700
In-Reply-To: <20251005182430.2791371-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251005182430.2791371-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251005182430.2791371-27-irogers@google.com>
Subject: [PATCH v7 26/27] perf test parse-events: Add evlist test helper
From: Ian Rogers <irogers@google.com>
To: James Clark <james.clark@linaro.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Xu Yang <xu.yang_2@nxp.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Atish Patra <atishp@rivosinc.com>, Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>, 
	Vince Weaver <vincent.weaver@maine.edu>
Cc: Ian Rogers <irogers@google.com>
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
index b6ba0e632454..20c91acea88a 100644
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
@@ -1642,6 +1721,9 @@ static int test__checkevent_complex_name(struct evlist *evlist)
 {
 	struct evsel *evsel = evlist__first(evlist);
 
+	TEST_ASSERT_EVLIST("wrong number of entries",
+			   evlist->core.nr_entries == num_core_entries(evlist),
+			   evlist);
 	TEST_ASSERT_VAL("wrong complex name parsing",
 			evsel__name_is(evsel,
 				       "COMPLEX_CYCLES_NAME:orig=cpu-cycles,desc=chip-clock-ticks"));
@@ -1652,7 +1734,7 @@ static int test__checkevent_raw_pmu(struct evlist *evlist)
 {
 	struct evsel *evsel = evlist__first(evlist);
 
-	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
+	TEST_ASSERT_EVLIST("wrong number of entries", 1 == evlist->core.nr_entries, evlist);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_SOFTWARE == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config", 0x1a == evsel->core.attr.config);
 	return TEST_OK;
@@ -1662,6 +1744,9 @@ static int test__sym_event_slash(struct evlist *evlist)
 {
 	struct evsel *evsel = evlist__first(evlist);
 
+	TEST_ASSERT_EVLIST("wrong number of entries",
+			   evlist->core.nr_entries == num_core_entries(evlist),
+			   evlist);
 	TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_CPU_CYCLES));
 	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
 	return TEST_OK;
@@ -1671,6 +1756,9 @@ static int test__sym_event_dc(struct evlist *evlist)
 {
 	struct evsel *evsel = evlist__first(evlist);
 
+	TEST_ASSERT_EVLIST("wrong number of entries",
+			   evlist->core.nr_entries == num_core_entries(evlist),
+			   evlist);
 	TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_CPU_CYCLES));
 	TEST_ASSERT_VAL("wrong exclude_user", evsel->core.attr.exclude_user);
 	return TEST_OK;
@@ -1680,6 +1768,9 @@ static int test__term_equal_term(struct evlist *evlist)
 {
 	struct evsel *evsel = evlist__first(evlist);
 
+	TEST_ASSERT_EVLIST("wrong number of entries",
+			   evlist->core.nr_entries == num_core_entries(evlist),
+			   evlist);
 	TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_CPU_CYCLES));
 	TEST_ASSERT_VAL("wrong name setting", strcmp(evsel->name, "name") == 0);
 	return TEST_OK;
@@ -1689,6 +1780,9 @@ static int test__term_equal_legacy(struct evlist *evlist)
 {
 	struct evsel *evsel = evlist__first(evlist);
 
+	TEST_ASSERT_EVLIST("wrong number of entries",
+			   evlist->core.nr_entries == num_core_entries(evlist),
+			   evlist);
 	TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_CPU_CYCLES));
 	TEST_ASSERT_VAL("wrong name setting", strcmp(evsel->name, "l1d") == 0);
 	return TEST_OK;
-- 
2.51.0.618.g983fd99d29-goog

