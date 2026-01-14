Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B905394487
	for <linux-perf-users@vger.kernel.org>; Wed, 14 Jan 2026 15:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768406268; cv=none; b=iErbtk5Xpc6N/dic9sYi+XtT1mtlWnQ9AtPWKPur+KWjTHFIrYgFUdcnrNILkzgUomv8r28KRPa4aHIhbHl5pYneOYIkMBk5jAPITDYbp8ON/GfbJsozBltSqRSkzg4nxCsSuwM+0c9dQJQHi3b9BANETAzpzzRsQpADP+6SNck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768406268; c=relaxed/simple;
	bh=m5ZHZ9nlMYrdHDXfhPH8Iav+WkxMm0bekJS47cvRmyU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o+eA+8RSPVFJjO/kB3fF3rDQFqMF059UEAX/LyYA31/pzfjWGeJG0v+fXmxvokIK8ur2NdR/97qqO5k1CaYgRTZnUyuG/yqU83ZUiDUJ4s3fUg6+R9CA/UWq+tkc18M22gUfArAcZD84vG/yNCdLBBvUf5xcYTtW8EUCmpwVrRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mRvm+DFK; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mRvm+DFK"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47ee807a4c5so3877325e9.2
        for <linux-perf-users@vger.kernel.org>; Wed, 14 Jan 2026 07:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768406265; x=1769011065; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WFM04/cBVS3JjjnsemivS8mMLgjxey36ij8/+pN2RLY=;
        b=mRvm+DFKrnTlAP4OHOr8p8mybSHdNz9QR0pb214UdNjYo7MLP0vCA8BovKwQj8h77V
         tzid+xJFGZpbFnYTeasNHQ6of09Z7um5pRzWxFvjPb+PHWX+QV5CBOJLMehXpw5li6zz
         X+ph36dYlxKZU3F8rxMIJVnknM6oVJGFvwORB4DUWJixDN7o+7TIhq/NO7mSGFTLg+Zi
         CUX1+tGCQP4gihjlQaFW81M5Lxkb0TNodFqh8vKG3k17aLosMCQSP4+WnAwk5QN0Y6PP
         2UkLUuGuZyEo4EdjXw+yZv2HvlfuPN13SaUNrwn0cjKqnaGYTRdeCbmQOimyV9C9rhLC
         NDyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768406265; x=1769011065;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WFM04/cBVS3JjjnsemivS8mMLgjxey36ij8/+pN2RLY=;
        b=naYopC0GCkN+Cy4UiJbwsw0u3lyEZbbi2CNsBZCN/kCHfbbJGHINst/6oSsl0zg/Dd
         eQ5JXCV+2/AQzsuzeV8n8KWL3AvzoauO8S4krGvJZGPt8Ih7FvBZR3fJazzYF/kty7rT
         OFcLoW/trbOQFmXN5Tdo+uP3HV0jv1ZXxCiGUvXF6SGbddnizie+yJ8yte6z9mmf46tA
         F5KPYlEjTdT5HEjH+yEapppUHThPCi+gTSl3dWNt1XYXEIfX5Ofana+PO8zKEPq3fkAT
         9eE9upf3WPZMWpq1JIsfjC9cTUWBuXKMUOpuQ8CuSyTAdzbT0czqTexo0MK+233bYlPc
         uc+Q==
X-Gm-Message-State: AOJu0YyNeYLc2SdGoTUYbYYKejoX51yDHcxCO0j0xSTY52KBFx7lYjQH
	O5TOQ5sHgli/XAZPQWgPz9Oq/2D45FBh3N+O1K7+72EIaUujv3yvSYxBQmz+A4kSzH8=
X-Gm-Gg: AY/fxX51d4ZVWMp+BHBVhtM7IjVvqnVBMJ7fHiYV0hbXpOyP584MT8ea6lrP/bpiKRg
	5migh10byMV0lD8cx8SXXbvRDPHHvRc/hqzCpvdY+czjrUnt8xEwn/45zVs2aSgPqBid5GhNG8q
	QyDNPh9rWltM15hSB/lpFDg6SPLOAjhDmyTBGqWJEPEcLVO3hfVf36cIikkv1gRe7t6e3kw4nKh
	jQwV19O+ndxk8dwmghhYbrVb0eVzCElrXVughNOwU3MLLAcQQx6r8AziqNo/T1sTz6byZIkQauJ
	aSF0B/qPIWStTNRYk5ojAMgvX8AW5KCqMvhduujSCrqsfGkN+4ePV2pb2gAGVqAhUWOgW2lednl
	+xOAgL6VPjbbMdGRRqI6k7qCEw//VPX5iAJCL7raqtkomm1crOt4UopO0mMlaHBNjXNJqGqv8/f
	sWDAoURbgw95OTkHPwuNi2
X-Received: by 2002:a05:600c:34cd:b0:479:2a3c:f31a with SMTP id 5b1f17b1804b1-47ee32e94acmr41043225e9.1.1768406264600;
        Wed, 14 Jan 2026 07:57:44 -0800 (PST)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47ee85e8807sm7426475e9.16.2026.01.14.07.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 07:57:43 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Wed, 14 Jan 2026 15:57:18 +0000
Subject: [PATCH v5 06/14] perf evsel: apply evsel__set_config_if_unset() to
 all config fields
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260114-james-perf-config-bits-v5-6-0ef97aaf1ac0@linaro.org>
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

Misleadingly, evsel__set_config_if_unset() only works with the config
field and not config1, config2, etc. This is fine at the moment because
all users of it happen to operate on bits that are in that config field.
Fix it before there are any new users of the function which operate on
bits in different config fields.

In theory it's also possible for a driver to move an existing bit to
another config field and this fixes that scenario too, although this
hasn't happened yet either.

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/evsel.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 27f4b5212dc6..3162bfc0ccfe 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1335,6 +1335,36 @@ void evsel__set_config_if_unset(struct evsel *evsel, const char *config_name,
 	struct perf_pmu_format *format = pmu_find_format(&evsel->pmu->format,
 							 config_name);
 	int fbit;
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
 
 	if (!format)
 		return;
@@ -1348,7 +1378,7 @@ void evsel__set_config_if_unset(struct evsel *evsel, const char *config_name,
 			return;
 
 	/* Otherwise replace it */
-	pmu_format_value(format->bits, val, &evsel->core.attr.config, /*zero=*/true);
+	pmu_format_value(format->bits, val, vp, /*zero=*/true);
 }
 
 void __weak arch_evsel__set_sample_weight(struct evsel *evsel)

-- 
2.34.1

