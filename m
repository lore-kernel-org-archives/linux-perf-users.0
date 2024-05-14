Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956EE1869
	for <linux-perf-users@vger.kernel.org>; Tue, 14 May 2024 00:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715645671; cv=none; b=NwgHKRonGG7WtkH9nssg+Z+/jY9c2gzhnCdxWydpARTwzCkwA9bTYYiMQNZIizmW4hT/fcK60n0wz2GzCEisNcrI7jrgdkdcaXv36AJF4SRGOiIClMj46zqChtcd5cXK+9ZznWhwAEYaGemR34+YgMNf5/wZfSN3yk2WTnbEok8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715645671; c=relaxed/simple;
	bh=SBrw0mlZryE7xylBjlOJomhP4bSWNQippGud3TNQfaY=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=hKF1P+fF/oMsNpDKjb+sX8fLkCbwgZWGlAmXizFTryghZSnIDDBshzhU9A4JaLkCZyXfumF7VEBXyOph7MAvETgjuL6mOeNk9mV+cLhHvE1d1Zm1lFVKk9zoY2/E0b0ELMlNm84lcoyg+Dc/Pg2l0JJZkKxy5aTzTo/brUMEr2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E/vqW6+Y; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E/vqW6+Y"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61be4b79115so96995127b3.1
        for <linux-perf-users@vger.kernel.org>; Mon, 13 May 2024 17:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715645668; x=1716250468; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3ibaSSKUEQIFW2f5/BFmJXtUec1nP88z8Ady4qrNXWk=;
        b=E/vqW6+Y6wXW04rouZNH/c1WmrzFTYqAS6k+dcSGAXATeN6oQtfuwpJYRsQkJwsRQd
         UZ+cej8JOIUsAr7KAkYBTd+8aM0zHepVoCr2pFGOpCby/O+RZKH+4ltDr3F4U7YaaSxH
         FjpaxbXDRfjm/SMH+aMf4TneC2Px4SUm/6L7M094TBPmP/cLCKuiQLfYdwTKUixNrueO
         mnGIppPLODR4WQy+dpDYDrQC8i5A9o+hE31ux0Er1v+bA+uF0de7wm3OgveVCvF5vnhC
         d16iGfSUntv+tho0jhf4uOPgrlgnYlK0XwwvUX3vc9Iq/LpFp/mN8kEMMMDrlJFO+NGh
         n/2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715645668; x=1716250468;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3ibaSSKUEQIFW2f5/BFmJXtUec1nP88z8Ady4qrNXWk=;
        b=dVeJIKF6kDVa4DYT0nfqLBho8Ih4zDPQHvIXSSVGhk7D2NziFrkuGBOg+0CtvacX/e
         beZCSXi1zTo3zo1jSRO6iWeGdUokGLkfXg/JQiRNIXk0VfN82eLPedw4sJvuNun0CLKm
         L/PTTvmVS9+dHTJ42fLrNaae16xet/YK9Mh9rmY+7APLRafmwZqInkG0Fidum8JJAp7G
         t9iCDjYE+CZ+ud2LvW6aspF6qfW/dWZpTuCpT/uq+u6dy+voovQEShF4UW88vTTyt0i7
         ZerSZacUrtkH1Fp22ei32qUlu9bDaLUEGomsixuDB4o4ZIO+POlC3ag5fWIG1qvWJMsp
         reTw==
X-Forwarded-Encrypted: i=1; AJvYcCURJblpZ8YmLLOb8KP5R42V2eDwU4HpNOcuaW0Mq6P2WR3e3JpRfn6jnVwhfk8qsOuCQjebbgZNpvJ8LOaj2yO+o8aJO3PFSjJaj0TY1spZoQ==
X-Gm-Message-State: AOJu0Yw4XMcwJniWYManYnyNmWTpDUyb2F+izz6pC9UTVt/diNwrWMzn
	yi4kmdsPGt+VjWHXI56xwcMazF2d9sBJycaWBoggIuJ+CMwlUzL2qVGqHy3zTlfmdNhJac5+EfS
	8hv3qVg==
X-Google-Smtp-Source: AGHT+IH3OxoUo+M6qhF1juRni/XNnOvR42UKjKaIcDCoZrqMh6XR1mCeBSC9VHaOMJ45AQmEhw/9VoCXg95j
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6e66:3031:b400:2dc8])
 (user=irogers job=sendgmr) by 2002:a05:690c:6c87:b0:61b:e15c:2b84 with SMTP
 id 00721157ae682-622afff942fmr31967487b3.6.1715645668705; Mon, 13 May 2024
 17:14:28 -0700 (PDT)
Date: Mon, 13 May 2024 17:13:59 -0700
In-Reply-To: <20240514001359.2882951-1-irogers@google.com>
Message-Id: <20240514001359.2882951-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240514001359.2882951-1-irogers@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Subject: [PATCH v4 2/2] perf tests: Add some pmu core functionality tests
From: Ian Rogers <irogers@google.com>
To: Tuan Phan <tuanphan@os.amperecomputing.com>, Robin Murphy <robin.murphy@arm.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Bhaskara Budiredla <bbudiredla@marvell.com>, 
	Bharat Bhushan <bbhushan2@marvell.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@arm.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>, 
	Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"

Test behavior of PMU names and comparisons wrt suffixes using Intel
uncore_cha, marvell mrvl_ddr_pmu and S390's cpum_cf as examples.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/pmu.c | 99 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 99 insertions(+)

diff --git a/tools/perf/tests/pmu.c b/tools/perf/tests/pmu.c
index 06cc0e46cb28..cc88b5920c3e 100644
--- a/tools/perf/tests/pmu.c
+++ b/tools/perf/tests/pmu.c
@@ -3,6 +3,7 @@
 #include "evsel.h"
 #include "parse-events.h"
 #include "pmu.h"
+#include "pmus.h"
 #include "tests.h"
 #include "debug.h"
 #include "fncache.h"
@@ -340,10 +341,108 @@ static int test__pmu_event_names(struct test_suite *test __maybe_unused,
 	return ret;
 }
 
+static const char * const uncore_chas[] = {
+	"uncore_cha_0",
+	"uncore_cha_1",
+	"uncore_cha_2",
+	"uncore_cha_3",
+	"uncore_cha_4",
+	"uncore_cha_5",
+	"uncore_cha_6",
+	"uncore_cha_7",
+	"uncore_cha_8",
+	"uncore_cha_9",
+	"uncore_cha_10",
+	"uncore_cha_11",
+	"uncore_cha_12",
+	"uncore_cha_13",
+	"uncore_cha_14",
+	"uncore_cha_15",
+	"uncore_cha_16",
+	"uncore_cha_17",
+	"uncore_cha_18",
+	"uncore_cha_19",
+	"uncore_cha_20",
+	"uncore_cha_21",
+	"uncore_cha_22",
+	"uncore_cha_23",
+	"uncore_cha_24",
+	"uncore_cha_25",
+	"uncore_cha_26",
+	"uncore_cha_27",
+	"uncore_cha_28",
+	"uncore_cha_29",
+	"uncore_cha_30",
+	"uncore_cha_31",
+};
+
+static const char * const mrvl_ddrs[] = {
+	"mrvl_ddr_pmu_87e1b0000000",
+	"mrvl_ddr_pmu_87e1b1000000",
+	"mrvl_ddr_pmu_87e1b2000000",
+	"mrvl_ddr_pmu_87e1b3000000",
+	"mrvl_ddr_pmu_87e1b4000000",
+	"mrvl_ddr_pmu_87e1b5000000",
+	"mrvl_ddr_pmu_87e1b6000000",
+	"mrvl_ddr_pmu_87e1b7000000",
+	"mrvl_ddr_pmu_87e1b8000000",
+	"mrvl_ddr_pmu_87e1b9000000",
+	"mrvl_ddr_pmu_87e1ba000000",
+	"mrvl_ddr_pmu_87e1bb000000",
+	"mrvl_ddr_pmu_87e1bc000000",
+	"mrvl_ddr_pmu_87e1bd000000",
+	"mrvl_ddr_pmu_87e1be000000",
+	"mrvl_ddr_pmu_87e1bf000000",
+};
+
+static int test__name_len(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
+{
+	TEST_ASSERT_VAL("cpu", pmu_name_len_no_suffix("cpu") == strlen("cpu"));
+	TEST_ASSERT_VAL("i915", pmu_name_len_no_suffix("i915") == strlen("i915"));
+	TEST_ASSERT_VAL("cpum_cf", pmu_name_len_no_suffix("cpum_cf") == strlen("cpum_cf"));
+	for (size_t i = 0; i < ARRAY_SIZE(uncore_chas); i++) {
+		TEST_ASSERT_VAL("Strips uncore_cha suffix",
+				pmu_name_len_no_suffix(uncore_chas[i]) ==
+				strlen("uncore_cha"));
+	}
+	for (size_t i = 0; i < ARRAY_SIZE(mrvl_ddrs); i++) {
+		TEST_ASSERT_VAL("Strips mrvl_ddr_pmu suffix",
+				pmu_name_len_no_suffix(mrvl_ddrs[i]) ==
+				strlen("mrvl_ddr_pmu"));
+	}
+	return TEST_OK;
+}
+
+static int test__name_cmp(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
+{
+	TEST_ASSERT_EQUAL("cpu", pmu_name_cmp("cpu", "cpu"), 0);
+	TEST_ASSERT_EQUAL("i915", pmu_name_cmp("i915", "i915"), 0);
+	TEST_ASSERT_EQUAL("cpum_cf", pmu_name_cmp("cpum_cf", "cpum_cf"), 0);
+	TEST_ASSERT_VAL("i915", pmu_name_cmp("cpu", "i915") < 0);
+	TEST_ASSERT_VAL("i915", pmu_name_cmp("i915", "cpu") > 0);
+	TEST_ASSERT_VAL("cpum_cf", pmu_name_cmp("cpum_cf", "cpum_ce") > 0);
+	TEST_ASSERT_VAL("cpum_cf", pmu_name_cmp("cpum_cf", "cpum_d0") < 0);
+	for (size_t i = 1; i < ARRAY_SIZE(uncore_chas); i++) {
+		TEST_ASSERT_VAL("uncore_cha suffixes ordered lt",
+				pmu_name_cmp(uncore_chas[i-1], uncore_chas[i]) < 0);
+		TEST_ASSERT_VAL("uncore_cha suffixes ordered gt",
+				pmu_name_cmp(uncore_chas[i], uncore_chas[i-1]) > 0);
+	}
+	for (size_t i = 1; i < ARRAY_SIZE(mrvl_ddrs); i++) {
+		TEST_ASSERT_VAL("mrvl_ddr_pmu suffixes ordered lt",
+				pmu_name_cmp(mrvl_ddrs[i-1], mrvl_ddrs[i]) < 0);
+		TEST_ASSERT_VAL("mrvl_ddr_pmu suffixes ordered gt",
+				pmu_name_cmp(mrvl_ddrs[i], mrvl_ddrs[i-1]) > 0);
+	}
+	return TEST_OK;
+}
+
 static struct test_case tests__pmu[] = {
 	TEST_CASE("Parsing with PMU format directory", pmu_format),
 	TEST_CASE("Parsing with PMU event", pmu_events),
 	TEST_CASE("PMU event names", pmu_event_names),
+	TEST_CASE("PMU name combining", name_len),
+	TEST_CASE("PMU name comparison", name_cmp),
 	{	.name = NULL, }
 };
 
-- 
2.45.0.118.g7fe29c98d7-goog

