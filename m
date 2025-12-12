Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E370D31B11C
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Dec 2025 15:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765553573; cv=none; b=RM7hcGOZdtR/GAhXeKtR6ZScatplSWFMb0gAG9lpYbrzBgqunzdQSUzsZSjreQONSsVhlHp4a73wbZeHUPavpK5TzrO/9kW9qRaqrYsAt8YyaV6avtp+QcVPxj8P7Uk+cUCvgnAbtQYkhf/yw5B/7AXsBOxsp1dg0MN1M4wvv58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765553573; c=relaxed/simple;
	bh=zLdx5e3pyh2JRQOFFSBmpdx51RRSEdD16iQSkfVhasc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M9vnRhVATMNHzkU/DBjpScezhqYnpRmUmZCvxMoFwvOc7cW8tQnv0SvaKObhs32fL9BboaLI8yrEsLZRBoamm+1M5SD5oBJrybJS11GMw+Qqp0H5b1BDY7uZCtwi/R6HnJKnrU93wI0uOwuc7wRwavZJju+zFyTMU0Ig3ZINxIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VFSMY8Tq; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VFSMY8Tq"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b725ead5800so198667666b.1
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Dec 2025 07:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765553569; x=1766158369; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9R0fqOMnWx/kXqG5KJ5IdcBa/s5Ujlxo3aE4ef72JzE=;
        b=VFSMY8Tq0wndD7ReNusaeIBbccnJS5PMKQFQzvDBISxQieatGL7DgAj+C0pyadgPrU
         vwJQdGTX45G2jeeQTVny6ll2IR/gbc1xAXsPugKr02oJ2sx0iXi7QLNJwCm0L45IjhNc
         ShvLllatSA/q7KKkrxxaH1P7p3rySP5h0A3uQRSS1oyTED02eaqQC2AP6+xdR8kjEemD
         6fFQPNy9JBJcl5alYwvIKbVmljSYoaUYZFxVll5srmY40jTtTPuec7iY8+ZkF8Vfm4gV
         WsHDy8VckMMn4oV+I0oaIr6ogXkaGsHda9sRaAW4eTIIxMLL6wRnhXi4Ne3blFVbHPZ3
         zF4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765553569; x=1766158369;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9R0fqOMnWx/kXqG5KJ5IdcBa/s5Ujlxo3aE4ef72JzE=;
        b=D+ioRrTmWEW/iLIjog2MNnhsfCueoZOuL5OaZcXKM2Y5hRzrn9QeIz4EL2+eILTPVc
         89utve2pjCTjZaXwdFretiBOVqdGIqaMv6e/Bmm39+f/KSFj1kIZxL/QsLcQJK425awX
         J7dHtmBRoy/O64fpoo1GTr9/AZG7+1tiPyMJgObRw2hVrM/ev4IpD1MjUvXwQBOw/lm9
         vBkd5wjohCZ2eh35I/95mBzX9EKruwUiQwveRjZAAODmz9Y/+dAMtNYXNiYP/yY+hrb4
         pTCFgg9z178VsvAD30LO7kICxzDi7Mk5kief9i04DxWdq1UZEk/OyTRdZn9WkPG5kAbF
         HNEA==
X-Gm-Message-State: AOJu0Yzgc7ELooXorTWzhrNHrZjpwKh/wrIEwlnQmU32rFvBQwXSEodZ
	9h7K2OD4MVcfwOncluZYUOQrsBEiTaEIP71Nyu32H8rxTmlOIk3sqXBTk8sV93gg+40=
X-Gm-Gg: AY/fxX4i6rMoQoYypeOQd3vbTw5FuXQNiuwakKTiKPIypgyQuqTzvKHjnUwVdVJoP4e
	rWe4XgQDVoFk+Z4bwWNl9RD12EZHOsNq30Z/zb8kaPliOj0sr/tRqtJaewA+//qgRVsOvaFMToU
	ooDaN64WVOne7YSW8a99egs6TPSm/JbsvdhJYhmYGTXtlfH25bEGqLPaW4lgVUgrJyYMWsDdlyo
	Va/DBn+gdatvBgsv5SnpmHqI6OgSjjGyABDwDa+WSTfizZZ9kusfSYzyQ/Vi560Y2YprCCejUGa
	1HvuOBPwHjySZlidR4G2nlHwNfhDNW2nPGuPNunwFD04mPurux3t8uRRZaNZnY9QCzLlTDi9WEa
	qp9luzVUXPNbpsaiFtgV22h/biwvY9eRuoDYttfcrEdhgURi5IAOOs53dcgLOGy2Ljl/3UXSCyB
	GLMqxT4kkO0D9svbCV1V+6IkUsh+XECuU=
X-Google-Smtp-Source: AGHT+IFbuckV0/lVSbpz/gLDBbP/OWExCz0AsI758ga/mOuq3N+WcR0TmjT9gy99TZcqWy5LGpaTmw==
X-Received: by 2002:a17:907:d29:b0:b7a:1bdd:3311 with SMTP id a640c23a62f3a-b7d23c5c413mr246282266b.62.1765553569104;
        Fri, 12 Dec 2025 07:32:49 -0800 (PST)
Received: from e133063.arm.com ([130.185.218.160])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6498210ed32sm5433234a12.29.2025.12.12.07.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 07:32:48 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Fri, 12 Dec 2025 17:32:21 +0200
Subject: [PATCH v3 04/12] perf evsel: apply evsel__set_config_if_unset() to
 all config fields
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251212-james-perf-config-bits-v3-4-aa36a4846776@linaro.org>
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
index e02f74d4020c151082ecc434c29c0ec4c2c9b2c8..514cba91f5d99b399d2d6a1e350971660c54a9fc 100644
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

