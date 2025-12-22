Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BFD32D0FE
	for <linux-perf-users@vger.kernel.org>; Mon, 22 Dec 2025 15:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766416505; cv=none; b=eTdnYZmQchA7yEJJOqbewOHHHQIgro3DPBucsuRGLaUMOqEzT1NigwY4f1dN0bjecdiu/wtU4fgI29HQPDdH5Gnoe2wIPaAXTOvhJYPKkk3/64PgtjK6Mjr7ZqybQ+Z8HQow80rMm1YENxM/52QgS1PuplcCke5t4zDXiOXYZBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766416505; c=relaxed/simple;
	bh=h3UUZ+MTt/jVXlppiWB5dfmCDIA0ulaZv1PvNfguK3Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Bjp46feDgf+yExRMJt1Zg8hlvptObqARm99UL9MJZEQGSeyzC96tllDgoQQIpJEtzy6KIXFvn4uvD17ihfGal7RfKbdLr3ZzpKCqsvJz2b4qiJ9J19qx5sMYMwR9XLA7JCQDuBrVrCQHo9AtH0EetGn/QBPFgC7YACU7Mq6+zxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MzBFVU05; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MzBFVU05"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-42fbbc3df8fso2050819f8f.2
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Dec 2025 07:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1766416501; x=1767021301; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NZnllZdyzmPDgDLg3NsetnXCFaQjqpO0nxPQg2XzMvs=;
        b=MzBFVU05D6D/g+Q83JgxRQ0ZOKgR9Je37QeEw4PHGd1yheqHuOZ9BkGD4BB4/UlMio
         GPj1Zz91Q5WyAWFRbjsiKcy8GXUt0/fYniGe4t1a1wAEi0ydpFSZnEcma8Q7Oy5povay
         57Ky//7qEgDjqyrrAIzAH3Z0StsYMonk9sRUTuf8BQRVUhm2r8L9UUtCbDP7d0Mu72Lq
         fBiWwmjN4yecf9aP+n0n7iD9vv+1OGxcjT8NAjv331X9PFPMd3ve1TJ4pjEhJilRayI4
         nG0f6Fy1IGA+bUD1sPZstB/BKGQEYbYizemd9Z4ptM+ZLAVNpPkki8/MN+uJuLbPr3Jj
         kn7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766416501; x=1767021301;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NZnllZdyzmPDgDLg3NsetnXCFaQjqpO0nxPQg2XzMvs=;
        b=jVAO2462XgOQR38f2KPBGTq5LKnZ0zIb3I13Wqit77a6Jp6kOsyqoLuq79dFcKH9x7
         VnWZjRq6RZmWalyuiWXLn+aUaZeuDS3WKDJsTS7SAmgMGEFUygXEFTLNqFP41fkdPSvC
         Vx38JzVBdQIjrIZDa5wl8NWiVxJN8r7R9DLsHJnQq0C5t6i7aEoKh1z+vEZRP/16fbDD
         KnLmpBYtKjbKUmvjLEtL/OEourHvGa0tW2+r0NCBIVCIr2gVFUUpgAFArQnvzqRTI0Sy
         eq3aN+Ct63gK9LjaGB45Y4zcCgYWMOwCRL1f48jE1jSEgc73VXqZQT6YVidWFuHQvfEk
         26IA==
X-Gm-Message-State: AOJu0Yzfmgirc4EwPosY84o2d4nf5fHGdRI3+oGWUfaTjOHNdKLjkSQG
	fuogDZq2w05SpS2Bs8t+AUwIA6jzNgypzvtKNMttNitIAUt1Y58aY+iHG3qmKr4CIvw=
X-Gm-Gg: AY/fxX47uue4FStL+Xdovsi2B8Pu/mEREE3un7KJGHKksfRGZQK5WP4W+G7xVTNRMkb
	nIPk/l9YPMzsDMCmTxa0P6qzDcn2DkakaF1cVWhuS5mXLYk+vGwZgwJDcax7jo416hLnCB2/6d2
	rAZw1USnZtEzKA9Z9G5mKS0wiP7+CKWIdg+uDCS+Peu0qWpEV4vsLqIc5tvjCu93fx1kMk9uZG9
	hdTLkAFKzRPGEPtLGPiNOF7ytkRPy7qGcdvXzEy19GQsb4I1hnrIK6J1N2cb+X+Q9bS6CiFCCUK
	cfpA5HICUms8wGSMP8FFw07PT6OAYS8fpBzzp61FSi99K/JwdFivaFvs7BW2V53mZ6GXTjUX/kZ
	gVyvtiQd/7Nvr3LqamXyB4RnWKDszW6+MlvhVxNdDvsOejU9cCC3irDAK2kFKfrtglKGzX3w4IF
	hLh83YKwwzUzoFefXdKl/o
X-Google-Smtp-Source: AGHT+IGJQxCV50ScDAMUPbUoVuouEnRfEx1ZAS/DBqZ58QgrzRh+YFP0A0+P2e7M/HVXKXG4s2eScA==
X-Received: by 2002:a05:6000:144f:b0:430:feb3:f5bb with SMTP id ffacd0b85a97d-4324e715af9mr13951920f8f.60.1766416501000;
        Mon, 22 Dec 2025 07:15:01 -0800 (PST)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea830fesm22750093f8f.20.2025.12.22.07.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 07:15:00 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Mon, 22 Dec 2025 15:14:38 +0000
Subject: [PATCH v4 13/14] perf cs-etm: Don't hard code config attribute
 when configuring the event
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251222-james-perf-config-bits-v4-13-0608438186fc@linaro.org>
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

These instances of hard coded config attributes are used for configuring
and validating the event options. Use the config attribute that's
published by the driver by replacing the open coded operations with
evsel__get_config_val() and evsel__set_config_if_unset().

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/arch/arm/util/cs-etm.c | 56 +++++++++++++++++++--------------------
 1 file changed, 27 insertions(+), 29 deletions(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index 12b28562c2f3..dc3f4e86b075 100644
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
+	evsel__get_config_val(evsel, "contextid", &ctxt);
+	evsel__get_config_val(evsel, "contextid1", &ctxt1);
+	evsel__get_config_val(evsel, "contextid2", &ctxt2);
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
+	evsel__get_config_val(evsel, "timestamp", &val);
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
@@ -273,16 +272,19 @@ static int cs_etm_parse_snapshot_options(struct auxtrace_record *itr,
 	return 0;
 }
 
+/*
+ * If the sink name format "@sink_name" is used, lookup the sink by name to convert to
+ * "sinkid=sink_hash" format. If the user has already manually provided a hash then
+ * "sinkid" isn't overwritten. If neither are provided then the driver will pick the best
+ * sink.
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
@@ -305,14 +307,10 @@ static int cs_etm_set_sink_attr(struct perf_pmu *pmu,
 			return ret;
 		}
 
-		evsel->core.attr.config2 |= hash;
+		evsel__set_config_if_unset(evsel, "sinkid", hash);
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

