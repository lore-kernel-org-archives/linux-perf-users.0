Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D7F37CD53
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Mar 2026 11:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772796301; cv=none; b=Sp5iYCp6aOCQja9uc8KPR95dthDhHwmXgJIHiugan5ZUs3lsxHCo3/13o5ac4d8sbRhOwCJeQN5FKgsEWn2VZ9E1ydw9JUKRsfmTpSjt8VggmFUHA6XwGDteVFTDJmNCpiJYWyKcLccGwmmvXnn3vyPkuNdq57ETnhwev+Hc0R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772796301; c=relaxed/simple;
	bh=XmlBp+FyfHa79b20c+WSM9OSUgkA0/TPAJwkgNdg3OI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q89qqbTMTzNkvq0B254Qyj8ISH82Jqq4poskYzNt/I3OhXvnQShUK5QlBPUPTQsR63WeW4b6vKfHfk2zZiMwg6aLVVCdhLHNcakegyQWqMEZwooPAAALmXFiDbBLYk6myzteaasPMQMjKrI2RRVdu9lrDpG+1J055HikWoFREyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nQ1tfJUk; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nQ1tfJUk"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-439ac15f35fso5783310f8f.0
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Mar 2026 03:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772796298; x=1773401098; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JR6LjrnAwci0LUUBKanGpetesFih9FEDm0wqajrsPkQ=;
        b=nQ1tfJUkoCjwpA6Uj6H7Tu0YHPVwjpAnDvP1F7rWDezam745Hh8jBGxZ5MaZowlXt0
         gfrNHAfnfhxEfwCNezMdTxiaVn0WCq/NtaeXArW2xz1/KznzxZligkq5ySflm8rXzPSK
         T/zST7HsHS97IQXsTI7qEsCVGjClsg1rNSKUiTFJvzoEs/RiCunTfHiJGD3oE9wKVxcQ
         QO7Mb1AkgU2V1oj4fghSF1xI3EesJQq7xgHPr1j+TTu14Me4oASnqjDugDHlWWdDpc3y
         8Bh0t6dOFjgUZwD5xyaH6aDLnYv8my2Vix0ghYY9LEMjNWE48axE5Ro2BX4HDmYxK+TQ
         49Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772796298; x=1773401098;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JR6LjrnAwci0LUUBKanGpetesFih9FEDm0wqajrsPkQ=;
        b=iyHzs3gmeCFYmmfnfHH85m+fwjKARsAXVQX/lUpGI8kwMWzvX+nIieixi8Ukm3cF7I
         nqOxl2KIjNStwDeFtDO2WXnAc3QIaCuZowmhFElO2E0PdOn6WPX/fCxEhko4wnddRVRa
         uB542VTvafIDq+FsSXXCZVxcBskotcW3EYITVfsSbFQy7Mb5Ar3E3+SiVqqFmpPg6f79
         tJhhxzCvslEPTSIpSKQrVk9g903TM56oG6OFi/R74azyd7VVUH+d1mkdE8THImiXbFsi
         xgTr2uUpikRS/lgBvhc8XUaVu7OH60yXU9KYJSDPIBrbXnG/uTyzKl7GTGU2TizRKXdz
         hIew==
X-Forwarded-Encrypted: i=1; AJvYcCXG5nEeeqyMitsWYEvrHckaR4ZsTwjOStxWcbDsUcCfr8Gy++BTYdVT2NkwSRLzk7jXnDySISOgFUzhJY8QkyGT@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx8GwHM9xt0ORqQwUafB0JmATeSwSWl0UEOhuNTzqM6weqlmQ5
	ROCfi4fWfia5ruOqlCc0oqgS72O30mVEQwFcSSSIbtZ2hdEDx53pQ2NroYnCgUZ7Brg=
X-Gm-Gg: ATEYQzw2csLUmMgPSlCVx9LHbio7UccpspKZrK4fp4JVycHIJh2eT3stQDxFxrl4skQ
	a+KA/Tez7LhJNpAsK9IYTM3n7q7V3D8UfDGHYw6s2VvnOePTwsW9n21qfYL47yT0gc9k8WtErqI
	goB13tX30xmPluXT8XUNDac/ZIPFWMFy+we8P9kQklH3nDJWnEG85rxSPNgOOlI0lByEkkwByqh
	80D3DbxC8D+o0xoyu2YOW9M9Q/9xoJKmss20rpocNAQhUzFVAUYhszCVawQHPaxkkSFUaoP+ru4
	Fi3EZ4f2EzrwmW0sXpZkG5+APY50x4vUJiQYfOPyWJJ+G/nUUwtEil2pRyQjBhyNgHjtyh/C/KF
	fsZYjbQtJnaPabQBKxOhnrjVMehxS3Rx8zjUe9RxqRPzZi165qYExyU8ze2rHfU8A6piPA4krRl
	lUVgJZZ8lbAIp5ReZZJJBhswwjW0a2phb8VRAmQr1Dw4Y=
X-Received: by 2002:a05:600c:3b0c:b0:480:3ad0:93bf with SMTP id 5b1f17b1804b1-48526979668mr26034545e9.24.1772796297511;
        Fri, 06 Mar 2026 03:24:57 -0800 (PST)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48527681a3esm66542245e9.4.2026.03.06.03.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 03:24:57 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Fri, 06 Mar 2026 11:24:45 +0000
Subject: [PATCH 1/2] perf cs-etm: Finish removal of ETM_OPT_*
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260306-james-perf-remove-etm_opt-v1-1-03c662380361@linaro.org>
References: <20260306-james-perf-remove-etm_opt-v1-0-03c662380361@linaro.org>
In-Reply-To: <20260306-james-perf-remove-etm_opt-v1-0-03c662380361@linaro.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Leo Yan <leo.yan@linux.dev>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@arm.com>
Cc: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, coresight@lists.linaro.org, 
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

These #defines have been removed from the kernel headers in favour of
the string based PMU format attributes. Usages were previously removed
from the recording side of cs-etm in Perf. Finish the removal by
removing usages from the decode side too.

It's a straight replacement of the old #defines with the new register
bit definitions. Except cs_etm__setup_timeless_decoding() which wasn't
looking at the saved metadata and was instead hard coding an access to
'attr.config'. This was vulnerable to the same issue of .config being
moved to .config2 etc that the original removal of ETM_OPT_* tried to
fix. So fix that too.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/arch/arm/util/cs-etm.c               | 14 ----------
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c |  2 +-
 tools/perf/util/cs-etm.c                        | 36 +++++++++----------------
 tools/perf/util/cs-etm.h                        | 15 +++++++++++
 4 files changed, 28 insertions(+), 39 deletions(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index dc3f4e86b075..4418d21708d6 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -68,20 +68,6 @@ static const char * const metadata_ete_ro[] = {
 
 enum cs_etm_version { CS_NOT_PRESENT, CS_ETMV3, CS_ETMV4, CS_ETE };
 
-/* ETMv4 CONFIGR register bits */
-#define TRCCONFIGR_BB		BIT(3)
-#define TRCCONFIGR_CCI		BIT(4)
-#define TRCCONFIGR_CID		BIT(6)
-#define TRCCONFIGR_VMID		BIT(7)
-#define TRCCONFIGR_TS		BIT(11)
-#define TRCCONFIGR_RS		BIT(12)
-#define TRCCONFIGR_VMIDOPT	BIT(15)
-
-/* ETMv3 ETMCR register bits */
-#define ETMCR_CYC_ACC		BIT(12)
-#define ETMCR_TIMESTAMP_EN	BIT(28)
-#define ETMCR_RETURN_STACK	BIT(29)
-
 static bool cs_etm_is_ete(struct perf_pmu *cs_etm_pmu, struct perf_cpu cpu);
 static int cs_etm_get_ro(struct perf_pmu *pmu, struct perf_cpu cpu, const char *path, __u64 *val);
 static bool cs_etm_pmu_path_exists(struct perf_pmu *pmu, struct perf_cpu cpu, const char *path);
diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index 3050fe212666..212f17a3dc72 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -549,7 +549,7 @@ cs_etm_decoder__set_tid(struct cs_etm_queue *etmq,
 	/*
 	 * Process the PE_CONTEXT packets if we have a valid contextID or VMID.
 	 * If the kernel is running at EL2, the PID is traced in CONTEXTIDR_EL2
-	 * as VMID, Bit ETM_OPT_CTXTID2 is set in this case.
+	 * as VMID, Format attribute 'contextid2' is set in this case.
 	 */
 	switch (cs_etm__get_pid_fmt(etmq)) {
 	case CS_ETM_PIDFMT_CTXTID:
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 95f439c96180..6c907c01635b 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -194,7 +194,7 @@ int cs_etm__get_cpu(struct cs_etm_queue *etmq, u8 trace_chan_id, int *cpu)
  *   CS_ETM_PIDFMT_CTXTID2: CONTEXTIDR_EL2 is traced.
  *   CS_ETM_PIDFMT_NONE: No context IDs
  *
- * It's possible that the two bits ETM_OPT_CTXTID and ETM_OPT_CTXTID2
+ * It's possible that the two format attributes 'contextid1' and 'contextid2'
  * are enabled at the same time when the session runs on an EL2 kernel.
  * This means the CONTEXTIDR_EL1 and CONTEXTIDR_EL2 both will be
  * recorded in the trace data, the tool will selectively use
@@ -210,15 +210,15 @@ static enum cs_etm_pid_fmt cs_etm__init_pid_fmt(u64 *metadata)
 	if (metadata[CS_ETM_MAGIC] == __perf_cs_etmv3_magic) {
 		val = metadata[CS_ETM_ETMCR];
 		/* CONTEXTIDR is traced */
-		if (val & BIT(ETM_OPT_CTXTID))
+		if (val & ETMCR_CTXTID)
 			return CS_ETM_PIDFMT_CTXTID;
 	} else {
 		val = metadata[CS_ETMV4_TRCCONFIGR];
 		/* CONTEXTIDR_EL2 is traced */
-		if (val & (BIT(ETM4_CFG_BIT_VMID) | BIT(ETM4_CFG_BIT_VMID_OPT)))
+		if (val & (TRCCONFIGR_VMID | TRCCONFIGR_VMIDOPT))
 			return CS_ETM_PIDFMT_CTXTID2;
 		/* CONTEXTIDR_EL1 is traced */
-		else if (val & BIT(ETM4_CFG_BIT_CTXTID))
+		else if (val & TRCCONFIGR_CID)
 			return CS_ETM_PIDFMT_CTXTID;
 	}
 
@@ -2914,29 +2914,19 @@ static int cs_etm__process_auxtrace_event(struct perf_session *session,
 	return 0;
 }
 
-static int cs_etm__setup_timeless_decoding(struct cs_etm_auxtrace *etm)
+static void cs_etm__setup_timeless_decoding(struct cs_etm_auxtrace *etm,
+					    u64 *metadata)
 {
-	struct evsel *evsel;
-	struct evlist *evlist = etm->session->evlist;
-
 	/* Override timeless mode with user input from --itrace=Z */
 	if (etm->synth_opts.timeless_decoding) {
 		etm->timeless_decoding = true;
-		return 0;
+		return;
 	}
 
-	/*
-	 * Find the cs_etm evsel and look at what its timestamp setting was
-	 */
-	evlist__for_each_entry(evlist, evsel)
-		if (cs_etm__evsel_is_auxtrace(etm->session, evsel)) {
-			etm->timeless_decoding =
-				!(evsel->core.attr.config & BIT(ETM_OPT_TS));
-			return 0;
-		}
-
-	pr_err("CS ETM: Couldn't find ETM evsel\n");
-	return -EINVAL;
+	if (metadata[CS_ETM_MAGIC] == __perf_cs_etmv3_magic)
+		etm->timeless_decoding = !(metadata[CS_ETM_ETMCR] & ETMCR_TIMESTAMP_EN);
+	else
+		etm->timeless_decoding = !(metadata[CS_ETMV4_TRCCONFIGR] & TRCCONFIGR_TS);
 }
 
 /*
@@ -3499,9 +3489,7 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
 	etm->auxtrace.evsel_is_auxtrace = cs_etm__evsel_is_auxtrace;
 	session->auxtrace = &etm->auxtrace;
 
-	err = cs_etm__setup_timeless_decoding(etm);
-	if (err)
-		return err;
+	cs_etm__setup_timeless_decoding(etm, metadata[0]);
 
 	etm->tc.time_shift = tc->time_shift;
 	etm->tc.time_mult = tc->time_mult;
diff --git a/tools/perf/util/cs-etm.h b/tools/perf/util/cs-etm.h
index a8caeea720aa..aa9bb4a32eca 100644
--- a/tools/perf/util/cs-etm.h
+++ b/tools/perf/util/cs-etm.h
@@ -230,6 +230,21 @@ struct cs_etm_packet_queue {
 /* CoreSight trace ID is currently the bottom 7 bits of the value */
 #define CORESIGHT_TRACE_ID_VAL_MASK	GENMASK(6, 0)
 
+/* ETMv4 CONFIGR register bits */
+#define TRCCONFIGR_BB		BIT(3)
+#define TRCCONFIGR_CCI		BIT(4)
+#define TRCCONFIGR_CID		BIT(6)
+#define TRCCONFIGR_VMID		BIT(7)
+#define TRCCONFIGR_TS		BIT(11)
+#define TRCCONFIGR_RS		BIT(12)
+#define TRCCONFIGR_VMIDOPT	BIT(15)
+
+/* ETMv3 ETMCR register bits */
+#define ETMCR_CYC_ACC		BIT(12)
+#define ETMCR_CTXTID		BIT(14)
+#define ETMCR_TIMESTAMP_EN	BIT(28)
+#define ETMCR_RETURN_STACK	BIT(29)
+
 int cs_etm__process_auxtrace_info(union perf_event *event,
 				  struct perf_session *session);
 void cs_etm_get_default_config(const struct perf_pmu *pmu, struct perf_event_attr *attr);

-- 
2.34.1

