Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B71D3A1CE7
	for <linux-perf-users@vger.kernel.org>; Wed, 14 Jan 2026 15:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768406278; cv=none; b=kaZ/IPjkPq3VmSyhz5MkJ9VNQslmIF7/vT39bOYjrmGtcKLBwwwczVuO+i856RXGVl8DO04ymNjyH5JPr920nka6BlVZV9MUlrWr4KRw8DDmFYCp/SckN1off1wobvu1x5ZH9i4kdrWDKjqDNa+5soxzpXi493tbkVyBjbjCSiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768406278; c=relaxed/simple;
	bh=h3UUZ+MTt/jVXlppiWB5dfmCDIA0ulaZv1PvNfguK3Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fQLPDdvg/pGT1XF4tDhu0sT9gQ5D/WTYPzZXVkc43n2WVAAdUvBsvEcZKKQWGzrWXlDMJxZjJuSB0Oyg4ep/bDfTM2Qkfc+jnZnNUNMmxszKuIpQrH/e5L+MEct/D3sZ7iyGjFyUwut4uojPMdxyaujPD2Q6sixMaE9mrbR50xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OKdjk2q2; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OKdjk2q2"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47d493a9b96so51040455e9.1
        for <linux-perf-users@vger.kernel.org>; Wed, 14 Jan 2026 07:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768406274; x=1769011074; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NZnllZdyzmPDgDLg3NsetnXCFaQjqpO0nxPQg2XzMvs=;
        b=OKdjk2q2+SHhPlM3rAXrthAA902+5Z05MjPAZ6/LXkQXbG2g3zTX1GonMBdkMJ7qhr
         b/Q21wUc+ty54PRt+uzuyePWvvNGGzq8F0hbc+wX7kg5sSnOokC4coztM3TViDAW5dod
         q4sxlx1yGT+F9bYYfo0Ye2dJe7C72B0Dp+DiveNQAcSneYNDUZ/me+h0qwEwiJ6E1Ey4
         Zu1FDfoQ3uRoQ5TtyLRN5mNpl1sP+bB6lBpk44wHLjT5s4pkVTXQUt9efq2QSotTNfmn
         EtealiEXR4+h0NiMzV6GzaMfo/OGyATzwvwRKQqKCe/F+xTLKH899SEwXCtILrpmING2
         ZPDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768406274; x=1769011074;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NZnllZdyzmPDgDLg3NsetnXCFaQjqpO0nxPQg2XzMvs=;
        b=CQ5xhVwAlL0Ueo25RzhR+YPML9SlERIoJHphNcwSwF6SWaUkeR+w272QqNFQBVD05k
         FBNm9QheOHHvYbe23sa9dj+dlEa0ZZZCFSjSt+hwIJpdeWgQVNOjcqnxQbFmjjb7Bxzl
         TkXWJK/YJRFcvsx3zZ3ALpsTc921LWAVRUon/ofZDa7TUA3jQFL2ytojUCd8CY42YjC+
         nb2SsHabEoEpsogppuXJVmKFH3EL+MJsrVqOlRTsJ0z+PKtAhaO6bOVo6VBhEOCXlIGX
         KZzWk1lKZXizaRwNNLU0R9Q1o21GngypMbx/T6udQjBk7QLGMZDzZqkuMC+98X2QdPgg
         pGww==
X-Gm-Message-State: AOJu0Yy0lDQmupoA4G3wQZizwjsiLzwExZZdHrBFkeoAHlbP2vgQ9GIa
	AhNF3mqgjFTsCdVck9z1iHwMIUx/YFhPyLGLM7ZwlFYNYhhhY6pr/tqbZvSesBRWAMattD/OnNM
	eyS7/
X-Gm-Gg: AY/fxX6KSQCqX0jOQcoVvlg3zKwx3pM3KsWBFjH1ZDVfVXdJ5lnj612a05kMH4fnMW2
	ySaEC+Lrv6RDirFJYxbDf8qh1BFKjiTTRhRFxzV9vMpck0LbRmJgPM8bU721+AR17QMA7NfVIJ5
	iQluwr2J161JMCZ73oSz5uTuXi2Ukznp5QJQyuswdRc46v1OQxXqTneRtXKd/fZGIxBd46wteq5
	pLXspOAWI7BZZBp8ArhU9R5cTqnad89wq8iozF1NKcU+/4Gq9QXC4UMz2ivuF+YHcrGesBJhW3y
	zhBsfeUYDJPJueXROTPVeJ6gxESYecVZP8fh+tDN90V3sR8q8eOVEekkh0ELsVHdbFKV7Os/j8s
	wqFX8/Olw7uEdF0YcOljdN2qjDrhm6OPXkUSu2EqaqV4hoveyDd33qjQCQmrrLmN4JbRNwJ7wv4
	zf4MOVQl5bgFYNFxWc7AWuNfBuXp1eaWE=
X-Received: by 2002:a05:600c:c4b8:b0:471:1765:839c with SMTP id 5b1f17b1804b1-47ee3394887mr36283365e9.20.1768406273776;
        Wed, 14 Jan 2026 07:57:53 -0800 (PST)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47ee85e8807sm7426475e9.16.2026.01.14.07.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 07:57:53 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Wed, 14 Jan 2026 15:57:25 +0000
Subject: [PATCH v5 13/14] perf cs-etm: Don't hard code config attribute
 when configuring the event
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260114-james-perf-config-bits-v5-13-0ef97aaf1ac0@linaro.org>
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

