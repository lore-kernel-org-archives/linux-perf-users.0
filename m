Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4738E2BEC53
	for <linux-perf-users@vger.kernel.org>; Sun,  5 Oct 2025 18:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759688732; cv=none; b=DlAsuSAtuzI1wzsMmw90dySUs4cEw7D23KDd0rkwmftz0C8LFS7repDK96lioaROcMys7/CpPY6urM48tTbvS0y+VjnequXHoz1i47++ytoJtMDLRfOkS7+1Cx2r94PUQd6qDrB9pKjEXa9VvXrEXaO0MrXFZvhILPISi1Y3gfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759688732; c=relaxed/simple;
	bh=7NfXoXjCmippNcPV17LsBuq2kpdjq25juLwJVddyl4E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WrIYlERubbqmgIX2YnW439A2G86LMXznsCRpE4KCwAmbtC+plkNyEhFkTHz9+IZqvp+z/hQM/ZqjcSTZglhayWigbnn35yOyChzQ2DhOXl6a0kUtkAoa5nyDVWUonpN4KyumShbzlpn2AdrXbEXJBMrVoBQkL5FmL4Hd4v+r2ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tmqoF0Xn; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tmqoF0Xn"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-28c58e009d1so68603815ad.3
        for <linux-perf-users@vger.kernel.org>; Sun, 05 Oct 2025 11:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759688730; x=1760293530; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eslNOVp40osNcdUjiaj9HXK8o7Gak8RPSpTueusR0jI=;
        b=tmqoF0XnnlbR+PxSj7PS7uY+DngUwPyPeTxr7KQF8eFubbf0fwdWwHuTPhc5BpPgni
         inMCqiKOmE2/Pmngpwb+nyM5E7IIcATEQVRXPPiGDN2V089JE1byKeM0LRoF1v63VcHb
         sL4H9M0VjB2n1BcyxTfmebAuc3esUnac56vYYq4aDJvtSR1NrsD01utx3qdVWQ/N5MBL
         4QM3IbIsBoK6Rouo+7uw0GBSOJRKAPi6X0MFxWpVw9PshOLJXtdcUaueTY+mHZ0uYKgm
         qKDqOFc6e3UIc2TTbPgkbl82hoTNJ423a5CUgUYmZpN/HzsuAh7I6636btp8T4GzqhfN
         4CUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759688730; x=1760293530;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eslNOVp40osNcdUjiaj9HXK8o7Gak8RPSpTueusR0jI=;
        b=fHRmMsuCp+mn85uuf9/hOs7XfSj4sDqa8If0uQpdpAYwAPpzesE+bNDPbi1kRd3SEg
         mts21/RmNkMW+38rI1n6qxrYCdDELHe7PhlPRnfaFpUGCjfEGS816FvtoVMuCFzg5n2h
         Zzji21DDrGNURWBLconZGvtW+uGpAoGX561FNFZq9a/VhxstPG9Tuk+vFCMbBu/mPn5S
         40qTQeHGu8GCiu8XLNZ6Y8hum5rLMDEeM1TsB34gBepoZDm1kg6uT6y/dvhRzjy+r5m8
         LfsTQShInK+Yy8WV0ntJQFY8oNKm216S5s4KfGdsUqkDxh/xTYMPPqFLglkdNYpuk6MY
         /tfQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0/vJzUNh6lQk34cwJ7rjU3uzUHX+LLho6PY4zTJqGPfpcKu/Lm1MBvdHB2w5LYNoNXpZEf2mYr9Fttmw7lLF7@vger.kernel.org
X-Gm-Message-State: AOJu0YwYa2KhECl+IHgL28e2hcarBhaLFYW//RyP3Do2UF7VPDAWcIJJ
	H7uawagKtEIaSILoTh6VkMe+VkTfAJlLuzltrBrCS5DJ7mtU1AORCFotjpaLo0gGQgJSuhWxsvE
	CDXSPR0xzKg==
X-Google-Smtp-Source: AGHT+IHiE+aTEy1l6BRt3qiCFrB5gxX3VeXUaGVK3goFmEPGbBhBVjDZfjHzbdAHxJrqXh2MSSt4KANfteu2
X-Received: from plblq3.prod.google.com ([2002:a17:903:1443:b0:28e:82ea:1815])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3c70:b0:265:47:a7bd
 with SMTP id d9443c01a7336-28e9a565600mr102685075ad.4.1759688729574; Sun, 05
 Oct 2025 11:25:29 -0700 (PDT)
Date: Sun,  5 Oct 2025 11:24:28 -0700
In-Reply-To: <20251005182430.2791371-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251005182430.2791371-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251005182430.2791371-26-irogers@google.com>
Subject: [PATCH v7 25/27] perf test: Clean up test_..config helpers
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

Just have a single test_hw_config helper that strips extended type
information in the case of hardware and hardware cache events.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/parse-events.c | 23 ++++-------------------
 1 file changed, 4 insertions(+), 19 deletions(-)

diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 5dd2f03e952d..b6ba0e632454 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -41,22 +41,7 @@ static int num_core_entries(struct evlist *evlist)
 	return 1;
 }
 
-static bool test_config(const struct evsel *evsel, __u64 expected_config)
-{
-	__u32 type = evsel->core.attr.type;
-	__u64 config = evsel->core.attr.config;
-
-	if (type == PERF_TYPE_HARDWARE || type == PERF_TYPE_HW_CACHE) {
-		/*
-		 * HARDWARE and HW_CACHE events encode the PMU's extended type
-		 * in the top 32-bits. Mask in order to ignore.
-		 */
-		config &= PERF_HW_EVENT_MASK;
-	}
-	return config == expected_config;
-}
-
-static bool test_perf_config(const struct perf_evsel *evsel, __u64 expected_config)
+static bool test_hw_config(const struct perf_evsel *evsel, __u64 expected_config)
 {
 	return (evsel->attr.config & PERF_HW_EVENT_MASK) == expected_config;
 }
@@ -129,7 +114,7 @@ static int test__checkevent_raw(struct evlist *evlist)
 		struct perf_pmu *pmu __maybe_unused = NULL;
 		bool type_matched = false;
 
-		TEST_ASSERT_VAL("wrong config", test_perf_config(evsel, 0x1a));
+		TEST_ASSERT_VAL("wrong config", test_hw_config(evsel, 0x1a));
 		TEST_ASSERT_VAL("event not parsed as raw type",
 				evsel->attr.type == PERF_TYPE_RAW);
 #if defined(__aarch64__)
@@ -215,7 +200,7 @@ static int test__checkevent_genhw(struct evlist *evlist)
 
 	perf_evlist__for_each_entry(&evlist->core, evsel) {
 		TEST_ASSERT_VAL("wrong type", PERF_TYPE_HW_CACHE == evsel->attr.type);
-		TEST_ASSERT_VAL("wrong config", test_perf_config(evsel, 1 << 16));
+		TEST_ASSERT_VAL("wrong config", test_hw_config(evsel, 1 << 16));
 	}
 	return TEST_OK;
 }
@@ -596,7 +581,7 @@ static int test__checkevent_pmu(struct evlist *evlist)
 
 	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", core_pmu->type == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config",    test_config(evsel, 10));
+	TEST_ASSERT_VAL("wrong config",    test_hw_config(&evsel->core, 10));
 	TEST_ASSERT_VAL("wrong config1",    1 == evsel->core.attr.config1);
 	TEST_ASSERT_VAL("wrong config2",    3 == evsel->core.attr.config2);
 	TEST_ASSERT_VAL("wrong config3",    0 == evsel->core.attr.config3);
-- 
2.51.0.618.g983fd99d29-goog

