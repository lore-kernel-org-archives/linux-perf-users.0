Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCFC33554C
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Dec 2025 16:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764607309; cv=none; b=s58uBN6gXOyF7fTY7nHw7ujT/+OkiqxvnXLPk5LTNlBARC5UNpvzOZVXvdNwgDk2fxe6ph81z6GrrH5eiYpVr+ER5PvQbZWS6pXw0LhCrCg5t1cZ09Gz2c4bING78uDKMlCY4OIEYE5+wmOEXq3K5XcV/Awb2YkN5Pa9Oez198g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764607309; c=relaxed/simple;
	bh=Y/ioDqGIzUScWoIaRX68KW6AKfDzMnOwyWt3rbeY7RE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pk3ZheSjTYrdM55lrRe8xitZkaIFy2fLTseewf9FnyhbT1m9gVi3hNYgc3+10rWF51JBvehR/iWBKp+Rkutded5qM6OFflgnZGMUR4K2fO4BTFGg04GB/qxP0aIp699ZOFZSEuxXbnVeNhC3iISfrX6niMg3srTrF9qLooXARm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YN/0XgNx; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YN/0XgNx"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-477a2ab455fso49520895e9.3
        for <linux-perf-users@vger.kernel.org>; Mon, 01 Dec 2025 08:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764607305; x=1765212105; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cpxmoGZlCGWci4RYJQsukYp/h5kR1+QCzzjmaZQmdKI=;
        b=YN/0XgNx3ebt9D1zA3b6I929OsBTDpAtFQ+L0NwGUD6MMw7mDW/g8vCGlKfESndLLp
         wLfVZDElA8czCg9hvabHLuoeqLNTyaaYVmRCIHYxxmMx34ySdVq3smkBAU8hpeJA6A3n
         i0ijkzv2TjmvBUEAFzoo/Gms+eZ3SbTl5hTfGLVg0HSAWSmq8PTtQZhvWElbBBLEkRTT
         yDFR9SytFcD+I1v7GGgaApQ/7v8ePCe6Yn7UbmdJsdFTkmGexfbw2fGgLbMkJg/BJIhh
         FrmA/lr2s8PeaysVHRq4oIPVack7XMkkSMJhLdDE/Rj/vKwILIj6hoQeesv2LvR1WOoy
         33dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764607305; x=1765212105;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cpxmoGZlCGWci4RYJQsukYp/h5kR1+QCzzjmaZQmdKI=;
        b=Om+saTgltvDiD9Roy5BxGE6YS8/j/hyUeCPQ9DZHnDwerc/G3MoamKIRNdEoQpjCzG
         x5al0mbV7UeRccLb+wTEJe0k0WKYmVHzTvEeH+cud4ZyFrLGf+0NYb+HuiUVILa6GLlY
         gg9JRAyhsBhpabKOmfNA2T2e2C1Q1VilktN2xdeKvPhAL2rndhvbS9a7MvrvynG4NJxX
         Te/GW3l4mU7YtYtP05KVnkpMAwwav2sBjfa4MP1Dyn5MaZH8crZzKPjY47Tpq8gdU5oU
         4VInXu/fowNnacmt/xdYqWi/DgCDAZavGXeUsh98tsdh9Z6WKDHqV/4YJ9pXgvI1AzmF
         PmFQ==
X-Gm-Message-State: AOJu0YxUxuyqHbUop5Ka/sEwHXwWZGYcehUycdblT27gMbcNS7l3/omD
	e9kvmyNkUabbZY+R2K3ddSpxKxa/bkgS5ZwxNvnmLQUz8TrKIDbBBjkqhV4jyR6Xtok=
X-Gm-Gg: ASbGncum8Tq7Kdm9/+HMgezyj0EqTUxv/CFNeL6GEYwlcHLxhq3XkYvE/VKTQpQH98h
	ea4c1BAbyK/a4tgT80NZ+nn3eCdjSKWxSjVLP+5d/Cwe9Yxq2zmMtRob9Tv93oRp3HaH6tZ5i16
	ukYJT4J4ZbqiGf1rxYfE6mGNsMjdH2S5bQ8LSW7shbBcgXXhZamvvgtv2dK6EnG0os4WVHXKCy2
	wbTwNlKMZeBxPnT5zPYv5ao0zs/ON/SSXd9SsySXuv+WyJ/0HWjgt1zV+rvxHTjHHE78Dpqou5g
	KvphtqOdigNhtVorvwm9lo+DjT9NjcOqhN0SRqDgN8vsgFfhNT5nuhDCHWoFzyFiww8hkOCqkJ9
	8tzjMeOktBmRcHicE5jcFrR8r73aFhMtcQsM8My5ZrvyjtvhrJlEVaTn6CFwwLpFHYDyATukHcT
	kS78uGa/wNCzORBZ1VZ7YP
X-Google-Smtp-Source: AGHT+IFv850C8awUZtGHTOiLNICfiiJUYFGeJOYwfQRd2+Nt5FLiP4oGJKVYYX9fX1k/MFpwo7/ZRA==
X-Received: by 2002:a05:600c:1ca4:b0:45d:f83b:96aa with SMTP id 5b1f17b1804b1-477c10c92d8mr469875015e9.7.1764607305455;
        Mon, 01 Dec 2025 08:41:45 -0800 (PST)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4791164d4f3sm255901275e9.13.2025.12.01.08.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 08:41:45 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Mon, 01 Dec 2025 16:41:05 +0000
Subject: [PATCH 2/7] perf tools: apply evsel__set_config_if_unset() to all
 config fields
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251201-james-perf-config-bits-v1-2-22ecbbf8007c@linaro.org>
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
 tools/perf/util/pmu.c | 60 +++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 44 insertions(+), 16 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 7a7db31be70d..c8968cddc0a9 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/list.h>
+#include <linux/bitfield.h>
 #include <linux/compiler.h>
 #include <linux/string.h>
 #include <linux/zalloc.h>
@@ -1371,6 +1372,18 @@ bool evsel__is_aux_event(const struct evsel *evsel)
 	return pmu && pmu->auxtrace;
 }
 
+static struct perf_pmu_format *
+pmu_find_format(const struct list_head *formats, const char *name)
+{
+	struct perf_pmu_format *format;
+
+	list_for_each_entry(format, formats, list)
+		if (!strcmp(format->name, name))
+			return format;
+
+	return NULL;
+}
+
 /*
  * Set @config_name to @val as long as the user hasn't already set or cleared it
  * by passing a config term on the command line.
@@ -1379,12 +1392,39 @@ bool evsel__is_aux_event(const struct evsel *evsel)
  * the bit pattern. It is shifted into position by this function, so to set
  * something to true, pass 1 for val rather than a pre shifted value.
  */
-#define field_prep(_mask, _val) (((_val) << (ffsll(_mask) - 1)) & (_mask))
 void evsel__set_config_if_unset(struct perf_pmu *pmu, struct evsel *evsel,
 				const char *config_name, u64 val)
 {
 	u64 user_bits = 0, bits;
-	struct evsel_config_term *term = evsel__get_config_term(evsel, USR_CHG_CONFIG);
+	struct evsel_config_term *term;
+	struct perf_pmu_format *format = pmu_find_format(&pmu->format, config_name);
+	__u64 *vp;
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
@@ -1396,20 +1436,8 @@ void evsel__set_config_if_unset(struct perf_pmu *pmu, struct evsel *evsel,
 		return;
 
 	/* Otherwise replace it */
-	evsel->core.attr.config &= ~bits;
-	evsel->core.attr.config |= field_prep(bits, val);
-}
-
-static struct perf_pmu_format *
-pmu_find_format(const struct list_head *formats, const char *name)
-{
-	struct perf_pmu_format *format;
-
-	list_for_each_entry(format, formats, list)
-		if (!strcmp(format->name, name))
-			return format;
-
-	return NULL;
+	*vp &= ~bits;
+	*vp |= FIELD_PREP(bits, val);
 }
 
 __u64 perf_pmu__format_bits(struct perf_pmu *pmu, const char *name)

-- 
2.34.1

