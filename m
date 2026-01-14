Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00B63A1A20
	for <linux-perf-users@vger.kernel.org>; Wed, 14 Jan 2026 15:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768406278; cv=none; b=Pr7HZ92Pl/aYIjzhoIX6Hlhyw0HvEb0QpnOnPQrJ7OBvSKPVPX1jJA7hlq5sm0NyDdX8X+9bIeMKA+X/x2AxeBm2KcO7skytm5g/tHaEH2wza3+BRwLwNoCmuEPE7+I5tMfLHsLmwl8zfjPeT2IhyHhoy503Aw5yxHdqWH9oD5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768406278; c=relaxed/simple;
	bh=LQArxmrJrNZZsUxSMnAWJcE4cLQNPPNILpLMGRQk8pU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y9kiK699sBTaxm4X2PJKIEckAcRoFkuYT6PbXK8ZEJwkTf0ZM0pXbE46ffL2JthjRSdn3DX9RXPaJ7BW26ajeL6WoRKYEfyy71j0Ga9Fd2IOieEwasDAi/gNn2sQ0Xbyztp1twmtcadFZfZKYi5ToNMa1ptbKxUP5t7wB67XuCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dpERR7tN; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dpERR7tN"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47a95efd2ceso74762355e9.2
        for <linux-perf-users@vger.kernel.org>; Wed, 14 Jan 2026 07:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768406269; x=1769011069; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i4eLrNTmJYNZqrOFXMkgnCrs/v9XFpKSoUUWAD+1qM0=;
        b=dpERR7tNUvQN706R+dIH7SGWutvDSRQwq/DEUiz/xqgZT2T9w9TTAQtBTujPX0Yu3O
         5vrHi8j8KNTW13sYiL/rF/Af2F0gsApV+svCHXn21nmUX2+cYVPG7W8guEZuIcM9TCGy
         N7DeUpVU8qpwweaeLkwNrvbDuOVidHOmK0XShanp+zgUdnqasbSysbka3mMV/ZG0pI8S
         NVajGdLBKD0HvMSLUdu1vDzjOLKXqPQVHJuBGm0u2q/xbVymcepLgyg6C1wR4XrZQtHv
         MKCgeyGzS93ETiFx/P6jSON5NrKwjphMtIJqWQpH02mSFddtv+gyiuX7jCK8tjxuqa0m
         Uuow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768406269; x=1769011069;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=i4eLrNTmJYNZqrOFXMkgnCrs/v9XFpKSoUUWAD+1qM0=;
        b=pTDPZuJzOzG9h+PHGISYEcfMgJiiarb+BzwrUbv59SoPNP8nWCOQmsyJ2RfplJSo4b
         cfMcQAQvRfUiq5XXkPCef8tbXpIPYF8LUl9FcZ2YUYnxrr8o8MpzU57eEqU92tB6slwf
         Bw+2W3R+NXaOY8EGQp7WEU4GOFOk56o7WCytwALvsIqDfkTzWu+frdPZ6wboZW1xCzLD
         R1i1LFnXIX4jhje6uL0CX3NLAciasXcmFW7RaqbDa9lo7wbFtjTnDNxjOF3ftvk8nBam
         sY31tSX/Z99KrvY5qyxqVjkwOIrq7S+Es+/KrFGJ1ia+daseUe1NgOYpXKlSKK/tRw50
         uE1w==
X-Gm-Message-State: AOJu0YxLUq+B3yqF/t0cZhw4jXndyI4GEihlWY0IwS8xq0g23H8+kzGl
	4U9WBzOIRb1kF7nahneh2R2fsV7AWDVnoHMd/Ho6K7ZdqlyoI1KbKrPNcQCpocuVCt4=
X-Gm-Gg: AY/fxX4k2aRYohg19hLW7BvBl12+B2g36XIEpSeRdYV6H+awzlFHL6xsMV1+3KF9mnf
	M4IshJHtl9DlKSlDpbUyUl+Y9pnBp4M6wTTh6tZf/kcZW1pa8pshKkqL2AyImx85nTcgPMjBUNO
	v47/4LwOBRQ6aPZkU21ovR3z9f5WyMvEahpwsYYG8EPXPXwUepWVrGH7LiplrehbiYS/DbYS7/8
	FLsZ08A/NeAg3JPK/MK/GjKO5EFNkTuyRsi1gnkME9e+SId8OQ3P+DR5R3D/jFQfwfDwnsmRMk4
	PNYOZWIDJHV2jMQbjl85UgcVfYuTsXT4QMfLBp+YZOpi8YawX6O2BlwW1cuDSFW6/YTXPb1tUs3
	Fk9CVsn22+zeKw8GW+tgFvL6I1+z5e+kaw5Tiy/x8bM28me5cuODtupI4X8DfHs8z/Nlq6kG6O9
	41WO1CIWsF0MrKhhkpTi3z
X-Received: by 2002:a05:600c:81c5:b0:477:755b:5587 with SMTP id 5b1f17b1804b1-47ee47bbe97mr31179035e9.8.1768406268797;
        Wed, 14 Jan 2026 07:57:48 -0800 (PST)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47ee85e8807sm7426475e9.16.2026.01.14.07.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 07:57:48 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Wed, 14 Jan 2026 15:57:21 +0000
Subject: [PATCH v5 09/14] perf tests: Test evsel__set_config_if_unset() and
 config change tracking
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260114-james-perf-config-bits-v5-9-0ef97aaf1ac0@linaro.org>
References: <20260114-james-perf-config-bits-v5-0-0ef97aaf1ac0@linaro.org>
In-Reply-To: <20260114-james-perf-config-bits-v5-0-0ef97aaf1ac0@linaro.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@linaro.org>, John Garry <john.g.garry@oracle.com>, 
 Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

Test that evsel__set_config_if_unset() behaves as expected. This also
tests the user config change tracking mechanism as it depends on it.

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/tests/pmu.c | 91 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/tools/perf/tests/pmu.c b/tools/perf/tests/pmu.c
index cbded2c6faa4..0ebf2d7b2cb4 100644
--- a/tools/perf/tests/pmu.c
+++ b/tools/perf/tests/pmu.c
@@ -192,12 +192,102 @@ static int test__pmu_format(struct test_suite *test __maybe_unused, int subtest
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
+		goto err_out;
+	}
+
+	parse_events_terms__init(&terms);
+	ret = parse_events(evlist, event, &err);
+	if (ret) {
+		pr_debug("failed to parse event '%s', err %d\n", event, ret);
+		parse_events_error__print(&err, event);
+		if (parse_events_error__contains(&err, "can't access trace events"))
+			ret = TEST_SKIP;
 		goto err_out;
 	}
+	evsel = evlist__first(evlist);
+
+	/*
+	 * Set via config=15, krava01 bits 0-1
+	 * Set via config1=4, krava11 bit 1
+	 * Set values: krava02=170, krava03=1, krava11=27, krava12=1
+	 *
+	 * Test that already set values aren't overwritten.
+	 */
+	evsel__set_config_if_unset(evsel, "krava01", 16);
+	evsel__get_config_val(evsel, "krava01", &val);
+	TEST_ASSERT_EQUAL("krava01 overwritten", (int) val, (15 & 0b11));
+
+	evsel__set_config_if_unset(evsel, "krava11", 45);
+	evsel__get_config_val(evsel, "krava11", &val);
+	TEST_ASSERT_EQUAL("krava11 overwritten", (int) val, (27 | (4 << 1)));
+
+	evsel__set_config_if_unset(evsel, "krava02", 32);
+	evsel__get_config_val(evsel, "krava02", &val);
+	TEST_ASSERT_EQUAL("krava02 overwritten", (int) val, 170);
+
+	evsel__set_config_if_unset(evsel, "krava03", 0);
+	evsel__get_config_val(evsel, "krava03", &val);
+	TEST_ASSERT_EQUAL("krava03 overwritten", (int) val, 1);
+
+	/*
+	 * krava13 doesn't have any bits set by either krava13= or config1=
+	 * but setting _any_ raw value for config1 implies that krava13
+	 * shouldn't be overwritten. So it's value should remain as 0.
+	 */
+	evsel__set_config_if_unset(evsel, "krava13", 5);
+	evsel__get_config_val(evsel, "krava13", &val);
+	TEST_ASSERT_EQUAL("krava13 overwritten", (int) val, 0);
+
+	/*
+	 * Unset values: krava21, krava22, krava23
+	 *
+	 * Test that unset values are overwritten.
+	 */
+	evsel__set_config_if_unset(evsel, "krava21", 13905);
+	evsel__get_config_val(evsel, "krava21", &val);
+	TEST_ASSERT_EQUAL("krava21 not overwritten", (int) val, 13905);
+
+	evsel__set_config_if_unset(evsel, "krava22", 11);
+	evsel__get_config_val(evsel, "krava22", &val);
+	TEST_ASSERT_EQUAL("krava22 not overwritten", (int) val, 11);
 
+	evsel__set_config_if_unset(evsel, "krava23", 0);
+	evsel__get_config_val(evsel, "krava23", &val);
+	TEST_ASSERT_EQUAL("krava23 not overwritten", (int) val, 0);
 	ret = TEST_OK;
 err_out:
 	parse_events_terms__exit(&terms);
+	evlist__delete(evlist);
 	test_pmu_put(dir, pmu);
 	return ret;
 }
@@ -539,6 +629,7 @@ static struct test_case tests__pmu[] = {
 	TEST_CASE("PMU name combining", name_len),
 	TEST_CASE("PMU name comparison", name_cmp),
 	TEST_CASE("PMU cmdline match", pmu_match),
+	TEST_CASE("PMU user config changes", pmu_usr_chgs),
 	{	.name = NULL, }
 };
 

-- 
2.34.1

