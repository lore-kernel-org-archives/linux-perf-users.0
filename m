Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E96326942
	for <linux-perf-users@vger.kernel.org>; Mon, 22 Dec 2025 15:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766416501; cv=none; b=D6ilGi+vBNkzkrfG4TCgakF0jodf3S6az3Eh2bRNf0IZv5xpOXJWr+EglHdN3BgczIGClFimC1HnDsmI+rQ8HujyKh45YYBL4tHLE82/0EkP6iThs4pBYSFbJJfnwPejeSGpqxIYKxFY/2x1sWVXvUea8UqKPhObiUybnkV42xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766416501; c=relaxed/simple;
	bh=LQArxmrJrNZZsUxSMnAWJcE4cLQNPPNILpLMGRQk8pU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fLumFD3iCmcT4Uplkiofjbk7FYvIGhiJncFkpXyeIrtz+KCuJaCm1DgiqjyMO0WT7pCGEs/6/dub9Dibt7BVXimRjI6ku+HDPhNDBG4Qca7BWpJ2fDJZ2Z+ZqlIe41WDk7QGjiD+7RtC3bHyanYpJFB9SGpMeNqA7MP6UIhWncI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ldhyMf85; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ldhyMf85"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43246af170aso2253410f8f.0
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Dec 2025 07:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1766416497; x=1767021297; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i4eLrNTmJYNZqrOFXMkgnCrs/v9XFpKSoUUWAD+1qM0=;
        b=ldhyMf85C+ZDf74tOdg2TS42KCRk2rGngkOCR+jlOC4p/7ej8M2TgifKWPcbD9HpMi
         n6u2Esh9SzvSMQpefMYWn5UU6+tEtc0O57mxK530gdXSw2pM3fCtRVS1aI9nsSDVnOvu
         O9PILaA/TgQSeesCYBNVfi6FCGjcetvyARNzM/KKkXnyldiE2cRLm64p/51I+WaDg2vN
         xyadmJ4XdjOtqgnsMB8vqEGMqrQQmdyjyaD2lj8EOEQddB5SYmBmVew7b5QhHZyG09JK
         vYDSn6BP4pkfOH/kYOZj8NTIj0ljJUtmPGfT6xW5nq1/ALTjfwzEPeNfM7jZLrEWRxpD
         CpFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766416497; x=1767021297;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=i4eLrNTmJYNZqrOFXMkgnCrs/v9XFpKSoUUWAD+1qM0=;
        b=BuPnXifSlSJ6Q2NVI8JEEYvBXaXOeeuRpf8dkOsgeoq/XstYNXk+wPQz9NfESj2EPX
         mwV60wy66yd99Jjdco0xBrIpYjJSXsSnAA+gq8J+meHxDhPVUdc0Hq3Vd4MMofbUILuL
         HWHjsD3o30IMhbHFmLVpLtQnwd7+KBv8Xr9lIwo0AyafJq9w84iDG7DXW9kXBYPZBxr+
         s3Yk8gf4ThNDxd7n8Qg2LPO7C/Imr7rzW+8IKfEZftpfOP+63GkJDpOq9UrtxmKsHsXK
         hVRe7b5QFKIvRMFUnDbRX1mRXgLMldpLTsjaMV6sThFDqu4IzYCEAMCw41V1NSSBMcpd
         JD2g==
X-Gm-Message-State: AOJu0YwJgtWrnvn9F6rYmVf/HMaRmOIvmlASyD0wPRKv+5uI+lSXPyQ+
	DlubZnH+PQpkCCYWOc7jUZ4hYI7voQBJBprCAQQtRT+XkciFxTerDEEaxQhFumEIy7c=
X-Gm-Gg: AY/fxX6XutcSPeAzpovrw8NQyqZo75KYDRFvKqWAg1USkzjErIUBVIpmzgSg2cFbEwo
	Qp1FZJ1M0/e00PM4Q7I77qQOpXIPQbmWoqhMfa+smM/xzI9wU+En+NIdDrtN1zUEGwZzFCGCnF8
	3dlG9YLk6vdqv7hjTBrXDgRmZviQ2BB9ByO+zvDZxWURVRr4ABTfnxM2HRAYPPnu0f9ZmhJkBrz
	S52WT8nJL7Hz1H1HMwD39po3dxTYvQax3Vu4fnFSoRk2YNiveNGjuV7FOw2tGz2jZKWaSaFzAlG
	uEMqJ7OOtF3k3191cSxBWZG/rr0SfqFuT59GneCItEy3lVCDBOr8Mf+VeF+1NuDfYC7K8UvVRsd
	N1PyuiND28jo02aEGabFs8tAClsvi374zfMPMtEwlyD/CgJdI/l4OoTyVRqZdAxYkli6cM1hro/
	cjcjFsNPUlxuuY7Dxj5lJI
X-Google-Smtp-Source: AGHT+IEX38PKZ1aYnAoijx5riCeANgTFac47kzzgBW07ko1Xcrdxsb2Y6X78FNQXCIfizNz2p3XEYg==
X-Received: by 2002:a05:6000:18a8:b0:430:f16b:d8cc with SMTP id ffacd0b85a97d-43244795353mr17080981f8f.3.1766416496632;
        Mon, 22 Dec 2025 07:14:56 -0800 (PST)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea830fesm22750093f8f.20.2025.12.22.07.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 07:14:56 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Mon, 22 Dec 2025 15:14:34 +0000
Subject: [PATCH v4 09/14] perf tests: Test evsel__set_config_if_unset() and
 config change tracking
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251222-james-perf-config-bits-v4-9-0608438186fc@linaro.org>
References: <20251222-james-perf-config-bits-v4-0-0608438186fc@linaro.org>
In-Reply-To: <20251222-james-perf-config-bits-v4-0-0608438186fc@linaro.org>
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

