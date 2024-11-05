Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B94E216A31
	for <linux-perf-users@vger.kernel.org>; Tue,  5 Nov 2024 21:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730842036; cv=none; b=O/JhKxe7KdqJoJ592fPy+wpKrZ69wBDU2iGssFqeluU8Cdhm9VWmKVH1mMRUOg4rSZIKCrPToX60BFpT3HUw+7PYMVbyyEo6tmdQkqsit2rkfDz2kH5Fz6aWdb9A+nQDS3lqVdIvX6Qqf9bxuy59wz6ve+z4Ev6M9gTEcaap/7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730842036; c=relaxed/simple;
	bh=TkS5pGIRNnEam46bfgl9Uj7ffjeE7cIcCgpMGBkUSW0=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=gHWwTLkzym7K/tveteojoohaQonv2lGhS/7tLM0P1mokB4XqsOmrJuAvilMKi5Qr0A/vuDSfsuG5kV224yeh8A7gDX0diZL97eYMoAr6JSdtGNk28P96WJ50Y4DjnaB81548kV5j1uwQwMvRoaHqz0xIYS2Wd5DWa6nuoJnige4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vSyUidcq; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vSyUidcq"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ea82a5480fso66615317b3.0
        for <linux-perf-users@vger.kernel.org>; Tue, 05 Nov 2024 13:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730842034; x=1731446834; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M2PH93HMmorh1b48i5mQD0XLDSM5RTSRQhDdzjBbjYo=;
        b=vSyUidcqVcdp90i/CKHbddEqU1x8N8ReUwLFJWakuVkDafP2cdU6ueGXLAcB5Zj3L7
         kzYCSIGDZAS3MrBZvQCn0W/5JfpTfXuI+vtc1btj8UB7H2WresOOW0NpdT+umM08vi1Q
         AUn1hXFVDaSdTpYMc4KNqOL7jJMUy/14hvXZxMQ7GnVNmGJqfofZIE8rV9IUVeViJCJR
         8gFzSjg24wceM0zmRZce5d45d1KhIYKLHMopgahxX/moymGQFiOj+TmPk1d6RobMDQWR
         ViI/2PiDQIokiWp2IHRYMuKLpVEm5DK1FbFYh7XSNDDSr48Gr/OQpWBxNNtac78QKteA
         PUnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730842034; x=1731446834;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M2PH93HMmorh1b48i5mQD0XLDSM5RTSRQhDdzjBbjYo=;
        b=muGZwZcaUDNpH2iy2ZeGwQAu/IYIA5K9b3eOK6gkf2hPobTU60C/YIE2k9iRa024KV
         xPnEDkjH07o/xhoiahAuWxEAeU1bNY51mRL35wGzYTQvdnvxWIwgGIYjCb1quJR4hgxY
         YzEFkyTEezXBwv6ssdnHpVBX9fQcKxbhy8MXnHW6LM8LAbR43CuSkrZVtVsyLIux/3vY
         ckRAaGzYFK/xo16kgyZuWcxKJqOBscbyg8mk55cZXogd+IDF8bfDDvIUel2mmNhdAFRj
         NP7jH2+Na4C6LPvlTyCxdcxcFsuIvT14CsMtUGIXz6KupQHTkz1pER13cmBzZxiOFkMc
         Q7Ew==
X-Forwarded-Encrypted: i=1; AJvYcCUATZ428e6qJ3UdDfgg8pMJ01OgfKRNPIxhJTzd2vOKhk+WwQm0L6lV7w5M+VpMReSh0XPAPpeHC5BaCyZ41N6p@vger.kernel.org
X-Gm-Message-State: AOJu0YyOtydYzM1GEbi3QftlnGEgfpD+WUFDDxXFXbZtPBNfARqOe1nh
	V1OIKLJORiBZJNztgg1/QrygBk2BCalCEujrzbI5wJVSMefNYvKinmKyVdOEM0UJ7fNSd4OT9he
	7fL4GIg==
X-Google-Smtp-Source: AGHT+IFjcXLcs06B8eplottHdJv3MowMx13MBZYVrZnj9CxGN1Q3h93fubGTb1YnkrC9EQnU8zgOBA2YBhDb
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:ff9e:ab12:75ac:c1a0])
 (user=irogers job=sendgmr) by 2002:a05:690c:4484:b0:6dd:fda3:6568 with SMTP
 id 00721157ae682-6ea64b8c23cmr1322607b3.3.1730842034072; Tue, 05 Nov 2024
 13:27:14 -0800 (PST)
Date: Tue,  5 Nov 2024 13:26:52 -0800
In-Reply-To: <20241105212652.401943-1-irogers@google.com>
Message-Id: <20241105212652.401943-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241105212652.401943-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Subject: [PATCH v3 6/6] perf tests: Enable tests disabled due to tracepoint parsing
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	James Clark <james.clark@linaro.org>, Dominique Martinet <asmadeus@codewreck.org>, 
	Yang Li <yang.lee@linux.alibaba.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Yang Jihong <yangjihong@bytedance.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
	Ze Gao <zegao2021@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Ben Gainey <ben.gainey@arm.com>, zhaimingbing <zhaimingbing@cmss.chinamobile.com>, 
	Zixian Cai <fzczx123@gmail.com>, Andi Kleen <ak@linux.intel.com>, Paran Lee <p4ranlee@gmail.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, 
	"Steven Rostedt (Google)" <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"

Tracepoint parsing required libtraceevent but no longer does. Remove
the Build logic and #ifdefs that caused the tests not to be run. Test
code that directly uses libtraceevent is still guarded.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/Build          |  6 +++---
 tools/perf/tests/builtin-test.c |  2 --
 tools/perf/tests/parse-events.c | 25 +------------------------
 3 files changed, 4 insertions(+), 29 deletions(-)

diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
index 01ed9335db4d..f26a668a96df 100644
--- a/tools/perf/tests/Build
+++ b/tools/perf/tests/Build
@@ -5,10 +5,10 @@ perf-test-y += tests-scripts.o
 perf-test-y += parse-events.o
 perf-test-y += dso-data.o
 perf-test-y += vmlinux-kallsyms.o
-perf-test-$(CONFIG_LIBTRACEEVENT) += openat-syscall.o
-perf-test-$(CONFIG_LIBTRACEEVENT) += openat-syscall-all-cpus.o
+perf-test-y += openat-syscall.o
+perf-test-y += openat-syscall-all-cpus.o
 perf-test-$(CONFIG_LIBTRACEEVENT) += openat-syscall-tp-fields.o
-perf-test-$(CONFIG_LIBTRACEEVENT) += mmap-basic.o
+perf-test-y += mmap-basic.o
 perf-test-y += perf-record.o
 perf-test-y += evsel-roundtrip-name.o
 perf-test-$(CONFIG_LIBTRACEEVENT) += evsel-tp-sched.o
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index d2cabaa8ad92..4c3b622130a9 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -60,11 +60,9 @@ static struct test_suite *arch_tests[] = {
 
 static struct test_suite *generic_tests[] = {
 	&suite__vmlinux_matches_kallsyms,
-#ifdef HAVE_LIBTRACEEVENT
 	&suite__openat_syscall_event,
 	&suite__openat_syscall_event_on_all_cpus,
 	&suite__basic_mmap,
-#endif
 	&suite__mem,
 	&suite__parse_events,
 	&suite__expr,
diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 82a19674a38f..5ec2e5607987 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -54,8 +54,6 @@ static bool test_perf_config(const struct perf_evsel *evsel, __u64 expected_conf
 	return (evsel->attr.config & PERF_HW_EVENT_MASK) == expected_config;
 }
 
-#ifdef HAVE_LIBTRACEEVENT
-
 #if defined(__s390x__)
 /* Return true if kvm module is available and loaded. Test this
  * and return success when trace point kvm_s390_create_vm
@@ -112,7 +110,6 @@ static int test__checkevent_tracepoint_multi(struct evlist *evlist)
 	}
 	return TEST_OK;
 }
-#endif /* HAVE_LIBTRACEEVENT */
 
 static int test__checkevent_raw(struct evlist *evlist)
 {
@@ -311,7 +308,6 @@ static int test__checkevent_breakpoint_rw(struct evlist *evlist)
 	return TEST_OK;
 }
 
-#ifdef HAVE_LIBTRACEEVENT
 static int test__checkevent_tracepoint_modifier(struct evlist *evlist)
 {
 	struct evsel *evsel = evlist__first(evlist);
@@ -340,7 +336,6 @@ test__checkevent_tracepoint_multi_modifier(struct evlist *evlist)
 
 	return test__checkevent_tracepoint_multi(evlist);
 }
-#endif /* HAVE_LIBTRACEEVENT */
 
 static int test__checkevent_raw_modifier(struct evlist *evlist)
 {
@@ -629,7 +624,6 @@ static int test__checkevent_pmu(struct evlist *evlist)
 	return TEST_OK;
 }
 
-#ifdef HAVE_LIBTRACEEVENT
 static int test__checkevent_list(struct evlist *evlist)
 {
 	struct evsel *evsel = evlist__first(evlist);
@@ -671,7 +665,6 @@ static int test__checkevent_list(struct evlist *evlist)
 
 	return TEST_OK;
 }
-#endif
 
 static int test__checkevent_pmu_name(struct evlist *evlist)
 {
@@ -971,7 +964,6 @@ static int test__group2(struct evlist *evlist)
 	return TEST_OK;
 }
 
-#ifdef HAVE_LIBTRACEEVENT
 static int test__group3(struct evlist *evlist __maybe_unused)
 {
 	struct evsel *evsel, *group1_leader = NULL, *group2_leader = NULL;
@@ -1078,7 +1070,6 @@ static int test__group3(struct evlist *evlist __maybe_unused)
 	}
 	return TEST_OK;
 }
-#endif
 
 static int test__group4(struct evlist *evlist __maybe_unused)
 {
@@ -1813,7 +1804,6 @@ static int test__term_equal_legacy(struct evlist *evlist)
 	return TEST_OK;
 }
 
-#ifdef HAVE_LIBTRACEEVENT
 static int count_tracepoints(void)
 {
 	struct dirent *events_ent;
@@ -1867,7 +1857,6 @@ static int test__all_tracepoints(struct evlist *evlist)
 
 	return test__checkevent_tracepoint_multi(evlist);
 }
-#endif /* HAVE_LIBTRACEVENT */
 
 struct evlist_test {
 	const char *name;
@@ -1876,7 +1865,6 @@ struct evlist_test {
 };
 
 static const struct evlist_test test__events[] = {
-#ifdef HAVE_LIBTRACEEVENT
 	{
 		.name  = "syscalls:sys_enter_openat",
 		.check = test__checkevent_tracepoint,
@@ -1887,7 +1875,6 @@ static const struct evlist_test test__events[] = {
 		.check = test__checkevent_tracepoint_multi,
 		/* 1 */
 	},
-#endif
 	{
 		.name  = "r1a",
 		.check = test__checkevent_raw,
@@ -1938,7 +1925,6 @@ static const struct evlist_test test__events[] = {
 		.check = test__checkevent_breakpoint_w,
 		/* 1 */
 	},
-#ifdef HAVE_LIBTRACEEVENT
 	{
 		.name  = "syscalls:sys_enter_openat:k",
 		.check = test__checkevent_tracepoint_modifier,
@@ -1949,7 +1935,6 @@ static const struct evlist_test test__events[] = {
 		.check = test__checkevent_tracepoint_multi_modifier,
 		/* 3 */
 	},
-#endif
 	{
 		.name  = "r1a:kp",
 		.check = test__checkevent_raw_modifier,
@@ -1995,13 +1980,11 @@ static const struct evlist_test test__events[] = {
 		.check = test__checkevent_breakpoint_w_modifier,
 		/* 2 */
 	},
-#ifdef HAVE_LIBTRACEEVENT
 	{
 		.name  = "r1,syscalls:sys_enter_openat:k,1:1:hp",
 		.check = test__checkevent_list,
 		/* 3 */
 	},
-#endif
 	{
 		.name  = "instructions:G",
 		.check = test__checkevent_exclude_host_modifier,
@@ -2032,13 +2015,11 @@ static const struct evlist_test test__events[] = {
 		.check = test__group2,
 		/* 9 */
 	},
-#ifdef HAVE_LIBTRACEEVENT
 	{
 		.name  = "group1{syscalls:sys_enter_openat:H,cycles:kppp},group2{cycles,1:3}:G,instructions:u",
 		.check = test__group3,
 		/* 0 */
 	},
-#endif
 	{
 		.name  = "{cycles:u,instructions:kp}:p",
 		.check = test__group4,
@@ -2049,13 +2030,11 @@ static const struct evlist_test test__events[] = {
 		.check = test__group5,
 		/* 2 */
 	},
-#ifdef HAVE_LIBTRACEEVENT
 	{
 		.name  = "*:*",
 		.check = test__all_tracepoints,
 		/* 3 */
 	},
-#endif
 	{
 		.name  = "{cycles,cache-misses:G}:H",
 		.check = test__group_gh1,
@@ -2111,7 +2090,7 @@ static const struct evlist_test test__events[] = {
 		.check = test__checkevent_breakpoint_len_rw_modifier,
 		/* 4 */
 	},
-#if defined(__s390x__) && defined(HAVE_LIBTRACEEVENT)
+#if defined(__s390x__)
 	{
 		.name  = "kvm-s390:kvm_s390_create_vm",
 		.check = test__checkevent_tracepoint,
@@ -2265,13 +2244,11 @@ static const struct evlist_test test__events[] = {
 		.check = test__checkevent_breakpoint_2_events,
 		/* 3 */
 	},
-#ifdef HAVE_LIBTRACEEVENT
 	{
 		.name = "9p:9p_client_req",
 		.check = test__checkevent_tracepoint,
 		/* 4 */
 	},
-#endif
 };
 
 static const struct evlist_test test__events_pmu[] = {
-- 
2.47.0.199.ga7371fff76-goog

