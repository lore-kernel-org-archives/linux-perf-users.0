Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFD7309DB1
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Dec 2025 16:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764607316; cv=none; b=qwKSLRTEcMMIHSE5PNR3QoiVj/KTDGMWaVs/Z72/H6W5zK4gI4PZsmBu/hDRO2Z/22giESKKt8eCwhKXc7nIUR1VrO5nNa2ja5Ps+ae0Pa1nI97DBvWTDL1Ix3t4tJ2iS3wFeUYRaIXQwszdnWQRhUnfaoaUQ9Zrdo1fNpHqyD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764607316; c=relaxed/simple;
	bh=6J8uBrrUyjtu+YlsylOUKYoPIhBIrTUDwfva8KvLpCk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M10Am8WEhtSuNJNx89pvWHKCGqPPwsedNFxJADtY5SUwUEdBP5t6188qHdZfLx2qFQLbr508UTGYZ8LFxE4KLSa0UIyVLBnl7X/ptq0O47bn0XCVsj9k3w6ANHLxndF5hOx7WPbsvDMDuMpFGYd6rV5kH0lYwHInIYS/bcg9L7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=k57PuznO; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k57PuznO"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4779ce2a624so44500565e9.2
        for <linux-perf-users@vger.kernel.org>; Mon, 01 Dec 2025 08:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764607312; x=1765212112; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cKUhf7S/zq7XInwoT4BCbYa77L5aJsIA3yCxD0J3mf4=;
        b=k57PuznOjxo1un4C2tM7GWkMOMnvBu9S/MU8YqX4u/YT6NBAdh6um5Z/qiwsKgJts8
         YrxhnMui7s3IOFCm894wbyqMr28h5FcEJbMyojo+AMMdFWx2Cnsy8/HlnBdXrwwxsKPM
         QGIQQ67OFYWEAqilowIdv0gDGTNYwiq8OJDIJDPH+RBP0GX4gY1KuKcUFxWC+pA0ybaZ
         wl+D9TvYkBYbLLVclZhBeaPoeZPu4IVUPN7XRBaUDK4J7PrgzZ0r4+WUwa8i3IBoKOtB
         TL6oWbCeHrEO4u9kdq/5EyM3F+mpOarZD3lA4amunBBsfrmzRpcqeBTBkog00igAJcg+
         +wPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764607312; x=1765212112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cKUhf7S/zq7XInwoT4BCbYa77L5aJsIA3yCxD0J3mf4=;
        b=Nhh22oKLE1kudIM1bhghFOXWb0NVDCIaW46quGb+oegjAVS4EZOQwOlJEtWYmw1OBG
         8Ibzo+2NYfaJB8uqGvOMXq5FeqbOmR9zcZZqgyRrq4IxeJEoPRExrnf8/suBFZQ43Vb5
         nTOI+yfy+RsmD8bHyzQOu1y/y8tXa8tjDzuqimBEkAeIA2WSG1Datn3I+Khj+FZ+dq/T
         2bcu7iOZ9zxAzOpUrvPXoc8O1uK8BRS3wivzlF943InZP6Egkl2/HtFUMzRdc8x261B9
         BJcPYXCuFJYORwixDiqxWf4IrsKl+3ZX9t9073DEfBUmvz/Q9zrwafx5d85w8wA4GVhz
         MfRA==
X-Gm-Message-State: AOJu0YzGlT2o62HwhIIv2CdwgE/PRjoQCpncRHXVBJPvzm5zDqVzK48Y
	VADta40OADlxzgGCKZ/i9dOXZ5VIspWQK6M6V/ob6MvtPuD6Hs3XJLQWfrANwNJuwUs=
X-Gm-Gg: ASbGncsu0g7M6Tz12UEyvbQdV8nl3FrZ6/nyUSyXcwqH93AMQdGeydf6Y6kGN4IAYHw
	H3ythyu56tH/CuHABp4C6jZjeJP93NAN3/hskIpVQ4IUPMVLxuZDaCfR129o63L+Mf981cHrH/o
	B/Yjz3HfW25H52RjHlcU234ARcXn+sZVXyKrrn9FRMKuDCevB5qi+NKPVoGH8hsb5Z2xD58lGmN
	2NFJOXJtBdEzhOElgHS7oJjziS6NzYtgRa8B8TXkPpopbaF7pUIoAH7g7wL86YSnuVChK+cymog
	MTCUoknpFJKe62yQOg/IMRQowRP7AAMlr+iNXh4W4nS+kZIgntYTNnHn89/cdi0EVzR7PjAh5AK
	vw30OZ7dVvzDR71BM4awMgnWkhIrTiIcl6jBvufbrR9el4U+C4QGOQRviqZ5xfrYcXUaMG48Tf8
	8LM5F2F6eFdYcUTGJhReCA
X-Google-Smtp-Source: AGHT+IEY4wsnu5t7RxRAb+lDOwrk2bVHKf8Daq/FFegD/RxGqBitL9q7Mn4TMWImABd/xtV4q+gq4A==
X-Received: by 2002:a05:600c:19ce:b0:477:79c7:8994 with SMTP id 5b1f17b1804b1-47904b25e63mr271343655e9.30.1764607311924;
        Mon, 01 Dec 2025 08:41:51 -0800 (PST)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4791164d4f3sm255901275e9.13.2025.12.01.08.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 08:41:50 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Mon, 01 Dec 2025 16:41:09 +0000
Subject: [PATCH 6/7] perf cs-etm: Don't hard code config attribute when
 configuring the event
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251201-james-perf-config-bits-v1-6-22ecbbf8007c@linaro.org>
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

These instances of hard coded config attributes are used for configuring
and validating the event options. Use the config attribute that's
published by the driver by replacing the open coded operations with
evsel__get_config_val() and evsel__set_config_if_unset().

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/arch/arm/util/cs-etm.c | 66 ++++++++++++++++++++++-----------------
 1 file changed, 37 insertions(+), 29 deletions(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index 51ca8fa66ef8..52e304584095 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -103,13 +103,20 @@ static int cs_etm_validate_context_id(struct perf_pmu *cs_etm_pmu, struct evsel
 				      struct perf_cpu cpu)
 {
 	int err;
-	__u64 val;
-	u64 contextid = evsel->core.attr.config &
-		(perf_pmu__format_bits(cs_etm_pmu, "contextid") |
-		 perf_pmu__format_bits(cs_etm_pmu, "contextid1") |
-		 perf_pmu__format_bits(cs_etm_pmu, "contextid2"));
+	u64 ctxt, ctxt1, ctxt2;
+	__u64 trcidr2;
 
-	if (!contextid)
+	err = evsel__get_config_val(cs_etm_pmu, evsel, "contextid", &ctxt);
+	if (err)
+		return err;
+	err = evsel__get_config_val(cs_etm_pmu, evsel, "contextid1", &ctxt1);
+	if (err)
+		return err;
+	err = evsel__get_config_val(cs_etm_pmu, evsel, "contextid2", &ctxt2);
+	if (err)
+		return err;
+
+	if (!ctxt && !ctxt1 && !ctxt2)
 		return 0;
 
 	/* Not supported in etmv3 */
@@ -120,12 +127,11 @@ static int cs_etm_validate_context_id(struct perf_pmu *cs_etm_pmu, struct evsel
 	}
 
 	/* Get a handle on TRCIDR2 */
-	err = cs_etm_get_ro(cs_etm_pmu, cpu, metadata_etmv4_ro[CS_ETMV4_TRCIDR2], &val);
+	err = cs_etm_get_ro(cs_etm_pmu, cpu, metadata_etmv4_ro[CS_ETMV4_TRCIDR2], &trcidr2);
 	if (err)
 		return err;
 
-	if (contextid &
-	    perf_pmu__format_bits(cs_etm_pmu, "contextid1")) {
+	if (ctxt1) {
 		/*
 		 * TRCIDR2.CIDSIZE, bit [9-5], indicates whether contextID
 		 * tracing is supported:
@@ -133,15 +139,14 @@ static int cs_etm_validate_context_id(struct perf_pmu *cs_etm_pmu, struct evsel
 		 *  0b00100 Maximum of 32-bit Context ID size.
 		 *  All other values are reserved.
 		 */
-		if (BMVAL(val, 5, 9) != 0x4) {
+		if (BMVAL(trcidr2, 5, 9) != 0x4) {
 			pr_err("%s: CONTEXTIDR_EL1 isn't supported, disable with %s/contextid1=0/\n",
 			       CORESIGHT_ETM_PMU_NAME, CORESIGHT_ETM_PMU_NAME);
 			return -EINVAL;
 		}
 	}
 
-	if (contextid &
-	    perf_pmu__format_bits(cs_etm_pmu, "contextid2")) {
+	if (ctxt2) {
 		/*
 		 * TRCIDR2.VMIDOPT[30:29] != 0 and
 		 * TRCIDR2.VMIDSIZE[14:10] == 0b00100 (32bit virtual contextid)
@@ -149,7 +154,7 @@ static int cs_etm_validate_context_id(struct perf_pmu *cs_etm_pmu, struct evsel
 		 * virtual context id is < 32bit.
 		 * Any value of VMIDSIZE >= 4 (i.e, > 32bit) is fine for us.
 		 */
-		if (!BMVAL(val, 29, 30) || BMVAL(val, 10, 14) < 4) {
+		if (!BMVAL(trcidr2, 29, 30) || BMVAL(trcidr2, 10, 14) < 4) {
 			pr_err("%s: CONTEXTIDR_EL2 isn't supported, disable with %s/contextid2=0/\n",
 			       CORESIGHT_ETM_PMU_NAME, CORESIGHT_ETM_PMU_NAME);
 			return -EINVAL;
@@ -163,10 +168,14 @@ static int cs_etm_validate_timestamp(struct perf_pmu *cs_etm_pmu, struct evsel *
 				     struct perf_cpu cpu)
 {
 	int err;
-	__u64 val;
+	u64 val;
+	__u64 trcidr0;
 
-	if (!(evsel->core.attr.config &
-	      perf_pmu__format_bits(cs_etm_pmu, "timestamp")))
+	err = evsel__get_config_val(cs_etm_pmu, evsel, "timestamp", &val);
+	if (err)
+		return err;
+
+	if (!val)
 		return 0;
 
 	if (cs_etm_get_version(cs_etm_pmu, cpu) == CS_ETMV3) {
@@ -176,7 +185,7 @@ static int cs_etm_validate_timestamp(struct perf_pmu *cs_etm_pmu, struct evsel *
 	}
 
 	/* Get a handle on TRCIRD0 */
-	err = cs_etm_get_ro(cs_etm_pmu, cpu, metadata_etmv4_ro[CS_ETMV4_TRCIDR0], &val);
+	err = cs_etm_get_ro(cs_etm_pmu, cpu, metadata_etmv4_ro[CS_ETMV4_TRCIDR0], &trcidr0);
 	if (err)
 		return err;
 
@@ -187,10 +196,9 @@ static int cs_etm_validate_timestamp(struct perf_pmu *cs_etm_pmu, struct evsel *
 	 *  0b00110 Implementation supports a maximum timestamp of 48bits.
 	 *  0b01000 Implementation supports a maximum timestamp of 64bits.
 	 */
-	val &= GENMASK(28, 24);
-	if (!val) {
+	trcidr0 &= GENMASK(28, 24);
+	if (!trcidr0)
 		return -EINVAL;
-	}
 
 	return 0;
 }
@@ -273,16 +281,20 @@ static int cs_etm_parse_snapshot_options(struct auxtrace_record *itr,
 	return 0;
 }
 
+/*
+ * The sink name format "@sink_name" is used, lookup the sink by name to convert
+ * to "sinkid=sink_hash" format.
+ *
+ * If the user has already manually provided a hash then "sinkid" isn't
+ * overwritten. If neither are provided then the driver will pick the best sink.
+ */
 static int cs_etm_set_sink_attr(struct perf_pmu *pmu,
 				struct evsel *evsel)
 {
 	char msg[BUFSIZ], path[PATH_MAX], *sink;
 	struct evsel_config_term *term;
-	int ret = -EINVAL;
 	u32 hash;
-
-	if (evsel->core.attr.config2 & GENMASK(31, 0))
-		return 0;
+	int ret;
 
 	list_for_each_entry(term, &evsel->config_terms, list) {
 		if (term->type != EVSEL__CONFIG_TERM_DRV_CFG)
@@ -305,14 +317,10 @@ static int cs_etm_set_sink_attr(struct perf_pmu *pmu,
 			return ret;
 		}
 
-		evsel->core.attr.config2 |= hash;
+		evsel__set_config_if_unset(pmu, evsel, "sinkid", hash);
 		return 0;
 	}
 
-	/*
-	 * No sink was provided on the command line - allow the CoreSight
-	 * system to look for a default
-	 */
 	return 0;
 }
 

-- 
2.34.1

