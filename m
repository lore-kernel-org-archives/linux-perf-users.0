Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9967C314D3B
	for <linux-perf-users@vger.kernel.org>; Mon,  8 Dec 2025 14:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765203806; cv=none; b=XxwJVh2B2v6tG2iB3R7Yg6wtSTgkDx1pGKkm7sFIsE+tZ/r9Td/MKJX6YKHMsF2EwY8DrwY9WUuOVstpLsgpKG1xJU2AiMatFVHDceyB45rToeHWy2bXq5f6tu+yjIjKjHb6Eu5mjnA6jmuPyygzzQ9LOQr4WpGOvippUqgAj2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765203806; c=relaxed/simple;
	bh=G91PVNHfi0QYrYWGktdjTNJ/Okf/P/cyrGTlMeXq90I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s9P9veqkB3YyUIrDG9dLPZP/yEW8Gg7fchLMfP0fUUPPjnG7g9PALFQrzSvjuHe05r5OpKJ1WFppXobb8PuqRNh7Xl4e3GJNmHQ+Pr995QnaHDgBKnGCB8rLetAYCZYgzFN8slHv0lNNaUm5GyxVoI0/pU6gJCMQbLH8qUngcww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eDq8/R/J; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eDq8/R/J"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47798ded6fcso33860915e9.1
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Dec 2025 06:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765203803; x=1765808603; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZRhf5LqtwI1BCs/MXxqcrvCOGauWve2lGZSZRvbtNrM=;
        b=eDq8/R/JfzeeH6y8BF+AWTwQINiTl38oUMd7dpbuLjNjbCzcOhPMX8Rp+877/Be1dR
         Qazyg3IO5gQuECgkSDh0E1EQhaw/kQN8at2kwBGSgJeCiiIreSNK7Gn0d4LydSeMqvQ+
         Nvl/b8S+6ju+Aa7a9fLH8Ol46bGGq1WBixI/ocuAdPB7SmLFXrMiSFa8BzoFkLPUcyFm
         7yRyn+0xgw9e+yUZcj+a3zBcDEE1iEHbr+3BdrsdCS2B8laDhgZ86AZER+nlxSpr4MZl
         /lUDaHIZNK1EWnLpVOfvawwcCm4CsEaDjWrOmBDpsFdA8bmUJyxBniidXka1B+ID2z9v
         WnFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765203803; x=1765808603;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZRhf5LqtwI1BCs/MXxqcrvCOGauWve2lGZSZRvbtNrM=;
        b=qkuo7BlkSV5wJDmRiqrHO2FMwc5/CD3nMRw5v3j4EIjDNVyurpb+1qfbgVgBKHoW92
         8uuxfuYf7SgUVNfBOcdo8AO4xUkn0HWmC0i8GQDFgZfKHijLqX1ImjWCcbShTTYKzU/H
         C6bVJhQZqsGyElCEtFl/uWagu1fpBY94AnuzMmKl91t3wAeCmIgSWJaXCbYLYeryjEgw
         RgpHweIsxpCoUIusqdhXG052lXepE2AfphdztzzTwV+Kmhv/km8ZWdJvz0kN0P6xdQC7
         5qKbrbTTTqAGP9FMTPgzy/pzU9aRjT6jy9Fm5aJrAKDmXHK8LItujQ0OkTSOt16wIJ1B
         25xw==
X-Gm-Message-State: AOJu0YwRs2QQlgjAKnaYjV9nGIxu/fiCTR8mI5DdhMloTbDjp2Rcjkj3
	5by3zEIIaVdCUbvrAFIfS4YNcNzfkxsTk1d4t3c6cXzhj3u0oxOVhhxLzwYphRyez/4=
X-Gm-Gg: ASbGnct6yYGKmIysnsnkWipQaZBdOB5qBL4Daz4qedjetIb1UFXnc/bsL5J29kbgH45
	loEWv5DcbXTCwgn/2P0L1EOM9oosLvlgXPNPFmGhYC12t9xxme11sPSbeWNn9BSiFGDAmaP4TsR
	GxXM3oG1zvk9qRsG++YcbK6dRmfHXYsOZ6n4Dr9emaOdX66T7lVVzYMTZm8pyZEtEBh/9HGmGAG
	0Kz4WmzzSy9yk1rm8Dd8bYomxxGHqBm+wnuMzH25Smw85/JEZhfMkBQF377C2GNfJHIG1TSK17L
	upK2lsFDR/dw6OeLhw72aYfAEk07Nr0Bl49lgIdj7SWKqv57ZePonvYSGh1VpR6GVOlzgejeL6b
	hPpRNX4ANQXEgqnYXf8WIyh5pom8jeifAELETvub89SxOTBMHHwBy8nFHY5rQRojj2xXrUm1FX2
	XFa5X32PIFW69J3AHPh/VA
X-Google-Smtp-Source: AGHT+IEhpoMN4+zTETFkcztiEWYM4FtF59nv9AEONwYh8tAIN/5BaZy8msPhg0ncsD8sYg+q3JZCMw==
X-Received: by 2002:a05:600c:3514:b0:477:7768:8da4 with SMTP id 5b1f17b1804b1-47939deac5bmr91892805e9.7.1765203802717;
        Mon, 08 Dec 2025 06:23:22 -0800 (PST)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47930920e0dsm248561065e9.2.2025.12.08.06.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 06:23:22 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Mon, 08 Dec 2025 14:22:07 +0000
Subject: [PATCH v2 04/12] perf evsel: apply evsel__set_config_if_unset() to
 all config fields
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251208-james-perf-config-bits-v2-4-4ac0281993b0@linaro.org>
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

Misleadingly, evsel__set_config_if_unset() only works with the config
field and not config1, config2, etc. This is fine at the moment because
all users of it happen to operate on bits that are in that config field.
Fix it before there are any new users of the function which operate on
bits in different config fields.

In theory it's also possible for a driver to move an existing bit to
another config field and this fixes that scenario too, although this
hasn't happened yet either.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/pmu.c | 37 +++++++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index e02f74d4020c..514cba91f5d9 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -146,6 +146,8 @@ struct perf_pmu_format {
 static int pmu_aliases_parse(struct perf_pmu *pmu);
 static void pmu_format_value(unsigned long *format, __u64 value, __u64 *v,
 			     bool zero);
+static struct perf_pmu_format *pmu_find_format(const struct list_head *formats,
+					       const char *name);
 
 static struct perf_pmu_format *perf_pmu__new_format(struct list_head *list, char *name)
 {
@@ -1387,7 +1389,38 @@ void evsel__set_config_if_unset(struct perf_pmu *pmu, struct evsel *evsel,
 				const char *config_name, u64 val)
 {
 	u64 user_bits = 0, bits;
-	struct evsel_config_term *term = evsel__get_config_term(evsel, USR_CHG_CONFIG);
+	struct evsel_config_term *term;
+	struct perf_pmu_format *format = pmu_find_format(&pmu->format, config_name);
+	__u64 *vp;
+
+	if (!format)
+		return;
+
+	switch (format->value) {
+	case PERF_PMU_FORMAT_VALUE_CONFIG:
+		term = evsel__get_config_term(evsel, USR_CHG_CONFIG);
+		vp = &evsel->core.attr.config;
+		break;
+	case PERF_PMU_FORMAT_VALUE_CONFIG1:
+		term = evsel__get_config_term(evsel, USR_CHG_CONFIG1);
+		vp = &evsel->core.attr.config1;
+		break;
+	case PERF_PMU_FORMAT_VALUE_CONFIG2:
+		term = evsel__get_config_term(evsel, USR_CHG_CONFIG2);
+		vp = &evsel->core.attr.config2;
+		break;
+	case PERF_PMU_FORMAT_VALUE_CONFIG3:
+		term = evsel__get_config_term(evsel, USR_CHG_CONFIG3);
+		vp = &evsel->core.attr.config3;
+		break;
+	case PERF_PMU_FORMAT_VALUE_CONFIG4:
+		term = evsel__get_config_term(evsel, USR_CHG_CONFIG4);
+		vp = &evsel->core.attr.config4;
+		break;
+	default:
+		pr_err("Unknown format value: %d\n", format->value);
+		return;
+	}
 
 	if (term)
 		user_bits = term->val.cfg_chg;
@@ -1399,7 +1432,7 @@ void evsel__set_config_if_unset(struct perf_pmu *pmu, struct evsel *evsel,
 		return;
 
 	/* Otherwise replace it */
-	pmu_format_value(&bits, val, &evsel->core.attr.config, /*zero=*/true);
+	pmu_format_value(&bits, val, vp, /*zero=*/true);
 }
 
 static struct perf_pmu_format *

-- 
2.34.1

