Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E504031D39F
	for <linux-perf-users@vger.kernel.org>; Mon,  8 Dec 2025 14:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765203832; cv=none; b=MLLIehPBfRiJnkcCeKMM4lHoL4gEAli2bm7K0SJMyRz3gfolT2kYNAJYn37g8Qz9gbgV0aVrWFBykEz5gRpWVcb6xVoeAGXhPPpHgwQtZ6e5A7I6g92a1e3kM2F9HTn6OaEQegGQT/OPLnwxHY4BCQ38M2bckrIESFRAYODPrrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765203832; c=relaxed/simple;
	bh=mEpxfkiT9R7sUWQ6ZKH/YPRS63jr9gZ8SH3kBajtofM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lZdZCo9husPaL708FUqQZKCCmO4lpL0HMzYo1kpdcZ7tkRHIBFTC8W4Ez9R7J97NGYon9EvHaj+txV+OI1TF8KrRjpKhbw5xTKAQ5bBDayXX/45zdR2JZBkAIuj+384MV5sRw8zC3OGLU0JG8I5isQQ0laKzUxqpTSQY7Sux4DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=P7PEbsIK; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P7PEbsIK"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-477563e28a3so32443775e9.1
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Dec 2025 06:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765203814; x=1765808614; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SsInU0t5SsRXwndpS/OaiCaWG6xiu+JNwIsRwUuzGhw=;
        b=P7PEbsIK12d57cfc7lzfpf93KpwC0x+uuLYD9bBJrhsFjhZBMkRzLhClhgZ6DO2af5
         mEqtLNoKnsiaVoCJqEYIhtsJrj6I5qZapD8Hmx/gCWjNIV71uInVZGbKCbCNh3UXXQyB
         6wcvWKu4RknicTdZ4YsC4hXa6SyV4DB7tnNw7+yhcSAcYOrOrxotwpsCaon9JZfDfLLI
         5O3ovpTo9kDYnXFPMwzUlbLGs2mddmP21RSqQRLt2IZ/nkd0TwmTcnTN1SLIweV1TOTQ
         4l/rowx73FiH9m3aHOnTc6zytKvUXhNFUnYlm6e7hDTdX+KLv5MqYNYGu1OB/Ca4HKyM
         WZSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765203814; x=1765808614;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SsInU0t5SsRXwndpS/OaiCaWG6xiu+JNwIsRwUuzGhw=;
        b=oHSJmWXPe8afLIsM5DMYnnkqbtfxpdCQDjsMNS3wPT7k0hgWpy66M0a5gM3eaQP62j
         krfzqAqQBcxF+HsLR/J3ir6NiEPgbZAEu/ieQXBVxY6DGnkgdXA+9FaO6Hkf+uvGGzmj
         fW4LGd9tHl+zcD8KiCnsFmPQwl0RmAdLAcCwJ1Nq0Dv5F5mVZYZwpSs6LW1K5y6Wzale
         9D8BJNceb9jKT24/ylN8gZhEDuDZ45wpaymhdZ2JJ7VI2TwAeUuBePAFw+V5kdSiGVXN
         kM8nRlzj2NAvMg+11ShGGNUexlVSRuKB6h+B8AyTCgcjL+XEN7UfZmMpyCzEl68By5oA
         ADGA==
X-Gm-Message-State: AOJu0Yy99vn1I5RjdOE46oUh7ahhYfG8XjS86Fl5WxUUxvuqU/ZcoNUq
	In5fMp6xN8qUzU6SkQGscxtuddgJqSYZPMs9ylj078uSvYbKZeyQrsKCt3+cgzZCDgA=
X-Gm-Gg: ASbGncsWG13Q3chA+UFIwURozc6YV3fCWEamsAxSiYVQWVxKx2U30Hq5MQiGFZ5bGlx
	ZS5D8M4OLWdgGjTlYsXFhKp0IZlOLOxd82sOQFtE9+RUVv3HQWNeLiVBH3Pl538SV3BTBmE6sJG
	xqIZE4WnIF1UWEna8CIJY95LRd270xHJmF9KXE1rKneQXfhqY/N//n/0dgdWH4V5w9evPcJto/K
	vQ9zv5KTaJfRzDM8PJ7U015B+KXc7r/tIF2MQJYFjuNVrjKsstKlvWUHzzxvyExJN7eHKkNCQ6l
	J7htqNgbPa/Zzxx18E23JvsDBV0Fl0SbdqpeQtSN5E+3F8JUJnjWYs1DSxIOf0iWwPoXs85rcKm
	R+cC8Gj414T2txfwfUUEAkJgG+XmFjsMAbSKzN1eqolzHEjZfZPhFJMhO6MiIjzcwBXXjeFpx+9
	ID68dseut2F7OSnC89NePn
X-Google-Smtp-Source: AGHT+IFSZGwfFwJSYKaBVY3GQ2FBMVbPJczh0bZwQlbrmePS7rzEeSRqZHVvyMQWkuI4F0AEn+gDQg==
X-Received: by 2002:a05:600c:8b6c:b0:477:9e0c:f59 with SMTP id 5b1f17b1804b1-47939df17f6mr81324235e9.2.1765203814305;
        Mon, 08 Dec 2025 06:23:34 -0800 (PST)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47930920e0dsm248561065e9.2.2025.12.08.06.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 06:23:33 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Mon, 08 Dec 2025 14:22:14 +0000
Subject: [PATCH v2 11/12] perf cs-etm: Don't hard code config attribute
 when configuring the event
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251208-james-perf-config-bits-v2-11-4ac0281993b0@linaro.org>
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

These instances of hard coded config attributes are used for configuring
and validating the event options. Use the config attribute that's
published by the driver by replacing the open coded operations with
evsel__get_config_val() and evsel__set_config_if_unset().

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/arch/arm/util/cs-etm.c | 57 +++++++++++++++++++--------------------
 1 file changed, 28 insertions(+), 29 deletions(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index 4a606b1e90f2..bfb573cb5878 100644
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

