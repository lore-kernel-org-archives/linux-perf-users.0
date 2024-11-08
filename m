Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D2521D212
	for <linux-perf-users@vger.kernel.org>; Fri,  8 Nov 2024 17:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731088195; cv=none; b=nslvevh43uqFl7XJoK+lbM0IPDdXXZQQ9D3X/F0DzLPuNyJ2xzruotu6evy99Gh1W2HC9Ou4WAbaSfbmeRoUn6jJyV9Gp62q5P0oX0ARdGVFooh3YRcrSIwqmdA91ml+tfTaNWR2L13w15MVOa69rYE6M5JDi80FtFoOfeSV0Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731088195; c=relaxed/simple;
	bh=NKbShQvwHgvwfpa9vU/9CUtrorWgMpA+fuT3dsm8tiw=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=P78ilXlrGMti1x3S1FFTsNM45AOYuGPS7usND6kYs/7YeH0g/i38YR/+SU/SwJ/j0mpOZhqYUQnmNooKzxqFNjHZln5a/TycUtyFGPfZAswXCnMuUyWrj+ywhNFQ8Zga1KHeQIFUMTYfOxDyFUyhmys4IK9+OTs7Ovjd/CrWREk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=12U/qiqB; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="12U/qiqB"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6eaa08a6fdbso43313587b3.3
        for <linux-perf-users@vger.kernel.org>; Fri, 08 Nov 2024 09:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731088193; x=1731692993; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U29VnNAdGfcDQYAQsqPFX5iA64VqRhVFXyadfuAtcAQ=;
        b=12U/qiqBwuzrJ2tD8l9GJCi78C8dnKPojWzmwn+LEjZbRUd1aXE4xuegjHKJxXE+Pd
         vi+rU6KjR84i5Fdnx+c5H5meJuI7s3FEtcmvlWr+ts6R2LT7ImHmZPxNQYTFeFRyq6jX
         oDEE2xWAkzjq8s+SPmMNVqFnQiD7BH3ZvH2y/yPdbzxW1zW59+wnBoY86xt6rRsVvYeP
         mufDMxmwRyZy2R9GS7vchhEPZq9BRGtTcX23h+ar5wAq9ltWrKSagppEvoFWUeyfTeWm
         QxLFlaoELD9EjTmsnhAGc9eryp4VleXsEfRJCfWC8/sQgfdoX6NtA9M3AUdqFGxaUCRd
         Sd9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731088193; x=1731692993;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U29VnNAdGfcDQYAQsqPFX5iA64VqRhVFXyadfuAtcAQ=;
        b=SfceJ5ZRjZvLYMU5/wIZ6S22RcL9RKMRXNUosz3GEZebO07HuJge0/idBkJGdF5CV3
         iw0ryvYI7sSG8v2OS4IZgG3WCxy6YI/Ctbx5JYHd+6MR6iD7ZagboAZQ4zoIG6yeRV93
         oATGf2WTCRVLeo5Hnsy92JOcuCYTStQ+ftG8ZkFqTa4k0/L7T4QwFhXfzmvDRJfzhrN9
         tGzPYczeswD1ZWTZ7RoIMOJ6+8czKJeuCYF63y46RC+F97iuFg4+doaLP99M7OcZzaPA
         Uzuly/4fnaaGGW8IJd6g2TZJ85GeA/cEFWda1JNOspc8/QovVXT3vitG7P3wdNoq9BeU
         +tag==
X-Forwarded-Encrypted: i=1; AJvYcCU2ZXOI64M+px1l+CHOLbGiAs4APVdFWc3s08Wrbtmd2Xta62bQ/qgYh2jnXM1hWjSHwTUQbvGQgbNPTskJj2KI@vger.kernel.org
X-Gm-Message-State: AOJu0YzLc2xdEWOTqYJL9e3TphUarmF8R0gbX2kI1Ms1RCQG0NlSlCw/
	Zxy0nqC84PSEmqmwP6u/zmHGAghvDuDQ62pGNxpFDyFl+5sFH53jnXQ8WNVj1+KsPKlWwvaHPvY
	f1pRHZw==
X-Google-Smtp-Source: AGHT+IEfV+T366mI7dWlMLWxQa/MdgOP3+nlG9w8nkhQHhM9EQOoTVfZRzQEA2XOw0C0dD2GGRP4uqSSUgJQ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:6fd2:1e36:6d8c:7c49])
 (user=irogers job=sendgmr) by 2002:a05:690c:4a13:b0:6e3:b93:3ae2 with SMTP id
 00721157ae682-6eaddd704d6mr196847b3.1.1731088193078; Fri, 08 Nov 2024
 09:49:53 -0800 (PST)
Date: Fri,  8 Nov 2024 09:49:32 -0800
In-Reply-To: <20241108174936.262704-1-irogers@google.com>
Message-Id: <20241108174936.262704-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241108174936.262704-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Subject: [PATCH v7 3/7] perf test: Add hwmon filename parser test
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Weilin Wang <weilin.wang@intel.com>, Yoshihiro Furudera <fj5100bi@fujitsu.com>, 
	James Clark <james.clark@linaro.org>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Howard Chu <howardchu95@gmail.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Changbin Du <changbin.du@huawei.com>, Ze Gao <zegao2021@gmail.com>, 
	Junhao He <hejunhao3@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Filename parsing maps a hwmon filename to constituent parts enum/int
parts for the hwmon config value. Add a test case for the parsing.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/Build          |   1 +
 tools/perf/tests/builtin-test.c |   1 +
 tools/perf/tests/hwmon_pmu.c    | 110 ++++++++++++++++++++++++++++++++
 tools/perf/tests/tests.h        |   1 +
 tools/perf/util/hwmon_pmu.c     |   2 +-
 5 files changed, 114 insertions(+), 1 deletion(-)
 create mode 100644 tools/perf/tests/hwmon_pmu.c

diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
index 01ed9335db4d..ec4e1f034742 100644
--- a/tools/perf/tests/Build
+++ b/tools/perf/tests/Build
@@ -66,6 +66,7 @@ perf-test-y += sigtrap.o
 perf-test-y += event_groups.o
 perf-test-y += symbols.o
 perf-test-y += util.o
+perf-test-y += hwmon_pmu.o
 perf-test-y += tool_pmu.o
 
 ifeq ($(SRCARCH),$(filter $(SRCARCH),x86 arm arm64 powerpc))
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index d2cabaa8ad92..8dcf74d3c0a3 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -71,6 +71,7 @@ static struct test_suite *generic_tests[] = {
 	&suite__PERF_RECORD,
 	&suite__pmu,
 	&suite__pmu_events,
+	&suite__hwmon_pmu,
 	&suite__tool_pmu,
 	&suite__dso_data,
 	&suite__perf_evsel__roundtrip_name_test,
diff --git a/tools/perf/tests/hwmon_pmu.c b/tools/perf/tests/hwmon_pmu.c
new file mode 100644
index 000000000000..f5b58486d8d3
--- /dev/null
+++ b/tools/perf/tests/hwmon_pmu.c
@@ -0,0 +1,110 @@
+// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+#include "debug.h"
+#include "hwmon_pmu.h"
+#include "tests.h"
+#include <linux/compiler.h>
+#include <linux/kernel.h>
+
+static int test__parse_hwmon_filename(struct test_suite *test __maybe_unused,
+				      int subtest __maybe_unused)
+{
+	const struct hwmon_parse_test {
+		const char *filename;
+		enum hwmon_type type;
+		int number;
+		enum hwmon_item item;
+		bool alarm;
+		bool parse_ok;
+	} tests[] = {
+		{
+			.filename = "cpu0_accuracy",
+			.type = HWMON_TYPE_CPU,
+			.number = 0,
+			.item = HWMON_ITEM_ACCURACY,
+			.alarm = false,
+			.parse_ok = true,
+		},
+		{
+			.filename = "temp1_input",
+			.type = HWMON_TYPE_TEMP,
+			.number = 1,
+			.item = HWMON_ITEM_INPUT,
+			.alarm = false,
+			.parse_ok = true,
+		},
+		{
+			.filename = "fan2_vid",
+			.type = HWMON_TYPE_FAN,
+			.number = 2,
+			.item = HWMON_ITEM_VID,
+			.alarm = false,
+			.parse_ok = true,
+		},
+		{
+			.filename = "power3_crit_alarm",
+			.type = HWMON_TYPE_POWER,
+			.number = 3,
+			.item = HWMON_ITEM_CRIT,
+			.alarm = true,
+			.parse_ok = true,
+		},
+		{
+			.filename = "intrusion4_average_interval_min_alarm",
+			.type = HWMON_TYPE_INTRUSION,
+			.number = 4,
+			.item = HWMON_ITEM_AVERAGE_INTERVAL_MIN,
+			.alarm = true,
+			.parse_ok = true,
+		},
+		{
+			.filename = "badtype5_baditem",
+			.type = HWMON_TYPE_NONE,
+			.number = 5,
+			.item = HWMON_ITEM_NONE,
+			.alarm = false,
+			.parse_ok = false,
+		},
+		{
+			.filename = "humidity6_baditem",
+			.type = HWMON_TYPE_NONE,
+			.number = 6,
+			.item = HWMON_ITEM_NONE,
+			.alarm = false,
+			.parse_ok = false,
+		},
+	};
+
+	for (size_t i = 0; i < ARRAY_SIZE(tests); i++) {
+		enum hwmon_type type;
+		int number;
+		enum hwmon_item item;
+		bool alarm;
+
+		TEST_ASSERT_EQUAL("parse_hwmon_filename",
+				parse_hwmon_filename(
+					tests[i].filename,
+					&type,
+					&number,
+					&item,
+					&alarm),
+				tests[i].parse_ok
+			);
+		if (tests[i].parse_ok) {
+			TEST_ASSERT_EQUAL("parse_hwmon_filename type", type, tests[i].type);
+			TEST_ASSERT_EQUAL("parse_hwmon_filename number", number, tests[i].number);
+			TEST_ASSERT_EQUAL("parse_hwmon_filename item", item, tests[i].item);
+			TEST_ASSERT_EQUAL("parse_hwmon_filename alarm", alarm, tests[i].alarm);
+		}
+	}
+	return TEST_OK;
+}
+
+static struct test_case tests__hwmon_pmu[] = {
+	TEST_CASE("Basic parsing test", parse_hwmon_filename),
+	{	.name = NULL, }
+};
+
+struct test_suite suite__hwmon_pmu = {
+	.desc = "Hwmon PMU",
+	.test_cases = tests__hwmon_pmu,
+};
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index af284dd47e5c..cb58b43aa063 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -92,6 +92,7 @@ DECLARE_SUITE(perf_evsel__tp_sched_test);
 DECLARE_SUITE(syscall_openat_tp_fields);
 DECLARE_SUITE(pmu);
 DECLARE_SUITE(pmu_events);
+DECLARE_SUITE(hwmon_pmu);
 DECLARE_SUITE(tool_pmu);
 DECLARE_SUITE(attr);
 DECLARE_SUITE(dso_data);
diff --git a/tools/perf/util/hwmon_pmu.c b/tools/perf/util/hwmon_pmu.c
index ee5fb1c41da3..f4b7b3b6a052 100644
--- a/tools/perf/util/hwmon_pmu.c
+++ b/tools/perf/util/hwmon_pmu.c
@@ -126,7 +126,7 @@ bool parse_hwmon_filename(const char *filename,
 	fn_item_len = strlen(fn_item);
 	if (fn_item_len > 6 && !strcmp(&fn_item[fn_item_len - 6], "_alarm")) {
 		assert(strlen(LONGEST_HWMON_ITEM_STR) < sizeof(fn_type));
-		strlcpy(fn_type, fn_item, fn_item_len - 6);
+		strlcpy(fn_type, fn_item, fn_item_len - 5);
 		fn_item = fn_type;
 		*alarm = true;
 	}
-- 
2.47.0.277.g8800431eea-goog

