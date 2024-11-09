Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E713C488
	for <linux-perf-users@vger.kernel.org>; Sat,  9 Nov 2024 00:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731112693; cv=none; b=hXdh72NQJseeH7+wkachjv1HebVwfgdH08amUu6zEhlw4OVsKu544WRCUCFiZYgboTgzGJfxdGiunNmSl09JEBgtDy9NfOv7UKwGTG9M/lCFExmv0rSZhCMjuVZ2gPMbWTgQ7/7JihdBjhDkMoYtJUwkxysygwCLzjAchxdiQbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731112693; c=relaxed/simple;
	bh=cJXlLHhPm/MxqQ001SlGf6LhXjO0VbFH7y7+7Dv6k6s=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Ej7bLeyDQPlGXZiWq29WjXvlWl+tvgSQDErPWfnrMggA1nzct1N7+V7JutyhTj8Q0v5ZFhTeD+LFidaLEH8MyxHn+YU2nyBqIxs9CnBmnN4F+r0JocunjcgybRVUwJR8DOlgTkabGPYxlfH94nwk2jspcrVQLfqDpb4RdLlr2xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cwPJNE5r; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cwPJNE5r"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e30c7a38bd7so2931949276.0
        for <linux-perf-users@vger.kernel.org>; Fri, 08 Nov 2024 16:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731112691; x=1731717491; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sMRp4SArakG3qttQ7Acj4+yjGFvVzfYJdi2BB3ubp6I=;
        b=cwPJNE5rrvT/SJNcQZbuoW9qxub4x5jU8VqRZYCsIG7Hx3y1lFwFsV0gLSrq5Tr5Nb
         DtmykYUROSvyV6exy7R7lbm2bybMBhBoObuo1kA7WUdOxjalMp3IBamKCu8wARRiNAEx
         d0AcfP5TpEtN0H/A5E6IjV9+Zpw1CiQ9ttnmlQ5O78BIF+/efNrGNOSWEvBtpCPNJ+rD
         BWLH8fj33+so4MgsirGvIeHgLa+l2KSytCCYYMhsOOg9l23kJxGl3Lga7G2uTXQ5lSia
         5GoYzL325Gs/pNWRiUoVkbnt9X4Joq24tSfI3HXvrds/8smclG1OytN3JZkcbBP1svLU
         iRNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731112691; x=1731717491;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sMRp4SArakG3qttQ7Acj4+yjGFvVzfYJdi2BB3ubp6I=;
        b=n+vcWN28lDYwUB1mpebTPoB7maUnrOq9mxaMRbFwHnY1mQXLntPwV2+Ka/ukbtOz7S
         wE0Q5t+QZz8+XfPoh0UUWxnpNX+4fYucYb8iLSGCb1zhNaFMyah/XuftK/5fCTAjCACF
         bT/SGKPWC2Xn9TWzf6lUzHWW+fRALEnNvrMYZBSDOv6NGJ3BiGYUCG+7OzZaTsruH3cq
         y6ESzAs8BbD7cLwhFTdhiAsnpAkgZ3Q3ogOYTkFyBBZMNlZ0U0hsbeQYK+gGGF+v+euY
         2yBjc3yWMZO+atI9qDvNRuGjVyZjd/zsoiiuK5qHchkw+3FHJJjG8KzrCCXK4u+U2F2w
         +6fQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYPcAPDJj8qOQtq6MaBp+OFJ3k3oUbdFrbZgaQJLcunrid/XlLNnpgnwWEjkz9le7CZTSS4GFEcNi/whL0vFFh@vger.kernel.org
X-Gm-Message-State: AOJu0YwMaqzzgZu8a2ItBdUSkPk/XdE9xdAivvJQ54wqfvB7xBmPf0QO
	3SeGr4o08BPiwGTtuyDoI7TvT6nytVUEyD6Z4B/j3vvAOrzIuzIS+o9ElGA+hMHVFZFLzR18Zpb
	G9aP7rQ==
X-Google-Smtp-Source: AGHT+IFH5L9yMlY50p0WH+meGB871eq2DYlEmJtgpnnORnt4x6dJ1AvKxHmGyMUHtEUvgDi6ZhweQRo4IMR5
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:6fd2:1e36:6d8c:7c49])
 (user=irogers job=sendgmr) by 2002:a25:abac:0:b0:e2b:db24:905e with SMTP id
 3f1490d57ef6-e338017a945mr20217276.5.1731112690863; Fri, 08 Nov 2024 16:38:10
 -0800 (PST)
Date: Fri,  8 Nov 2024 16:37:55 -0800
In-Reply-To: <20241109003759.473460-1-irogers@google.com>
Message-Id: <20241109003759.473460-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241109003759.473460-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Subject: [PATCH v9 3/7] perf test: Add hwmon filename parser test
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
 4 files changed, 113 insertions(+)
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
-- 
2.47.0.277.g8800431eea-goog

