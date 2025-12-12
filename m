Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BC63246EA
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Dec 2025 15:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765553589; cv=none; b=oYk122T+Lj94ltmy8s02JzxlsMdqH5jy9W3m9H2S8vU5uIbA2WuRSIAU+PD2u8ZALyLRsuWvrT3D3G3mznPXXVLh0X3HiLem6d6P2SGTawUM2SlKoT8myeIwczayYdSnHd+dCu4lb8sAuDflBqMx6ue5gGOC+vo1jAT/bsGgIfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765553589; c=relaxed/simple;
	bh=+yrQI73Lj/6kyvMP4ZVVuHkJzhmrKrpf7NHGZLhRzg8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Bc6xFXRT1TUZtoXOtJwgbvseKP8IXYiNtpod6SE6aYOoIsGEV6vBgCVWevobgNpHy/4MSKkmbUIFGpq5IWCeY66dC6gVqwucfAUDNUBsnNxtbYLChE36jnWINutIUmKNzLgjhZ6wus/XGXyrpEEC1U7ZOUpcba7oOKBbjlzQc7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=W1ZbJUyw; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W1ZbJUyw"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b735487129fso233655966b.0
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Dec 2025 07:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765553585; x=1766158385; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HW9vySL1eLI2H1Kn0+dJzMzzH5Eo6siVgDQRHUDflG4=;
        b=W1ZbJUywGGe6XrUe9xd1F17131VuF0RZK5XaCYtcbgsh9MC2xCc6wYhjB17KFyTXV+
         lfVhQs4On/P2uoWVOgX6smZuoi89gPl74L0REB5lM0dpHBSJEfRUxGr9/3FdFUEkwqLG
         8X3KQUQcym5nViTwEN7JPFiPFkdlrFgp5/n1cSlBkvRKuIyvGhvueVTllQfCyzY8nGWr
         7k1y+2ibzQcEz4nBqNYrjT1Eu9QCQ2HOHkaF67N87RFk6YvNSMrlk8se1BogOE2iyRwi
         QMVSPJH4yLF1kmg+0JLLT/gXwMIyowK2RHbooESqTH1iOOpYIdMvh01e6Fe9psRye6vC
         pF+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765553585; x=1766158385;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HW9vySL1eLI2H1Kn0+dJzMzzH5Eo6siVgDQRHUDflG4=;
        b=DQc88l64JtsPSsg2oMvWJvvVPilAJ1+bx0KHXaar6J06lyzCMSCVe51v8wjDg03K76
         pE9K7vl0gfxF8FD0arsQSUOCH3reGLnD3LCmMuNGxobLKfwSPq4uTHjnklT2Lm/uqpAY
         bvl9MTKA6/ksDj3ICdx6X+NKGPXkCSp/Sa8rkCGwB8D5dyp4Yefn9iSaxwgH27l+P9O0
         O1B9gxezy+4TUnmulWagXf6yf7aNafO5qFNaqrMUMGPn1NBGn4hybVkGOphN3zV6JtUW
         HZimBoiDObs9fa5Xudy6eycLOQpnweKdjG/7N1v7Huj350F8EuIypgpnX8U3RlFDbGLg
         u3kA==
X-Gm-Message-State: AOJu0YwPrvIGZOIjpojuQ01ZDfY1AWKCkPUL8z9KkzuJdjAJV7bgZPe9
	sYhDKP7XR5YmfShRkmt9VZRKEQP8UoEMZQyHjpd2p0brJnIGtO0/NxPL62ueTFfJ/h4=
X-Gm-Gg: AY/fxX6wl2VMfDjN0mR0FeusJp8Cm5UBNiXgEj/+GAusnvp3UOpXAhl9tz+73IIX4Dm
	LmvEz0WNtES9sNDPN58wetaYKHX/9jt14Ro9Jz2TUiPHOlveF59fMXGlykxZd8R3PnLvNE7OeaC
	mn0PBa9o4dWKpLsSaOuFklxvFqsyabS7RQkh9rUVJKAa9s/mvibrJBuNCFEhQnkNCcrSEkinMKG
	0OMArmV04eykMtmCzAPTo8VuagKamaQqxw6LT3sR2INgNbdbqcBEFvZjf0ZUXHjB9lGDcJpVoRZ
	vwA57RoqEzW1KWv1lShyLWosYSOWUYpON+DvL8b3VAeKKbq0s1MchdWmiYbrp+ZkrLXBukJFjZo
	WjSpBR4WHyVkDl8cr3ZeTO/FEnChsDAeVXc4rb8ZB+flJHHfAXYn7zkw45EzkacNs7Ts4T1FgGL
	vm1kTk3hJ+zkpzIPuUcjlD
X-Google-Smtp-Source: AGHT+IFzKlUxyQ53WXrw5hS/OfPtHid1213GH5FkblCTWns2qdDPxDDyZ/WVIFJPhZGFwV5zxjVgZA==
X-Received: by 2002:a17:907:d22:b0:b76:b76e:112a with SMTP id a640c23a62f3a-b7d235c7f18mr229365366b.11.1765553584541;
        Fri, 12 Dec 2025 07:33:04 -0800 (PST)
Received: from e133063.arm.com ([130.185.218.160])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6498210ed32sm5433234a12.29.2025.12.12.07.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 07:33:04 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Fri, 12 Dec 2025 17:32:28 +0200
Subject: [PATCH v3 11/12] perf cs-etm: Don't hard code config attribute
 when configuring the event
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251212-james-perf-config-bits-v3-11-aa36a4846776@linaro.org>
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

These instances of hard coded config attributes are used for configuring
and validating the event options. Use the config attribute that's
published by the driver by replacing the open coded operations with
evsel__get_config_val() and evsel__set_config_if_unset().

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/arch/arm/util/cs-etm.c | 57 +++++++++++++++++++--------------------
 1 file changed, 28 insertions(+), 29 deletions(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index 4a606b1e90f227aef9915e90439b2a024eeabcfe..bfb573cb587893b7d91b92fed4c61f421392fbcf 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -103,13 +103,14 @@ static int cs_etm_validate_context_id(struct perf_pmu *cs_etm_pmu, struct evsel
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
+	evsel__get_config_val(cs_etm_pmu, evsel, "contextid", &ctxt);
+	evsel__get_config_val(cs_etm_pmu, evsel, "contextid1", &ctxt1);
+	evsel__get_config_val(cs_etm_pmu, evsel, "contextid2", &ctxt2);
+
+	if (!ctxt && !ctxt1 && !ctxt2)
 		return 0;
 
 	/* Not supported in etmv3 */
@@ -120,12 +121,11 @@ static int cs_etm_validate_context_id(struct perf_pmu *cs_etm_pmu, struct evsel
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
@@ -133,15 +133,14 @@ static int cs_etm_validate_context_id(struct perf_pmu *cs_etm_pmu, struct evsel
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
@@ -149,7 +148,7 @@ static int cs_etm_validate_context_id(struct perf_pmu *cs_etm_pmu, struct evsel
 		 * virtual context id is < 32bit.
 		 * Any value of VMIDSIZE >= 4 (i.e, > 32bit) is fine for us.
 		 */
-		if (!BMVAL(val, 29, 30) || BMVAL(val, 10, 14) < 4) {
+		if (!BMVAL(trcidr2, 29, 30) || BMVAL(trcidr2, 10, 14) < 4) {
 			pr_err("%s: CONTEXTIDR_EL2 isn't supported, disable with %s/contextid2=0/\n",
 			       CORESIGHT_ETM_PMU_NAME, CORESIGHT_ETM_PMU_NAME);
 			return -EINVAL;
@@ -163,10 +162,11 @@ static int cs_etm_validate_timestamp(struct perf_pmu *cs_etm_pmu, struct evsel *
 				     struct perf_cpu cpu)
 {
 	int err;
-	__u64 val;
+	u64 val;
+	__u64 trcidr0;
 
-	if (!(evsel->core.attr.config &
-	      perf_pmu__format_bits(cs_etm_pmu, "timestamp")))
+	evsel__get_config_val(cs_etm_pmu, evsel, "timestamp", &val);
+	if (!val)
 		return 0;
 
 	if (cs_etm_get_version(cs_etm_pmu, cpu) == CS_ETMV3) {
@@ -176,7 +176,7 @@ static int cs_etm_validate_timestamp(struct perf_pmu *cs_etm_pmu, struct evsel *
 	}
 
 	/* Get a handle on TRCIRD0 */
-	err = cs_etm_get_ro(cs_etm_pmu, cpu, metadata_etmv4_ro[CS_ETMV4_TRCIDR0], &val);
+	err = cs_etm_get_ro(cs_etm_pmu, cpu, metadata_etmv4_ro[CS_ETMV4_TRCIDR0], &trcidr0);
 	if (err)
 		return err;
 
@@ -187,10 +187,9 @@ static int cs_etm_validate_timestamp(struct perf_pmu *cs_etm_pmu, struct evsel *
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
@@ -273,16 +272,20 @@ static int cs_etm_parse_snapshot_options(struct auxtrace_record *itr,
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
@@ -305,14 +308,10 @@ static int cs_etm_set_sink_attr(struct perf_pmu *pmu,
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

