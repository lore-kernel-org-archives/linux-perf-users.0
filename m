Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0900131B118
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Dec 2025 15:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765553580; cv=none; b=UHYPI2OHgceUG3ZCfjUtO3HEo4psr3DGueIwCkZwON0Gxibbq8jIOP2KMIdnhRL6ntsV9KbvCigv5jUKVxozl/BiAXud2r7gZeqe7R9RythpOMoU69l9GyyO0ZKZYwp4Or2v9qdTcpCYxHJkiNq9jlfuvHtlEPZepxBj86+tLPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765553580; c=relaxed/simple;
	bh=UW8aZJ/wrytG8nQKXwmbp89xjQYr1P2Ou6Va12MmDEU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P7tl3PPy+9/+U/xG1vTkfBiIjb0PXfFk4TZ8TCNQKjUbgMj5DKR67usoraZWXoRU8aBe5BUYkzYAfDING3EwCrNt4xg3kurQkNah3RkKEkHl8nFNGLf2xSL3QicMdP5vDFph7J1s3Iu0BzCJ5jpD7tc1+POdaaG0gQgQD+M3sW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EkKVPayn; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EkKVPayn"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b7277324054so258718966b.0
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Dec 2025 07:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765553577; x=1766158377; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e7fahmTBI9kipCQMheuyeZUpREbzXH29kA76YEVRHtk=;
        b=EkKVPaynJYTxdVOY5CRXddG5B79ItU2QesDWOd3Y71Caarr0b4uKyIZ7tgkCk3sDEe
         zywluPK8JhOo4R3Fd4qFGbuAVbEeIYV6MpiHbWkmDJi9KnyB0f/oCvCeVxZ86V4+ZGcF
         8OrfKZRYZD1GY7NfkTJ2AYoIbxaGcksgUDJSIBsn8ivwVZsygEsv70FDPAZjko+gM6Nl
         PTh6TTNpHbVEs3/2nPIWlTCHJl5RJ8dnUQhOyJ0AATKDZlOnFn0KQXpXSwZGEcNRRO4q
         t1VRhFRge11kPxAwkDwVfD85VAdUxBA72BApsyazVfPvzcteF45993ujn2Yw0iO/I48a
         cWNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765553577; x=1766158377;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=e7fahmTBI9kipCQMheuyeZUpREbzXH29kA76YEVRHtk=;
        b=oX6RRW2pTsLRO2h9Fg7vpOVOicexIANFeVCv+R5ydaoKSr/CJRYcEcddZMo3iSOxDz
         FTBNnOu/LgrTiDRK6KA/D0DmIfWTarvsFxaaKlqe/QnSG8kkYHIVNVfu+6Re7tXbEZsK
         WC1tspvaguorah0oaGwOBwnrjebEC4Fwm1MhgSowB+j33/C7szWqso0IgUem/MbQvQPJ
         jS+TUeLmC/TuBEcRNaZYlg3WhnT+WV3MJ6rzXycc2PkTN0Af7A7jAdgoxFGNSWERu1b3
         u9oww5nDRiWDO8w0jvblq1nz6VQNQhfnI1DP4bRHHZwXUziunXUAII0MAUsD5J9Id137
         X7Jg==
X-Gm-Message-State: AOJu0YzT9UmTD7UiacGZ8mpBNMBlpv4ru12ziDTQCxg3gpIakxU0Eq7P
	VKdQE1RCFUPgnrc8pbs7N7coxcHc6zlt6ffjUvuszFPaRk5TY3W8bjS+v9Vq6uMATc4=
X-Gm-Gg: AY/fxX7xNNEiVsZc/EgGhKY1qyQOV+CtEUHSDJfOQQeqGf72SEUX5zjEi5sdGTXv1D4
	/PU5qg6u7E+5OLNXh+vCD2mXRxCFUveWSrX3ihikaJAt8r50yE/X6F0vEG6Sb9n08CnSxziyzgE
	ZhYkQD8fzZwP9suDQ+H1lh+vdW/68Pl+MVf6d0fPZCDcD5OY/8uf3a4zm9qrNIXEEeRl246oQHt
	wjfXvPARHAwetcc3hQ1lKM+BY1x0QOnYl2Fn1HuSz/JoYeU/xPRKEmu1I/fwwmfOb/uQRsfnlGH
	+EvxbTxXiDoITkhBfEnWCXhVR3NPYEg+befcsHg4UXBHCOuh+iq2iaXoWiQyIEsWzXp+11U+DnE
	YdsQAqp8fD7Ow/vZBLp2sB1Si1bE/VxgWm0vrFcQixYw1LAcdwsgQ44nY5JTKkTYfOE3Q+OodRL
	bXEPBXPLpAswmsF0BzJJj2
X-Google-Smtp-Source: AGHT+IEQFiVpXtjTbT1nEBymPVvwKhgGbHnTLlvzOpyqaM6FBur+TFlEfnGCvotgjkxj0qijhEHzow==
X-Received: by 2002:a17:907:6095:b0:b72:3765:eda9 with SMTP id a640c23a62f3a-b7d23a7988cmr220274966b.60.1765553577012;
        Fri, 12 Dec 2025 07:32:57 -0800 (PST)
Received: from e133063.arm.com ([130.185.218.160])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6498210ed32sm5433234a12.29.2025.12.12.07.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 07:32:56 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Fri, 12 Dec 2025 17:32:24 +0200
Subject: [PATCH v3 07/12] perf tests: Test evsel__set_config_if_unset() and
 config change tracking
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251212-james-perf-config-bits-v3-7-aa36a4846776@linaro.org>
References: <20251212-james-perf-config-bits-v3-0-aa36a4846776@linaro.org>
In-Reply-To: <20251212-james-perf-config-bits-v3-0-aa36a4846776@linaro.org>
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
X-Mailer: b4 0.14.2

Test that evsel__set_config_if_unset() behaves as expected. This also
tests the user config change tracking mechanism as it depends on it.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/tests/pmu.c | 91 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/tools/perf/tests/pmu.c b/tools/perf/tests/pmu.c
index cbded2c6faa4d5b422936e81bde83bc328fcdfe7..9e313a9a44fdebd0d417c7558b15e5db89241867 100644
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
 
+	evsel__set_config_if_unset(pmu, evsel, "krava23", 0);
+	evsel__get_config_val(pmu, evsel, "krava23", &val);
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

