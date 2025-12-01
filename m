Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F33335BB4
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Dec 2025 16:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764607313; cv=none; b=gAf+xVlpybpYNGPbn3droQLRAA2kgSWWMK4HNoVzctjoPycfudhpRw+K5+6ZHHyxE6w5IqK++CMHv6WgZjrln9+1Lxh+PFIHlp/BQmahvPVsVDMbkfL4TZZjl6LXxG4G0UbsPCpNEjeSxaKSvWITK93hiscarMfQeo69dK0kqyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764607313; c=relaxed/simple;
	bh=FcfDph9akWAhpmOmSa2BIV+EJ7RMAeS7smVRcRQOMOY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GXLfdvgSxH1bWXFQGQl8g6fT9QP2K7KVeV4SXOPDHjFOldIzwCpYsIjijeCkNi4nSwIVizcShdz6aJPRDuxHycnyw3Q+/VSpd14DBLX8PLwzMfTidmWLYsUFsSocQxvi3mrEUHwF07DlTtdlFag7Vi/kQxJMfgqDta3mBYBpSFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RFVAmMy3; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RFVAmMy3"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-477b1cc8fb4so26787965e9.1
        for <linux-perf-users@vger.kernel.org>; Mon, 01 Dec 2025 08:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764607310; x=1765212110; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wCK5jvjqS1OJSbH7Q8M4qbQBHOcn0cDJFYSc0X1U4g8=;
        b=RFVAmMy3Zw5gFcTpZJ4nDsuwIYs3DFnh5tp8Ut2Wl80GWOjHG2tqK7705lDuLhtdtR
         WapAhGhGqYumlKmVEMjHOH1Qwxdrb9g/xlUmiTNChV/yMNJFOvDIgYoE4cx+L1n9Y16N
         0FHCNZBJnS+M7RJ+EQ92uQlxDgwsx8S0SRPFshr+eUAC/CGGv3jBDRTz05gW/iexOCJj
         s9Qea/tQehsl6VWGVqju+PqD8g0Yj5ZWYJqAR31U/2ywbIO7qs01f/sPHwL8yMHKyPyD
         IunPRUu98jIiOfmMc06A6l+m/WYL2yRdDpcFb9+EfjkQOyESu3QRPUzpLgI9zHNA0+oQ
         ESJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764607310; x=1765212110;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wCK5jvjqS1OJSbH7Q8M4qbQBHOcn0cDJFYSc0X1U4g8=;
        b=t1h2oK52JR7Il9sRDWUkwUcVWhlcPPeVWbbMxE0R4HJ2GR6JQxMrbuZsFCWMD72YmJ
         O7PL1wSX1OOllF3kz6p2ir2kYMZ6jPiMFqTY/ASxEiQAVaQH7wjeU+zm70LWkaObffEL
         gH/RGb7TKNHl0b4XODqOvgmS87n5SLCryH/0qi1NhS9InaJyN2OXXC4UKWOxB/rDVeEz
         zXOjyLu3Oz5sNFtYi0mQn+8LCBQmn3+c0tBpiqK7x0eGvbB0HcIMwgL04nuWjiGGaplT
         7KtPc2uANXGCwgvhdQTdOIPDdhRdIesxcHkYPsz1yksQuT5puWGDZSAKLAPkWqQn3xg/
         PV4Q==
X-Gm-Message-State: AOJu0Yxa2zbHaVFy7zDu2IIqllgQujiF+ZCJLdtq7wun3f7mqJZ0a1P5
	gbq45qcXfOxEL7Wxcb97XjE1UXOCew48zZsgL6rsW7d1SYnGjDwzFFrfNa4sw24EhGs=
X-Gm-Gg: ASbGncsMwD1hX4Df/pCPpc419MqRJQZOaA8InaEOG8k6WxNqY0z5O3GaqOlY1aNxzMb
	WKgCbh5LGLSrHPV0xlrMo8cO10Xcyn7INldRBbPd//Nt+R8XC4ZadFpu4Hx+lSjsmPtpT9hiBZF
	oJW9ZAyfR8X+WxNFGtdh6pM12kNddDIGLBebT2orm+QoXNNeqvJYCSqgfsaT8DFigF7aTkkC5Ef
	YYMuy7doSyxJJiE17zCWxbL65JJX6KSgJguLlKyRu0WcO7qgTdYibX1Lgj0rGFZj9ssqvEiHBtW
	xJakRw7i4Fn8oKVgYlHSun+xajx5NkuimAIvTrXhg2+DQsMzHhNH3UQXkBJEuhVXiLSVlIpAnwW
	/gQ7VGg+sG/tmQMsZILGQEcP7wDMB8d4OS9BQv5d5WQc4becwA7ROqweXpgj1zMDQ/kLFEY6hkF
	qHY0pfRcgF0/EY9YnH3QLy
X-Google-Smtp-Source: AGHT+IEP/tNXfSvGkzJDnroSc7cg8nQooiX3N1v7Fw5uWyfNSqPrA6fMWwoGMhgB5DjA5qOUhENmxw==
X-Received: by 2002:a05:600c:1c82:b0:477:9c73:268b with SMTP id 5b1f17b1804b1-47904b2b36amr283793595e9.33.1764607309963;
        Mon, 01 Dec 2025 08:41:49 -0800 (PST)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4791164d4f3sm255901275e9.13.2025.12.01.08.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 08:41:49 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Mon, 01 Dec 2025 16:41:08 +0000
Subject: [PATCH 5/7] perf cs-etm: Don't use hard coded config bits when
 setting up TRCCONFIGR
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251201-james-perf-config-bits-v1-5-22ecbbf8007c@linaro.org>
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

Perf only looks at attr.config when determining what was programmed into
TRCCONFIGR. These bits could theoretically be in any of the config
fields. Use the evsel__get_config_val() helper so it's agnostic to
which config field they are in.

The kernel will also stop publishing the TRCCONFIGR register bits in a
header [1] so preempt that by defining them here.

[1]: https://lore.kernel.org/linux-arm-kernel/20251128-james-cs-syncfreq-v8-10-4d319764cc58@linaro.org/
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/arch/arm/util/cs-etm.c | 79 +++++++++++++++++----------------------
 1 file changed, 34 insertions(+), 45 deletions(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index 414cafb21c98..51ca8fa66ef8 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -68,6 +68,14 @@ static const char * const metadata_ete_ro[] = {
 
 enum cs_etm_version { CS_NOT_PRESENT, CS_ETMV3, CS_ETMV4, CS_ETE };
 
+/* ETMv4 CONFIGR register bits */
+#define TRCCONFIGR_BB		BIT(3)
+#define TRCCONFIGR_CCI		BIT(4)
+#define TRCCONFIGR_CID		BIT(6)
+#define TRCCONFIGR_VMID		BIT(7)
+#define TRCCONFIGR_TS		BIT(11)
+#define TRCCONFIGR_RS		BIT(12)
+#define TRCCONFIGR_VMIDOPT	BIT(15)
 
 /* ETMv3 ETMCR register bits */
 #define ETMCR_CYC_ACC		BIT(12)
@@ -520,56 +528,37 @@ static u64 cs_etm_guess_etmcr(struct auxtrace_record *itr)
 	return etmcr;
 }
 
-static u64 cs_etm_get_config(struct auxtrace_record *itr)
+static u64 cs_etmv4_guess_trcconfigr(struct auxtrace_record *itr)
 {
+	u64 trcconfigr = 0;
 	struct cs_etm_recording *ptr =
-			container_of(itr, struct cs_etm_recording, itr);
+		container_of(itr, struct cs_etm_recording, itr);
 	struct perf_pmu *cs_etm_pmu = ptr->cs_etm_pmu;
-	struct evlist *evlist = ptr->evlist;
-	struct evsel *evsel = cs_etm_get_evsel(evlist, cs_etm_pmu);
-
-	/*
-	 * Variable perf_event_attr::config is assigned to
-	 * ETMv3/PTM.  The bit fields have been made to match
-	 * the ETMv3.5 ETRMCR register specification.  See the
-	 * PMU_FORMAT_ATTR() declarations in
-	 * drivers/hwtracing/coresight/coresight-perf.c for
-	 * details.
-	 */
-	return evsel ? evsel->core.attr.config : 0;
-}
-
-#ifndef BIT
-#define BIT(N) (1UL << (N))
-#endif
+	struct evsel *evsel = cs_etm_get_evsel(ptr->evlist, cs_etm_pmu);
+	u64 val;
 
-static u64 cs_etmv4_get_config(struct auxtrace_record *itr)
-{
-	u64 config = 0;
-	u64 config_opts = 0;
+	if (!evsel)
+		return 0;
 
 	/*
-	 * The perf event variable config bits represent both
-	 * the command line options and register programming
-	 * bits in ETMv3/PTM. For ETMv4 we must remap options
-	 * to real bits
+	 * Roughly guess what the kernel programmed into TRCCONFIGR based on
+	 * what options the event was opened with. This doesn't have to be
+	 * complete or 100% accurate, not all bits used by OpenCSD anyway.
 	 */
-	config_opts = cs_etm_get_config(itr);
-	if (config_opts & BIT(ETM_OPT_CYCACC))
-		config |= BIT(ETM4_CFG_BIT_CYCACC);
-	if (config_opts & BIT(ETM_OPT_CTXTID))
-		config |= BIT(ETM4_CFG_BIT_CTXTID);
-	if (config_opts & BIT(ETM_OPT_TS))
-		config |= BIT(ETM4_CFG_BIT_TS);
-	if (config_opts & BIT(ETM_OPT_RETSTK))
-		config |= BIT(ETM4_CFG_BIT_RETSTK);
-	if (config_opts & BIT(ETM_OPT_CTXTID2))
-		config |= BIT(ETM4_CFG_BIT_VMID) |
-			  BIT(ETM4_CFG_BIT_VMID_OPT);
-	if (config_opts & BIT(ETM_OPT_BRANCH_BROADCAST))
-		config |= BIT(ETM4_CFG_BIT_BB);
-
-	return config;
+	if (!evsel__get_config_val(cs_etm_pmu, evsel, "cycacc", &val) && val)
+		trcconfigr |= TRCCONFIGR_CCI;
+	if (!evsel__get_config_val(cs_etm_pmu, evsel, "contextid1", &val) && val)
+		trcconfigr |= TRCCONFIGR_CID;
+	if (!evsel__get_config_val(cs_etm_pmu, evsel, "timestamp", &val) && val)
+		trcconfigr |= TRCCONFIGR_TS;
+	if (!evsel__get_config_val(cs_etm_pmu, evsel, "retstack", &val) && val)
+		trcconfigr |= TRCCONFIGR_RS;
+	if (!evsel__get_config_val(cs_etm_pmu, evsel, "contextid2", &val) && val)
+		trcconfigr |= TRCCONFIGR_VMID | TRCCONFIGR_VMIDOPT;
+	if (!evsel__get_config_val(cs_etm_pmu, evsel, "branch_broadcast", &val) && val)
+		trcconfigr |= TRCCONFIGR_BB;
+
+	return trcconfigr;
 }
 
 static size_t
@@ -691,7 +680,7 @@ static void cs_etm_save_etmv4_header(__u64 data[], struct auxtrace_record *itr,
 	struct perf_pmu *cs_etm_pmu = ptr->cs_etm_pmu;
 
 	/* Get trace configuration register */
-	data[CS_ETMV4_TRCCONFIGR] = cs_etmv4_get_config(itr);
+	data[CS_ETMV4_TRCCONFIGR] = cs_etmv4_guess_trcconfigr(itr);
 	/* traceID set to legacy version, in case new perf running on older system */
 	data[CS_ETMV4_TRCTRACEIDR] = cs_etm_get_legacy_trace_id(cpu);
 
@@ -723,7 +712,7 @@ static void cs_etm_save_ete_header(__u64 data[], struct auxtrace_record *itr, st
 	struct perf_pmu *cs_etm_pmu = ptr->cs_etm_pmu;
 
 	/* Get trace configuration register */
-	data[CS_ETE_TRCCONFIGR] = cs_etmv4_get_config(itr);
+	data[CS_ETE_TRCCONFIGR] = cs_etmv4_guess_trcconfigr(itr);
 	/* traceID set to legacy version, in case new perf running on older system */
 	data[CS_ETE_TRCTRACEIDR] = cs_etm_get_legacy_trace_id(cpu);
 

-- 
2.34.1

