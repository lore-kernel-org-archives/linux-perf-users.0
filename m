Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B97313D530
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Sep 2024 19:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726167860; cv=none; b=KpGQ2vxV/912w2OKbkprUMyqVihkLv8V3AGz7R/2VUG+mEuJiHYk9EEQYm9+ogcbw3BLrZygF1XBmgbK+1QD6MnHYdHRm7qb0FCzEFE8Wxzoh6Jcp5rH76FAEFCKxDBFXhI6Az7HhNn7oE+j0KeG+aeTzVRV7gF4riP1+yyEgf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726167860; c=relaxed/simple;
	bh=U9APJT7hEYPoXs7SvHXmwg9xL41gB9+yHawfFh+sHN8=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=ScFYwYPNyD/jHyYkpSZIeWfCaYbUrl9s8h9Fz2a2G8hMdBsgxTviiGztYIOq3nEx/G4esCSbylavnBnvR0g8I3tuaDrLSERTulUKylJ5kNqN1SCoZtd+9JIOfQNxEHBU7Unko6SpQDh++g+8Deor818jHP6gFxJ0ycLHwqBUQCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RCh0iq35; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RCh0iq35"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6d5fccc3548so18877037b3.1
        for <linux-perf-users@vger.kernel.org>; Thu, 12 Sep 2024 12:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726167857; x=1726772657; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LYQxbI0xJENyVQY/2MELgzBJgym8JS4gaUWkXN/8Ipk=;
        b=RCh0iq35crz++nwd3eghIs7lneI5F9on2tfMxABKIV5cG/EGfKw8amjq/+Tnc3YOL4
         RYl2sCYcxWNlkYBNkK14rQcVFCmS3yfads1yV3e+7L8V6DsX+0HGecpL/YqnIcpbVU9z
         TbeU+0e/LBa5go3hNekqBtJbmWWPFUtzeODmB/ls/VBZ6hfI9IvBsvzKTXixW6NIVtwD
         koy0FGxNnSt4kR0cTGf/QH8TZZEHPRu7izhAUdXyBkBKz/I1DZTqHQPqoO3Cu41k/nCA
         G/S+FdfWjutrCIwXG6UVv8Jn222YWIqK7vWwaxJjvyJAJyz7fxz9zXDu8oIywNqsnyZH
         YARA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726167857; x=1726772657;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LYQxbI0xJENyVQY/2MELgzBJgym8JS4gaUWkXN/8Ipk=;
        b=HuCZuw86GquPa/EiKAmf9eEiNat7HwNjXMKc0pY/YR6+mHwMxuD/8FdJ7tFlX0QgpF
         X8mMjIwJ8INBgKezznRTpt6oyS3RUv5LiKsiQoSyav3BrporrbNkPM4KIl8yLK/m7Uk4
         +wlZudTwVAl/zK2BNK+oY6Sh5jrzJKP7hzFGTjsWwpfzbKYkivmCDZCJwItfuc1+ZrNp
         UXAWVJ2KY8b03mGdTCbRs3++7D2hwfXQMmIjArj7Szj5IyYpQwswWdIeBiYDWRvjoIYd
         +85pzcs+qEbUXxjmsaxbL4uGCBoOLUsd/A4rR5Quqr0i/wVsB+nzjh9A7zhDIka1o4Mp
         EIhg==
X-Forwarded-Encrypted: i=1; AJvYcCVs/DFdzipnnazFFDZ8wjCeq/ViNLwDTX+s2TD2fIzfpTrjDjaKTf8GbWQ6bmRp+PaHCkhzQuN6QGrGpWjUBUw8@vger.kernel.org
X-Gm-Message-State: AOJu0YzCJQCiwK3kpAyCS8RLtFuvbfAkHpkWJIc5W0CKViTJy3MqgNLI
	trDbtqFT0VtGF0XxakIPVydeTnySzrxg2eCjXIz8lgq/5CbyZM8C+EI0r+B7kbFaYonDrN2Te7a
	SO7UZ8Q==
X-Google-Smtp-Source: AGHT+IG1sYctGmQHdIfQPhhU1xsJ9+zS+RzH6z3SsYtTo2xMx1/nXFiacuve7Uj8WhMzevi8nSfBtI9dMf/c
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:cf0e:7a99:e672:3862])
 (user=irogers job=sendgmr) by 2002:a05:690c:4b81:b0:68e:8de6:617c with SMTP
 id 00721157ae682-6dbb717cbd7mr1685827b3.5.1726167857102; Thu, 12 Sep 2024
 12:04:17 -0700 (PDT)
Date: Thu, 12 Sep 2024 12:03:39 -0700
In-Reply-To: <20240912190341.919229-1-irogers@google.com>
Message-Id: <20240912190341.919229-13-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240912190341.919229-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.662.g92d0881bb0-goog
Subject: [PATCH v2 12/13] perf test: Add hwmon "PMU" test
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Weilin Wang <weilin.wang@intel.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Xu Yang <xu.yang_2@nxp.com>, 
	Sandipan Das <sandipan.das@amd.com>, Benjamin Gray <bgray@linux.ibm.com>, 
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>, Howard Chu <howardchu95@gmail.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Yang Jihong <yangjihong@bytedance.com>, 
	Colin Ian King <colin.i.king@gmail.com>, Veronika Molnarova <vmolnaro@redhat.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Changbin Du <changbin.du@huawei.com>, Ze Gao <zegao2021@gmail.com>, 
	Andi Kleen <ak@linux.intel.com>, 
	"=?UTF-8?q?Cl=C3=A9ment=20Le=20Goffic?=" <clement.legoffic@foss.st.com>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	Junhao He <hejunhao3@huawei.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Yicong Yang <yangyicong@hisilicon.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Based on a mix of the sysfs PMU test (for creating the reference
files) and the tool PMU test, test that parsing given hwmon events
with there aliases creates the expected config values.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/Build          |   1 +
 tools/perf/tests/builtin-test.c |   1 +
 tools/perf/tests/hwmon_pmu.c    | 243 ++++++++++++++++++++++++++++++++
 tools/perf/tests/tests.h        |   1 +
 tools/perf/util/pmus.c          |   7 +
 tools/perf/util/pmus.h          |   3 +
 6 files changed, 256 insertions(+)
 create mode 100644 tools/perf/tests/hwmon_pmu.c

diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
index a771e4928247..078d2580d46c 100644
--- a/tools/perf/tests/Build
+++ b/tools/perf/tests/Build
@@ -67,6 +67,7 @@ perf-test-y += sigtrap.o
 perf-test-y += event_groups.o
 perf-test-y += symbols.o
 perf-test-y += util.o
+perf-test-y += hwmon_pmu.o
 perf-test-y += tool_pmu.o
 
 ifeq ($(SRCARCH),$(filter $(SRCARCH),x86 arm arm64 powerpc))
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 3b30f258c395..81c0f12b8820 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -73,6 +73,7 @@ static struct test_suite *generic_tests[] = {
 	&suite__PERF_RECORD,
 	&suite__pmu,
 	&suite__pmu_events,
+	&suite__hwmon_pmu,
 	&suite__tool_pmu,
 	&suite__dso_data,
 	&suite__perf_evsel__roundtrip_name_test,
diff --git a/tools/perf/tests/hwmon_pmu.c b/tools/perf/tests/hwmon_pmu.c
new file mode 100644
index 000000000000..712d6ecbd8f9
--- /dev/null
+++ b/tools/perf/tests/hwmon_pmu.c
@@ -0,0 +1,243 @@
+// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+#include "debug.h"
+#include "evlist.h"
+#include "parse-events.h"
+#include "tests.h"
+#include "hwmon_pmu.h"
+#include <fcntl.h>
+#include <sys/stat.h>
+
+static const struct test_event {
+	const char *name;
+	const char *alias;
+	long config;
+} test_events[] = {
+	{
+		"temp_test_hwmon_event1",
+		"temp1",
+		0xA0001,
+	},
+	{
+		"temp_test_hwmon_event2",
+		"temp2",
+		0xA0002,
+	},
+};
+
+/* Cleanup test PMU directory. */
+static int test_pmu_put(const char *dir, struct perf_pmu *hwm)
+{
+	char buf[PATH_MAX + 20];
+	int ret;
+
+	if (scnprintf(buf, sizeof(buf), "rm -fr %s", dir) < 0) {
+		pr_err("Failure to set up buffer for \"%s\"\n", dir);
+		return -EINVAL;
+	}
+	ret = system(buf);
+	if (ret)
+		pr_err("Failure to \"%s\"\n", buf);
+
+	perf_pmu__delete(hwm);
+	return ret;
+}
+
+/*
+ * Prepare test PMU directory data, normally exported by kernel at
+ * /sys/class/hwmon/hwmon<number>/. Give as input a buffer to hold the file
+ * path, the result is PMU loaded using that directory.
+ */
+static struct perf_pmu *test_pmu_get(char *dir, size_t sz)
+{
+	const char *test_hwmon_name_nl = "A test hwmon PMU\n";
+	const char *test_hwmon_name = "A test hwmon PMU";
+	/* Simulated hwmon items. */
+	const struct test_item {
+		const char *name;
+		const char *value;
+	} test_items[] = {
+		{ "temp1_label", "test hwmon event1\n", },
+		{ "temp1_input", "40000\n", },
+		{ "temp2_label", "test hwmon event2\n", },
+		{ "temp2_input", "50000\n", },
+	};
+	int dirfd, file;
+	struct perf_pmu *hwm = NULL;
+	ssize_t len;
+
+	/* Create equivalent of sysfs mount point. */
+	scnprintf(dir, sz, "/tmp/perf-hwmon-pmu-test-XXXXXX");
+	if (!mkdtemp(dir)) {
+		pr_err("mkdtemp failed\n");
+		dir[0] = '\0';
+		return NULL;
+	}
+	dirfd = open(dir, O_DIRECTORY);
+	if (dirfd < 0) {
+		pr_err("Failed to open test directory \"%s\"\n", dir);
+		goto err_out;
+	}
+
+	/* Create the test hwmon directory and give it a name. */
+	if (mkdirat(dirfd, "hwmon1234", 0755) < 0) {
+		pr_err("Failed to mkdir hwmon directory\n");
+		goto err_out;
+	}
+	file = openat(dirfd, "hwmon1234/name", O_WRONLY | O_CREAT, 0600);
+	if (!file) {
+		pr_err("Failed to open for writing file \"name\"\n");
+		goto err_out;
+	}
+	len = strlen(test_hwmon_name_nl);
+	if (write(file, test_hwmon_name_nl, len) < len) {
+		close(file);
+		pr_err("Failed to write to 'name' file\n");
+		goto err_out;
+	}
+	close(file);
+
+	/* Create test hwmon files. */
+	for (size_t i = 0; i < ARRAY_SIZE(test_items); i++) {
+		const struct test_item *item = &test_items[i];
+
+		file = openat(dirfd, item->name, O_WRONLY | O_CREAT, 0600);
+		if (!file) {
+			pr_err("Failed to open for writing file \"%s\"\n", item->name);
+			goto err_out;
+		}
+
+		if (write(file, item->value, strlen(item->value)) < 0) {
+			pr_err("Failed to write to file \"%s\"\n", item->name);
+			close(file);
+			goto err_out;
+		}
+		close(file);
+	}
+
+	/* Make the PMU reading the files created above. */
+	hwm = perf_pmus__add_test_hwmon_pmu(dirfd, "hwmon1234", test_hwmon_name);
+	if (!hwm)
+		pr_err("Test hwmon creation failed\n");
+
+err_out:
+	if (!hwm) {
+		test_pmu_put(dir, hwm);
+		if (dirfd >= 0)
+			close(dirfd);
+	}
+	return hwm;
+}
+
+static int do_test(size_t i, bool with_pmu, bool with_alias)
+{
+	const char *test_event = with_alias ? test_events[i].alias : test_events[i].name;
+	struct evlist *evlist = evlist__new();
+	struct evsel *evsel;
+	struct parse_events_error err;
+	int ret;
+	char str[128];
+	bool found = false;
+
+	if (!evlist) {
+		pr_err("evlist allocation failed\n");
+		return TEST_FAIL;
+	}
+
+	if (with_pmu)
+		snprintf(str, sizeof(str), "/%s/", test_event);
+	else
+		strncpy(str, test_event, sizeof(str));
+
+	pr_debug("Testing '%s'\n", str);
+	parse_events_error__init(&err);
+	ret = parse_events(evlist, str, &err);
+	if (ret) {
+		evlist__delete(evlist);
+
+		pr_debug("FAILED %s:%d failed to parse event '%s', err %d\n",
+			 __FILE__, __LINE__, str, ret);
+		parse_events_error__print(&err, str);
+		ret = TEST_FAIL;
+		goto out;
+	}
+
+	ret = TEST_OK;
+	if (with_pmu ? (evlist->core.nr_entries != 1) : (evlist->core.nr_entries < 1)) {
+		pr_debug("FAILED %s:%d Unexpected number of events for '%s' of %d\n",
+			 __FILE__, __LINE__, str, evlist->core.nr_entries);
+		ret = TEST_FAIL;
+		goto out;
+	}
+
+	evlist__for_each_entry(evlist, evsel) {
+		if (!perf_pmu__is_hwmon(evsel->pmu))
+			continue;
+
+		if (evsel->core.attr.config != (u64)test_events[i].config) {
+			pr_debug("FAILED %s:%d Unexpected config for '%s', %lld != %ld\n",
+				__FILE__, __LINE__, str,
+				evsel->core.attr.config,
+				test_events[i].config);
+			ret = TEST_FAIL;
+			goto out;
+		}
+		found = true;
+	}
+
+	if (!found) {
+		pr_debug("FAILED %s:%d Didn't find hwmon event '%s' in parsed evsels\n",
+			 __FILE__, __LINE__, str);
+		ret = TEST_FAIL;
+	}
+
+out:
+	evlist__delete(evlist);
+	return ret;
+}
+
+static int test__hwmon_pmu(bool with_pmu)
+{
+	char dir[PATH_MAX];
+	struct perf_pmu *pmu = test_pmu_get(dir, sizeof(dir));
+	int ret = TEST_OK;
+
+	if (!pmu)
+		return TEST_FAIL;
+
+	for (size_t i = 0; i < ARRAY_SIZE(test_events); i++) {
+		ret = do_test(i, with_pmu, /*with_alias=*/false);
+
+		if (ret != TEST_OK)
+			break;
+
+		ret = do_test(i, with_pmu, /*with_alias=*/true);
+
+		if (ret != TEST_OK)
+			break;
+	}
+	test_pmu_put(dir, pmu);
+	return ret;
+}
+
+static int test__hwmon_pmu_without_pmu(struct test_suite *test __maybe_unused,
+				      int subtest __maybe_unused)
+{
+	return test__hwmon_pmu(/*with_pmu=*/false);
+}
+
+static int test__hwmon_pmu_with_pmu(struct test_suite *test __maybe_unused,
+				   int subtest __maybe_unused)
+{
+	return test__hwmon_pmu(/*with_pmu=*/false);
+}
+
+static struct test_case tests__hwmon_pmu[] = {
+	TEST_CASE("Parsing without PMU name", hwmon_pmu_without_pmu),
+	TEST_CASE("Parsing with PMU name", hwmon_pmu_with_pmu),
+	{	.name = NULL, }
+};
+
+struct test_suite suite__hwmon_pmu = {
+	.desc = "Hwmon PMU",
+	.test_cases = tests__hwmon_pmu,
+};
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index 1ed76d4156b6..260daa77eb06 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -83,6 +83,7 @@ DECLARE_SUITE(perf_evsel__tp_sched_test);
 DECLARE_SUITE(syscall_openat_tp_fields);
 DECLARE_SUITE(pmu);
 DECLARE_SUITE(pmu_events);
+DECLARE_SUITE(hwmon_pmu);
 DECLARE_SUITE(tool_pmu);
 DECLARE_SUITE(attr);
 DECLARE_SUITE(dso_data);
diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index 5c3e88adb9e6..451c6e00ad70 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -733,6 +733,13 @@ struct perf_pmu *perf_pmus__add_test_pmu(int test_sysfs_dirfd, const char *name)
 	return perf_pmu__lookup(&other_pmus, test_sysfs_dirfd, name, /*eager_load=*/true);
 }
 
+struct perf_pmu *perf_pmus__add_test_hwmon_pmu(int hwmon_dir,
+					       const char *sysfs_name,
+					       const char *name)
+{
+	return hwmon_pmu__new(&other_pmus, hwmon_dir, sysfs_name, name);
+}
+
 struct perf_pmu *perf_pmus__fake_pmu(void)
 {
 	static struct perf_pmu fake = {
diff --git a/tools/perf/util/pmus.h b/tools/perf/util/pmus.h
index e1742b56eec7..a0cb0eb2ff97 100644
--- a/tools/perf/util/pmus.h
+++ b/tools/perf/util/pmus.h
@@ -30,6 +30,9 @@ bool perf_pmus__supports_extended_type(void);
 char *perf_pmus__default_pmu_name(void);
 
 struct perf_pmu *perf_pmus__add_test_pmu(int test_sysfs_dirfd, const char *name);
+struct perf_pmu *perf_pmus__add_test_hwmon_pmu(int hwmon_dir,
+					       const char *sysfs_name,
+					       const char *name);
 struct perf_pmu *perf_pmus__fake_pmu(void);
 
 #endif /* __PMUS_H */
-- 
2.46.0.662.g92d0881bb0-goog

