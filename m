Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC35480BEC
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Dec 2024 02:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733365393; cv=none; b=K6U6N4LY9sSO+DswAlbgHhBHrlQ+20dDH0UP8Zakho59tnKUosF/RzQlqlOf08jqV/8cuSG8e23uawITh/BFlJB7dysD/TqSrQaOQ9FLFheykJzEbjkAGg9rGsONTFB9AWJKM21O0Slsdc/dB5mY4xF3gOaRD11xqa47uvF/LPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733365393; c=relaxed/simple;
	bh=dUoPXWx5g/C05ns4181AszXXKtfKrw24jER/MqQIQeA=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=p3QwuS0f71ZOTrDkguGiKjX+j6V2os/G5PS5QxWxxYIBfSUy4hsfawNyoByeLtrcl2qSDkJV6oHA6bMtNiqkd/48GNxrMFf2A3hHEaSBT6RW8qH/27BXtxkbkWCoMgRYdXqUtO8qb7Cgwfsn/w3ryf08jntCcaJWEkLkcUUAZbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lu9vF1eb; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lu9vF1eb"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e35e0e88973so1164399276.0
        for <linux-perf-users@vger.kernel.org>; Wed, 04 Dec 2024 18:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733365391; x=1733970191; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Jcq8s/qJvxHm0kGrnwNvGixVnYCeqYmFdkAzf/e/ncg=;
        b=lu9vF1ebjmOtcDAuD/Nfyeoh411tYQwzgOXVlxhaQi/HqPvVJZVLMPYd08ZNmZDemg
         S6n+PtAgdTBdnaTdfJZYCzytAj6p4aCRLR9DW2MERGcgRu5ZXK1yfdeY/49HzOF8Rxcy
         NFfH7dlhCZTpWxHy4DSf1Np6fKZhYSfRWy3bZDIKnpWZm6Ah3ZxlPAQbv0EZx/vrrnqd
         MeenRiVE/L5CxwebsgZNboykt0enCQmml8MFoW9hK4dGYYK7S7Cd6MJP0IVjsg3gaWV6
         gMKeBavi/MAT6m4sziFZqKEk95yrFDLDL+QCipGzUJxjk4FVRlJV6jZICO2QcYmf0wxq
         JpGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733365391; x=1733970191;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jcq8s/qJvxHm0kGrnwNvGixVnYCeqYmFdkAzf/e/ncg=;
        b=gU0FXmnwNZ3yqzIa9z7+bRv7a7rmx5KOjYyH1mWytAqzpr4IcUtznlSUf9llJGooQj
         1jJwD4ZVpAcUhwd3k8537dahNO0cbXhws8ga0XzECHm/knS240s6R3p9MpS4aHgo7XHX
         u4Y/SIjoZGvyOHicQyfGUFS/xfWwIgQB1MZPpNhtQmoi2PaM5vd3IWnPTrOLeID6m8Ed
         niHTGWjcauU+YXRRpVa+y5UPBVQ8/eUom0t/MxGz/l3qkl9laoge1F/4UvzicKJMJept
         E4lcgko9ztW9UNGbn3JzdCMdI7liSZX1/lZ7u6lPQgnOfkWj+Ct6Wepn6gocop/KU8UJ
         iX5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVuaXuQ2wG7CmLpnK6kJoO2jvBTd/vWuB9MDj0qLkQ21jvpcxe9MRrmXK8abdJfjHzfSEf7rSAN1aIh2d9m1IHS@vger.kernel.org
X-Gm-Message-State: AOJu0YxgquIgO4GkH4yhFX2b3/oIYPRsvP8iP6E6o9EQ1QLeOqBjula2
	A9zYoQBsG15PKI/Wjz0HhH4tMDnQ8NhUJEZVrYrE97Fu9u6nb+f80rcJecc4F6VY490c9zfaYVv
	wZHid0w==
X-Google-Smtp-Source: AGHT+IEiDc6wp/vOXpk+5qGCYbvmQ6wGcBzRlLrmQKrhyAXvCyjL7Lbc+BIS2p/Piw0LSEa9N89HM31ntAR1
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:8733:728b:3b2b:932])
 (user=irogers job=sendgmr) by 2002:a25:aa6c:0:b0:e38:81f0:8c23 with SMTP id
 3f1490d57ef6-e39f2459342mr2847276.6.1733365390932; Wed, 04 Dec 2024 18:23:10
 -0800 (PST)
Date: Wed,  4 Dec 2024 18:23:05 -0800
Message-Id: <20241205022305.158202-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Subject: [PATCH v1] perf test expr: Fix system_tsc_freq for only x86
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, akanksha@linux.ibm.com, maddy@linux.ibm.com, 
	atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com, disgoel@linux.vnet.ibm.com, 
	hbathini@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

The refactoring of tool PMU events to have a PMU then adding the expr
literals to the tool PMU made it so that the literal system_tsc_freq
was only supported on x86. Update the test expectations to match -
namely the parsing is x86 specific and only yields a non-zero value on
Intel.

Fixes: 609aa2667f67 ("perf tool_pmu: Switch to standard pmu functions and json descriptions")
Reported-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Closes: https://lore.kernel.org/linux-perf-users/20241022140156.98854-1-atrajeev@linux.vnet.ibm.com/
Co-developed-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/expr.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
index 41ff1affdfcd..726cf8d4da28 100644
--- a/tools/perf/tests/expr.c
+++ b/tools/perf/tests/expr.c
@@ -75,14 +75,12 @@ static int test__expr(struct test_suite *t __maybe_unused, int subtest __maybe_u
 	double val, num_cpus_online, num_cpus, num_cores, num_dies, num_packages;
 	int ret;
 	struct expr_parse_ctx *ctx;
-	bool is_intel = false;
 	char strcmp_cpuid_buf[256];
 	struct perf_cpu cpu = {-1};
 	char *cpuid = get_cpuid_allow_env_override(cpu);
 	char *escaped_cpuid1, *escaped_cpuid2;
 
 	TEST_ASSERT_VAL("get_cpuid", cpuid);
-	is_intel = strstr(cpuid, "Intel") != NULL;
 
 	TEST_ASSERT_EQUAL("ids_union", test_ids_union(), 0);
 
@@ -245,12 +243,19 @@ static int test__expr(struct test_suite *t __maybe_unused, int subtest __maybe_u
 	if (num_dies) // Some platforms do not have CPU die support, for example s390
 		TEST_ASSERT_VAL("#num_dies >= #num_packages", num_dies >= num_packages);
 
-	TEST_ASSERT_VAL("#system_tsc_freq", expr__parse(&val, ctx, "#system_tsc_freq") == 0);
-	if (is_intel)
-		TEST_ASSERT_VAL("#system_tsc_freq > 0", val > 0);
-	else
-		TEST_ASSERT_VAL("#system_tsc_freq == 0", fpclassify(val) == FP_ZERO);
 
+	if (expr__parse(&val, ctx, "#system_tsc_freq") == 0) {
+		bool is_intel = strstr(cpuid, "Intel") != NULL;
+
+		if (is_intel)
+			TEST_ASSERT_VAL("#system_tsc_freq > 0", val > 0);
+		else
+			TEST_ASSERT_VAL("#system_tsc_freq == 0", fpclassify(val) == FP_ZERO);
+	} else {
+#if defined(__i386__) || defined(__x86_64__)
+		TEST_ASSERT_VAL("#system_tsc_freq unsupported", 0);
+#endif
+	}
 	/*
 	 * Source count returns the number of events aggregating in a leader
 	 * event including the leader. Check parsing yields an id.
-- 
2.47.0.338.g60cca15819-goog

