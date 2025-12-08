Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAA53176EF
	for <linux-perf-users@vger.kernel.org>; Mon,  8 Dec 2025 14:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765203811; cv=none; b=ps6fJOJJDTxM+hoWOXkxkCTV5yPa6k+j0Rf1A+pbFTYo7ojRfcv66Pw7IBrfUVECS79+EsD4MZ4FzBk7flmT6epP4NObi8oZhtebjDFQS0VVB3Kn90xEnyT5zWcc8gQJXt5TITOC95ZzLrGHYKO1lgWQ8GTd6xi75rpG7PUsSjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765203811; c=relaxed/simple;
	bh=AbvdrNMw88FZN4IE7Nf9KGk3nUuhKsauA7lRPU7zeEw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eHKe7/GNKqWv2wIpp05KV+zH/XjBIxNT9VJimYiNByS+twtIfJ7YKTU9wG0Sr/NAgtYy4TaWeDrtGsFFO+YF2LXwEVQO9sKDA3+V0TmwmJ3WYWDxZJsbg97GEOF/6XACVDawgFXts5gVUuxx8iUZkfdU/4qyacoHzCJqoP0Fek0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lqTsn5Ed; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lqTsn5Ed"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47775fb6cb4so37918745e9.0
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Dec 2025 06:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765203807; x=1765808607; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5kd2R0ME/G1mScEH97Zt/42ug6RvhAVhA6QI6GEroJM=;
        b=lqTsn5EdJ2nAkG04p5K9UJSV6+AYGnc1nXJosP0q52k+f2zATDkcsOk1VDn7WMOf6z
         F7M5Be5UxiWyyzqFL27hacusEfMAvN2ueKwZ88Ddo2BAUzJVmTGaeJHY4RbW9EDwXq6N
         saU+xldUkRLsJoN2BgX102djU+reVItA8cKjw5DeuglNWs/xywiTZYuBXlGOv13kifP9
         fsy0tsXDmp0EG/ACYtk5pqioqXhizp502HKLpP9RrXd8uTHAmjnk0i5Zh+eYZ53pxeE6
         d6Hb+2gEfcL/V3SU6pRlMWld3FSqFhxWxZPcdsbvJtLjbK65wNGh9rBS8/jQoucPZd9i
         kjmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765203807; x=1765808607;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5kd2R0ME/G1mScEH97Zt/42ug6RvhAVhA6QI6GEroJM=;
        b=xHgUP5sfXxOAa8Vxbp+9m/sgPnPBN4843CW3eyZa9OnBXVa8aMKyDZVBUgaHcLUEO3
         IvXsmSdltlmngxG7kAiCBTcfVGtpoWd5ryWnjAMkJY7Y4TNTEaYfgVArGlpIoMa4BxK2
         XKa7DHjuHORDQcJK2OR4xuPeHpY1kk/tKBabkLTA8rB8eR41n3azXWPS6jxt84iGi3G0
         pwFUk/LaBt1Pv/jxcU5nww9PWdGCoEwQaAkXpcf1b9YTfX3H8VRsOCJNgmcPIA1uub68
         UyHJ97EJBbXqSpudiR3rLPVumuBDEKO8OCVv0igf8v++Tve3h04lxxUUF8IRNx0+NknT
         rsLg==
X-Gm-Message-State: AOJu0Yx/Ox6sYTdjyQcFkCz91159ckZeJlrjrTKLBlTj5IJdH6ALdPSE
	5EfCgWSuOQoQcASuQ1Rc4+YyO5a/X3Fug5erRKvPwwZIPhY64gaK6FgMUehmZlXf73I=
X-Gm-Gg: ASbGncvNXR6UGbru2SmDGEaZC9bBYSdEbq/CFXohEYSA02MORoBKbVFjHhNh0x3p0x0
	eDAQWC3RsEuf4AYS5rcdCyg1EQ8Id8zjqV7iZIx6f6JTCk3bAWDvau7DTeEWbcQs6EKZi+7HgE1
	l5C591dFwG/3DgVNB8hfuxB1a4PdBF1oaWsf3ZMXpA0wW256wEiDoax1z0TDk8gdsQZQiKR1cG6
	tzm9mZgE51o31LACbv5PdcsqKFFXiCpnH9n6hSt2oi67qtuvb8/PGwzT6ckGSEht2CCd7Eask+r
	JdQUPhZ85FioGrZ2QuITb8+9zwAFspqGI961MTfv6miuMAxqVJ/SQxJx6KoqD+Fr5Dt+R12A7UD
	PvL+Trcnqsqipuiw6KkcztIsi3RJUOiSeMIGVlzwXtO7rFzN7+9xYQ9MnQFEZYT6F9TZ5/ytWba
	aN94MMFmWNJknRvvF9RxIs
X-Google-Smtp-Source: AGHT+IEhbbXGKkuGD/fbdNeyATAFNtzV6xXJwj6vpDm344XgOyf9yieISnwZUUrfZfDQkKbisoBK8g==
X-Received: by 2002:a05:600c:6748:b0:471:9da:5232 with SMTP id 5b1f17b1804b1-47939dfdc35mr82272095e9.15.1765203806602;
        Mon, 08 Dec 2025 06:23:26 -0800 (PST)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47930920e0dsm248561065e9.2.2025.12.08.06.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 06:23:26 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Mon, 08 Dec 2025 14:22:10 +0000
Subject: [PATCH v2 07/12] perf tests: Test evsel__set_config_if_unset() and
 config change tracking
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251208-james-perf-config-bits-v2-7-4ac0281993b0@linaro.org>
References: <20251208-james-perf-config-bits-v2-0-4ac0281993b0@linaro.org>
In-Reply-To: <20251208-james-perf-config-bits-v2-0-4ac0281993b0@linaro.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@linaro.org>, John Garry <john.g.garry@oracle.com>, 
 Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>, leo.yan@arm.com
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

Test that evsel__set_config_if_unset() behaves as expected. This also
tests the user config change tracking mechanism as it depends on it.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/tests/pmu.c | 90 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/tools/perf/tests/pmu.c b/tools/perf/tests/pmu.c
index cbded2c6faa4..f938135e62aa 100644
--- a/tools/perf/tests/pmu.c
+++ b/tools/perf/tests/pmu.c
@@ -192,9 +192,98 @@ static int test__pmu_format(struct test_suite *test __maybe_unused, int subtest
 	}
 	if (attr.config2 != 0x0400000020041d07) {
 		pr_err("Unexpected config2 value %llx\n", attr.config2);
+	}
+
+	ret = TEST_OK;
+err_out:
+	parse_events_terms__exit(&terms);
+	test_pmu_put(dir, pmu);
+	return ret;
+}
+
+static int test__pmu_usr_chgs(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
+{
+	const char *event = "perf-pmu-test/config=15,config1=4,krava02=170,"
+			    "krava03=1,krava11=27,krava12=1/";
+	struct parse_events_terms terms;
+	struct parse_events_error err;
+	LIST_HEAD(config_terms);
+	struct evlist *evlist;
+	struct perf_pmu *pmu;
+	struct evsel *evsel;
+	int ret = TEST_FAIL;
+	char dir[PATH_MAX];
+	u64 val;
+
+	pmu = test_pmu_get(dir, sizeof(dir));
+	if (!pmu)
+		return TEST_FAIL;
+
+	evlist = evlist__new();
+	if (evlist == NULL) {
+		pr_err("Failed allocation");
 		goto err_out;
 	}
 
+	parse_events_terms__init(&terms);
+	ret = parse_events(evlist, event, &err);
+	if (ret) {
+		pr_debug("failed to parse event '%s', err %d\n", event, ret);
+		parse_events_error__print(&err, event);
+		if (parse_events_error__contains(&err, "can't access trace events"))
+			ret = TEST_SKIP;
+		goto err_out;
+	}
+	evsel = evlist__first(evlist);
+
+	/*
+	 * Set via config=15, krava01 bits 0-1
+	 * Set via config1=4, krava11 bit 1
+	 * Set values: krava02=170, krava03=1, krava11=27, krava12=1
+	 *
+	 * Test that already set values aren't overwritten.
+	 */
+	evsel__set_config_if_unset(pmu, evsel, "krava01", 16);
+	evsel__get_config_val(pmu, evsel, "krava01", &val);
+	TEST_ASSERT_EQUAL("krava01 overwritten", (int) val, (15 & 0b11));
+
+	evsel__set_config_if_unset(pmu, evsel, "krava11", 45);
+	evsel__get_config_val(pmu, evsel, "krava11", &val);
+	TEST_ASSERT_EQUAL("krava11 overwritten", (int) val, (27 | (4 << 1)));
+
+	evsel__set_config_if_unset(pmu, evsel, "krava02", 32);
+	evsel__get_config_val(pmu, evsel, "krava02", &val);
+	TEST_ASSERT_EQUAL("krava02 overwritten", (int) val, 170);
+
+	evsel__set_config_if_unset(pmu, evsel, "krava03", 0);
+	evsel__get_config_val(pmu, evsel, "krava03", &val);
+	TEST_ASSERT_EQUAL("krava03 overwritten", (int) val, 1);
+
+	/*
+	 * krava13 doesn't have any bits set by either krava13= or config1=
+	 * but setting _any_ raw value for config1 implies that krava13
+	 * shouldn't be overwritten. So it's value should remain as 0.
+	 */
+	evsel__set_config_if_unset(pmu, evsel, "krava13", 5);
+	evsel__get_config_val(pmu, evsel, "krava13", &val);
+	TEST_ASSERT_EQUAL("krava13 overwritten", (int) val, 0);
+
+	/*
+	 * Unset values: krava21, krava22, krava23
+	 *
+	 * Test that unset values are overwritten.
+	 */
+	evsel__set_config_if_unset(pmu, evsel, "krava21", 13905);
+	evsel__get_config_val(pmu, evsel, "krava21", &val);
+	TEST_ASSERT_EQUAL("krava21 not overwritten", (int) val, 13905);
+
+	evsel__set_config_if_unset(pmu, evsel, "krava22", 11);
+	evsel__get_config_val(pmu, evsel, "krava22", &val);
+	TEST_ASSERT_EQUAL("krava22 not overwritten", (int) val, 11);
+
+	evsel__set_config_if_unset(pmu, evsel, "krava23", 0);
+	evsel__get_config_val(pmu, evsel, "krava23", &val);
+	TEST_ASSERT_EQUAL("krava23 not overwritten", (int) val, 0);
 	ret = TEST_OK;
 err_out:
 	parse_events_terms__exit(&terms);
@@ -539,6 +628,7 @@ static struct test_case tests__pmu[] = {
 	TEST_CASE("PMU name combining", name_len),
 	TEST_CASE("PMU name comparison", name_cmp),
 	TEST_CASE("PMU cmdline match", pmu_match),
+	TEST_CASE("PMU user config changes", pmu_usr_chgs),
 	{	.name = NULL, }
 };
 

-- 
2.34.1

