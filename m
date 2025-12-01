Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED156336EFD
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Dec 2025 16:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764607316; cv=none; b=eEZ5e9AtkfH9/BzurUeA/tKbPyscX98SL0pnweAKErPR1L5b3wVu3f696RWj7BYqngrZMIT7iHZ+qSxua453vZHYEBb8MA7lq5e/t2uIZLHGgJ1lrHN+4hyiAZL1ffoDJ3Z0yeP6My52ed+OsIr9yUSbTCv6XHq/LvRD6A10HvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764607316; c=relaxed/simple;
	bh=XDHLC1TToim0ot24UHTP8tg0u/f4uP/BR8HUnpB+CwQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q9CNkE4jhcDYiS7blH6Ib1w/6Z/o4MUwbXI6fCItwoBmp7Rc2WaWLHVJHDwlBIz0YSUm1iJkFWFcFg/BfD3wgyBvfQVwDA+s7SIT/52o4yapOcM1KmZ/wRxwhVZclQzGCho93WdQHSqygcOOu7IP8bQXht5bzEDNmFfsvgwxRvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K5hMjO3t; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K5hMjO3t"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47796a837c7so31007575e9.0
        for <linux-perf-users@vger.kernel.org>; Mon, 01 Dec 2025 08:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764607313; x=1765212113; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2GmRPB0jBQgoThlmGWejjg28u4BOouUoY2C6pZo+51c=;
        b=K5hMjO3tkDxSzE9NvXv86os0KLjJSgCCvpFMzEmDN+cVOz+7GYNULjgrFOrb99xJMw
         APiH1SK/iNiIcZjpJsjigs/qBMd1cVmXd8ECuRiBgZD/e5EgA9kcWqgI7ovShKvyLGMB
         1ESiwPCjWm+2yNOfVQxkxgS9oUK3BOFzNdpFCUCau2yTNV8T89+FjmlGVqaJJwRYUebu
         b3ykGByTIVD6Dd9WtJPgRA3Rc5WoSQ0RsKtMBYqgXV2XMSQJAps4/bayjg+Inl4rhTbY
         wgtGQFmL9KJlUHsxZCW6Cy6mTlNRTaK1daO0IL+6mfzB2jQD25+GDhBWsY4EDhD3qM9Z
         Z9hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764607313; x=1765212113;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2GmRPB0jBQgoThlmGWejjg28u4BOouUoY2C6pZo+51c=;
        b=qp93T+o7qFsQpX8gyXd3pPPEr2a/z+5UMjYzwSq9EFc7sSarmuMjXeCiYBty/6Ok0a
         nWli523fULc436wKDeEijSdhIDKppp6wKAOhjucKN/AwKdqVrGqYJxLsR7MxBmWCtiAj
         JPMN0IB14wvQGBR8KLDvInUWD7FQ4gBGnuBiuR8swjxsxx86Im9PntcXbCskyeufaL56
         VSjxfVei003buVBW9NwUuQ54YM6v+Z3Au+99abMOuXRBAxCjbmavWwvlLi6DJgPtVS5O
         dCrEgxuFKQrEzlLvDe/i8UDJcbGJwNvAiYNFuLE9rqcHy2NABAlwlxhhQasnJQQv+div
         KExg==
X-Gm-Message-State: AOJu0YzyLaIeamLkfo5kjtiaLAt3pVUV2rZEDNJfSz4N6cIKXSQB8I4R
	H8tBmZLxEtEnm1m5Ew5QlbCvvoz6bPS1KCrYoiRKBQdnwmAdQJDadOOGvADxWgbgX/g=
X-Gm-Gg: ASbGncs0nGRprTN2k1oaqNZK5+rIp8A7tIIhUAQWMeqwlM2ZCt8GDm5/DCz4yp2Qm5q
	i3NGhNlDlWyDT5uVO35m8sYxYai7q8FR5pqxhs3wJPQi287ncjv/dL+TSDYf2a5e7MXtRQSPrNA
	/XqxkY56S0L/0QePDo82S4Aa4jJz+3auEvD8nDsAwSFsctOP5VroIouNVRbhRjhwmdCBm8Em9St
	Ei1bgeiitnlDWBntIvCzERexsN01CWr/c9TCxJTAAxLeMNjO0jif2G+1iCwAabez/nW5v2pc1IS
	J0ku2ofaTKdgRdZiZtFV/gxBx7haQ70VzT9BcHggEjpM6pFUpmQXES8/8ksTEY4WpjZV1wu71+Z
	OrHcT4aVZvPhjhwgE/xd+CS8XBSGW8C2RXtCDrOiLPzL0ErfzUr5JUBWn5Y0IBORmq/2NFSmAxm
	H0kDHN/saJtn9+VGLJ23l5
X-Google-Smtp-Source: AGHT+IFPwkzUwt5EiRHYLaJ1366EfwcLCjCSX4vJLGbexn4dFtCnAICQ5GKj987Mcpxp3OuhbV/5PQ==
X-Received: by 2002:a05:600c:4ed2:b0:477:55ce:f3c3 with SMTP id 5b1f17b1804b1-477c0162dd6mr377290195e9.5.1764607313297;
        Mon, 01 Dec 2025 08:41:53 -0800 (PST)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4791164d4f3sm255901275e9.13.2025.12.01.08.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 08:41:52 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Mon, 01 Dec 2025 16:41:10 +0000
Subject: [PATCH 7/7] perf arm-spe: Don't hard code config attribute
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251201-james-perf-config-bits-v1-7-22ecbbf8007c@linaro.org>
References: <20251201-james-perf-config-bits-v1-0-22ecbbf8007c@linaro.org>
In-Reply-To: <20251201-james-perf-config-bits-v1-0-22ecbbf8007c@linaro.org>
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

Use the config attribute that's published by the driver instead of
hard coding "attr.config".

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/arch/arm64/util/arm-spe.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
index d5ec1408d0ae..6c3dc97fde30 100644
--- a/tools/perf/arch/arm64/util/arm-spe.c
+++ b/tools/perf/arch/arm64/util/arm-spe.c
@@ -256,7 +256,7 @@ static __u64 arm_spe_pmu__sample_period(const struct perf_pmu *arm_spe_pmu)
 
 static void arm_spe_setup_evsel(struct evsel *evsel, struct perf_cpu_map *cpus)
 {
-	u64 bit;
+	u64 pa_enable_bit;
 
 	evsel->core.attr.freq = 0;
 	evsel->core.attr.sample_period = arm_spe_pmu__sample_period(evsel->pmu);
@@ -288,9 +288,10 @@ static void arm_spe_setup_evsel(struct evsel *evsel, struct perf_cpu_map *cpus)
 	 * inform that the resulting output's SPE samples contain physical addresses
 	 * where applicable.
 	 */
-	bit = perf_pmu__format_bits(evsel->pmu, "pa_enable");
-	if (evsel->core.attr.config & bit)
-		evsel__set_sample_bit(evsel, PHYS_ADDR);
+
+	if (!evsel__get_config_val(evsel->pmu, evsel, "pa_enable", &pa_enable_bit))
+		if (pa_enable_bit)
+			evsel__set_sample_bit(evsel, PHYS_ADDR);
 }
 
 static int arm_spe_setup_aux_buffer(struct record_opts *opts)
@@ -397,6 +398,7 @@ static int arm_spe_recording_options(struct auxtrace_record *itr,
 	struct perf_cpu_map *cpus = evlist->core.user_requested_cpus;
 	bool discard = false;
 	int err;
+	u64 discard_bit;
 
 	sper->evlist = evlist;
 
@@ -425,9 +427,8 @@ static int arm_spe_recording_options(struct auxtrace_record *itr,
 	evlist__for_each_entry_safe(evlist, tmp, evsel) {
 		if (evsel__is_aux_event(evsel)) {
 			arm_spe_setup_evsel(evsel, cpus);
-			if (evsel->core.attr.config &
-			    perf_pmu__format_bits(evsel->pmu, "discard"))
-				discard = true;
+			if (!evsel__get_config_val(evsel->pmu, evsel, "discard", &discard_bit))
+				discard = !!discard_bit;
 		}
 	}
 

-- 
2.34.1

