Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357FE3A0EAB
	for <linux-perf-users@vger.kernel.org>; Wed, 14 Jan 2026 15:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768406268; cv=none; b=qPRjcJ040v5bMwuUliYs30QBSsX4mB7OfWHq0m1ScHYrrE8K94sMgWGhiJCuk+RYsZ0Wwewq88lI75igTLsRIXlKQPLhBAW2eirJleFqhvM1bz3ngJStmiuSGd4wZ5cioTo8evXqbPofS1fm3axZw19TA8KZO54BghLP/Q4fySg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768406268; c=relaxed/simple;
	bh=Jc9rERJ1aa9uPXcRf+vQny2CNy2GLYq2wwN414Q1Kbg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j4BZqyDT9iLli32INtWqWhP1cHx9mI9kZ7E/4RySgvyx4VwMAzCfqIGWmMoHgJ+wgS6HGsdBI6JLE6K6QrxeiaHJNxRbzCFkCYmVLMEpjTMmmrLB4SKy/Fn3DQ/OTFLI/h75IU4jvEH7quJM60JIfB9bX0GUVCNNVop/w2SCqFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eMC5/24I; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eMC5/24I"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-477a219dbcaso70914345e9.3
        for <linux-perf-users@vger.kernel.org>; Wed, 14 Jan 2026 07:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768406260; x=1769011060; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LcmTvJXahQwVxWMEArSL10u6PwPhpeVpWDjIQEb7L7Y=;
        b=eMC5/24IPLgkx2naGfSnFmSutQm++zPrhXK8FQixGb3jfWiRvQ3aX4SAbaLJsQq61h
         EjKovDZ6J7RV7z1YtK9XxcS1N7z8uXUH9p5j27WFkHNzLgheYFBaeZOVCruMTYDfPqFQ
         idiUzlxq6nuDiYts8Sw0u9pOP0eQMdZpAdSU5KxXZy2bs5Lmlw2vJcbvSdoymxQj4G7s
         QSg051wbrDtLmI/OZd6jwSbZvSmjFuOjYUW5b9nYNGBeo36d3KlYt2k6QlX9Cg/0gGys
         0v65/V+fDd1Mr3T8COAoMFpkg/OLoV1agoEgg8rQ3MJ48e1ErruIXf2dgKRcztsjTdVF
         cJiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768406260; x=1769011060;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LcmTvJXahQwVxWMEArSL10u6PwPhpeVpWDjIQEb7L7Y=;
        b=Robo8NJTyxsSsoL5pk94+iVbuNB5HMglkZ8HDOI/EqLsoPrejONnG+t6p/u17huu+5
         yLMILOdA6uS0Mf0Pic7tmxvxqIqBj87Jpeq247s543LKbuMwex60MxGatnMycdYocNmW
         mevTWxhzxx5+QiMtdXBRpxyzJFnxDNWEsSqf1GYqjQPjiOTdX6r38+H6rySBZ05TOJL1
         5y6tcsfxXNpfYTRyU2kDjQR4hcLqTca7jFwJOuJTesUI8JtlZIfhXaWwat3pBtV7EUnN
         d8QxQse4hf+JOccQWsxD5+DnSIo5q2mFrbkagyaI1Q+eWXkt/XjJtOx05FA7MaknwrZd
         ZpkA==
X-Gm-Message-State: AOJu0YykLPY6tIrAHL8jiEi20OVFxdbc5GXBRfQADnvJOSXtNxNmzsvs
	Dz0e+/Cggt72W5/4SO35YGz4RkWDIbKlzGuxthH7qzurZcdk4SJsk6FqF8knO10qlE0=
X-Gm-Gg: AY/fxX7HMSBYdOyJRpQ5by8Vr86His/v9nV1TUEWTft896AlBc/Ru2+dNsVAMBCSaLw
	ERLrUlwSWKS/bejodZAuK5DPr8s4VleJmS2YLGFWC9RcJBumlB1q55/hZAyVhcXcghdKLzOwT7v
	etTy+d5Y0kLpq2O17JoCpDESIYF22x92fOz0SnBk84PFE6OomX7WepvRagjdY8S0/N6MpbU6yKx
	Ts9FBt9j/U5KykSeJn15l2/UUpkUedO1xPkn6Fy6aAR3G9CjFUxNVJkQpMLV6Ax3R1FpCmVbUv5
	pFZnwMtjgnpcfRGhgqMakzxmHWCYbcQ88C7w0oiqGD0ENQLOvF1wVZnZFb6IRpNF/z4ChTXC4u4
	FhZp1k5wDPpqEwiLQD1zzC5FFSKnnzA1BtGDt3UR2F8xqxll7Ej7V90YUk/7trbOWZHwRN3uilj
	gH/fJqKessW/wcqR3EIgt3
X-Received: by 2002:a05:600c:81c5:b0:477:755b:5587 with SMTP id 5b1f17b1804b1-47ee47bbe97mr31174885e9.8.1768406260536;
        Wed, 14 Jan 2026 07:57:40 -0800 (PST)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47ee85e8807sm7426475e9.16.2026.01.14.07.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 07:57:40 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Wed, 14 Jan 2026 15:57:15 +0000
Subject: [PATCH v5 03/14] perf evsel: Move evsel__* functions to evsel.c
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260114-james-perf-config-bits-v5-3-0ef97aaf1ac0@linaro.org>
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

At least one of these were put here to avoid a Python binding linking
issue which is no longer present. Put them back in their correct
location to avoid confusion about which file to add a new evsel__*
function to later.

Link: https://lore.kernel.org/all/ZEbAS2yx2fguW60w@kernel.org/
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/evsel.c | 40 ++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/pmu.c   | 40 ----------------------------------------
 2 files changed, 40 insertions(+), 40 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index ec6552a6f667..21878e9bd029 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1314,6 +1314,35 @@ struct evsel_config_term *__evsel__get_config_term(struct evsel *evsel, enum evs
 	return found_term;
 }
 
+/*
+ * Set @config_name to @val as long as the user hasn't already set or cleared it
+ * by passing a config term on the command line.
+ *
+ * @val is the value to put into the bits specified by @config_name rather than
+ * the bit pattern. It is shifted into position by this function, so to set
+ * something to true, pass 1 for val rather than a pre shifted value.
+ */
+#define field_prep(_mask, _val) (((_val) << (ffsll(_mask) - 1)) & (_mask))
+void evsel__set_config_if_unset(struct evsel *evsel, const char *config_name,
+				u64 val)
+{
+	u64 user_bits = 0, bits;
+	struct evsel_config_term *term = evsel__get_config_term(evsel, CFG_CHG);
+
+	if (term)
+		user_bits = term->val.cfg_chg;
+
+	bits = perf_pmu__format_bits(evsel->pmu, config_name);
+
+	/* Do nothing if the user changed the value */
+	if (bits & user_bits)
+		return;
+
+	/* Otherwise replace it */
+	evsel->core.attr.config &= ~bits;
+	evsel->core.attr.config |= field_prep(bits, val);
+}
+
 void __weak arch_evsel__set_sample_weight(struct evsel *evsel)
 {
 	evsel__set_sample_bit(evsel, WEIGHT);
@@ -4098,6 +4127,17 @@ void evsel__set_leader(struct evsel *evsel, struct evsel *leader)
 	evsel->core.leader = &leader->core;
 }
 
+bool evsel__is_aux_event(const struct evsel *evsel)
+{
+	struct perf_pmu *pmu;
+
+	if (evsel->needs_auxtrace_mmap)
+		return true;
+
+	pmu = evsel__find_pmu(evsel);
+	return pmu && pmu->auxtrace;
+}
+
 int evsel__source_count(const struct evsel *evsel)
 {
 	struct evsel *pos;
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index e87c12946d71..e3a1f26213ec 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1362,46 +1362,6 @@ void perf_pmu__warn_invalid_formats(struct perf_pmu *pmu)
 	}
 }
 
-bool evsel__is_aux_event(const struct evsel *evsel)
-{
-	struct perf_pmu *pmu;
-
-	if (evsel->needs_auxtrace_mmap)
-		return true;
-
-	pmu = evsel__find_pmu(evsel);
-	return pmu && pmu->auxtrace;
-}
-
-/*
- * Set @config_name to @val as long as the user hasn't already set or cleared it
- * by passing a config term on the command line.
- *
- * @val is the value to put into the bits specified by @config_name rather than
- * the bit pattern. It is shifted into position by this function, so to set
- * something to true, pass 1 for val rather than a pre shifted value.
- */
-#define field_prep(_mask, _val) (((_val) << (ffsll(_mask) - 1)) & (_mask))
-void evsel__set_config_if_unset(struct evsel *evsel, const char *config_name,
-				u64 val)
-{
-	u64 user_bits = 0, bits;
-	struct evsel_config_term *term = evsel__get_config_term(evsel, CFG_CHG);
-
-	if (term)
-		user_bits = term->val.cfg_chg;
-
-	bits = perf_pmu__format_bits(evsel->pmu, config_name);
-
-	/* Do nothing if the user changed the value */
-	if (bits & user_bits)
-		return;
-
-	/* Otherwise replace it */
-	evsel->core.attr.config &= ~bits;
-	evsel->core.attr.config |= field_prep(bits, val);
-}
-
 static struct perf_pmu_format *
 pmu_find_format(const struct list_head *formats, const char *name)
 {

-- 
2.34.1

