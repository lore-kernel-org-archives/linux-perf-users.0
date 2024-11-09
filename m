Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EB76A019
	for <linux-perf-users@vger.kernel.org>; Sat,  9 Nov 2024 00:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731112457; cv=none; b=jCHK7auH0nj1vD2ToNahxtZPxEYbICrBpEa9cRwCR8nBSJSRHp4519Xt0JoZGX2osmM6Ek/NQPT+DaGusDnhOBBOtLw8v2bLgG2zSdActieBI7PHGsa0jLK/NdRnxwAlimw6ox27Rr/gNDIlytwjHmWixkDfAHMSQwTnBVQoERw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731112457; c=relaxed/simple;
	bh=AGv74AJZdeu7zWXnn9qpaFjvkwR5rG7fCt7CgLsbOyw=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=gv82fnrGBzPW3631QTtsx1S/+rfntEkhU5YoKQ6HdtTI2Nuwl/Vn/9GJHuHdEGLiYsAvwv3HST3vAHnywRRp4sbWWAnGoS6tzmMfrBAUFP3iKARABSRr/+IRf4zrWU/8ffoPGzhejEbOQ+Tmsby030gmJjgQjzGZoGobI410y0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Lthqh13k; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lthqh13k"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e3313b47a95so5484113276.3
        for <linux-perf-users@vger.kernel.org>; Fri, 08 Nov 2024 16:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731112455; x=1731717255; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xGtMOz6yOSk+lm+i7Vt4SUAHF0VdrlVxtCtmCN8/Bao=;
        b=Lthqh13kFggUHJl5gei+bGLCPn6i15jBp/uDKoTQdNYjXrzgS3DI/hm+KJxrerDKI8
         POZnbF6zEHAGIIOLJbZ8ZvkQPTMmFNb61CEjJyQ2CHM0C6iWPoVzJKb02dqHZ32EnQUD
         qe4iqJQ00rRE4CEOgfict5Rl6IkifysDJteYilXW3zAEhVDaE5m9FCd7oU06NqsQcMau
         5tV7HP11K/ln2PiEjbn2cZE+L5sXZjpG9+iOuzb4ZE0qPojOxoKTD9ZFL2JLJtkz4PEB
         PWV/4YLMRvzojHTdSYXk3dmbahXitDS5Sd/vFPhs5m+Cx8Q9rNEuK3ozvWSDnqGitZOy
         CdeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731112455; x=1731717255;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xGtMOz6yOSk+lm+i7Vt4SUAHF0VdrlVxtCtmCN8/Bao=;
        b=d9SJHG6LHMHMlGeJ9n9dxBtZyNNKGavk+Twp6YlettvBfkJj/C5Pd1D0FI11U/5STJ
         jh1Z0YxAhNXZ+gHBAyUAtkmbKXxop8+/HMAFdlJLi5fTiJVLnxOcSpmNiehOYPH2gj/p
         TsOlbqCnHs4NXGbdP37vxOs9LycmtPcYfxDV56S63PhCJoAjye9MfOfDB90owCVoGHHW
         tlrA8UhVndLG52pK2NwVR4cf1d9SAg7HhgJeqQ7eTqbg4s+HixxpfC1q145tw4HC3V3B
         +igwgdPFtiBRSfLCo0n8CvUYzQzvDotEqRQMlyZ/nRrxHRfdAr2zCaaFuLoALlhZjOsf
         QlyA==
X-Forwarded-Encrypted: i=1; AJvYcCWeC4NV582j62N48IFVlMnsTuxEkuw2wm4t8WSjKH4JXNQ9fTBJd6ctmGY6uTW5waX9Rc5pXwLgnQEorqIRQt7s@vger.kernel.org
X-Gm-Message-State: AOJu0YxNq1C0BSm9vqwu9dDTtjCD2Mr5EvzGNAEbJjcNiUW0xBXIthtv
	tvF+2nG0704e0dMO5yrSVtObp6q2WHIZLIYYYIuPrqqjEHE8t+RlV2AzJ8G6nIF1IKG+eQKJl6o
	o8z7XoQ==
X-Google-Smtp-Source: AGHT+IFgId3CJ0thNULc8VJ0pydC7o+YSJzwxnR9byUvy2JEXYKIQ3KhmfGvhui7YaD89EyDNOqcBRbcDoO/
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:6fd2:1e36:6d8c:7c49])
 (user=irogers job=sendgmr) by 2002:a25:15c2:0:b0:e28:f231:1aa8 with SMTP id
 3f1490d57ef6-e337f846765mr5659276.2.1731112454789; Fri, 08 Nov 2024 16:34:14
 -0800 (PST)
Date: Fri,  8 Nov 2024 16:33:57 -0800
In-Reply-To: <20241109003358.461437-1-irogers@google.com>
Message-Id: <20241109003358.461437-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241109003358.461437-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Subject: [PATCH v8 6/7] perf test: Add hwmon "PMU" test
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

Based on a mix of the sysfs PMU test (for creating the reference
files) and the tool PMU test, test that parsing given hwmon events
with there aliases creates the expected config values.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/hwmon_pmu.c | 230 +++++++++++++++++++++++++++++++++++
 tools/perf/util/pmus.c       |   7 ++
 tools/perf/util/pmus.h       |   3 +
 3 files changed, 240 insertions(+)

diff --git a/tools/perf/tests/hwmon_pmu.c b/tools/perf/tests/hwmon_pmu.c
index f5b58486d8d3..3a95cc63fc48 100644
--- a/tools/perf/tests/hwmon_pmu.c
+++ b/tools/perf/tests/hwmon_pmu.c
@@ -1,10 +1,238 @@
 // SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
 #include "debug.h"
+#include "evlist.h"
 #include "hwmon_pmu.h"
+#include "parse-events.h"
 #include "tests.h"
+#include <fcntl.h>
+#include <sys/stat.h>
 #include <linux/compiler.h>
 #include <linux/kernel.h>
 
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
+		strlcpy(str, test_event, sizeof(str));
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
 static int test__parse_hwmon_filename(struct test_suite *test __maybe_unused,
 				      int subtest __maybe_unused)
 {
@@ -101,6 +329,8 @@ static int test__parse_hwmon_filename(struct test_suite *test __maybe_unused,
 
 static struct test_case tests__hwmon_pmu[] = {
 	TEST_CASE("Basic parsing test", parse_hwmon_filename),
+	TEST_CASE("Parsing without PMU name", hwmon_pmu_without_pmu),
+	TEST_CASE("Parsing with PMU name", hwmon_pmu_with_pmu),
 	{	.name = NULL, }
 };
 
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
2.47.0.277.g8800431eea-goog

